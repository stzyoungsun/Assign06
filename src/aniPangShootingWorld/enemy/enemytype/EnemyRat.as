package aniPangShootingWorld.enemy.enemytype
{
	import aniPangShootingWorld.enemy.EnemyObject;
	import aniPangShootingWorld.enemy.EnemyObjectUtil;
	
	import framework.display.Sprite;
	import framework.texture.FwTexture;
	
	/**
	 * Note @유영선 pig 객체와 거의 동일 하고 각각 객체 마다 특징을 가짐
	 * (객체에 대한 자세한 설명은 pig 객체 참고)
	 * RAT 적의 특징 : 체력이 높음
	 */	
	public class EnemyRat extends EnemyObject
	{
		private var _stage : Sprite;
		
		public function EnemyRat(textureVector:Vector.<FwTexture>, frame:Number, stage:Sprite)
		{
			super(textureVector, frame, stage);
			_stage = stage;
			_prevTime = 0;
			
			_pEnemyType = EnemyObjectUtil.ENEMY_RAT;
			
			maxHP = 2;
		}
	}
}