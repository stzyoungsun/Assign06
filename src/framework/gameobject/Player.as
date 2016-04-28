package framework.gameobject
{
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	
	import framework.core.Framework;
	import framework.display.Image;
	import framework.display.Sprite;

	/**
	 * 
	 * @author user
	 * Note @유영선 플레이어 객체는 사용자의 마우스 움직임에 따라 X값이 자동으로 바뀌는 객체
	 */
	public class Player extends Image
	{
		private var _playBitmapData : BitmapData;
		private var _bulletBitmapData : BitmapData;
		
		private var _bulletArray : Vector.<Bullet> = new Vector.<Bullet>;
		private var _bulletCount : int = 0;
		private var _stage:Sprite;
		
		public function Player(playBitmapData : BitmapData, bulletBitmap : BitmapData,stage:Sprite )
		{
			_playBitmapData = playBitmapData;
			_bulletBitmapData = bulletBitmap;
			
			y = Framework.viewport.height - _playBitmapData.height*2;
			super(0,y,_playBitmapData);
			
			_playerFlag = true;
			
			addEventListener(MouseEvent.MOUSE_OVER,onOver);
			_stage=stage;
			playBitmapData = null;
		}
		
		private function onOver(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			trace(Framework.mousex);
			this.x= Framework.mousex;
		}
		
		public override function createBullet() : void
		{
			_bulletArray[_bulletCount] = new Bullet(this.x,this.y,_bulletBitmapData);
			_stage.addChild(_bulletArray[_bulletCount++]);
		}
	}
}