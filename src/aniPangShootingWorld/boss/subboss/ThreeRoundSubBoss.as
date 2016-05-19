package aniPangShootingWorld.boss.subboss
{
	import flash.utils.getTimer;
	
	import aniPangShootingWorld.boss.BossObject;
	import aniPangShootingWorld.boss.bosstype.ThreeRoundBoss;
	import aniPangShootingWorld.item.ItemGroup;
	import aniPangShootingWorld.player.Player;
	import aniPangShootingWorld.round.Round;
	import aniPangShootingWorld.util.GameTexture;
	import aniPangShootingWorld.util.UtilFunction;
	
	import framework.core.Framework;
	import framework.display.Image;
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
		
		private var _warrning : Image;
		private var warrningFlag : Boolean = false;
		
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
			_name = "ThreeRoundSubBoss";
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
			var currentTime:Number = 0;
			if(warrningFlag == false)
			{
				_prevTime = UtilFunction.random(0, 10000,1);
				if(_prevTime > 9900)
				{
					bulletX = this.x + this.width / 2;
					bulletY = this.y;
					_warrning = new Image(bulletX, bulletY, GameTexture.meteorWarning);
					_warrning.width = Framework.viewport.width/10;
					_warrning.height = Framework.viewport.width/10;
					_stage.addChild(_warrning);
					warrningFlag = true;
					_prevTime = getTimer();
				}
			}
				
			else	
			{
				currentTime = getTimer();
				if(currentTime - _prevTime > 2000)
				{
					bulletX = this.x;
					bulletY = this.y + this.height;
					
					shooting(bulletX, bulletY);
					_stage.removeChild(_warrning, true);
					warrningFlag = false;
				}
			}
		}
		
		/**
		 * 보스의 HP가 0이 되면 호출되는 메서드
		 */
		public override function dieBoss():void
		{
			var currentTime:Number = getTimer();
			// 3초후 제거
		
			_stage.removeChild(this);
				
			if(_stage.getChildIndex(_warrning) != -1)
				_stage.removeChild(_warrning, true);
				
			if(_stage.getChildIndex(_bulletManager.bulletVector[0]) != -1)
				_stage.removeChild(_bulletManager.bulletVector[0]);
				
			var item : ItemGroup = new ItemGroup(10,this.x, this.y,_stage);
			item.drawItem();
			ThreeRoundBoss.sSubBossCnt--;
		}
		/**
		 * 미사일을 발사 하는 함수 입니다. 미리 생성해 놓은 미사일을 선택하여 발사 합니다. 
		 */		
		public function shooting(x:Number, y:Number) : void
		{
			//Note @유영선 발사 할 미사일 번호를 저장하는 변수
			var bulletNum:Number = _bulletManager.bulletNumVector.pop();
			//Note @유영선 선택 된 미사일을 ENEMY_BULLET_MOVING 상태로 설정
			_bulletManager.bulletVector[bulletNum].objectType = ObjectType.ENEMY_BULLET_MOVING;
			//Note @유영선 선택 된 미사일을 적들의 위치에 따라 재설정 그리고 크거 조절
			_bulletManager.bulletVector[bulletNum].initBullet(x, y, Framework.viewport.width/30, Framework.viewport.width/30);
			//Note @유영선 round의 stage에 addChild
			_stage.addChild(_bulletManager.bulletVector[bulletNum]);	
		}
	}
}