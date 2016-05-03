package aniPangShootingWorld.enemy
{
	import flash.display.BitmapData;
	import flash.utils.getTimer;
	
	import aniPangShootingWorld.round.MenuVIew;
	
	import framework.core.Framework;
	import framework.display.ObjectType;
	import framework.display.Sprite;
	import framework.gameobject.BulletManager;
	import framework.gameobject.Collision;

	public class EnemyRat extends EnemyObject
	{
		private var _enemyBitmapData : BitmapData;
		private var _bulletManager : BulletManager;
		
		private var _stage:Sprite;
		private var _temp : int = 1;
		private var _prevTime:Number;
		private var _enemyHP : Number = 5;
		
		public function EnemyRat(enemyBitmapData : BitmapData)
		{
			_enemyBitmapData = enemyBitmapData;
			//_bulletManager = bulletManager;
			super(_enemyBitmapData);
			
			this.y = _enemyBitmapData.height*2;
			this.x =10;
			
			//_stage=stage;
			//_bulletManager.createBullet(this.x,this.y);
			_prevTime = 0;
		}
		
//		public function shooting() : void
//		{
//			var bulletNum : Number = _bulletManager.bulletNumVector.pop();
//			
//			_bulletManager.bulletVector[bulletNum].initBullet(this);
//			_stage.addChild(_bulletManager.bulletVector[bulletNum]);	
//		}
//		
//		public function bulletFrame() : void
//		{
//			for(var i :int= 0; i < _bulletManager.totalBullet; i ++)
//			{
//				if(Collision.bulletToWall(_bulletManager.bulletVector[i]))
//				{
//					_stage.removeChild(_bulletManager.bulletVector[i]);
//					_bulletManager.bulletNumVector.push(i);
//				}
//				else
//					_bulletManager.bulletVector[i].shootingState(bulletstate,i);
//			}		
//		}
//		public function bulletstate(bulletNum : Number) : void
//		{
//			_bulletManager.bulletVector[bulletNum].y += 5;
//		}
		
		
		public override function render():void
		{
			if(this.objectType == ObjectType.ENEMY_GENERAL)
			{
				this.bitmapData = MenuVIew.sloadedImage.imageDictionary["rat1.png"].bitmapData;
				autoMoving();
			}	
			else if(this.objectType == ObjectType.ENEMY_COLLISION)
			{
				this.objectType = ObjectType.ENEMY_GENERAL;
				_enemyHP--;
				this.bitmapData = MenuVIew.sloadedImage.imageDictionary["rat2.png"].bitmapData;
				
				if(_enemyHP == 0)
				{
					EnemyLine._sCurLineCount--;
					this.objectType = ObjectType.COIN;
					
				}
				if(EnemyLine._sCurLineCount == 0)
				{
					EnemyLine._sCurLineCount = 5;
					EnemyObjectUtil._sRedraw = true;
				}
			}
			else
			{
				this.bitmapData = MenuVIew.sloadedImage.imageDictionary["eat2.png"].bitmapData;
				autoMoving();
			}
			super.render();
		}
	}
}