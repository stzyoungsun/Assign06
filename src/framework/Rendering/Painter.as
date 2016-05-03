package framework.Rendering
{
	import com.adobe.utils.AGALMiniAssembler;
	
	import flash.display.Stage3D;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DBlendFactor;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Program3D;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	import flash.utils.ByteArray;
	
	import framework.display.DisplayObject;
	
	public class Painter
	{
		private var _context:Context3D;
		private var _program:Program3D;
		
		private var _assembler:AGALMiniAssembler;
		private var _vertexProgram:ByteArray;
		private var _fragmentProgram:ByteArray;
		
		private var _projectionMatrix:Matrix3D;
		private var _modelViewMatrix:Matrix3D;
		private var _matrixStack:Vector.<Matrix3D>;
		
		public function Painter(stage3D:Stage3D)
		{
			_context = stage3D.context3D;
			_assembler = new AGALMiniAssembler();
			
			_matrixStack = new <Matrix3D>[];
			_projectionMatrix = new Matrix3D();
			_modelViewMatrix = new Matrix3D();
			
			createProgram();
			
			loadIdentity();
		}
		
		public function setOrthographicProjection(width:Number, height:Number, near:Number=-1.0, far:Number=1.0):void
		{
			var coords:Vector.<Number> = new <Number>[
				2.0/width, 0.0, 0.0, 0.0,
				0.0, -2.0/height, 0.0, 0.0,
				0.0, 0.0, -2.0/(far-near), 0.0,
				-1.0, 1.0, -(far+near)/(far-near), 1.0
			];
			
			_projectionMatrix.copyRawDataFrom(coords);
		}
		
		public function loadIdentity():void
		{
			_modelViewMatrix.identity();
		}
		
		public function transformMatrix(object:DisplayObject):void
		{
			transformMatrixForObject(_modelViewMatrix, object);   
		}
		
		public function pushMatrix():void
		{
			_matrixStack.push(_modelViewMatrix.clone());
		}
		
		public function popMatrix():void
		{
			_modelViewMatrix = _matrixStack.pop();
		}
		
		public function resetMatrix():void
		{
			if (_matrixStack.length != 0)
				_matrixStack = new <Matrix3D>[];
			
			loadIdentity();
		}
		
		public function setDefaultBlendFactors(premultipliedAlpha:Boolean):void
		{
			var destFactor:String = Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA;
			var sourceFactor:String = premultipliedAlpha ? Context3DBlendFactor.ONE : Context3DBlendFactor.SOURCE_ALPHA;
			_context.setBlendFactors(sourceFactor, destFactor);
		}
		
		public function get mvpMatrix():Matrix3D
		{
			var mvpMatrix:Matrix3D = new Matrix3D();
			mvpMatrix.append(_modelViewMatrix);
			mvpMatrix.append(_projectionMatrix);
			return mvpMatrix;
		}
		
		public static function transformMatrixForObject(matrix:Matrix3D, object:DisplayObject):void
		{
			matrix.prependTranslation(object.x, object.y, 0.0);
			matrix.prependRotation(object.rotation / Math.PI * 180.0, Vector3D.Z_AXIS);
			matrix.prependScale(object.scaleX, object.scaleY, 1.0);
			matrix.prependTranslation(-object.pivotX, -object.pivotY, 0.0);
		}
		
		public function createProgram():void
		{
			_assembler.assemble(
				Context3DProgramType.VERTEX,
				"m44 op, va0, vc0  			\n" +
//				"mov v0, va1      			\n" +
				"mov vt0, va2				\n" +
				"div vt0.xy, vt0.xy, vc4.xy	\n" +
				"mov v1, vt0				\n"
			);
			_vertexProgram = _assembler.agalcode;
			
			_assembler.assemble(
				Context3DProgramType.FRAGMENT,
				"tex ft1, v1, fs1 <2d,linear,mipnone,clamp> \n" +
//				"mul ft2, ft1, v0       \n" +
				"mul oc, ft1, fc0      \n"
			);

			_fragmentProgram = _assembler.agalcode;
			
			_program = _context.createProgram();
			_program.upload(_vertexProgram, _fragmentProgram);
		}
		
		public function get context():Context3D { return _context; }
		public function get program():Program3D { return _program; }
		public function get projectionMatrix():Matrix3D { return _projectionMatrix; }
		public function get modelViewMatrix():Matrix3D { return _modelViewMatrix; }
	}
}