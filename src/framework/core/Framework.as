package framework.core
{
	import com.adobe.utils.AGALMiniAssembler;
	
	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.Program3D;
	import flash.display3D.VertexBuffer3D;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	import framework.display.DisplayObject;
	import framework.display.Stage;
	
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
		
		private var _vertexBuffer:VertexBuffer3D;
		private var _indexBuffer:IndexBuffer3D;
		
		private var tempAssembler:AGALMiniAssembler = new AGALMiniAssembler();
		private var vertexProgram:ByteArray;
		private var fragmentProgram:ByteArray;
		
		public function Framework(rootClass:Class, stage:flash.display.Stage, viewPort:Rectangle=null, stage3D:Stage3D=null)
		{
			if (stage == null) throw new ArgumentError("Stage must not be null");
			if (viewPort == null) viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
						
			_stage = new Stage(viewPort.width, viewPort.height, stage.color);
			_rootClass = rootClass;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			_nativeOverlay = new Sprite();    //Note @유영선 framework의 큰 틀을 stage에 덮어씀
			_nativeStage = stage;
			_nativeStage.addChild(_nativeOverlay);
			
			_viewPort = viewPort;
			
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			stage.stage3Ds[0].addEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
			stage.stage3Ds[0].requestContext3D();
			_stage3D = stage.stage3Ds[0];
		}
		
		private function onContextCreated(event:Event):void
		{
			_stage3D.removeEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
			
			_context3D = _stage3D.context3D;
			
			var root:DisplayObject = new _rootClass() as DisplayObject;
			_stage.addChildAt(root, 0);
		}
		
		private function createProgram():void
		{
			tempAssembler.assemble(
				Context3DProgramType.VERTEX,
				// Apply draw matrix (object -> clip space)
				"m44 op, va0, vc0\n" +
				
				// Scale texture coordinate and copy to varying
				"mov vt0, va1\n" +
				"div vt0.xy, vt0.xy, vc4.xy\n" +
				"mov v0, vt0\n"
			);
			vertexProgram = tempAssembler.agalcode;
			
			tempAssembler.assemble(
				Context3DProgramType.FRAGMENT,
				"tex oc, v0, fs0 <2d,linear,mipnone,clamp>"
			);
			fragmentProgram = tempAssembler.agalcode;
			
			var program:Program3D = _context3D.createProgram();
			program.upload(vertexProgram, fragmentProgram);
			
			// Create the positions and texture coordinates vertex buffer
			_vertexBuffer = _context3D.createVertexBuffer(4, 5);
			_vertexBuffer.uploadFromVector(
				new <Number>[
					// X,  Y,  Z, U, V
					-1,   -1, 0, 0, 1,
					-1,    1, 0, 0, 0,
					1,    1, 0, 1, 0,
					1,   -1, 0, 1, 1
				], 0, 4
			);
			
			// Create the triangles index buffer
			_indexBuffer = _context3D.createIndexBuffer(6);
			_indexBuffer.uploadFromVector(
				new <uint>[
					0, 1, 2,
					2, 3, 0
				], 0, 6
			);
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
				render();
			}
		}
		
		public function render():void
		{
			_context3D.clear(0.5, 0.5, 0.5);
			
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
		
		//public function get shareContext() : Boolean { return _painter.shareContext; }
	}
}