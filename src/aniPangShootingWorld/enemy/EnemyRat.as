package aniPangShootingWorld.enemy
{
	import flash.display.BitmapData;
	
	import aniPangShootingWorld.round.MenuVIew;
	
	import framework.display.ObjectType;
	import framework.display.Sprite;
	import framework.gameobject.BulletManager;
	
	/**
	 * Note @유영선 pig 객체와 거의 동일 하고 각각 객체 마다 특징을 가짐
	 * (객체에 대한 자세한 설명은 pig 객체 참고)
	 * RAT 적의 특징 : 체력이 높음
	 */	
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
			super(_enemyBitmapData);
			
			this.y = _enemyBitmapData.height*2;
			this.x =10;
	
			_prevTime = 0;
		}
		
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