package framework.Rendering
{
	import com.adobe.utils.AGALMiniAssembler;
	
	import flash.display.Stage3D;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DBlendFactor;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Program3D;
	import flash.geom.Matrix;
	import flash.geom.Matrix3D;
	import flash.utils.ByteArray;
	
	import framework.display.DisplayObject;
	import framework.display.Quad;
	import framework.display.QuadBatch;
	import framework.texture.FwTexture;
	
	public class Painter
	{
		private var _context:Context3D;
		private var _quadProgram:Program3D;
		private var _imageProgram:Program3D;
		private var _assembler:AGALMiniAssembler;
		
		private var _quadBatchVector:Vector.<QuadBatch>;
		private var _currentQuadBatchID:int;
		private var _drawCount:int;
		
		private var _modelViewMatrix:Matrix;
		private var _matrixStack:Vector.<Matrix>;
		private var _matrixStackSize:int;
		
		private var _projectionMatrix3D:Matrix3D;
		private var _modelViewMatrix3D:Matrix3D;
		private var _mvpMatrix3D:Matrix3D;
		
		private static var _sRawData:Vector.<Number> = new <Number>[1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1];
		private static var _sMatrix3D:Matrix3D = new Matrix3D();
		
		public function Painter(stage3D:Stage3D)
		{
			_context = stage3D.context3D;
			_assembler = new AGALMiniAssembler();
			
			_modelViewMatrix = new Matrix();
			_matrixStack = new <Matrix>[];
			_matrixStackSize = 0;
			
			_projectionMatrix3D = new Matrix3D();
			_modelViewMatrix3D = new Matrix3D();
			_mvpMatrix3D = new Matrix3D();
			
			createQuadProgram();
			createImageProgram();
			
			_quadBatchVector = new <QuadBatch>[new QuadBatch()];
			_currentQuadBatchID = 0;
			
			loadIdentity();
		}
		
		private function createQuadProgram():void
		{
			var vertexProgram:ByteArray;
			var fragmentProgram:ByteArray;
			
			_assembler.assemble(
				Context3DProgramType.VERTEX,
				"m44 op, va0, vc0	\n" +
				"mov v0, va1		\n"
			);
			vertexProgram = _assembler.agalcode;
			
			_assembler.assemble(
				Context3DProgramType.FRAGMENT,
				"mul ft0, v0, fc0	\n" +
				"mov oc, ft0		\n"
			);
			fragmentProgram = _assembler.agalcode;
			
			_quadProgram = _context.createProgram();
			_quadProgram.upload(vertexProgram, fragmentProgram);
		}
		
		private function createImageProgram():void
		{
			var vertexProgram:ByteArray;
			var fragmentProgram:ByteArray;
			
			_assembler.assemble(
				Context3DProgramType.VERTEX,
				"m44 op, va0, vc0			\n" +
				"mov v1, va1		 		\n"
			);
			vertexProgram = _assembler.agalcode;
			
			_assembler.assemble(
				Context3DProgramType.FRAGMENT,
				"tex ft1, v1, fs1 <2d, linear, mipnone, clamp>	\n" +
				"mul ft2, ft1, fc0								\n" +
				"mov oc ft2										\n"
			);
			fragmentProgram = _assembler.agalcode;
			
			_imageProgram = _context.createProgram();
			_imageProgram.upload(vertexProgram, fragmentProgram);
		}
		
		public function setOrthographicProjection(width:Number, height:Number, near:Number=-1.0, far:Number=1.0):void 
		{ 
			var coords:Vector.<Number> = new <Number>[ 
				2.0/width, 0.0, 0.0, 0.0, 
				0.0, -2.0/height, 0.0, 0.0, 
				0.0, 0.0, -2.0/(far-near), 0.0, 
				-1.0, 1.0, -(far+near)/(far-near), 1.0 
			]; 
			_projectionMatrix3D.copyRawDataFrom(coords);
		}
		
		public function loadIdentity():void
		{
			_modelViewMatrix.identity();
			_modelViewMatrix3D.identity();
		}
		
		public function transformMatrix(object:DisplayObject):void
		{
			prependMatrix(_modelViewMatrix, object.transformationMatrix);
		}
		
		public function pushMatrix():void
		{
			if (_matrixStack.length < _matrixStackSize + 1)
				_matrixStack.push(new Matrix());
			
			_matrixStack[int(_matrixStackSize++)].copyFrom(_modelViewMatrix);
		}
		
		public function popMatrix():void
		{
			_modelViewMatrix.copyFrom(_matrixStack[int(--_matrixStackSize)]);
		}
		
		public function resetMatrix():void
		{
			_matrixStackSize = 0;
			loadIdentity();
		}
		
		public function setDefaultBlendFactors(premultipliedAlpha:Boolean):void
		{
			var destFactor:String = Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA;
			var sourceFactor:String = premultipliedAlpha ? Context3DBlendFactor.ONE : Context3DBlendFactor.SOURCE_ALPHA;
			_context.setBlendFactors(sourceFactor, destFactor);
		}
		
		public function batch(quad:Quad, texture:FwTexture=null):void
		{
			if(_quadBatchVector[_currentQuadBatchID].isStateChange(texture))
			{
				finishQuadBatch();
			}
			
			_quadBatchVector[_currentQuadBatchID].addBatch(quad, texture, _modelViewMatrix);
		}
		
		public function finishQuadBatch():void
		{
			var currentBatch:QuadBatch = _quadBatchVector[_currentQuadBatchID];
			
			if(currentBatch.numQuads != 0)
			{
				currentBatch.render(_projectionMatrix3D);
				currentBatch.reset();
				_currentQuadBatchID++;
				
				if(_quadBatchVector.length <= _currentQuadBatchID)
				{
					_quadBatchVector.push(new QuadBatch());
				}
			}
		}
		
		public function nextFrame():void
		{
			_drawCount = 0;
			_currentQuadBatchID = 0;
		}
		
		public function convertTo3D(matrix:Matrix, resultMatrix:Matrix3D=null):Matrix3D
		{
			if (resultMatrix == null) resultMatrix = new Matrix3D();
			
			_sRawData[ 0] = matrix.a;
			_sRawData[ 1] = matrix.b;
			_sRawData[ 4] = matrix.c;
			_sRawData[ 5] = matrix.d;
			_sRawData[12] = matrix.tx;
			_sRawData[13] = matrix.ty;
			
			resultMatrix.copyRawDataFrom(_sRawData);
			return resultMatrix;
		}
		
		public function prependMatrix(base:Matrix, prep:Matrix):void
		{
			base.setTo(base.a * prep.a + base.c * prep.b,
				base.b * prep.a + base.d * prep.b,
				base.a * prep.c + base.c * prep.d,
				base.b * prep.c + base.d * prep.d,
				base.tx + base.a * prep.tx + base.c * prep.ty,
				base.ty + base.b * prep.tx + base.d * prep.ty);
		}
		
		public function get mvpMatrix3D():Matrix3D
		{
			_mvpMatrix3D.copyFrom(_projectionMatrix3D);
			_mvpMatrix3D.prepend(_modelViewMatrix3D);
			_mvpMatrix3D.prepend(convertTo3D(_modelViewMatrix, _sMatrix3D));
			
			return _mvpMatrix3D;
		}
		
		public function get context():Context3D { return _context; }
		public function get quadProgram():Program3D { return _quadProgram; }
		public function get imageProgram():Program3D { return _imageProgram; }
		
		public function get drawCount():int { return _drawCount; }
		public function set drawCount(value:int):void { _drawCount = value; }
	}
}