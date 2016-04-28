package
{

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import mx.core.mx_internal;
	
	import framework.Anmaiton.AtlasBitmapData;
	import framework.Anmaiton.MoveClip;
	import framework.display.Image;
	import framework.display.Quad;
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
		private var image4 : MoveClip;
		private var atlas : AtlasBitmapData;
		private var _image2 : Image;
		public function Main()
		{
//			var image : Image = new Image(500,900,(new TEXTURE()).bitmapData as BitmapData);
//			addChild(image);
//			
//			var image1 : Image = new Image(100,500,(new TEXTURE2()).bitmapData as BitmapData);
//			addChild(image1);
			
			var quad : Quad  = new Quad(0,0,100,100,0xfff000);
			addChild(quad);
			_image2 = new Image(500,800,(new TEXTURE()).bitmapData as BitmapData);
			addChild(_image2);
			
			//_image2.width =500;
			//_image2.height = 30;
			
			_image2.addEventListener(MouseEvent.MOUSE_DOWN, onTouch);
			
			var spriteSheet : Bitmap = (new SPRITESHEET()) as Bitmap;
		
			var byteArray:ByteArray = new SPRITESHEETXML() as ByteArray;
			var xmlsprite:XML = new XML(byteArray.readUTFBytes(byteArray.length));
		
			 atlas  = new AtlasBitmapData(spriteSheet,xmlsprite);		
		
			 image4 = new MoveClip(atlas,0,0);
			addChild(image4);
		}
	
		private function onTouch(event:MouseEvent):void
		{
			image4.x = 100;
			image4.y = 100;
			image4.clipwidth = 500;
			image4.clipheight = 500;
			
			image4.start();
			trace("hi");
		}
	}
}