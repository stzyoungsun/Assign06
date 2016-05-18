package aniPangShootingWorld.boss.subboss
{
	import flash.utils.getTimer;
	
	import aniPangShootingWorld.boss.BossObject;
	import aniPangShootingWorld.player.Player;
	
	import framework.core.Framework;
	import framework.display.ObjectType;
	import framework.display.Sprite;
	import framework.gameobject.BulletManager;
	import framework.texture.FwTexture;

	public class ThreeRoundSubBoss extends BossObject
	{
		private var _bulletManager:BulletManager;
		private var _stage:Sprite;
		private var _shotAngle:Number;
		private var _shotSpeed:Number;
		private var _bossPhase:Number;
		private var _waitTime:Number;
		private var _wait:Boolean;
		private var _remainBullet:Boolean;
		private var _parentBoss : BossObject;
		
		public function ThreeRoundSubBoss(parentBoss : BossObject,textureVector:Vector.<FwTexture>, frame:Number, bossMaxHP : Number, bulletManager:BulletManager, stage:Sprite)
		{
			super(textureVector, frame, bulletManager, stage);
			
			_parentBoss = parentBoss;
			
			this.width = _parentBoss.width/2;
			this.height = _parentBoss.height/2;
			this.start();
			
			_prevTime = 0;
			
			_stage = stage;
			
			_bulletManager = bulletManager;
			_bulletManager.createBullet(this.x, this.y);
			
			_shotAngle = 0;
			_shotSpeed = Framework.viewport.height / 500;
			_wait = false;
			_waitTime = 2000;
			
			bossHp = bossMaxHP;
			maxBossHp = bossMaxHP;
		}
		
		public function initSubBoss(x : Number, y : Number) : void
		{
			this.x = x;
			this.y = y;
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
			if(currentTime - _prevTime > 500)
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
		}
	}
}