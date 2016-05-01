package framework.core
{
	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DBlendFactor;
	import flash.display3D.Context3DCompareMode;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import framework.Rendering.Painter;
	import framework.display.DisplayObject;
	import framework.display.DisplayObjectContainer;
	import framework.display.Stage;
	import framework.event.TouchPhase;
	

	
	public class Framework  extends EventDispatcher
	{
		private var _started:Boolean;
		private var _rendering:Boolean;
		
		private var _nativeStage:flash.display.Stage;
		private var _nativeOverlay:Sprite;
		
		private var _context3D:Context3D;
		private var _stage:Stage;
		private var _viewPort:Rectangle;
		private var _rootClass:Class;
		private var _stage3D:Stage3D;

		private var _painter:Painter;
		private var _leftMouseDown:Boolean;
		private var _sceneStage : DisplayObjectContainer;
		private static var CURRENT:Framework;
		
		private static var _sglobalX:Number;
		private static var _sglobalY:Number;
		public function Framework(rootClass:Class, stage:flash.display.Stage)
		{
			if (stage == null) throw new ArgumentError("Stage must not be null");
			
			_viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			_stage = new Stage(_viewPort.width, _viewPort.height, stage.color);
			_rootClass = rootClass;
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			_stage3D = stage.stage3Ds[0];
			
			_nativeOverlay = new Sprite();    //Note @유영선 framework의 큰 틀을 stage에 덮어씀
			_nativeStage = stage;
			_nativeStage.addChild(_nativeOverlay);
			
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(TouchEvent.TOUCH_BEGIN, onTouch);
			stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouch);
			stage.addEventListener(TouchEvent.TOUCH_END, onTouch);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onTouch);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onTouch);
			stage.addEventListener(MouseEvent.MOUSE_UP, onTouch);
			
			stage.stage3Ds[0].addEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
			stage.stage3Ds[0].requestContext3D();
		}
		
		private function onContextCreated(event:Event):void
		{
			_stage3D.removeEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
			
			_context3D = _stage3D.context3D;
		
			_context3D.configureBackBuffer(
				_nativeStage.stageWidth,
				_nativeStage.stageHeight,
				1,
				true
			);
			
			_context3D.setBlendFactors(
				Context3DBlendFactor.SOURCE_ALPHA,
				Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA
			);
			_context3D.setDepthTest(true, Context3DCompareMode.ALWAYS);
			_painter = new Painter(_stage3D);
			
			makeCurrent();
			
			var root:DisplayObject = new _rootClass() as DisplayObject;
			_sceneStage = root as DisplayObjectContainer;
			_stage.addChildAt(_sceneStage, 0);
		}
		
		private function onTouch(event:Event):void
		{
			if(!_started) return;
			
			var phase:String;
			
			if(event is MouseEvent)
			{
				_sglobalX = (event as MouseEvent).stageX;
				_sglobalY = (event as MouseEvent).stageY;
			}
			else
			{
				_sglobalX = (event as TouchEvent).stageX;
				_sglobalY = (event as TouchEvent).stageY;
			}
			
			switch (event.type)
			{
				case TouchEvent.TOUCH_BEGIN:	phase = TouchPhase.BEGAN; break;
				case TouchEvent.TOUCH_MOVE:		phase = TouchPhase.MOVED; break;
				case TouchEvent.TOUCH_END:		phase = TouchPhase.ENDED; break;
				case MouseEvent.MOUSE_DOWN:		phase = TouchPhase.BEGAN; break;
				case MouseEvent.MOUSE_UP:		phase = TouchPhase.ENDED; break;
				case MouseEvent.MOUSE_MOVE:		phase = (_leftMouseDown ? TouchPhase.MOVED : TouchPhase.HOVER); break;
			}
			
			_sglobalX = _stage.stageWidth  * (_sglobalX - _viewPort.x) / _viewPort.width;
			_sglobalY = _stage.stageHeight * (_sglobalY - _viewPort.y) / _viewPort.height;
			
			if(phase == TouchPhase.BEGAN)
			{
				trace("클릭됨");
				var point:Point = new Point(_sglobalX, _sglobalY);
				var displayObject:DisplayObject = _stage.hitTest(point);
				if(displayObject != null)
					displayObject.dispatchTouchEvent(MouseEvent.MOUSE_DOWN);
			}
			
			if(phase == TouchPhase.HOVER)
			{
				var displayObjectOVER: DisplayObject = _sceneStage.recursiveSearch();
					
				if(displayObjectOVER != null)
					displayObjectOVER.dispatchTouchEvent(MouseEvent.MOUSE_OVER);
			}
		}
		
		
		public function dispose() : void
		{
			_nativeStage.removeEventListener(Event.ENTER_FRAME, onEnterFrame, false);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */        
		private function onEnterFrame(event:Event):void
		{
			//if (!shareContext)
			//{
			// Note @유영선 스테이트  패턴에 따라 stage가 변경 되면 그에 맞는 frame 출력    
			
			//}
			
			if(_started && _context3D != null)
			{
				_stage.children = _sceneStage.children;
				render();
			}
			
			updateNativeOverlay();
		}
		
		public function render():void
		{
			_context3D.clear(1, 1, 1);
			
			_stage.render();
			
			_context3D.present();
		}
		
		/**
		 * Note @유영선 FrameWork의 시작을 알리는 함수
		 * 
		 */        
		public function start() : void
		{
			_started = true;
		}
		
		/**
		 * 
		 * @param backGoundRendering stop 후 출력 되고 있는 이미지를 지울껀지의 여부 (true = 그림을 지우지 않습니다)
		 * 
		 * Note @유영선 FrameWork의 종료를 알리는 함수
		 */        
		public function stop(backGoundRendering : Boolean = true) : void
		{
			_started = false;
			_rendering = backGoundRendering;
		}
		
		private function updateNativeOverlay():void
		{
			_nativeOverlay.x = _viewPort.x;
			_nativeOverlay.y = _viewPort.y;
			_nativeOverlay.scaleX = _viewPort.width / _stage.stageWidth;
			_nativeOverlay.scaleY = _viewPort.height / _stage.stageHeight;
		}
		
		public function makeCurrent():void
		{
			CURRENT = this;
		}
		
		public static function get current():Framework { return CURRENT; }
		public static function get painter():Painter { return CURRENT ? CURRENT._painter : null; }
		public static function get viewport():Rectangle { return CURRENT ? CURRENT._viewPort : null; }
		
		public static function get sceneStage():DisplayObjectContainer { return CURRENT ? CURRENT._sceneStage : null; }
		public static function set sceneStage(value:DisplayObjectContainer):void {CURRENT._sceneStage =value; }
		
		public static function get mousex() : Number {return _sglobalX;};
		public static function get mousey() : Number {return _sglobalY;};
		//public function get shareContext() : Boolean { return _painter.shareContext; }
	}
}