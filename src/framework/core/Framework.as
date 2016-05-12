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
	import framework.sound.SoundManager;
	
	public class Framework  extends EventDispatcher
	{
		private var _nativeStage:flash.display.Stage;
		private var _nativeOverlay:Sprite;
		
		private var _stage:Stage;
		private var _stage3D:Stage3D;
		private var _context3D:Context3D;
		private var _rootClass:Class;
		private var _viewPort:Rectangle;
		private var _painter:Painter;

		private var _started:Boolean;
		private var _leftMouseDown:Boolean;
		private var _sceneStage:DisplayObjectContainer;
		private var _touch:Touch;
		private var _touchedObject:DisplayObject;
		
		private static var _sCurrent:Framework;
		private static var _sPoint:Point = new Point(0, 0);
		
		private var _statsDisplay:FrameWorkDrawCall;
		/**
		 * 생성자 - native stage 설정, 이벤트 리스너 등록, Stage3D context 생성 요청 등을 수행
		 * @param rootClass - start() 메서드 이후로 실행할 클래스
		 * @param stage - native application의 stage 객체
		 */
		public function Framework(rootClass:Class, stage:flash.display.Stage)
		{
			if (stage == null) throw new ArgumentError("Stage must not be null");
			
			// native stage 설정
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			// viewport 설정, Framework.display.stage 객체 생성
			_viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			_stage = new Stage(_viewPort.width, _viewPort.height, stage.color);
			_statsDisplay = new FrameWorkDrawCall(_viewPort.width*4/9,0,_viewPort.width/25,_viewPort.width/25);
			// 시작 클래스 설정
			_rootClass = rootClass;
			
			//Note @유영선 framework의 큰 틀을 stage에 덮어씀
			_nativeOverlay = new Sprite();
			_nativeStage = stage;
			_nativeStage.addChild(_nativeOverlay);
			
			// 이벤트 리스너 등록
			_nativeStage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			_nativeStage.addEventListener(TouchEvent.TOUCH_BEGIN, onTouch);
			_nativeStage.addEventListener(TouchEvent.TOUCH_MOVE, onTouch);
			_nativeStage.addEventListener(TouchEvent.TOUCH_END, onTouch);
			_nativeStage.addEventListener(MouseEvent.MOUSE_DOWN, onTouch);
			_nativeStage.addEventListener(MouseEvent.MOUSE_MOVE, onTouch);
			_nativeStage.addEventListener(MouseEvent.MOUSE_UP, onTouch);
			
			// Stage3D context 생성 요청
			_stage3D = _nativeStage.stage3Ds[0];
			_stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
			_stage3D.requestContext3D();
		}
		
		public function  showStats(value:Boolean):void
		{
			if (value == false) return;
			
			if (value)
			{
				trace("들어옴");
				if (_statsDisplay) _stage.addChild(_statsDisplay);
			}
		}
		/**
		 * Stage3D의 context가 생성되면 호출되는 메서드 
		 * @param event - 발생한 이벤트 정보를 갖고있는 Event 객체
		 */
		private function onContextCreated(event:Event):void
		{
			// 이벤트 리스너 제거
			_stage3D.removeEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
			
			_context3D = _stage3D.context3D;
			
			// 렌더링 버퍼의 크기 설정
			_context3D.configureBackBuffer(
				_nativeStage.stageWidth,
				_nativeStage.stageHeight,
				1,
				true
			);
			
			// depth 비교 설정
			_context3D.setDepthTest(true, Context3DCompareMode.ALWAYS);
			
			// Painter 객체 생성
			_painter = new Painter(_stage3D);
			
			// 외부에서 static 메서드를 호출할 때 사용하는 변수
			_sCurrent = this;
			
			// 메인으로 설정한 클래스를 stage의 첫 번째 자식으로 등록
			var root:DisplayObject = new _rootClass() as DisplayObject;
			_sceneStage = root as DisplayObjectContainer;
			_stage.addChildAt(_sceneStage, 0);
			
			// Touch 객체 생성
			_touch = new Touch();
		}
		
		/**
		 * flash.events.MouseEvent와 flash.events.TouchEvent가 발생했을 때 호출되는 메서드
		 * 발생한 이벤트는 Framework.event.TouchEvent로 재생성해서 이벤트를 디스패치한다
		 * @param event - 발생한 마우스 이벤트 혹은 터치 이벤트 정보를 가진 객체
		 */
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
			
			// event.type에 따라서 터치 상태를 정의
			switch (event.type)
			{
				case TouchEvent.TOUCH_BEGIN:	_touch.phase = TouchPhase.BEGAN; break;
				case TouchEvent.TOUCH_MOVE:		_touch.phase = TouchPhase.MOVED; break;
				case TouchEvent.TOUCH_END:		_touch.phase = TouchPhase.ENDED; break;
				case MouseEvent.MOUSE_DOWN:		_touch.phase = TouchPhase.BEGAN; break;
				case MouseEvent.MOUSE_UP:		_touch.phase = TouchPhase.ENDED; break;
				case MouseEvent.MOUSE_MOVE:		_touch.phase = (_leftMouseDown ? TouchPhase.MOVED : TouchPhase.HOVER); break;
			}
			
			// 터치 위치를 _sPoint, _touch에 입력
			_sPoint.x = _touch.globalX = _stage.stageWidth  * (globalX - _viewPort.x) / _viewPort.width;
			_sPoint.y = _touch.globalY = _stage.stageHeight * (globalY - _viewPort.y) / _viewPort.height;
			
			// 터치이벤트 생성
			var touchEvent:framework.event.TouchEvent = new framework.event.TouchEvent(_touch, framework.event.TouchEvent.TOUCH, true)
			
			// 터치의 상태가 HOVER이면 터치된 위치에 존재하는 오브젝트를 _touchedObject에 저장 후 dispatchEvent 호출
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
		 * 매 프레임마다 호출되는 메서드. render 메서드와 updateNativeOverlay 메서드를 호출한다
		 * @param event - 발생한 이벤트 정보를 가진 객체
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
		
		/**
		 * Stage3D에 객체를 출력시키는 메서드. 매 프레임마다 호출된다
		 */
		public function render():void
		{
			_painter.nextFrame();
			// 스테이지의 크기에 맞춰 직교투영 행렬을 설정
			_painter.setOrthographicProjection(_stage.stageWidth, _stage.stageHeight);
			// blendFactor 설정
			_painter.setDefaultBlendFactors(true);
			// 렌더링 버퍼 클리어
			_context3D.clear(1.0, 1.0, 1.0, 1.0);
			// 스테이지에 등록된 모든 객체의 render 메서드 호출
			
			_stage.render();
			// @FIXME jihwan.ryu 드로우콜 횟수 출력 - 화면 출력으로 변경
			_statsDisplay.createTextImage(_painter.drawCount);
			_painter.finishQuadBatch();
			
			// 버퍼에 그려진 데이터를 화면에 출력
			_context3D.present();
			// 행렬 초기화
			_painter.resetMatrix();
			// 드로우콜 초기화
			_painter.drawCount = 0;
		}
		
		/**
		 * Note @유영선 Framework의 시작을 알리는 함수
		 */        
		public function start() : void
		{
			_started = true;
		}
		
		/**
		 * Note @유영선 FrameWork의 종료를 알리는 함수
		 */        
		public function stop() : void
		{
			_started = false;
			SoundManager.getInstance().stopLoopedPlaying();
		}
		
		private function updateNativeOverlay():void
		{
			_nativeOverlay.x = _viewPort.x;
			_nativeOverlay.y = _viewPort.y;
			_nativeOverlay.scaleX = _viewPort.width / _stage.stageWidth;
			_nativeOverlay.scaleY = _viewPort.height / _stage.stageHeight;
		}
		
		// static get 메서드
		public static function get current():Framework { return _sCurrent; }
		public static function get painter():Painter { return _sCurrent ? _sCurrent._painter : null; }
		public static function get viewport():Rectangle { return _sCurrent ? _sCurrent._viewPort : null; }
		public static function get sceneStage():DisplayObjectContainer { return _sCurrent ? _sCurrent._sceneStage : null; }
		public static function set sceneStage(value:DisplayObjectContainer):void {_sCurrent._sceneStage = value; }
		public static function get stage():DisplayObjectContainer { return _sCurrent ? _sCurrent._stage : null; }
	}
}