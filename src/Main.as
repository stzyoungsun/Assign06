package
{

	import flash.display.BitmapData;
	
	import framework.display.Image;
	import framework.display.Quad;
	import framework.display.Sprite;
	
	public class Main extends Sprite
	{
		[Embed(source="ani_play_button.png")]
		private static const TEXTURE:Class;
		
		public function Main()
		{
			
			var image : Image = new Image((new TEXTURE()).bitmapData as BitmapData);
			addChild(image);
				
		}
	}
}