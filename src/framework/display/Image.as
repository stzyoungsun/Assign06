package framework.display
{
	import flash.display.BitmapData;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.textures.Texture;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import framework.Rendering.Painter;
	import framework.core.Framework;
	
	/**
	 * Quad를 상속받은 클래스로 특정 비트맵을 텍스쳐로 입힌 후 화면에 그려지는 클래스
	 * @author jihwan.ryu youngsun.yoo
	 */
	public class Image extends Quad
	{
		private static const TEMP_RECT:Rectangle = new Rectangle();
		private static const TEMP_POINT:Point = new Point();
		
		private var _bitmapData:BitmapData;
		private var _texture:Texture;
		private var _textureWidth:int;
		private var _textureHeight:int;
		private var _uvCoordinate:Vector.<Number> = new <Number>[1, 1, 1, 1];
		
		/**
		 * 생성자 - x, y, bitmapData 인자를 통해 부모의 생성자를 호출 
		 * @param x - x좌표 값
		 * @param y - y좌표 값
		 * @param bitmapData - 텍스쳐로 생성하려는 비트맵 데이터
		 */
		public function Image(x:int, y:int, bitmapData:BitmapData)
		{
			// width와 height는 BitmapData 객체의 크기를 넣어준다
			super(x, y, bitmapData.width, bitmapData.height);
			
			_bitmapData = bitmapData;
		}
		
		/**
		 * Vertex 버퍼에 업로드할 데이터를 생성하는 메서드
		 */
		protected override function createBufferData():void
		{
			// raw 데이터 설정
			_vertexData = new <Number>
			[
			//	X,	Y,	Z,	U,	V
				0,	0,	0,	0,	0,
				0,	0,	0,	1,	0,
				0,	0,	0,	0,	1,
				0,	0,	0,	1,	1,
			]
			
			// 버텍스 당 데이터 갯수
			_numDataPerVertex = 5;
			
			// 버퍼 데이터 설정
			_vertexBuffer = Framework.painter.context.createVertexBuffer(4, _numDataPerVertex);
			_indexBuffer = Framework.painter.context.createIndexBuffer(6);
		}
		
		/**
		 * 렌더링 버퍼에 Vertex, Index 버퍼 데이터를 입력하여 화면에 출력하도록 하는 메서드. 쉐이더 프로그램에서 사용될 변수와 상수 데이터를 적용한다.
		 */
		public override function render():void
		{
			var painter:Painter = Framework.painter;
			var context:Context3D = painter.context;
			
			bitmapDataControl(_bitmapData);
			
			// Vertex, Index 버퍼에 데이터 업로드
			_vertexBuffer.uploadFromVector(_vertexData, 0, 4);
			_indexBuffer.uploadFromVector(Vector.<uint>([0, 1, 2, 1, 3, 2]), 0, 6);
			
			painter.setDefaultBlendFactors(true);
			
			// 쉐이더 프로그램 설정
			context.setProgram(painter.imageProgram);
			// Vertex 프로그램에서 사용될 변수를 위해 버퍼 등록
			context.setVertexBufferAt(0, _vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_3);	// va0
			context.setVertexBufferAt(1, _vertexBuffer, 3, Context3DVertexBufferFormat.FLOAT_2);	// va1
			// Vertex, Fragment 프로그램에서 사용될 상수 설정
			context.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, painter.mvpMatrix, true);	// vc0
			context.setProgramConstantsFromVector(Context3DProgramType.VERTEX, 4, _uvCoordinate);	// vc4
			context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, new <Number>[1.0, 1.0, 1.0, 1.0], 1);	// fc0
			// 텍스쳐 설정
			context.setTextureAt(1, _texture);	// ft1
			
			// Index Buffer의 설정에 따라서 삼각형을 그리기
			context.drawTriangles(_indexBuffer, 0, 2);
			
			// 버퍼 비우기
			context.setVertexBufferAt(0, null);
			context.setVertexBufferAt(1, null);
			context.setTextureAt(1, null);
		}
		
		/**
		 * 비트맵 데이터의 높이, 너비에 맞춰 Texture 객체를 생성한 후 그에 따라 UV 좌표를 설정하는 메서드 
		 * @param bmd - 텍스쳐로 만드려하는 비트맵 데이터
		 */
		private function bitmapDataControl(bmd:BitmapData): void
		{
			var width:uint = bmd.width;
			var height:uint = bmd.height;
			
			if (createTexture(width, height))
			{
				// If the new texture doesn't match the BitmapData's dimensions
				if (width != _textureWidth || height != _textureHeight)
				{
					// Create a BitmapData with the required dimensions
					var powOfTwoBMD:BitmapData = new BitmapData(
						_textureWidth,
						_textureHeight,
						bmd.transparent
					);
					
					// Copy the given BitmapData to the newly-created BitmapData
					TEMP_RECT.width = width;
					TEMP_RECT.height = height;
					powOfTwoBMD.copyPixels(bmd, TEMP_RECT, TEMP_POINT);
					
					// Upload the newly-created BitmapData instead
					bmd = powOfTwoBMD;
					
					// Scale the UV to the sub-texture
					_uvCoordinate[0] = _textureWidth / width;
					_uvCoordinate[1] = _textureHeight / height;
				}
				else
				{
					// Reset UV scaling
					_uvCoordinate[0] = 1;
					_uvCoordinate[1] = 1;
				}
			}
			
			_texture.uploadFromBitmapData(bmd);
		}
		
		/**
		 * Texture 객체를 생성하는 메서드 
		 * @param bitwidth - bitmapData의 너비
		 * @param bitheight - bitmapData의 높이
		 * @return 생성에 성공하면 true, 실패하면 false 반환
		 */
		private function createTexture(bitwidth:uint, bitheight:uint): Boolean
		{
			bitheight = nextPowerOfTwo(bitheight);
			bitwidth = nextPowerOfTwo(bitwidth);
			
			if (!_texture || _textureWidth != bitwidth || _textureHeight != bitheight)
			{
				_texture = Framework.painter.context.createTexture(bitwidth, bitheight, Context3DTextureFormat.BGRA,false);
				_textureWidth = bitwidth;
				_textureHeight = bitheight;
				
				return true;
			}
			return false;
		}
		
		/**
		 * v의 값보다 크거나 같은 2의 제곱 수를 찾아 반환하는 메서드 
		 * @param v - 검색하려는 데이터
		 * @return v보다 크거나 같은 2의 제곱 수
		 */
		private function nextPowerOfTwo(v:uint): uint
		{
			v--;
			v |= v >> 1;
			v |= v >> 2;
			v |= v >> 4;
			v |= v >> 8;
			v |= v >> 16;
			v++;
			return v;
		}
		
		public function get texture():Texture { return _texture; }
		public function set bitmapData(value:BitmapData):void { _bitmapData = value; }
	}
}