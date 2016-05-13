package aniPangShootingWorld.enemy.enemytype
{
	import aniPangShootingWorld.enemy.EnemyObject;
	import aniPangShootingWorld.enemy.EnemyObjectUtil;
	
	import framework.animaiton.AtlasBitmapData;
	import framework.display.Sprite;
	import framework.gameobject.BulletManager;

	public class EnemyMonkey extends EnemyObject
	{
		private var _enemyAtlas : AtlasBitmapData;

		private var _stage:Sprite;
		private var _temp : int = 1;
		
		public function EnemyMonkey(enemyAtlas : AtlasBitmapData, frame : Number, bulletManager : BulletManager, stage : Sprite)
		{
			//Note @유영선 적 객체의 비트맵데이터
			_enemyAtlas = enemyAtlas;

			super(_enemyAtlas,frame,stage);
	
			//Note @유영선 ronud의 stage
			_stage = stage;
			//Note @유영선 시간 조절을 위한 변수 (Displayobject 변수)
			_prevTime = 0;
			
			_pEnemyType = EnemyObjectUtil.ENEMY_MONKEY;
			maxHP = 6;
			
			_stage = null;
		}
	}
}