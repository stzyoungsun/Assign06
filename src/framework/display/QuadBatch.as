package framework.display
{
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.VertexBuffer3D;
	import flash.geom.Matrix;
	import flash.geom.Matrix3D;
	import flash.geom.Rectangle;
	
	import framework.Rendering.Painter;
	import framework.core.Framework;
	import framework.texture.FwTexture;
	
	public class QuadBatch
	{
		public static const MAX_NUM_QUADS:int = 1024;
		
		private var _numQuads:int;
		private var _texture:FwTexture;
		private var _vertexData:Vector.<Number>;
		private var _vertexBuffer:VertexBuffer3D;
		private var _indexData:Vector.<uint>;
		private var _indexBuffer:IndexBuffer3D;
		private var _capacity:Number;
		
		private var _syncRequired:Boolean;
		
		public function QuadBatch()
		{
			_numQuads = 0;
			_capacity = 0;
		}
		
		/**
		 * 현재 Quad를 수용할 수 있는 크기를 증가시키는 메서드
		 */
		public function expand():void
		{
			var oldCapacity:int = this.capacity;
			this.capacity = oldCapacity < 8 ? 16 : oldCapacity * 2;
			destroyBuffers();
			_syncRequired = true;
		}
		
		/**
		 * Vertex 버퍼를 생성하고 벡터 데이터를 업로드하는 메서드
		 */
		private function createBufferData():void
		{
			// 버퍼 데이터 설정
			_vertexBuffer = Framework.painter.context.createVertexBuffer(this.capacity * 4, 5);
			_vertexBuffer.uploadFromVector(_vertexData, 0, this.capacity * 4);
			
			_indexBuffer = Framework.painter.context.createIndexBuffer(this.capacity * 6);
			_indexBuffer.uploadFromVector(_indexData, 0, this.capacity * 6);
			
			_syncRequired = false;
		}
		
		/**
		 * 버퍼의 데이터를 갱신하는 메서드 
		 */
		private function syncBuffers():void
		{
			// _vertexBuffer가 null이면 buffer를 생성 후 벡터 데이터 업로드
			if (_vertexBuffer == null)
			{
				createBufferData();
			}
				// 이미 존재한다면 벡터 데이터만 업로드해서 갱신
			else
			{
				_vertexBuffer.uploadFromVector(_vertexData, 0, this.capacity * 4);
				_syncRequired = false;
			}
		}
		
		/**
		 * Vertex, Index 버퍼에 업로드 된 데이터를 해제하는 메서드. 
		 */
		private function destroyBuffers():void
		{
			if(_vertexBuffer)
			{
				_vertexBuffer.dispose();
				_vertexBuffer = null;
			}
			
			if(_indexBuffer)
			{
				_indexBuffer.dispose();
				_indexBuffer = null;
			}
		}
		
		/**
		 * Quad 객체를 Batching하는 메서드 
		 * @param quad - Batch하려는 Quad 객체
		 * @param texture - Quad에 적용하려는 Texture 객체
		 * @param modelViewMatrix - Quad 객체의 모델 뷰 매트릭스. 버텍스 데이터를 설정하기 위해 사용
		 */
		public function addBatch(quad:Quad, texture:FwTexture, modelViewMatrix:Matrix):void
		{
			if(_numQuads == 0)
			{
				_texture = texture;
				_vertexData = new Vector.<Number>();
				_indexData = new Vector.<uint>();
			}
			
			if(_numQuads + 1 > this.capacity)
			{
				expand();
			}
			
			var indexOffset:int = _numQuads * 6;
			var base:int = _numQuads * 4;
			_indexData[indexOffset++] = base;
			_indexData[indexOffset++] = base + 1;
			_indexData[indexOffset++] = base + 2;
			_indexData[indexOffset++] = base + 1;
			_indexData[indexOffset++] = base + 3;
			_indexData[indexOffset++] = base + 2;
			
			var vertexOffset:int = _numQuads * 20;
			for(var i:int = 0; i < 20; i++)
			{
				_vertexData[vertexOffset + i] = quad.vertexData[i];
			}
			
			var x:Number = _vertexData[vertexOffset];
			var y:Number = _vertexData[vertexOffset + 1];
			var uvRegion:Rectangle = texture.uvRegion;
			
			_vertexData[vertexOffset++] =  x * modelViewMatrix.a + modelViewMatrix.c * y + modelViewMatrix.tx;
			_vertexData[vertexOffset++] =  modelViewMatrix.d * y + modelViewMatrix.b * x + modelViewMatrix.ty;
			vertexOffset++;
			_vertexData[vertexOffset++] = uvRegion.left;
			_vertexData[vertexOffset++] = uvRegion.top;
			
			x = _vertexData[vertexOffset];
			y = _vertexData[vertexOffset + 1];
			_vertexData[vertexOffset++] =  x * modelViewMatrix.a + modelViewMatrix.c * y + modelViewMatrix.tx;
			_vertexData[vertexOffset++] =  modelViewMatrix.d * y + modelViewMatrix.b * x + modelViewMatrix.ty;
			vertexOffset++;
			_vertexData[vertexOffset++] = uvRegion.right;
			_vertexData[vertexOffset++] = uvRegion.top;
			
			x = _vertexData[vertexOffset];
			y = _vertexData[vertexOffset + 1];
			_vertexData[vertexOffset++] =  x * modelViewMatrix.a + modelViewMatrix.c * y + modelViewMatrix.tx;
			_vertexData[vertexOffset++] =  modelViewMatrix.d * y + modelViewMatrix.b * x + modelViewMatrix.ty;
			vertexOffset++;
			_vertexData[vertexOffset++] = uvRegion.left;
			_vertexData[vertexOffset++] = uvRegion.bottom;
			
			x = _vertexData[vertexOffset];
			y = _vertexData[vertexOffset + 1];
			_vertexData[vertexOffset++] =  x * modelViewMatrix.a + modelViewMatrix.c * y + modelViewMatrix.tx;
			_vertexData[vertexOffset++] =  modelViewMatrix.d * y + modelViewMatrix.b * x + modelViewMatrix.ty;
			vertexOffset++;
			_vertexData[vertexOffset++] = uvRegion.right;
			_vertexData[vertexOffset++] = uvRegion.bottom;
			
			_numQuads++;
		}
		
		public function render(mvpMatrix:Matrix3D):void
		{
			var painter:Painter = Framework.painter;
			var context:Context3D = painter.context;
			
			if (_syncRequired) syncBuffers();
			
			painter.setDefaultBlendFactors(true);
			
			// 쉐이더 프로그램 설정
			context.setProgram(painter.imageProgram);
			// Vertex 프로그램에서 사용될 변수를 위해 버퍼 등록
			context.setVertexBufferAt(0, _vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_3);	// va0
			context.setVertexBufferAt(1, _vertexBuffer, 3, Context3DVertexBufferFormat.FLOAT_2);	// va1
			// Vertex, Fragment 프로그램에서 사용될 상수 설정
			context.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, mvpMatrix, true);	// vc0
			context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, new <Number>[1.0, 1.0, 1.0, 1.0], 1);	// fc0
			// 텍스쳐 설정
			context.setTextureAt(1, _texture.baseTexture);	// ft1
			
			// Index Buffer의 설정에 따라서 삼각형을 그리기
			context.drawTriangles(_indexBuffer, 0, _numQuads * 2);
			
			painter.drawCount++;
			
			// 버퍼 비우기
			context.setVertexBufferAt(0, null);
			context.setVertexBufferAt(1, null);
			context.setTextureAt(1, null);
		}
		
		public function reset():void
		{
			_numQuads = 0;
			_capacity = 0;
			_vertexData = null;
			_indexData = null;
			_texture = null;
		}
		
		/**
		 * 다음 배치대상을 포함시킬지 말지 결정하는 메서드 
		 * @param texture
		 * @return 
		 */
		public function isStateChange(texture:FwTexture):Boolean
		{
			if (_numQuads + 1 > MAX_NUM_QUADS) return true;
			else if (_texture != null && texture != null)
			{
				if(_texture.parent == null && texture.parent == null) return true;
				else return _texture.parent != texture.parent;
			}
			else return true;
		}
		
		public function get numQuads():int { return _numQuads; }
		public function get texture():FwTexture { return _texture; }
		public function get capacity():Number { return _capacity; }
		public function set capacity(value:Number):void
		{
			_vertexData.length = value * 20;
			_indexData.length = value * 6;
			_capacity = value;
		}
	}
}