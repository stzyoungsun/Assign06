package
{

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import framework.animaiton.AtlasBitmapData;
	import framework.animaiton.MoveClip;
	import framework.core.Framework;
	import framework.display.Image;
	import framework.display.Quad;
	import framework.display.Sprite;
	import framework.gameobject.Player;
	
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
		private var _image5 : Player;
		public function Main()
		{
//			var image : Image = new Image(500,900,(new TEXTURE()).bitmapData as BitmapData);
//			addChild(image);
//			
//			var image1 : Image = new Image(100,500,(new TEXTURE2()).bitmapData as BitmapData);
//			addChild(image1);
			
//			var quad : Quad  = new Quad(0,0,100,100,0xfff000);
//			addChild(quad);
//			_image2 = new Image(500,800,(new TEXTURE()).bitmapData as BitmapData);
//			addChild(_image2);
//			
//			//_image2.width =500;
//			//_image2.height = 30;
//			
//			_image2.addEventListener(MouseEvent.MOUSE_DOWN, onTouch);
//		
//			
//			var spriteSheet : Bitmap = (new SPRITESHEET()) as Bitmap;
//		
//			var byteArray:ByteArray = new SPRITESHEETXML() as ByteArray;
//			var xmlsprite:XML = new XML(byteArray.readUTFBytes(byteArray.length));
//		
//			 atlas  = new AtlasBitmapData(spriteSheet,xmlsprite);		
//		
//			 image4 = new MoveClip(atlas,0,0);
//			addChild(image4);
			
//			removeChild(quad);
//			quad.dispose();
//			
			var quad : Quad  = new Quad(0,0,100,100,0xfff000);
			addChild(quad);
				
			var quad1: Quad  = new Quad(300,150,100,100,0xff0000);
			addChild(quad1);
			
			var quad2 : Quad  = new Quad(300,500,100,100,0xffff00);
			addChild(quad2);
			
			var quad3 : Quad  = new Quad(600,600,100,100,0xf00000);
			addChild(quad3);
			
			var quad3 : Quad  = new Quad(100,400,100,300,0xf00000);
			addChild(quad3);
			_image5 = new Player((new TEXTURE()).bitmapData,(new TEXTURE2()).bitmapData,this);
			addChild(_image5);
			
			
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