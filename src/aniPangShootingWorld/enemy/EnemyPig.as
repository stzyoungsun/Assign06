
package aniPangShootingWorld.enemy
{
	import flash.display.BitmapData;
	
	import aniPangShootingWorld.round.MenuVIew;
	
	import framework.core.Framework;

	import framework.display.ObjectType;
	import framework.display.Sprite;


	public class EnemyPig extends EnemyObject
	{
		private var _enemyBitmapData : BitmapData;
		//private var _bulletManager : BulletManager;
		
		private var _stage:Sprite;
		private var _temp : int = 1;
		private var _prevTime:Number;
		private var _hp : Number = 2;
		public function EnemyPig(enemyBitmapData : BitmapData)
		{
			_enemyBitmapData = enemyBitmapData;
			//_bulletManager = bulletManager;
			super(enemyBitmapData);
			
			this.y = _enemyBitmapData.height/8;
			this.x =Framework.viewport.width;
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
		
		public function autoMoving():void
		{
			
			this.y+=Framework.viewport.height/100;
			
			if(this.y > Framework.viewport.height)
			{
				EnemyObjectUtil._sRedraw = true;
				EnemyLine._sCurLineCount = 5;
				this.y = 0;
			}
				
		}
		
//		public function bulletstate(bulletNum : Number) : void
//		{
//			_bulletManager.bulletVector[bulletNum].x += 5;
//			_bulletManager.bulletVector[bulletNum].y += 15;
//		}
		
		public override function render():void
		{
			if(this.objectType == ObjectType.ENEMY_GENERAL)
			{
				this.bitmapData = MenuVIew.sloadedImage.imageDictionary["pig1.png"].bitmapData;
				autoMoving();
			}	
			else if(this.objectType == ObjectType.ENEMY_COLLISION)
			{
				this.objectType = ObjectType.ENEMY_GENERAL;
				_hp--;
				this.bitmapData = MenuVIew.sloadedImage.imageDictionary["pig2.png"].bitmapData;
				
				if(_hp == 0)
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
				this.bitmapData = MenuVIew.sloadedImage.imageDictionary["coin1.png"].bitmapData;
				autoMoving();
			}
			super.render();
			//bulletFrame();
		}
	}
}