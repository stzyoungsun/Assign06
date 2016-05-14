package aniPangShootingWorld.enemy.enemytype
{
	import flash.utils.getTimer;
	
	import aniPangShootingWorld.enemy.EnemyObject;
	import aniPangShootingWorld.enemy.EnemyObjectUtil;
	import aniPangShootingWorld.round.MenuView;
	import aniPangShootingWorld.util.HPbar;
	
	import framework.animaiton.AtlasBitmapData;
	import framework.display.ObjectType;
	import framework.display.Sprite;
	
	/**
	 * Note @유영선 pig 객체와 거의 동일 하고 각각 객체 마다 특징을 가짐
	 * (객체에 대한 자세한 설명은 pig 객체 참고)
	 * RAT 적의 특징 : 체력이 높음
	 */	
	public class EnemyRat extends EnemyObject
	{
		private var _enemyAtlas : AtlasBitmapData;
		
		private var _temp : int = 1;
		
		public function EnemyRat(enemyAtlas : AtlasBitmapData, frame : Number, stage : Sprite)
		{
			_enemyAtlas = enemyAtlas;
			super(_enemyAtlas,frame,stage);
			
			_prevTime = getTimer();
			
			_pEnemyType = EnemyObjectUtil.ENEMY_RAT;
			maxHP = 2;
		}	
	}
}