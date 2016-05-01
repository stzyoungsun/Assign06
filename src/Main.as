package
{
	import flash.display.Bitmap;
	import flash.utils.ByteArray;
	
	import enemy.EnemyTwo;
	import enemy.Enemyone;
	
	import framework.animaiton.AtlasBitmapData;
	import framework.animaiton.MovieClip;
	import framework.background.BackGround;
	import framework.core.Framework;
	import framework.display.Image;
	import framework.display.ObjectType;
	import framework.display.Sprite;
	import framework.event.Touch;
	import framework.event.TouchEvent;
	import framework.event.TouchPhase;
	import framework.gameobject.BulletManager;
	import framework.gameobject.Player;
	import framework.scene.Scene;
	
	public class Main extends Sprite
	{
		[Embed(source="ani_play_button.png")]
		private static const TEXTURE:Class;
		
		[Embed(source="ani_play_button2.png")]
		private static const TEXTURE2:Class;
		
		[Embed(source="SpriteSheet.png")]
		private static const SPRITESHEET:Class;
		
		[Embed(source="background1.jpg")]
		private static const BACK:Class;
		
		[Embed(source="background_2.png")]
		private static const BACK1:Class;
		
		[Embed(source="SpriteSheet.xml",mimeType="application/octet-stream")]
		private static const SPRITESHEETXML:Class;
		private var image4 : MovieClip;
		private var atlas : AtlasBitmapData;
		private var _image5 : Player;
		private var _image6 : Enemyone;
		private var _image7 : EnemyTwo;
		public function Main()
		{
			Scene.instance.addScene(this,0);
			
			var Backgorund : BackGround = new BackGround(2,30,1,(new BACK()).bitmapData);
			addChild(Backgorund);
			
			var Backgorund1 : BackGround = new BackGround(2,60,10,(new BACK1()).bitmapData);
			addChild(Backgorund1);
			
			var spriteSheet : Bitmap = (new SPRITESHEET()) as Bitmap;
			var byteArray:ByteArray = new SPRITESHEETXML() as ByteArray;
			var xmlsprite:XML = new XML(byteArray.readUTFBytes(byteArray.length));
			atlas  = new AtlasBitmapData(spriteSheet,xmlsprite);
			image4 = new MovieClip(atlas, 60, 0);
			image4.start();
			addChild(image4);
			
			 var bulletmanager : BulletManager = new BulletManager(ObjectType.PLAYER_BULLET,30,(new TEXTURE2()).bitmapData);
			_image5 = new Player((new TEXTURE()).bitmapData,bulletmanager,this);
			addChild(_image5);
			_image5.width = Framework.viewport.width/15;
			_image5.height= Framework.viewport.height/15;
			_image5.y = Framework.viewport.height- _image5.height*2;
				
			var bulletmanager1 : BulletManager = new BulletManager(ObjectType.ENEMY_BULLET,30,(new TEXTURE2()).bitmapData);
			_image6 = new Enemyone((new TEXTURE()).bitmapData,bulletmanager1,this);
			addChild(_image6);
			_image6.width = Framework.viewport.width/20;
			_image6.height= Framework.viewport.height/20;
			
			var bulletmanager2 : BulletManager = new BulletManager(ObjectType.ENEMY_BULLET,30,(new TEXTURE2()).bitmapData);
			_image7 = new EnemyTwo((new TEXTURE()).bitmapData,bulletmanager2,this);
			addChild(_image7);
			_image7.width = Framework.viewport.width/20;
			_image7.height= Framework.viewport.height/20;
			
			Backgorund1.addEventListener(TouchEvent.TOUCH, onTouchStage);
			_image5.addEventListener(TouchEvent.TOUCH, onTouchStage);
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