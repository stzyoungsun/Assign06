package aniPangShootingWorld.boss
{
	import flash.utils.getTimer;
	
	import framework.animaiton.AtlasBitmapData;
	import framework.display.ObjectType;
	import framework.display.Sprite;
	import framework.gameobject.BulletManager;

	import aniPangShootingWorld.round.MenuView;
	public class OneRoundBoss extends BossObject
	{
		public static const ONE_BOSS_HP : Number  = 50;
		
		private var _bossAtlas : AtlasBitmapData;
		private var _bulletManager : BulletManager;
		private var _oneBossHP : Number = ONE_BOSS_HP;
		private var _stage:Sprite;
		
		public static var sBossLevel : Number =0;
		public function OneRoundBoss(bossAtlas : AtlasBitmapData, frame : Number, bulletManager : BulletManager, stage : Sprite)
		{
			_bossAtlas = bossAtlas;
			_stage = stage;
			super(_bossAtlas,frame,_stage);
		}
		
		public override function render():void
		{
			if(this.objectType == ObjectType.BOSS_GENERAL)
			{
				this._prevTime = getTimer();
			}
		
			//플레이어 미사일과 충돌 했을 경우
			else if(this.objectType == ObjectType.BOSS_COLLISION)
			{
				//체력 감소
				_oneBossHP--;
				//체력이 0일 경우
				if(_oneBossHP <= 0)
				{
					var curBossTime : Number = getTimer();
					//Note @유영선 2초간 죽는 모션
					if(curBossTime - this._prevTime < 2000)
					{
						this.bitmapData = MenuView.sloadedImage.imageDictionary["bossdie.png"].bitmapData;
					}
					
					else
					{
						sBossLevel++;
						this.objectType = ObjectType.BOSS_DIE;
						this.visible = false;
					}
				}
				
				else
				{
					this.objectType = ObjectType.BOSS_GENERAL;
				}
			}
			super.render();
		}
		
		public function get oneBossHP():Number{return _oneBossHP;}
	}
}