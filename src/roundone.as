package
{
	import enemy.Enemyone;
	
	import framework.display.ObjectType;
	import framework.display.Sprite;
	import framework.event.TouchEvent;
	import framework.gameobject.BulletManager;
	import framework.scene.SceneManager;

	public class roundone extends Sprite
	{
		[Embed(source="ani_play_button.png")]
		private static const TEXTURE:Class;
		private var _image6 : Enemyone;
		
		public function roundone() 
		{
			var bulletmanager1 : BulletManager = new BulletManager(ObjectType.ENEMY_BULLET,30,(new TEXTURE()).bitmapData);
			_image6 = new Enemyone((new TEXTURE()).bitmapData,bulletmanager1,this);
			addChild(_image6);
			_image6.addEventListener(TouchEvent.TOUCH, onTouch);
			_image6.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(event:TouchEvent):void
		{
			SceneManager.sceneChange(0);
			trace("hi");
		}
	}
}