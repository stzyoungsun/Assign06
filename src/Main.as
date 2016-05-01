package
{

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	import enemy.EnemyTwo;
	import enemy.Enemyone;
	
	import framework.animaiton.AtlasBitmapData;
	import framework.animaiton.MoveClip;
	import framework.core.Framework;
	import framework.display.Image;
	import framework.display.ObjectType;
	import framework.display.Quad;
	import framework.display.Sprite;
	import framework.event.Touch;
	import framework.event.TouchEvent;
	import framework.event.TouchPhase;
	import framework.gameobject.BulletManager;
	import framework.gameobject.Player;
	import framework.scene.Scene;
	import framework.scene.SceneManager;
	
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
		private var _image6 : Enemyone;
		private var _image7 : EnemyTwo;
		
		public function Main()
		{
			Scene.instance.addScene(this,0);
//			var spriteSheet : Bitmap = (new SPRITESHEET()) as Bitmap;
////		
//			var byteArray:ByteArray = new SPRITESHEETXML() as ByteArray;
//			var xmlsprite:XML = new XML(byteArray.readUTFBytes(byteArray.length));
////		
//			 atlas  = new AtlasBitmapData(spriteSheet,xmlsprite);		
//		
//			 image4 = new MoveClip(atlas,0,0);
//			addChild(image4);
			
//			removeChild(quad);
//			quad.dispose();
//			
//			var quad : Quad  = new Quad(0,0,100,100,0xfff000);
//			addChild(quad);
//				
//			var quad1: Quad  = new Quad(300,150,100,100,0xff0000);
//			addChild(quad1);
//			
//			var quad2 : Quad  = new Quad(300,500,100,100,0xffff00);
//			addChild(quad2);
//			
//			var quad3 : Quad  = new Quad(600,600,100,100,0xf00000);
//			addChild(quad3);
//			
//			var quad4 : Quad  = new Quad(100,400,100,300,0xf00000);
//			addChild(quad4);
			
			 var bulletmanager : BulletManager = new BulletManager(ObjectType.PLAYER_BULLET,30,(new TEXTURE2()).bitmapData);
			_image5 = new Player((new TEXTURE()).bitmapData,bulletmanager,this);
			addChild(_image5);
			
			var bulletmanager1 : BulletManager = new BulletManager(ObjectType.ENEMY_BULLET,30,(new TEXTURE2()).bitmapData);
			
			_image6 = new Enemyone((new TEXTURE()).bitmapData,bulletmanager1,this);
			addChild(_image6);
			_image6.addEventListener(TouchEvent.TOUCH, onTouch);
			
			var bulletmanager2 : BulletManager = new BulletManager(ObjectType.ENEMY_BULLET,30,(new TEXTURE2()).bitmapData);
			_image7 = new EnemyTwo((new TEXTURE()).bitmapData,bulletmanager2,this);
			addChild(_image7);
//			var moiveClip : MoveClip = new MoveClip(atlas,60,100,100);
//			moiveClip.frame = 1;
//			moiveClip.start();
//			
//			addChild(moiveClip)
			
			// 현재 스테이지와 플레이어 객체에 이벤트 추가
			Framework.stage.addEventListener(TouchEvent.TOUCH, onTouchStage);
			_image5.addEventListener(TouchEvent.TOUCH, onTouchStage);
		}
		
		private function onTouch(event:TouchEvent):void
		{
			var round : roundone  = new roundone();
			Scene.instance.addScene(round,1);
			SceneManager.sceneChange(1);
			trace("hi");
		}
		
		private function onTouchStage(event:TouchEvent):void
		{
			var touch:Touch = event.touch;
			
			if(touch.phase == TouchPhase.MOVED)
			{
				_image5.x += touch.globalX - touch.previousGlobalX;
			}
		}
	}
}