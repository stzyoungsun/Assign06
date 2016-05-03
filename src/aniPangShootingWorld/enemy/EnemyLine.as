package aniPangShootingWorld.enemy
{
	import flash.display.BitmapData;
	
	import framework.core.Framework;

	public class EnemyLine
	{
		private var _enemyBitmapDataVector : Vector.<BitmapData>;
		private var _enemyVector : Vector.<EnemyObject>;
		public static var _sCurLineCount :  Number = 5;
	
		public function EnemyLine()
		{
			
		}
		
		public function setEnemyLine(enemyBitmapDataVector : Vector.<BitmapData>) : void
		{
			_enemyBitmapDataVector = enemyBitmapDataVector;
			_enemyVector = new Vector.<EnemyObject>;
			for(var i:int = 0; i < _sCurLineCount; i++)
			{
				_enemyVector.push(new EnemyPig(_enemyBitmapDataVector[i]));
				_enemyVector[i].width = Framework.viewport.width*4/25;
				_enemyVector[i].height = _enemyVector[i].width ;
				_enemyVector[i].x = Framework.viewport.width/30*(i+1) + _enemyVector[i].width*i;
				_enemyVector[i].y = 0;
			}
		}
		
		public function get enemyVector():Vector.<EnemyObject>{return _enemyVector;}
	}
}