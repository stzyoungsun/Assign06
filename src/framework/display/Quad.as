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
		
		public function Quad(x:Number = 0, y:Number =0, width:Number = 0, height:Number =0,color:uint = 0xffffff)
		{
			_context = Framework.painter.context;
			
			if(_bitmapData == null)
			{
				_bitmapData = new BitmapData(width, height, false, color);
			}
			
			this.x = x;
			this.y = y;
			
			this.width = _bitmapData.width;
			this.height = _bitmapData.height;
			
			_bounds = new Rectangle(x, y, _bitmapData.width, _bitmapData.height);
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
				_texture = _context.createTexture(bitwidth,bitheight,Context3DTextureFormat.BGRA,false);
				_textureWidth = bitwidth;
				_textureHeight = bitheight;
			
				return true;
			}
			return false;
		}
		
		{
			
		}
		
		public override function render():void
		{
			
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
		public function set bitmapData(value:BitmapData):void { _bitmapData = value;this.width = _bitmapData.width; this.height = _bitmapData.height; }
		
		public override function get bounds():Rectangle { return new Rectangle(x, y, width, height); }
	}
}