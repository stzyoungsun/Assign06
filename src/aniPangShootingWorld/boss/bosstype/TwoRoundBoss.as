package aniPangShootingWorld.boss.bosstype
{
	import flash.utils.getTimer;
	
	import aniPangShootingWorld.boss.BossObject;
	import aniPangShootingWorld.enemy.EnemyObject;
	import aniPangShootingWorld.enemy.enemytype.EnemyChicken;
	import aniPangShootingWorld.item.ItemGroup;
	import aniPangShootingWorld.player.Player;
	import aniPangShootingWorld.round.Round;
	import aniPangShootingWorld.round.Setting.RoundSetting;
	import aniPangShootingWorld.util.GameTexture;
	import aniPangShootingWorld.util.UtilFunction;
	
	import framework.core.Framework;
	import framework.display.ObjectType;
	import framework.display.Sprite;
	import framework.gameobject.BulletManager;
	import framework.texture.FwTexture;

	public class TwoRoundBoss  extends BossObject
	{
		private var _bulletManager:BulletManager;
		private var _stage:Sprite;
		private var _shotAngle:Number;
		private var _shotSpeed:Number;
		private var _bossPhase:Number;
		private var _waitTime:Number;
		private var _wait:Boolean;
		private var _remainBullet:Boolean;
		
		public static var stotalBossCnt : Number = 15;
		public function TwoRoundBoss(textureVector:Vector.<FwTexture>, frame:Number, bossMaxHP : Number, bulletManager:BulletManager, stage:Sprite)
		{
			super(textureVector, frame, bulletManager, stage);
			
			this.x = Framework.viewport.width / 8;
			this.y = 0;
			this.width = Framework.viewport.width * 4 / 5;
			this.height = Framework.viewport.height / 4;
			this.start();
			
			_prevTime = 0;
			
			_stage = stage;
			_bulletManager = bulletManager;
			_bulletManager.createBullet(this.x, this.y);
			
			_shotAngle = 0;
			_shotSpeed = Framework.viewport.height / 100;
			_wait = false;
			_waitTime = 2000;
			
			bossHp = bossMaxHP;
			maxBossHp = bossMaxHP;
			
			_name = "TwoRoundBoss";
		}
		
		/**
		 * 보스의 HP가 0이 되면 호출되는 메서드
		 */
		public override function dieBoss():void
		{
			var currentTime:Number = getTimer();
			// 3초후 제거
			if(currentTime - _prevTime > 2000)
			{
				devide();
				// 보스 자신을 제거
				
				_stage.removeChild(this);
				
				var item : ItemGroup = new ItemGroup(10,this.x, this.y,_stage);
				item.drawItem();
				
				stotalBossCnt--;
				if(stotalBossCnt == 0)
				{
					_stage.resultTimer = getTimer();
					_stage.objectType = ObjectType.ROUND_CLEAR;
					stotalBossCnt = 15;
				}
			}
		}
		
		public function devide() : void
		{
			var randomx : Number = 0;
			var randomy : Number = 0;
			if(this.width < Framework.viewport.width/8)
			{
				return;
			}
			for(var i : int =0 ; i < 2 ; ++i)
			{
				randomx = UtilFunction.random(0,Framework.viewport.width - this.width/2, 1);

				var childBoss : TwoRoundBoss = new TwoRoundBoss(GameTexture.boss2, 10, maxBossHp/2, 
					new BulletManager(ObjectType.ENEMY_BULLET_IDLE, 100, GameTexture.bullet[8]), _stage);
				
				childBoss.start();
				childBoss.addHPBar();
				childBoss.width = this.width/2;
				childBoss.height = this.height/2;
				
				if(i == 0)
					childBoss.x = this.x;
				else
					childBoss.x = this.x + childBoss.width;
				
				childBoss.y = Framework.viewport.height*0.1;
				
				_stage.addChild(childBoss);
			}	
		}
		
		public override function shotBullet():void
		{
			if(bossHp <= 0)
			{
				return;
			}
			var bulletX:Number = 0;
			var bulletY:Number = 0;
			var bulletSpeed:Number = 0;
			
			var currentTime:Number = getTimer();
			if(currentTime - _prevTime > 350)
			{
				bulletX = this.x + this.width / 2;
				bulletY = this.y;
				// 각도를 플레이어 객체가 있는 위치를 조준하도록 설정
				_shotAngle = Math.atan2(Player.currentPlayer.y - bulletY, Player.currentPlayer.x + Player.currentPlayer.width / 2 - bulletX) / Math.PI / 2;
				shooting(bulletX, bulletY, _shotAngle, _shotSpeed * 1.2);
				_prevTime = currentTime;
			}
		}
		
		/**
		 * 미사일을 발사 하는 함수 입니다. 미리 생성해 놓은 미사일을 선택하여 발사 합니다. 
		 */		
		public function shooting(x:Number, y:Number, shotAngle:Number, shotSpeed:Number) : void
		{
			//Note @유영선 발사 할 미사일 번호를 저장하는 변수
			var bulletNum:Number = _bulletManager.bulletNumVector.pop();
			//Note @유영선 선택 된 미사일을 ENEMY_BULLET_MOVING 상태로 설정
			_bulletManager.bulletVector[bulletNum].objectType = ObjectType.ENEMY_BULLET_MOVING;
			//Note @유영선 선택 된 미사일을 적들의 위치에 따라 재설정 그리고 크거 조절
			_bulletManager.bulletVector[bulletNum].initBullet(x, y, Framework.viewport.width/30, Framework.viewport.width/30, shotAngle, shotSpeed);
			//Note @유영선 round의 stage에 addChild
			_stage.addChild(_bulletManager.bulletVector[bulletNum]);	
			_bulletManager.bulletVector[bulletNum].visible = true;
		}
	}
}