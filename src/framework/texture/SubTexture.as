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
		private var _uvRegion:Rectangle;
		private var _bitmapData:BitmapData;
		
		public function SubTexture(baseTexture:Texture, parent:FwTexture, region:Rectangle, textureRegion:Rectangle)
		{
			_baseTexture = baseTexture;
			_parent = parent;
			_region = region;
			
			_uvRegion = new Rectangle(
				region.x / textureRegion.width,
				region.y / textureRegion.height,
				region.width / textureRegion.width,
				region.height / textureRegion.height
			);
		}
		
		public override function get bitmapData():BitmapData{ return _bitmapData; }
		public override function set bitmapData(bitmapData:BitmapData):void { _bitmapData = bitmapData; }
		public override function get baseTexture():Texture { return _baseTexture; }
		public override function get parent():FwTexture { return _parent; }
		public override function get region():Rectangle { return _region; }
		public override function get uvRegion():Rectangle { return _uvRegion; }
		public override function get width():Number { return region.width; }
		public override function get height():Number { return region.height; }
	}
}