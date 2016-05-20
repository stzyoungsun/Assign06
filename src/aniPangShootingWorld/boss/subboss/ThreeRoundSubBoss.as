package aniPangShootingWorld.boss.subboss
{
	import flash.utils.getTimer;
	
	import aniPangShootingWorld.boss.BossObject;
	import aniPangShootingWorld.boss.bosstype.ThreeRoundBoss;
	import aniPangShootingWorld.item.ItemGroup;
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
		private var _remainBullet:Boolean;
		private var _parentBoss : BossObject;
		
		private var _warrning : Image;
		private var _warrningFlag : Boolean = false;
		
		/**
		 * @param parentBoss 메인 보스의 객체
		 * @param textureVector 부하 보스의 텍스쳐
		 * @param frame 부하 보스의 프레임
		 * @param bossMaxHP 부하 보스의 체력
		 * @param bulletManager 부하 보스의 미사일 매니져
		 * @param stage 라운드의 stage
		 * 부하보스는 보스와 함께 등장하는 적 Object 입니다
		 */		
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
			
			bossHp = bossMaxHP;
			maxBossHp = bossMaxHP;
			_name = "ThreeRoundSubBoss";
		}
		
		/**
		 * 
		 * @param x 부하 보스의 x좌표
		 * @param y 부하 보스의 y좌표
		 * 부하 보스의 위치를 성정하는 함수
		 */		
		public function initSubBoss(x : Number, y : Number) : void
		{
			this.x = x;
			this.y = y;
		}
		
		/**
		 * 미사일 발사 패턴을 조절하는 함수 
		 */		
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
			
			if(_warrningFlag == false)
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
					_warrningFlag = true;
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
					_warrningFlag = false;
				}
			}
		}
		
		/**
		 * 보스의 HP가 0이 되면 호출되는 메서드
		 */
		public override function dieBoss():void
		{
			var currentTime:Number = getTimer();

			_stage.removeChild(this);
				
			if(_stage.getChildIndex(_warrning) != -1)
				_stage.removeChild(_warrning, true);
				
			if(_stage.getChildIndex(_bulletManager.bulletVector[0]) != -1)
				_stage.removeChild(_bulletManager.bulletVector[0]);
			
			//사망시 첫번째 매개변수 만큼 아이템을 생성
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
			_bulletManager.bulletVector[bulletNum].visible = true;
		}
	}
}