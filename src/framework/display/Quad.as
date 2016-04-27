package framework.display
{
	import flash.display.BitmapData;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.textures.Texture;
	import flash.geom.Matrix3D;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	
	import framework.Rendering.Painter;
	import framework.core.Framework;
	

	public class Quad extends DisplayObject
	{
		private static const TEMP_MATRIX3D:Matrix3D = new Matrix3D();
		private static const TEMP_RECT:Rectangle = new Rectangle();
		private static const TEMP_POINT:Point = new Point();
		private static const Z_AXIS:Vector3D = Vector3D.Z_AXIS;

		private var _context:Context3D;
		private var _bitmapData:BitmapData;
		private var _painter : Painter;
		private var _texture:Texture;
		
		public var _textureWidth:int;
		public var _textureHeight:int;
		
		private var _drawx : Number;
		private var _drawy : Number;
		private var _drawWidth : Number;
		private var _drawHeight : Number;
		private var _bounds:Rectangle;
		
		private var _fragConsts:Vector.<Number> = new <Number>[1, 1, 1, 1];
		
		public function Quad(x:Number = 0, y:Number =0, width:Number = 0, height:Number =0,color:uint = 0xffffff)
		{
			_painter = Framework.painter;
			_context = _painter.context;
			
			if(_bitmapData == null)
			{
				_bitmapData = new BitmapData(width, height, false, color);
			}
			
			this.x = x;
			this.y = y;
			
			if(width == 0 && height == 0)
			{
				this.width = _bitmapData.width;
				this.height = _bitmapData.height;
			}
			else
			{
				this.width = width;
				this.height = height;
			}
			
			_bounds = new Rectangle(x, y, _bitmapData.width, _bitmapData.height);
			
			bitmapDataControl(_bitmapData);
		}
		
		public function  bitmapDataControl(bmd:BitmapData): void
		{
			var width:uint = bmd.width;
			var height:uint = bmd.height;
			
			if(_texture == null)
			{
				if (createTexture(_bitmapData.width, _bitmapData.height))
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
			}
			_texture.uploadFromBitmapData(bmd);
		}
		
		protected function createTexture(bitwidth:uint, bitheight:uint): Boolean
		{
			bitheight = nextPowerOfTwo(bitheight);
			bitwidth = nextPowerOfTwo(bitwidth);
			
			if (!_texture || _textureWidth != bitwidth || _textureHeight != bitheight)
			{
				_texture = _context.createTexture(bitwidth,bitheight,Context3DTextureFormat.BGRA,false);
				_textureWidth = bitwidth;
				_textureHeight = bitheight;
				
				
				return true;
			}
			return false;
		}
		
		public function controlBitmap() : void
		{
			_drawx = (this.x-Framework.viewport.width/2)/(Framework.viewport.width/2);
			_drawy = (Framework.viewport.height/2-this.y)/(Framework.viewport.height/2);
			
			_drawWidth = (this.width)/Framework.viewport.width;
			_drawHeight = (this.height)/Framework.viewport.height;
		}
		
		public override function render():void
		{
			controlBitmap();
			
			var  mModelViewMatrix : Matrix3D = new Matrix3D();
			TEMP_MATRIX3D.identity();
			TEMP_MATRIX3D.appendRotation(-rotation, Z_AXIS);
			TEMP_MATRIX3D.appendScale(_drawWidth, _drawHeight, 1);
			TEMP_MATRIX3D.appendTranslation(_drawx+_drawWidth,_drawy-_drawHeight,0);
			
			_context.setProgram(_painter.program);
			_context.setTextureAt(0, _texture);
			_context.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, TEMP_MATRIX3D, true);
			_context.setProgramConstantsFromVector(Context3DProgramType.VERTEX, 4, _fragConsts);
			_context.setVertexBufferAt(0, _painter.vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_3);
			_context.setVertexBufferAt(1, _painter.vertexBuffer, 3, Context3DVertexBufferFormat.FLOAT_2);
			_context.drawTriangles(_painter.indexBuffer);
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
		
		public function get texture():Texture { return _texture; }
		public function set bitmapData(value:BitmapData):void { _bitmapData = value; }
		public override function get bounds():Rectangle { return new Rectangle(x, y, width, height); }
	}
}