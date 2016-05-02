package framework.display
{
	import flash.display.BitmapData;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.VertexBuffer3D;
	import flash.display3D.textures.Texture;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import framework.Rendering.Painter;
	import framework.Rendering.VertexData;
	import framework.core.Framework;

	public class Quad extends DisplayObject
	{
		private static const TEMP_RECT:Rectangle = new Rectangle();
		private static const TEMP_POINT:Point = new Point();

		private var _context:Context3D;
		private var _bitmapData:BitmapData;
		private var _texture:Texture;
		
		public var _textureWidth:int;
		public var _textureHeight:int;
		
		private var _bounds:Rectangle;
		
		private var _fragConsts:Vector.<Number> = new <Number>[1, 1, 1, 1];
		
		private var _vertexData:VertexData;
		private var _vertexBuffer:VertexBuffer3D;
		private var _indexBuffer:IndexBuffer3D;
		
		public function Quad(x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0, color:uint = 0xffffff)
		{
			_context = Framework.painter.context;
			
			if(_bitmapData == null)
			{
				_bitmapData = new BitmapData(width, height, false, color);
			}
			
			_bounds = new Rectangle(x, y, _bitmapData.width, _bitmapData.height);
			
			this.x = x;
			this.y = y;
//			
//			this.width = _bitmapData.width;
//			this.height = _bitmapData.height;
			
			_vertexData = new VertexData(4);
			_vertexData.setPosition(0, 0.0, 0.0);
			_vertexData.setPosition(1, _bitmapData.width, 0.0);
			_vertexData.setPosition(2, 0.0, _bitmapData.height);
			_vertexData.setPosition(3, _bitmapData.width, _bitmapData.height);
//			_vertexData.setUniformColor(color);
			
			_vertexData.setTexCoords(0, 0.0, 0.0);
			_vertexData.setTexCoords(1, 1.0, 0.0);
			_vertexData.setTexCoords(2, 0.0, 1.0);
			_vertexData.setTexCoords(3, 1.0, 1.0);
		}
		
		public function  bitmapDataControl(bmd:BitmapData): void
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
						_fragConsts[0] = _textureWidth / width;
						_fragConsts[1] = _textureHeight / height;
					}
					else
					{
						// Reset UV scaling
						_fragConsts[0] = 1;
						_fragConsts[1] = 1;
					}
				}
			
			_texture.uploadFromBitmapData(bmd);
		}
		
		protected function createTexture(bitwidth:uint, bitheight:uint): Boolean
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
		
		public override function render():void
		{
//			this.width = _bitmapData.width;
//			this.height = _bitmapData.height;
			
			bitmapDataControl(_bitmapData);
			
			var painter:Painter = Framework.painter;
			var context:Context3D = painter.context;
			
			if (_vertexBuffer == null) createVertexBuffer();
			if (_indexBuffer  == null) createIndexBuffer();
			
			painter.setDefaultBlendFactors(true);
			
			context.setProgram(painter.program);
			context.setTextureAt(1, _texture);
			context.setVertexBufferAt(0, _vertexBuffer, VertexData.POSITION_OFFSET, Context3DVertexBufferFormat.FLOAT_3); 
//			context.setVertexBufferAt(1, _vertexBuffer, VertexData.COLOR_OFFSET,    Context3DVertexBufferFormat.FLOAT_4);
			context.setVertexBufferAt(2, _vertexBuffer, VertexData.TEXCOORD_OFFSET, Context3DVertexBufferFormat.FLOAT_2);
			context.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, painter.mvpMatrix, true);
			context.setProgramConstantsFromVector(Context3DProgramType.VERTEX, 4, _fragConsts);
			context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, new <Number>[1.0, 1.0, 1.0, 1.0], 1);

			context.drawTriangles(_indexBuffer, 0, 2);
			
			context.setTextureAt(1, null);
			context.setVertexBufferAt(0, null);
//			context.setVertexBufferAt(1, null);
			context.setVertexBufferAt(2, null);
		}
		
		private function createVertexBuffer():void
		{
			if (_vertexBuffer == null) 
				_vertexBuffer = Framework.painter.context.createVertexBuffer(4, VertexData.ELEMENTS_PER_VERTEX);
			
			_vertexBuffer.uploadFromVector(vertexData.data, 0, 4);
		}
		
		private function createIndexBuffer():void
		{
			if (_indexBuffer == null)
				_indexBuffer = Framework.painter.context.createIndexBuffer(6);
			
			_indexBuffer.uploadFromVector(Vector.<uint>([0, 1, 2, 1, 3, 2]), 0, 6);
		}
		
		public static function nextPowerOfTwo(v:uint): uint
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
		
		public function get vertexData():VertexData { return _vertexData.clone(); }
		public function get texture():Texture { return _texture; }
		public function set bitmapData(value:BitmapData):void { _bitmapData = value;this.width = _bitmapData.width; this.height = _bitmapData.height; }
		
		public override function get bounds():Rectangle { return _bounds; }
		public override function set width(value:Number):void
		{
			super.width = value;
			_vertexData.setPosition(0, 0.0, 0.0);
			_vertexData.setPosition(1, value, 0.0);
			_vertexData.setPosition(2, 0.0, height);
			_vertexData.setPosition(3, value, height);
			
			_bounds.width = value;
		}
		
		public override function set height(value:Number):void
		{
			super.height = value;
			_vertexData.setPosition(0, 0.0, 0.0);
			_vertexData.setPosition(1, width, 0.0);
			_vertexData.setPosition(2, 0.0, value);
			_vertexData.setPosition(3, width, value);
			
			_bounds.height = value;
		}
	}
}