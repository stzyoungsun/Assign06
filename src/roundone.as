package
{
	import flash.events.MouseEvent;
	
	import enemy.Enemyone;
	
	import framework.display.ObjectType;
	import framework.display.Sprite;
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
			_image6.addEventListener(MouseEvent.MOUSE_DOWN, onTouch);
			
			_image6.addEventListener(MouseEvent.MOUSE_DOWN, onTouch);
		}
		
		private function onTouch(event:MouseEvent):void
		{

			SceneManager.sceneChange(0);
			trace("hi");
		}
	}
}