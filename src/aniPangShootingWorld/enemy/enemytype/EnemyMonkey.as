package aniPangShootingWorld.enemy.enemytype
{
	import aniPangShootingWorld.enemy.EnemyObject;
	import aniPangShootingWorld.enemy.EnemyObjectUtil;
	
	import framework.display.Sprite;
	import framework.texture.FwTexture;
	
	/**
	 * Note @유영선 Monkey 적의 클래스 입니다. 
	 * Monkey 적의 특징 : 6의 높은 체력을 가집니다.
	 */
	public class EnemyMonkey extends EnemyObject
	{

		private var _stage:Sprite;
		
		public function EnemyMonkey(textureVector:Vector.<FwTexture>, frame : Number, stage : Sprite)
		{
			super(textureVector, frame, stage);
	
			//Note @유영선 ronud의 stage
			_stage = stage;
			
			//Note @유영선 시간 조절을 위한 변수 (Displayobject 변수)
			_prevTime = 0;
			
			_pEnemyType = EnemyObjectUtil.ENEMY_MONKEY;
			
			maxHP = 6;
		}
	}
}