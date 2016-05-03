package aniPangShootingWorld.enemy
{
	import flash.display.BitmapData;
	
	import aniPangShootingWorld.round.MenuVIew;
	
	import framework.core.Framework;
	import framework.display.ObjectType;
	import framework.display.Sprite;
	import framework.gameobject.BulletManager;

	public class EnemyLine
	{
		private var _enemyBitmapDataVector : Vector.<BitmapData>;
		private var _enemyVector : Vector.<EnemyObject>;
		public static var _sCurLineCount :  Number = 5;
	
		/**
		 *Note @유영선 적 5명을 일렬로 세우기 위한 클래스 
		 * 
		 */		
		public function EnemyLine()
		{
			
		}
		/**
		 * 
		 * @param enemyBitmapDataVector 5명의 적의 비트맵을 담은 벡터
		 * @param enemyTypeArray 5명의 적의 Type 순서를 담은 배열
		 * 
		 * Note @유영선 5명의 적을 Type 배열의 순서에 따라 일렬로 출력합니다.
		 */		
		public function setEnemyLine(enemyBitmapDataVector : Vector.<BitmapData> , enemyTypeArray : Array, stage : Sprite) : void
		{
			_enemyBitmapDataVector = enemyBitmapDataVector;
			_enemyVector = new Vector.<EnemyObject>;
			for(var i:int = 0; i < _sCurLineCount; i++)
			{
				var bulletMgr : BulletManager = new BulletManager(ObjectType.ENEMY_BULLET_IDLE,1,MenuVIew.sloadedImage.imageDictionary["Bulletfour.png"].bitmapData);
				
				switch(enemyTypeArray[i])
				{
					
					case 0:
					{
						_enemyVector.push(new EnemyPig(_enemyBitmapDataVector[i],bulletMgr,stage));
						break;
					}
						
					case 1 :
					{
						_enemyVector.push(new EnemyRat(_enemyBitmapDataVector[i]));
						break;
					}
				}
				
				_enemyVector[i].width = Framework.viewport.width*4/25;
				_enemyVector[i].height = _enemyVector[i].width ;
				_enemyVector[i].x = Framework.viewport.width/30*(i+1) + _enemyVector[i].width*i;
				_enemyVector[i].y = 0;
			}
		}
		
		public function get enemyVector():Vector.<EnemyObject>{return _enemyVector;}
	}
}