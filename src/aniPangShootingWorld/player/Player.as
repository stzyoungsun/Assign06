package aniPangShootingWorld.player
{
	import flash.utils.getTimer;
	
	import aniPangShootingWorld.resource.SoundResource;
	
	import framework.animaiton.AtlasBitmapData;
	import framework.animaiton.MovieClip;
	import framework.core.Framework;
	import framework.display.ObjectType;
	import framework.display.Sprite;
	import framework.gameobject.BulletManager;
	import framework.gameobject.Collision;
	import framework.scene.SceneManager;
	import framework.sound.SoundManager;
	//import com.adobe.nativeExtensions.Vibration;

	/**
	 * Note @유영선 사용자가 직접 조종하는 객체입니다
	 * MovieClip을 상속 받습니다.
	 */
	public class Player extends MovieClip
	{
		private static var _sPlayer:Player;
		
		private var _playerAtlas:AtlasBitmapData;
		private var _bulletManager:BulletManager;
		private var _stage:Sprite;
		private var _soundManager:SoundManager;
		private var _shieldTime : Number;
		/**
		 * 
		 * @param playerAtlas 	애니매이션 할 Atals 객체
		 * @param frame       	애미매이션의 Frmae
		 * @param bulletManager 플레이어가 발사 할 미사일
		 * @param stage			현재 Round의 객체
		 * 
		 */		
		public function Player(playerAtlas : AtlasBitmapData, frame : Number, bulletManager  : BulletManager,stage:Sprite )
		{	
			_playerAtlas = playerAtlas;
			_bulletManager = bulletManager;
			
			//@Note 유영선  플레이어의 y값을 설정 합니다. 플레이어는 화면 바닥에 고정
			y = Framework.viewport.height - Framework.viewport.height/5;
			super(_playerAtlas, frame, 0, y);
			
			//@Note 유영선  현재 플레이어의 상태를  PLAYER_GENERAL로 설정합니다.
			this.objectType = ObjectType.PLAYER_GENERAL;
			//@Note 유영선  플레이어의 미사일을 생성
			_bulletManager.createBullet(this.x,this.y);
			_stage=stage;
			
			_playerAtlas = null;
			_prevTime = getTimer();
			
			_soundManager = SoundManager.getInstance();
			_sPlayer = this;
		}
		
		public override function dispose():void
		{
			super.dispose();
			_stage = null;
			
			_bulletManager.dispose();
			_bulletManager = null;
		}
		
		/**
		 *미사일을 발사 하는 함수 입니다. 미리 생성해 놓은 미사일을 선택하여 발사 합니다. 
		 */		
		public function shooting() : void
		{
			//Note @유영선 발사 할 미사일 번호를 저장하는 변수
			var bulletNum : Number = _bulletManager.bulletNumVector.pop();
			//Note @유영선 선택 된 미사일을 플레이어 위치에 따라 재설정 그리고 크거 조절
			_bulletManager.bulletVector[bulletNum].initBullet(this.x+this.width/3,this.y,this.width/2, this.height/2);
			//Note @유영선 round의 stage에 addChild
			_bulletManager.bulletVector[bulletNum].objectType = ObjectType.PLAYER_BULLET_MOVING;
			_stage.addChild(_bulletManager.bulletVector[bulletNum]);
			// Note @jihwan.ryu 미사일 발사마다 효과음 재생
			_soundManager.play(SoundResource.PLAYER_MISSILE);
		}
		
		/**
		 *  플레이어 미사일의 현재 상태를 확인하고 벽과의 충돌을 검사하는 함수 
		 */		
		public function bulletFrame() : void
		{
			for(var i :int= 0; i < _bulletManager.totalBullet; i ++)
			{
				//@Note 유영선  플레이어 미사일이 벽과 충돌 했는지 확인합니다ㅣ.
				if(Collision.bulletToWall(_bulletManager.bulletVector[i]) && _bulletManager.bulletVector[i].objectType == ObjectType.PLAYER_BULLET_MOVING)
				{
					_stage.removeChild(_bulletManager.bulletVector[i]);
					_bulletManager.bulletVector[i].objectType = ObjectType.PLAYER_BULLET_IDLE;
					_bulletManager.bulletNumVector.push(i);
				}
				
				//@Note 유영선  플레이어 미사일이 적들과 충돌 했으면 그 미사일을 제거합니다.
				else if(_bulletManager.bulletVector[i].objectType == ObjectType.PLAYER_BULLET_COLLISION)
				{
					_stage.removeChild(_bulletManager.bulletVector[i]);
					_bulletManager.bulletVector[i].objectType = ObjectType.PLAYER_BULLET_IDLE;
					_bulletManager.bulletNumVector.push(i);
				}
				
				else
				{
					_bulletManager.bulletVector[i].shootingState(bulletstate,i);
				}
			}
		}
		
		/**
		 * @param bulletNum 미사일 번호
		 * 번호에 맞는 미사일에 상태를 설정 합니다.
		 */		
		public function bulletstate(bulletNum : Number) : void
		{
			_bulletManager.bulletVector[bulletNum].y -= Framework.viewport.height/20;
		}
		
		/**
		 * 상태에 맞게 플레이어 객체와 플레이어 미사일을 그려주는 함수입니다.
		 */		
		public override function render():void
		{
			super.render();
			
			var curTimerBullet:int = getTimer();
			
			//Note @유영선  플레이어가 발사 속도를 조절
			if(curTimerBullet - _prevTime > 100)
			{
				shooting();
				_prevTime = getTimer();
			}
			
			//Note @유영선 슈퍼파워 모드 일 경우 플레이어 케릭이 커짐
			if(PlayerState.sSuperPowerFlag == false)
			{
				this.width = Framework.viewport.width/6;
				this.height = Framework.viewport.height/6;
			}
			else
			{
				this.width = Framework.viewport.width/3;
				this.height = Framework.viewport.height/3;
			}
			
			//@Note 유영선  플레이어가 충돌 되었을 때 체력을 감수
			if(this.objectType == ObjectType.PLAYER_COLLISION)
			{
				if(PlayerState.sSuperPowerFlag == false)
				{
					_shieldTime = getTimer();
					
//					var vibe:Vibration;
//					
//					if (Vibration.isSupported)
//					{
//						vibe = new Vibration();
//						vibe.vibrate(1000);
//					}
					
					this.objectType = ObjectType.PLAYER_SHIELD_MODE;
					PlayerState.sPlayerHeart--;
				}
			}
			
			//Note @유영선  플레이어 쉴드 시간
			if(this.objectType == ObjectType.PLAYER_SHIELD_MODE)
			{
				var curShieldTimer:int = getTimer();
				
				if(curShieldTimer - _shieldTime < 2000)
				{
					this.showImageAt(0);
					this.width = Framework.viewport.width/9;
					this.height = Framework.viewport.height/9;
				}
				else
				{
					this.start();
					this.objectType = ObjectType.PLAYER_GENERAL;
					this.width = Framework.viewport.width/6;
					this.height = Framework.viewport.height/6;
				}
			}
			
			
			//@Note 유영선 플레이어 체력이 0이 되었을 경우 메뉴 화면으로 돌아감
			if(PlayerState.sPlayerHeart == 0)
			{
				_stage.dispose();
				SceneManager.instance.sceneChange();
				return;
			}
			
			bulletFrame();
		}
		
		public static function get currentPlayer():Player { return _sPlayer; }
	}
}