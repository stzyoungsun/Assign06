package framework.display
{
	import com.adobe.utils.AGALMiniAssembler;
	
	import flash.display.Stage3D;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.Program3D;
	import flash.display3D.VertexBuffer3D;
	import flash.events.Event;
	import flash.utils.ByteArray;

	public class Painter
	{
		private var _stage3D:Stage3D;
		private var _context:Context3D;
		
		private var _program:Program3D;
		private var _vertexBuffer:VertexBuffer3D;
		private var _indexBuffer:IndexBuffer3D;
		
		private var tempAssembler:AGALMiniAssembler = new AGALMiniAssembler();
		private var vertexProgram:ByteArray;
		private var fragmentProgram:ByteArray;
		
		public function Painter(stage3D:Stage3D)
		{
			_stage3D = stage3D;
			_stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
		}
		
		private function onContextCreated(event:Event):void
		{
			_context = _stage3D.context3D;
			createProgram();
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
			
			_program = _context.createProgram();
			_program.upload(vertexProgram, fragmentProgram);
			
			// Create the positions and texture coordinates vertex buffer
			_vertexBuffer = _context.createVertexBuffer(4, 5);
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
			_indexBuffer = _context.createIndexBuffer(6);
			_indexBuffer.uploadFromVector(
				new <uint>[
					0, 1, 2,
					2, 3, 0
				], 0, 6
			);
		}
		
		public function get context():Context3D { return _context; }
		public function get vertexBuffer():VertexBuffer3D { return _vertexBuffer; }
		public function get indexBuffer():IndexBuffer3D { return _indexBuffer; }
		public function get program():Program3D { return _program; }
	}
}