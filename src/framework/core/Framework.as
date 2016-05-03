package framework.core
{
	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display3D.Context3D;
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
	import framework.event.Touch;
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
		private var _sceneStage:DisplayObjectContainer;
		private var _touch:Touch;
		private var _touchedObject:DisplayObject;
		
		private static var _sCurrent:Framework;
		private static var _sPoint:Point = new Point(0, 0);
		
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
			
			_context3D.setDepthTest(true, Context3DCompareMode.ALWAYS);
			
			_painter = new Painter(_stage3D);
			
			makeCurrent();
			
			var root:DisplayObject = new _rootClass() as DisplayObject;
			_sceneStage = root as DisplayObjectContainer;
			_stage.addChildAt(_sceneStage, 0);
			
			_touch = new Touch();
		}
		
		private function onTouch(event:Event):void
		{
			if(!_started) return;
			
			var globalX:Number;
			var globalY:Number;
			
			if(event is MouseEvent)
			{
				globalX = (event as MouseEvent).stageX;
				globalY = (event as MouseEvent).stageY;
				
				// 마우스 클릭 상태인지 체크
				if (event.type == MouseEvent.MOUSE_DOWN)    _leftMouseDown = true;
				else if (event.type == MouseEvent.MOUSE_UP) _leftMouseDown = false;
			}
			else
			{
				globalX = (event as TouchEvent).stageX;
				globalY = (event as TouchEvent).stageY;
			}
			
			switch (event.type)
			{
				case TouchEvent.TOUCH_BEGIN:	_touch.phase = TouchPhase.BEGAN; break;
				case TouchEvent.TOUCH_MOVE:		_touch.phase = TouchPhase.MOVED; break;
				case TouchEvent.TOUCH_END:		_touch.phase = TouchPhase.ENDED; break;
				case MouseEvent.MOUSE_DOWN:		_touch.phase = TouchPhase.BEGAN; break;
				case MouseEvent.MOUSE_UP:		_touch.phase = TouchPhase.ENDED; break;
				case MouseEvent.MOUSE_MOVE:		_touch.phase = (_leftMouseDown ? TouchPhase.MOVED : TouchPhase.HOVER); break;
			}
			
			_sPoint.x = _touch.globalX = _stage.stageWidth  * (globalX - _viewPort.x) / _viewPort.width;
			_sPoint.y = _touch.globalY = _stage.stageHeight * (globalY - _viewPort.y) / _viewPort.height;
			
			// 터치이벤트 생성
			var touchEvent:framework.event.TouchEvent = new framework.event.TouchEvent(_touch, framework.event.TouchEvent.TOUCH, true)
			
			// 터치의 상태가 HOVER이면 터치된 위치에 존재하는 오브젝트를 _touchedObject에 저장
			if(_touch.phase == TouchPhase.HOVER)
			{
				_touchedObject = _stage.hitTest(_sPoint);
				_touchedObject.dispatchEvent(touchEvent);
			}
			// 그 외의 상태라면, _touchedObject에 저장된 객체의 dispatchEvent를 호출
			else
			{
				// _touchedObject에 저장된 오브젝트의 dispatchEvent 호출
				_touchedObject.dispatchEvent(touchEvent);
				
				// 터치 상태가 ENDED면 _touchedObject를 null로 대입
				if(_touch.phase == TouchPhase.ENDED)
				{
					_touchedObject = null;
				}
			}
		}
		
		/**
		 * Framework에서 생성된 이벤트, 객체 등을 제거하는 메서드
		 */
		public function dispose() : void
		{
			stop();
			
			_nativeStage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			_nativeStage.removeEventListener(TouchEvent.TOUCH_BEGIN, onTouch);
			_nativeStage.removeEventListener(TouchEvent.TOUCH_MOVE, onTouch);
			_nativeStage.removeEventListener(TouchEvent.TOUCH_END, onTouch);
			_nativeStage.removeEventListener(MouseEvent.MOUSE_DOWN, onTouch);
			_nativeStage.removeEventListener(MouseEvent.MOUSE_MOVE, onTouch);
			_nativeStage.removeEventListener(MouseEvent.MOUSE_UP, onTouch);
			_nativeStage.removeChild(_nativeOverlay);
			
			_stage3D.removeEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
			
			if(_stage) _stage.dispose();
			if(_sCurrent == this) _sCurrent = null;
		}
		
		/**
		 * @param event
		 */        
		private function onEnterFrame(event:Event):void
		{			
			if(_started && _context3D != null)
			{
				_stage.children[0] = _sceneStage;
				render();
			}
			
			updateNativeOverlay();
		}
		
		public function render():void
		{
			_painter.setOrthographicProjection(_stage.stageWidth, _stage.stageHeight);
			
			_painter.setDefaultBlendFactors(true);
			
			_context3D.clear(1.0, 1.0, 1.0, 1.0);
			
			_stage.render();
			
			_context3D.present();
			
			_painter.resetMatrix();
		}
		
		/**
		 * Note @유영선 FrameWork의 시작을 알리는 함수
		 */        
		public function start() : void
		{
			_started = true;
		}
		
		/**
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
			_sCurrent = this;
		}
		
		public static function get current():Framework { return _sCurrent; }
		public static function get painter():Painter { return _sCurrent ? _sCurrent._painter : null; }
		public static function get viewport():Rectangle { return _sCurrent ? _sCurrent._viewPort : null; }
		
		public static function get sceneStage():DisplayObjectContainer { return _sCurrent ? _sCurrent._sceneStage : null; }
		public static function set sceneStage(value:DisplayObjectContainer):void {_sCurrent._sceneStage =value; }
		
		public static function get stage():DisplayObjectContainer { return _sCurrent ? _sCurrent._stage : null; }
	}
}