package
{

	import flash.display.BitmapData;
	
	import framework.display.Image;
	import framework.display.Sprite;
	
	public class Main extends Sprite
	{
		[Embed(source="ani_play_button.png")]
		private static const TEXTURE:Class;
		
		public function Main()
		{
			
			var image : Image = new Image(500,900,(new TEXTURE()).bitmapData as BitmapData);
			addChild(image);
			
			var image1 : Image = new Image(100,900,(new TEXTURE()).bitmapData as BitmapData);
			addChild(image1);
			
			var image2 : Image = new Image(100,300,(new TEXTURE()).bitmapData as BitmapData);
			addChild(image2);
		}

	}
}