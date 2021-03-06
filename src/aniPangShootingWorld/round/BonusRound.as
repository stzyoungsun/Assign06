package aniPangShootingWorld.round
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	
	import aniPangShootingWorld.boss.BossObject;
	import aniPangShootingWorld.boss.bosstype.OneRoundBoss;
	import aniPangShootingWorld.boss.bosstype.ThreeRoundBoss;
	import aniPangShootingWorld.boss.bosstype.TwoRoundBoss;
	import aniPangShootingWorld.player.Player;
	import aniPangShootingWorld.player.PlayerState;
	import aniPangShootingWorld.resourceName.SoundResource;
	import aniPangShootingWorld.round.SelectViewSub.RoundButton;
	import aniPangShootingWorld.round.Setting.GameSetting;
	import aniPangShootingWorld.round.Setting.RoundSetting;
	import aniPangShootingWorld.ui.ConfigureBox;
	import aniPangShootingWorld.ui.MessageBox;
	import aniPangShootingWorld.util.GameTexture;
	import aniPangShootingWorld.util.HPbar;
	import aniPangShootingWorld.util.ResultDlg;
	
	import framework.animaiton.MovieClip;
	import framework.background.BackGround;
	import framework.core.Framework;
	import framework.display.Image;
	import framework.display.ObjectType;
	import framework.display.Sprite;
	import framework.event.TouchEvent;
	import framework.event.TouchPhase;
	import framework.gameobject.BulletManager;
	import framework.scene.SceneManager;
	import framework.sound.SoundManager;
	import framework.texture.TextureManager;
	
	/**
	 * 보스들로만 이루어진 특별 라운드입니다.
	 */	
	public class BonusRound extends Sprite
	{
		//Note @유영선 배경 그라운드를 저장 할 변수
		private var _backGround : BackGround;
		//Note @유영선 게임 시작전 화면 
		private var _prevGameView : MovieClip;
		//Note @유영선 플레이어의 객체를 저장 할 변수
		private var _player : Player;
		//Note @유영선 플레이어 상태창 저장 할 변수
		private var _playerState : PlayerState;
		
		//Note @유영선 적들의 Type을 저장 할 변수 초기화
		private var _typeArray : Array = new Array();
		
		private var _soundManager:SoundManager;
		//Note @유영선 적의 라인이 나온 횟수를 검사하는 변수
		private var _EnemyCnt : Number = 0;
		
		//Note @유영선 보스 나오기 전  화면을 조절하는 시간
		private var _bossWarningTime : Number = 0;
		private var _bossWarningView : Image;
		
		//Note @유영선 보스 
		private var _boss:BossObject;
		//Note @유영선 보스의 체력바
		private var _bossHPbar:HPbar;
		
		//Note @유영선 결과창
		private var _resultView : ResultDlg;
		
		private var _bossNumber : Number = 0;
		/**
		 * 적들의 LineCount를 초기화 하고 순서에 따라 화면에 뿌려줍니다.
		 */
		
		public function BonusRound()
		{
			this.objectType = ObjectType.ROUND_PREV;
	
			GameSetting.instance.pause = true;
			
			PlayerState.sPlayerHeart = PlayerState.MAX_HERAT;
			PlayerState.sPlayerPower = 0;
			PlayerState.sGoldCount = 0;
			PlayerState.sTotalHeart = 0;
			PlayerState.sTotalPower = 0;
			//Note @유영선 배경 그라운드를 화면에 출력
			backGroundDraw();
			//Note @유영선 게임 준비 단계를 화면에 출력
			prevGameStart();
			//Note @유영선 플레이어를 화면에 출력
			playerDraw();
			//Note @유영선 플레이어 상태창 화면에 출력
			playerStateDraw();
			//Note @유영선 결과창을 등록 합니다
			resultViewDraw();
			
			_soundManager = SoundManager.getInstance();
		}
		
		/**
		 *Note @유영선 적들을 그립니다 
		 */
		public override function render():void
		{
			super.render();
			
			if(super.children == null || GameSetting.instance.pause) return;
			
			if(_soundManager.loopedPlayingState == "stop" && GameSetting.instance.bgm)
				_soundManager.play(SoundResource.BGM_1, true);
			
			//Note @유영선 플레이어의 파워 게이지가 가득 찾을 경우 (배경의 속도가 증가)
			if(PlayerState.sSuperPowerFlag == true) 
			{
				_backGround.step = Framework.viewport.height/30;
			}
			else
				_backGround.step = Framework.viewport.height/500;
			
			//Note @유영선 시작 전 화면 구현
			if(this.objectType == ObjectType.ROUND_PREV)
			{
				if(_prevGameView.play == false)
				{
					_bossWarningTime = getTimer();
					this.objectType = ObjectType.ROUND_BOSS_WARNING;
				}	
			}
				
			//Note @유영선 보스 전 시작 경고 화면
			else if(this.objectType == ObjectType.ROUND_BOSS_WARNING)
			{
				var curBossWarningTime : int = getTimer();
				//Note @유영선 보스 워닝 화면 5초간 출력
				if(curBossWarningTime - _bossWarningTime < 5000)
				{
					_bossWarningView.visible = true;
					_bossWarningView.width = Framework.viewport.width;
					_bossWarningView.height = Framework.viewport.height;
				}
					//Note @유영선 보스 워닝하면 5초간 출력 후 보스 등장
				else 
				{
					_bossWarningView.visible = false;
					bossDraw(_bossNumber++);
				}
			}
				
				//Note @유영선 보스전 출력
			else if(this.objectType == ObjectType.ROUND_BOSS)
			{
				PlayerState.sPlayerPower = 0;
			}
				
				//Note @유영선 결과 창 구현
			else if(this.objectType == ObjectType.ROUND_CLEAR)
			{
				_boss = null;
				
				if(_bossNumber != 3)
				{
					this.objectType = ObjectType.ROUND_PREV;
					return;
				}
				
				var curResultTimer : int = getTimer();
				PlayerState.sPlayerPower = 0;
				
				Framework.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
				_prevGameView = null;
				//Note @결과 창 출력
				if(curResultTimer - resultTimer > 4000)
				{
					_resultView.visible = true;
					
					if(_resultView.calcPoint())
					{
						//Note @유영선 점수 결과 합산이 끝낱을 경우
						removeEventListener(TouchEvent.TOUCH, onTouch);
						
						_resultView.totalDraw();
						_resultView.nextButtonDraw();
						_resultView.nextButton.addEventListener(TouchEvent.TOUCH, onNextClick);
						
						this.objectType = ObjectType.ROUND_IDLE;
					}
				}
			}
		}
		
		/**
		 * Note @유영선 Next 버튼 클릭 시 다음 라운드 진행
		 */		
		protected function onNextClick(event:TouchEvent):void
		{
			if(event.touch.phase == TouchPhase.ENDED)
			{
				this.dispose();
				
				SceneManager.instance.sceneChange();
				(Framework.sceneStage as SelectView).initView();
			}
		}
		
		private function resultViewDraw():void
		{
			_resultView = new ResultDlg();
			_resultView.visible = false;
			addChild(_resultView);
		}
		
		/**	 
		 * Note @유영선 게임 시작 전 화면을 구현 합니다.
		 */		
		private function prevGameStart():void
		{
			_prevGameView = new MovieClip(GameTexture.readyNumber, 1, 0, 0, true);
			_prevGameView.width = Framework.viewport.width/2;
			_prevGameView.height = Framework.viewport.height/3;
			_prevGameView.x = Framework.viewport.width/2 - _prevGameView.width/2;
			_prevGameView.y = Framework.viewport.height/2 - _prevGameView.height/2;
			_prevGameView.start();
			_prevGameView.addEventListener("stop", onStopMovie);
			
			addChild(_prevGameView);
		}
		
		/**
		 *Note @유영선 보스를 화면에 출력 합니다.
		 */		
		private function bossDraw(bossNum : Number) : void
		{
			if(_boss == null)
			{
				this.objectType = ObjectType.ROUND_BOSS;
				bossSetting(bossNum);
				addChild(_boss);
			}
		}
		
		/** 
		 *  Note @유영선 라운드에 따라 보스를 설정 합니다.
		 */		
		private function bossSetting(bossNum : Number):void
		{
			switch(bossNum)
			{
				case 0:
				{
					_boss = new OneRoundBoss(GameTexture.boss1, 10, RoundSetting.instance.roundObject[0].BossHP, new BulletManager(ObjectType.ENEMY_BULLET_IDLE, 100, GameTexture.bullet[8]), this);
					break;
				}
				case 1:
				{
					TwoRoundBoss.stotalBossCnt = 15;
					_boss = new TwoRoundBoss(GameTexture.boss2, 10, RoundSetting.instance.roundObject[1].BossHP, new BulletManager(ObjectType.ENEMY_BULLET_IDLE, 100, GameTexture.bullet[8]), this);
					break;
				}
					
				case 2:
				{
					_boss = new ThreeRoundBoss(GameTexture.boss3, 10, RoundSetting.instance.roundObject[2].BossHP, new BulletManager(ObjectType.ENEMY_BULLET_IDLE, 100, GameTexture.bullet[8]), this);
					break;
				}	
			}
			_boss.addHPBar();
		}

		/**
		 * Note @유영선 Player를 그립니다 
		 */		
		private function playerDraw():void
		{
			_player = new Player(GameTexture.player, 5, new BulletManager(ObjectType.PLAYER_BULLET_IDLE, 30, GameTexture.bullet[0]), this);
			_player.addEventListener("exit", onExitGame);
			_player.width = Framework.viewport.width/8;
			_player.height = Framework.viewport.height/8;
			_player.start();
			
			addChild(_player);
		}
		
		/** 
		 * Note @유영선 플레이어 상태 창 구현
		 */		
		private function playerStateDraw():void
		{
			_playerState = new PlayerState();
			addChild(_playerState);
		}
		
		private function onTouch(event:TouchEvent):void
		{
			switch(event.touch.phase)
			{
				case TouchPhase.MOVED:
					_player.x += event.touch.globalX - event.touch.previousGlobalX;
					if(_player.x < 0)
						_player.x = 0;
					else if(_player.x >= Framework.viewport.width - _player.width)
						_player.x = Framework.viewport.width - _player.width;
					break;
			}
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.MENU)
			{
				GameSetting.instance.pause = true;
				
				var configureBox:ConfigureBox = new ConfigureBox();
				configureBox.width = Framework.viewport.width / 2;
				configureBox.height = Framework.viewport.height / 3;
				configureBox.x = Framework.viewport.width / 4;
				configureBox.y = Framework.viewport.height / 3;
				configureBox.addEventListener("resume", onResume);
				addChild(configureBox);
				
				Framework.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
				removeEventListener(TouchEvent.TOUCH, onTouch);
			}
			else if(event.keyCode == Keyboard.BACK)
			{
				GameSetting.instance.pause = true;
				
				var exitBox:MessageBox = new MessageBox(
					"Go back to the main menu",
					25,
					true,
					function():void { exitBox.dispatchEvent(new Event("exit")); },
					function():void { exitBox.dispatchEvent(new Event("resume")); }
				);
				
				exitBox.width = Framework.viewport.width / 2;
				exitBox.height = Framework.viewport.height / 3;
				exitBox.x = Framework.viewport.width / 4;
				exitBox.y = Framework.viewport.height / 3;
				exitBox.addEventListener("resume", onResume);
				exitBox.addEventListener("exit", onExitGame);
				addChild(exitBox);
				
				Framework.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
				removeEventListener(TouchEvent.TOUCH, onTouch);
			}
		}
		
		private function onResume(evnet:Event):void
		{
			prevGameStart();
		}
		
		private function onStopMovie(event:Event):void
		{
			removeChild(_prevGameView);
			_prevGameView.removeEventListener("stop", onStopMovie);
			GameSetting.instance.pause = false;
			addEventListener(TouchEvent.TOUCH, onTouch);
			Framework.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onExitGame(event:Event):void
		{
			this.dispose();
			
			Framework.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
			_soundManager.stopLoopedPlaying();
			SceneManager.instance.sceneChange();
			(Framework.sceneStage as SelectView).initView();
		}
		
		/**
		 * Note @유영선 배경화면을 그립니다.
		 */		
		private function backGroundDraw():void
		{
			_backGround = new BackGround(60, 1, TextureManager.getInstance().textureDictionary["back4.jpg"]);
			addChild(_backGround);
			
			//Note @유영선 보스워닝뷰 라운드 화면에 등록 후 visble false
			_bossWarningView = new Image(0, 0, TextureManager.getInstance().textureDictionary["boss_warning.png"]);
			_bossWarningView.visible = false;
			addChild(_bossWarningView);
		}
		
		public override function dispose():void
		{
			super.dispose();
			
			_typeArray = null;
			
			_bossHPbar = null;
			_boss = null;
		}
	}
}

