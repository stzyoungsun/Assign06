package aniPangShootingWorld.boss.bosstype
{
	import flash.utils.getTimer;
	
	import aniPangShootingWorld.boss.BossObject;
	import aniPangShootingWorld.boss.subboss.ThreeRoundSubBoss;
	import aniPangShootingWorld.item.ItemGroup;
	import aniPangShootingWorld.player.Player;
	import aniPangShootingWorld.round.Round;
	import aniPangShootingWorld.util.GameTexture;
	
	import framework.core.Framework;
	import framework.display.ObjectType;
	import framework.display.Sprite;
	import framework.gameobject.Bullet;
	import framework.gameobject.BulletManager;
	import framework.texture.FwTexture;

	public class ThreeRoundBoss extends BossObject
	{
		private static const PHASE_1:Number = 1;
		private static const PHASE_2:Number = 2;
		private static const PHASE_3:Number = 3;
		private static const MAX_SUB_COUNT : Number = 4;
		
		private var _bulletManager:BulletManager;
		private var _stage:Sprite;
		private var _shotAngle:Number; 
		private var _shotSpeed:Number;
		private var _bossPhase:Number;
		private var _waitTime:Number;
		private var _wait:Boolean;
		private var _remainBullet:Boolean;
		private var _subBossVector : Vector.<ThreeRoundSubBoss> = new Vector.<ThreeRoundSubBoss>;
		
		public function ThreeRoundBoss(textureVector:Vector.<FwTexture>, frame:Number, bossMaxHP : Number, bulletManager:BulletManager, stage:Sprite)
		{
			super(textureVector, frame, bulletManager, stage);
			
			this.width = Framework.viewport.width*0.5;
			this.height = Framework.viewport.height / 5;
			this.start();
			
			this.x = Framework.viewport.width/2 - this.width/2 ;
			this.y = 0;
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
			
			createSubBoss();
		}
		
		private function createSubBoss():void
		{
			// TODO Auto Generated method stub
			for(var i : Number =0; i < MAX_SUB_COUNT ; i++)
			{
				_subBossVector.push(new ThreeRoundSubBoss(this,GameTexture.boss3Object,10,30,new BulletManager(ObjectType.ENEMY_BULLET_IDLE, 100, GameTexture.bullet[8]),_stage));
				_subBossVector[i].initSubBoss(i*_subBossVector[i].width, this.height);
				_subBossVector[i].addHPBar();
				_stage.addChild(_subBossVector[i]);
			}
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
				_stage.removeChild(this);
				(_stage as Round).resultTimer = getTimer();
				var item : ItemGroup = new ItemGroup(10,this.x, this.y,_stage);
				item.drawItem();
			}
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