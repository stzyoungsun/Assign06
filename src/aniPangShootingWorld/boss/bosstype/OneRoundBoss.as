package aniPangShootingWorld.boss.bosstype
{
	import flash.utils.getTimer;
	
	import aniPangShootingWorld.item.ItemGroup;
	import aniPangShootingWorld.player.Player;
	import aniPangShootingWorld.round.Round;
	
	import framework.core.Framework;
	import framework.display.ObjectType;
	import framework.display.Sprite;
	import framework.gameobject.Bullet;
	import framework.gameobject.BulletManager;
	import framework.texture.FwTexture;
	import aniPangShootingWorld.boss.BossObject;
	
	public class OneRoundBoss extends BossObject
	{
		private static const PHASE_1:Number = 1;
		private static const PHASE_2:Number = 2;
		private static const PHASE_3:Number = 3;
		
		private var _bulletManager:BulletManager;
		private var _stage:Sprite;
		private var _shotAngle:Number;
		private var _shotSpeed:Number;
		private var _bossPhase:Number;
		private var _waitTime:Number;
		private var _wait:Boolean;
		private var _remainBullet:Boolean;
		
		public function OneRoundBoss(textureVector:Vector.<FwTexture>, frame:Number, bossMaxHP : Number, bulletManager:BulletManager, stage:Sprite)
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
			_bossPhase = PHASE_1;
			_wait = false;
			_waitTime = 2000;
			
			bossHp = bossMaxHP;
			maxBossHp = bossMaxHP;
		}
		
		/**
		 * 패턴 변경 후 보스가 공격하지 않고 대기시키도록 하는 메서드 
		 * @param waitTime - 대기 시간
		 */
		private function waitForPatternChange():void
		{
			if(_remainBullet)
			{
				for(var i:int = 0; i < _bulletManager.totalBullet; i++)
				{
					var bullet:Bullet = _bulletManager.bulletVector[i];
					if(bullet.objectType != ObjectType.ENEMY_BULLET_IDLE)
					{
						return;
					}
				}
				_remainBullet = false;
				_prevTime = getTimer();
			}
			
			var currentTime:Number = getTimer();
			if(currentTime - _prevTime > 500)
			{
				_wait = false;
				_prevTime = currentTime;
			}
		}
		
		/**
		 * 보스가 특정 패턴에 따라 미사일을 발사하도록 하는 메서드 
		 */
		public override function shotBullet():void
		{
			if(bossHp <= 0)
			{
				return;
			}
			
			if(_wait)
			{
				waitForPatternChange();
				return;
			}
			
			var bulletX:Number = 0;
			var bulletY:Number = 0;
			var bulletSpeed:Number = 0;
			
			switch(_bossPhase)
			{
				case PHASE_1:
					var currentTime:Number = getTimer();
					if(currentTime - _prevTime > 250)
					{
						bulletX = this.x + this.width / 2;
						bulletY = this.y;
						// 각도를 플레이어 객체가 있는 위치를 조준하도록 설정
						_shotAngle = Math.atan2(Player.currentPlayer.y - bulletY, Player.currentPlayer.x + Player.currentPlayer.width / 2 - bulletX) / Math.PI / 2;
						shooting(bulletX, bulletY, _shotAngle, _shotSpeed * 1.2);
						_prevTime = currentTime;
					}
					break;
				case PHASE_2:
					var randomPosition:int = Math.random() * 3;
					if(randomPosition == 0) { bulletX = this.x; }
					else if(randomPosition == 1) { bulletX = this.x + this.width / 2; }
					else if(randomPosition == 2) { bulletX = this.x + this.width; }
					bulletY = this.y + this.height / 2;
					_shotAngle += 0.05;
					_shotAngle -= Math.floor(_shotAngle);
					shooting(bulletX, bulletY, _shotAngle, _shotSpeed);
					break;
				case PHASE_3:
					bulletX = Math.random() * this.width;
					bulletY = this.y + this.height / 2;
					_shotAngle += 0.05;
					shooting(bulletX, bulletY, _shotAngle, _shotSpeed * 1.3);
					break;
			}
		}
		
		/**
		 * 체력 비율에 따라 보스의 Phase를 변경시키는 메서드
		 */
		public override function changePhase():void
		{
			// 보스의 체력 비율에 따라 PHASE를 변경 시킴
			var bossHpRatio:Number = bossHp / maxBossHp;
			
			if(_bossPhase == PHASE_1 && bossHpRatio < 0.8)
			{
				_shotAngle = 0;
				_bossPhase = PHASE_2;
				_wait = true;
				_remainBullet = true;
			}
			else if(_bossPhase == PHASE_2 && bossHpRatio < 0.4)
			{
				_shotAngle = 0;
				_bossPhase = PHASE_3;
				_wait = true;
				_remainBullet = true;
			}
		}
		
		/**
		 * 보스의 HP가 0이 되면 호출되는 메서드
		 */
		public override function dieBoss():void
		{
			var currentTime:Number = getTimer();
			// 3초후 제거
			if(currentTime - _prevTime > 3000)
			{
				// 보스 자신을 제거
				_stage.objectType = ObjectType.ROUND_CLEAR;
				_stage.removeChild(this);
				(_stage as Round).resultTimer = getTimer();
				var item : ItemGroup = new ItemGroup(30,this.x, this.y,_stage);
				item.drawItem();
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
			_bulletManager.bulletVector[bulletNum].initBullet(x, y, this.width / 15, this.height / 15, shotAngle, shotSpeed);
			//Note @유영선 round의 stage에 addChild
			_stage.addChild(_bulletManager.bulletVector[bulletNum]);	
		}
	}
}