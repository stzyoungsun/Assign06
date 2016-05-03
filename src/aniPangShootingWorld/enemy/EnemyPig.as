
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


	public class EnemyPig extends EnemyObject
	{
		private var _enemyBitmapData : BitmapData;
		private var _bulletManager : BulletManager;
		
		private var _stage:Sprite;
		private var _temp : int = 1;
		private var _prevTime:Number;
		private var _enemyHP : Number = 1;
		public function EnemyPig(enemyBitmapData : BitmapData, bulletManager : BulletManager, stage : Sprite)
		{
			_enemyBitmapData = enemyBitmapData;
			_bulletManager = bulletManager;
			super(enemyBitmapData);
			
			this.y = _enemyBitmapData.height/8;
			this.x =Framework.viewport.width;
			_bulletManager.createBullet(this.x,this.y);
			_stage = stage;
			_prevTime = 0;
		}
		
		public function shooting() : void
		{
			var bulletNum : Number = _bulletManager.bulletNumVector.pop();
			
			_bulletManager.bulletVector[bulletNum].objectType = ObjectType.ENEMY_BULLET_MOVING;
			_bulletManager.bulletVector[bulletNum].initBullet(this.x+this.width/3,this.y,this.width/5, this.height/5);
			_stage.addChild(_bulletManager.bulletVector[bulletNum]);	
		}
		
		public function bulletFrame() : void
		{
			
			for(var i :int= 0; i < _bulletManager.totalBullet; i ++)
			{
				if(Collision.bulletToWall(_bulletManager.bulletVector[i]) || _bulletManager.bulletVector[i].objectType == ObjectType.ENEMY_BULLET_COLLISION)
				{
					_stage.removeChild(_bulletManager.bulletVector[i]);
				}
				else
					_bulletManager.bulletVector[i].shootingState(bulletstate,i);
			}		
		}
		
		public function bulletstate(bulletNum : Number) : void
		{
			_bulletManager.bulletVector[bulletNum].y += Framework.viewport.height/80;
		}
		
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
				_enemyHP--;
				this.bitmapData = MenuVIew.sloadedImage.imageDictionary["pig2.png"].bitmapData;
				
	
				if(_enemyHP == 0)
				{				
					shooting();
			
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
			
			if(_bulletManager.bulletVector[0].objectType != ObjectType.ENEMY_BULLET_IDLE) 
				bulletFrame();
			super.render();
		}
		
		public override function dispose():void
		{
			super.dispose();
		}
		
	}
}