package aniPangShootingWorld.enemy
{
	import flash.utils.getTimer;
	
	import aniPangShootingWorld.round.MenuView;
	import aniPangShootingWorld.util.HPbar;
	
	import framework.animaiton.AtlasBitmapData;
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
		private var _enemyAtlas : AtlasBitmapData;
		private var _bulletManager : BulletManager;
		
		private var _temp : int = 1;
		private var _stage : Sprite;
		
		public function EnemyRat(enemyAtlas : AtlasBitmapData, frame : Number, stage : Sprite)
		{
			_enemyAtlas = enemyAtlas;
			_stage = stage;
			super(_enemyAtlas,frame,stage);
			
			_prevTime = getTimer();
			
			maxHP = 2;
		}
		
		public override function render():void
		{
			if(this.objectType == ObjectType.ENEMY_GENERAL)
			{
				this.showImageAt(0);
			}	
			else if(this.objectType == ObjectType.ENEMY_COLLISION)
			{
				this.objectType = ObjectType.ENEMY_GENERAL;
				enemyHP--;
				this.showImageAt(1);
				
				if(enemyHP == 0)
				{
					this.objectType = ObjectType.ITEM_IDLE;
				}
			}
			super.render();
		}
		
		public override function dispose():void
		{
			super.dispose();
			_bulletManager = null;
			_stage = null;
			_enemyAtlas = null;
		}
	}
}