package enemy
{
	import flash.display.BitmapData;
	import flash.utils.getTimer;
	
	import framework.core.Framework;
	import framework.display.Image;
	import framework.display.ObjectType;
	import framework.display.Sprite;
	import framework.gameobject.BulletManager;
	import framework.gameobject.Collision;

	public class Enemyone extends Image
	{
		private var _enemyBitmapData : BitmapData;
		private var _bulletManager : BulletManager;
		
		private var _stage:Sprite;
		private var _temp : int = 1;
		private var _prevTime:Number;
		
		public function Enemyone(enemyBitmapData : BitmapData, bulletManager  : BulletManager,stage:Sprite )
		{
			_enemyBitmapData = enemyBitmapData;
			_bulletManager = bulletManager;
			super(0,0,_enemyBitmapData);
			
			this.y = _enemyBitmapData.height*2;
			this.x =10;
			this._objectType = ObjectType.ENEMY;
			
			_stage=stage;
			_bulletManager.createBullet(this.x,this.y);
			_prevTime = 0;
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
					_bulletManager.bulletVector[i].shootingState(bulletstate,i);
			}		
		}
		
		public function autoMoving():void
		{
			this.x += _temp;
			
			if(this.x >= Framework.viewport.width - _enemyBitmapData.width)
				_temp = -1;
			
			else if(this.x<= 0)
				_temp = 1;
		}
		
		public function bulletstate(bulletNum : Number) : void
		{
			_bulletManager.bulletVector[bulletNum].y += 5;
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
			
			autoMoving();
			
			bulletFrame();
		}
	}
}