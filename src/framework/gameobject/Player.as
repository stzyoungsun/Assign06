package framework.gameobject
{
	import flash.display.BitmapData;
	import flash.utils.getTimer;
	
	import framework.core.Framework;
	import framework.display.Image;
	import framework.display.Sprite;

	/**
	 * @author user
	 * Note @유영선 플레이어 객체는 사용자의 마우스 움직임에 따라 X값이 자동으로 바뀌는 객체
	 */
	public class Player extends Image
	{
		private var _playBitmapData:BitmapData;
		private var _bulletManager:BulletManager;
		private var _stage:Sprite;
		private var _prevTime:Number;
		
		public function Player(playBitmapData : BitmapData, bulletManager  : BulletManager,stage:Sprite )
		{
			_playBitmapData = playBitmapData;
			_bulletManager = bulletManager;
			
			y = Framework.viewport.height - _playBitmapData.height * 2;
			super(0, y, _playBitmapData);
			
			_bulletManager.createBullet(this.x,this.y);
			
			_stage=stage;
			_playBitmapData = null;
			_prevTime = 0;
		}
		
		public override function dispose():void
		{
			_stage = null;
		}
		
		public function shooting() : void
		{
			var bulletNum : Number = _bulletManager.bulletNumVector.pop();
			
			_bulletManager.bulletVector[bulletNum].initBullet(this);
			_stage.addChild(_bulletManager.bulletVector[bulletNum]);	
		}
		
		public function bulletFrame() : void
		{
			for(var i :int= 0; i < _bulletManager.totalBullet; i ++)
			{
				if(Collision.bulletToWall(_bulletManager.bulletVector[i]))
				{
					_stage.removeChild(_bulletManager.bulletVector[i]);
					_bulletManager.bulletNumVector.push(i);
				}
				else
				{
					_bulletManager.bulletVector[i].shootingState();
				}
			}
		}
		
		public override function render():void
		{
			super.render();
			
			var curTimerBullet:int = getTimer();
			
			if(curTimerBullet - _prevTime > 500)
			{
				shooting();
				_prevTime = getTimer();
			}
			
			bulletFrame();
		}
	}
}