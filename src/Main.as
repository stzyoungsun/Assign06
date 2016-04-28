package
{

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import framework.Anmaiton.AtlasBitmapData;
	import framework.display.Image;
	import framework.display.Sprite;
	
	public class Main extends Sprite
	{
		[Embed(source="ani_play_button.png")]
		private static const TEXTURE:Class;
		
		[Embed(source="ani_play_button2.png")]
		private static const TEXTURE2:Class;
		
		[Embed(source="SpriteSheet.png")]
		private static const SPRITESHEET:Class;
		
		[Embed(source="SpriteSheet.xml",mimeType="application/octet-stream")]
		private static const SPRITESHEETXML:Class;
		
		public function Main()
		{
			var image : Image = new Image(500,900,(new TEXTURE()).bitmapData as BitmapData);
			addChild(image);
			
			var image1 : Image = new Image(100,500,(new TEXTURE2()).bitmapData as BitmapData);
			addChild(image1);
			
			var image2 : Image = new Image(100,300,(new TEXTURE()).bitmapData as BitmapData);
			addChild(image2);
			
			image2.width =300;
			image2.height = 30;
			
			image2.addEventListener(MouseEvent.MOUSE_DOWN, onTouch);
			
			var spriteSheet : Bitmap = (new SPRITESHEET()) as Bitmap;
			
			var byteArray:ByteArray = new SPRITESHEETXML() as ByteArray;
			var xmlsprite:XML = new XML(byteArray.readUTFBytes(byteArray.length));
			
			var atlas : AtlasBitmapData = new AtlasBitmapData(spriteSheet,xmlsprite);
			
			var image3 : Image = new Image(0,0,atlas.getsubSpriteSheet["Attack01_141"]);
			addChild(image3);
		}
		
		private function onTouch(event:MouseEvent):void
		{
			trace("hi");
		}
	}
}