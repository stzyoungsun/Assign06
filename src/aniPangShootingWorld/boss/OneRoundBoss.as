package aniPangShootingWorld.boss
{
	import flash.utils.getTimer;
	
	import aniPangShootingWorld.player.Player;
	
	import framework.animaiton.AtlasBitmapData;
	import framework.display.ObjectType;
	import framework.display.Sprite;
	import framework.gameobject.Bullet;
	import framework.gameobject.BulletManager;
	import framework.gameobject.Collision;
	
	public class OneRoundBoss extends BossObject
	{
		private static const PHASE_1:Number = 1;
		private static const PHASE_2:Number = 2;
		private static const PHASE_3:Number = 3;
		
		public static const MAX_BOSS_HP:Number = 150;
		
		private var _bossAtlas:AtlasBitmapData;
		private var _bulletManager:BulletManager;
		private var _bossHp:Number;
		private var _stage:Sprite;
		private var _shotAngle:Number;
		private var _shotSpeed:Number;
		private var _bossPhase:Number;
		private var _pattern:Number;
		private var _wait:Boolean;
		
		public function OneRoundBoss(bossAtlas : AtlasBitmapData, frame : Number, bulletManager : BulletManager, stage : Sprite)
		{
			_bossAtlas = bossAtlas;
			_stage = stage;
			super(_bossAtlas, frame, _stage);
			_bossHp = MAX_BOSS_HP;
			_bulletManager = bulletManager;
			_bulletManager.createBullet(this.x, this.y);
			_prevTime = getTimer();
			_bossPhase = PHASE_1;
			_shotAngle = 0;
			_shotSpeed = 10;
			_wait = false;
			_pattern = 1;
		}
		
		public override function render():void
		{
			super.render();
			
			var currentTime:Number = getTimer();
			
			// 페이즈 변경 후 발생하는 대기 시간
			if(currentTime - _prevTime > 2000)
			{
				_wait = false;
				_prevTime = currentTime;
			}
			
			// 대기시간이면 그냥 넘긴다.
			if(!_wait)
			{
				shotBullet();
			}
			
			if(this.objectType == ObjectType.BOSS_COLLISION)
			{
				//체력 감소
				_bossHp--;
				
				// 보스의 체력 비율에 따라 PHASE를 변경 시킴
				var bossHpRatio:Number = _bossHp / MAX_BOSS_HP;
				
				if(_bossPhase == PHASE_1 && bossHpRatio < 0.7)
				{
					_shotAngle = 0;
					_bossPhase = PHASE_2;
					_wait = true;
				}
				else if(_bossPhase == PHASE_2 && bossHpRatio < 0.3)
				{
					_shotAngle = 0;
					_bossPhase = PHASE_3;
					_wait = true;
				}
				
				//체력이 0일 경우
				if(_bossHp <= 0)
				{
					this.objectType = ObjectType.BOSS_DIE;
					
					for(var i:int = 0; i < _bulletManager.totalBullet; i++)
					{
						if(_bulletManager.bulletVector[i].objectType != ObjectType.ENEMY_BULLET_IDLE)
						{
							_stage.removeChild(_bulletManager.bulletVector[i]);
						}
					}
					_stage.removeChild(this);
					return;
				}
				else
				{
					this.objectType = ObjectType.BOSS_GENERAL;
				}
			}
			
			bulletFrame();
		}
		
		/**
		 * 보스가 특정 패턴에 따라 미사일을 발사하도록 하는 메서드 
		 * 
		 */
		private function shotBullet():void
		{
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
						_shotAngle = Math.atan2(Player.currentPlayer.y - bulletY, Player.currentPlayer.x - bulletX) / Math.PI / 2;
						shooting(bulletX, bulletY, _shotAngle, _shotSpeed + 5);
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
					shooting(bulletX, bulletY, _shotAngle, _shotSpeed + 3);
					break;
			}
		}
		
		/**
		 * 미사일과 벽에 출동 미사일과 플레이어의 충돌을 검사하는 함수 입니다.
		 */		
		public function bulletFrame() : void
		{
			for(var i:int = 0; i < _bulletManager.totalBullet; i++)
			{
				//Note @유영선 충돌 체크 매니져를 이용하여 벽과의 충돌과 미사일의 상태가 ENEMY_BULLET_COLLISION이면 stage에서 제거
				if((Collision.bulletToWall(_bulletManager.bulletVector[i])
					&& _bulletManager.bulletVector[i].objectType == ObjectType.ENEMY_BULLET_MOVING) 
					|| _bulletManager.bulletVector[i].objectType == ObjectType.ENEMY_BULLET_COLLISION)
				{
					_stage.removeChild(_bulletManager.bulletVector[i]);
					_bulletManager.bulletVector[i].objectType = ObjectType.ENEMY_BULLET_IDLE;
					_bulletManager.bulletNumVector.push(i);
				}
				else
				{
					//Note @유영선 충돌 상태가 아닐 경우 shootingState의 함수에 bulletstate 함수를 설정
					_bulletManager.bulletVector[i].shootingState(bulletState, i);
				}
			}
		}
		
		/**
		 * @param bulletNum 미사일 번호
		 * 번호에 맞는 미사일에 상태를 설정 합니다.
		 */
		public function bulletState(bulletNum : Number) : void
		{
			var bullet:Bullet = _bulletManager.bulletVector[bulletNum];
			var radian:Number = bullet.angle * Math.PI * 2;
			
			bullet.x += bullet.speed * Math.cos(radian);
			bullet.y += bullet.speed * Math.sin(radian);
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
			_bulletManager.bulletVector[bulletNum].initBullet(x, y, this.width / 10, this.height / 10, shotAngle, shotSpeed);
			//Note @유영선 round의 stage에 addChild
			_stage.addChild(_bulletManager.bulletVector[bulletNum]);	
		}
		
		public function get currentBossHp():Number{return _bossHp;}
	}
}