package framework.texture
{
	import flash.display.BitmapData;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.textures.Texture;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getQualifiedClassName;
	
	import framework.Rendering.Painter;
	import framework.core.Framework;
	
	public class FwTexture
	{
		private static const S_RECT:Rectangle = new Rectangle();
		private static const S_POINT:Point = new Point();
		
		public function FwTexture()
		{
			if(getQualifiedClassName(this) == "Framework.texture.FTexture")
			{
				throw new Error("This class is abstract");
			}
		}
		
		public static function fromBitmapData(data:BitmapData):FwTexture
		{
			var texture:FwTexture = FwTexture.empty(data.width, data.height);
			
			if(data.width != texture.width || data.height != texture.height)
			{
				var powerOfTwoBimtapData:BitmapData = new BitmapData(texture.width, texture.height, true, 0x0);
				powerOfTwoBimtapData.copyPixels(data, data.rect, S_POINT);
				data = powerOfTwoBimtapData;
			}
			
			texture.baseTexture.uploadFromBitmapData(data);
			return texture;
		}
		
		public static function fromTexture(texture:FwTexture, region:Rectangle):FwTexture
		{
			return new SubTexture(texture.baseTexture, texture, region, new Rectangle(0, 0, texture.width, texture.height));
		}
		
		public static function empty(width:Number, height:Number):FwTexture
		{
			var painter:Painter = Framework.painter;
			var context:Context3D = painter.context;
			
			var originWidth:Number = width;
			var originHeight:Number = height;
			var textureWidth:Number = nextPowerOfTwo(width);
			var textureHeight:Number = nextPowerOfTwo(height);
			var nativeTexture:Texture = context.createTexture(textureWidth, textureHeight, Context3DTextureFormat.BGRA, false);
			
			return new SubTexture(nativeTexture, null, new Rectangle(0, 0, originWidth, originHeight), new Rectangle(0, 0, textureWidth, textureHeight));
		}
		
		/**
		 * v의 값보다 크거나 같은 2의 제곱 수를 찾아 반환하는 메서드 
		 * @param v - 검색하려는 데이터
		 * @return v보다 크거나 같은 2의 제곱 수
		 */
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
		
		public function get bitmapData():BitmapData{ return null; }
		public function set bitmapData(bitmapData:BitmapData):void {}
		public function get baseTexture():Texture { return null; }		
		public function get parent():FwTexture { return null; }
		public function get region():Rectangle { return null; }
		public function get uvRegion():Rectangle { return null; }
		public function get width():Number { return 0; }
		public function get height():Number { return 0; }
	}
}