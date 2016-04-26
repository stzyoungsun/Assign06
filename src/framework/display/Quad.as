package framework.display
{
	import flash.display.BitmapData;
	import flash.display3D.textures.Texture;

	public class Quad extends DisplayObject
	{
		private var _texture:Texture;
		public function Quad(x:int, y:int, color:uint)
		{
			var bitmapData:BitmapData = new BitmapData(128, 128, true, color);
			
			_texture.uploadFromBitmapData(bitmapData);			
		}
		
		public override function render():void
		{
			
		}
		
		public function get texture():Texture { return _texture; }
	}
}