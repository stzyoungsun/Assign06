package enemy
{
	import flash.display.BitmapData;
	
	import framework.core.Framework;
	import framework.display.Image;
	import framework.display.ObjectType;
	import framework.display.Sprite;
	import framework.gameobject.BulletManager;
	import framework.gameobject.Collision;

	public class EnemyTwo extends Image
	{
		private var _enemyBitmapData : BitmapData;
		private var _bulletManager : BulletManager;
		
		private var _stage:Sprite;
		private var _temp : int = 1;
		public function EnemyTwo(enemyBitmapData : BitmapData, bulletManager  : BulletManager,stage:Sprite )
		{
			_enemyBitmapData = enemyBitmapData;
			_bulletManager = bulletManager;
			super(0,0,_enemyBitmapData);
			
			this.y = _enemyBitmapData.height*8;
			this.x =Framework.viewport.width;
			this._objectType = ObjectType.ENEMY;
			
			_stage=stage;
			_bulletManager.createBullet(this.x,this.y);
		}
		
		public override function shooting() : void
		{
			// Abstract Method
			var bulletNum : Number = _bulletManager.bulletNumVector.pop();
			
			_bulletManager.bulletVector[bulletNum].initBullet(this);
			_stage.addChild(_bulletManager.bulletVector[bulletNum]);	
		}
		
		public override function bulletFrame() : void
		{
			// Abstract Method
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
		
		public override function autoMoving():void
		{
			this.x+=_temp;
			
			if(this.x >= Framework.viewport.width - _enemyBitmapData.width)
				_temp = -1;
			
			else if(this.x<= 0)
				_temp = 1;
		}
		
		public function bulletstate(bulletNum : Number) : void
		{
			_bulletManager.bulletVector[bulletNum].x += 5;
			_bulletManager.bulletVector[bulletNum].y += 15;
		}
	}
}