package framework.texture
{
	import flash.display.BitmapData;
	import flash.display3D.textures.Texture;
	import flash.geom.Rectangle;

	public class SubTexture extends FwTexture
	{
		private var _baseTexture:Texture;
		private var _parent:FwTexture;
		private var _region:Rectangle;
		private var _width:Number;
		private var _height:Number;
		private var _u:Number;
		private var _v:Number;
		private var _bitmapData:BitmapData;
		
		public function SubTexture(baseTexture:Texture, parent:FwTexture, region:Rectangle, textureRegion:Rectangle)
		{
			_baseTexture = baseTexture;
			_parent = parent;
			_region = region;
			_width = textureRegion.width;
			_height = textureRegion.height;
			_u = region.width / _width;
			_v = region.height / _height;
		}
		
		public override function get bitmapData():BitmapData{ return _bitmapData; }
		public override function set bitmapData(bitmapData:BitmapData):void { _bitmapData = bitmapData; }
		public override function get baseTexture():Texture { return _baseTexture; }
		public override function get parent():FwTexture { return _parent; }
		public override function get region():Rectangle { return _region; }
		public override function get u():Number { return _u; }
		public override function set u(bWidth:Number):void
		{
			var textureWidth:Number = FwTexture.nextPowerOfTwo(bWidth);
			_u = bWidth / textureWidth;
			_width = textureWidth;
			_region.width = bWidth;
		}
		
		public override function get v():Number { return _v; }
		public override function set v(bHeight:Number):void
		{
			var textureHeight:Number = FwTexture.nextPowerOfTwo(bHeight);
			_v = bHeight / textureHeight;
			_height = textureHeight;
			_region.height = bHeight;
		}
		public override function get width():Number { return _width; }
		public override function get height():Number { return _height; }
		public override function get bitmapWidth():Number { return region.width; }
		public override function get bitmapHeight():Number { return region.height; }
	}
}