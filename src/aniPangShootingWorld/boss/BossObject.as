package aniPangShootingWorld.boss
{
	import framework.animaiton.AtlasBitmapData;
	import framework.animaiton.MovieClip;
	import framework.display.ObjectType;
	import framework.display.Sprite;
	import framework.gameobject.Bullet;
	import framework.gameobject.BulletManager;
	import framework.gameobject.Collision;

	/**
	 * 라운드의 마지막 몬스터인 보스를 나타내는 클래스. 해당 클래스는 추상 클래스이며, 이 클래스를 상속받아서 사용해야한다.<br/>
	 * 상속받은 클래스에서는 shotBullet, changePhase, dieBoss 메서드를 오버라이드해서 재정의해줘야한다.
	 * @author jihwan.ryu youngsun.yoo
	 */
	public class BossObject extends MovieClip
	{
		public static const BASE_MAX_BOSS_HP:Number = 150;
		
		private var _bulletManager:BulletManager;
		private var _bossHp:Number;
		private var _maxBossHp:Number;
		private var _stage:Sprite;
		
		/**
		 * 생성자 - 객체 및 변수의 초기화 작업 진행 
		 * @param bossAtlas - 보스의 이미지를 담은 AtlasBitmapData 객체
		 * @param frame - 애니메이션 프레임 값
		 * @param bulletManager - 보스의 탄을 관리하는 BulletManager 객체
		 * @param stage - 현재 보스가 렌더링되고 있는 라운드
		 */
		public function BossObject(bossAtlas:AtlasBitmapData, frame:Number, bulletManager:BulletManager, stage:Sprite)
		{
			super(bossAtlas, frame, 0, 0);
			this.objectType = ObjectType.BOSS_GENERAL;
			_stage = stage;
			_bulletManager = bulletManager;
		}

		/**
		 * 보스를 렌더링하는 메서드.<br/>
		 * 1.Bullet 발사<br/>
		 * 2.충돌 처리<br/>
		 * 3.Bullet 검사<br/>
		 * 이 세 가지를 반복적으로 수행한다.
		 */
		public override function render():void
		{
			super.render();

			shotBullet();
			
			processCollision();
			
			bulletFrame();
		}
		
		/**
		 * 플레이어의 미사일과 보스의 충돌을 처리하는 메서드 
		 */
		private function processCollision():void
		{
			if(this.objectType == ObjectType.BOSS_COLLISION)
			{
				//체력 감소
				_bossHp--;
				
				// 체력 비율에 따라 보스의 Phase를 변경시키는 메서드
				changePhase();
				
				//체력이 0일 경우
				if(_bossHp <= 0)
				{
					this.objectType = ObjectType.BOSS_DIE;
					// 현재 스테이지에 자식으로 등록되어 있고, 상태가 IDLE이 아닌 Bullet들을 모두 제거
					for(var i:int = 0; i < _bulletManager.totalBullet; i++)
					{
						if(_bulletManager.bulletVector[i].objectType != ObjectType.ENEMY_BULLET_IDLE)
						{
							_stage.removeChild(_bulletManager.bulletVector[i]);
						}
					}
				}
				else
				{
					this.objectType = ObjectType.BOSS_GENERAL;
				}
			}			
			else if(this.objectType == ObjectType.BOSS_DIE)
			{
				// 보스의 죽음 처리
				dieBoss();
			}
		}
		
		/**
		 * 미사일과 벽에 출동 미사일과 플레이어의 충돌을 검사하는 함수 입니다.
		 */		
		private function bulletFrame():void
		{
			// 보스가 죽은 경우 바로 리턴한다
			if(_bossHp <= 0)
			{
				return;
			}
			
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
		 * 번호에 해당하는 미사일에 상태를 설정 합니다.
		 * @param bulletNum 미사일 번호
		 */
		private function bulletState(bulletNum : Number) : void
		{
			var bullet:Bullet = _bulletManager.bulletVector[bulletNum];
			var radian:Number = bullet.angle * Math.PI * 2;
			
			bullet.x += bullet.speed * Math.cos(radian);
			bullet.y += bullet.speed * Math.sin(radian);
		}
		
		/**
		 * 보스가 특정 패턴에 따라 미사일을 발사하도록 하는 메서드 
		 */
		public virtual function shotBullet():void {}
		
		/**
		 * 체력 비율에 따라 보스의 Phase를 변경시키는 메서드
		 */
		public virtual function changePhase():void {}
		
		/**
		 * 보스의 HP가 0이 되었을 때 처리하는 메서드
		 */
		public virtual function dieBoss():void {}

		public function get bossHp():Number { return _bossHp; }
		public function set bossHp(value:Number):void { _bossHp = value; }

		public function get maxBossHp():Number { return _maxBossHp; }
		public function set maxBossHp(value:Number):void { _maxBossHp = value; }
	}
}