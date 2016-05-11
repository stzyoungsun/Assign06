package aniPangShootingWorld.round
{
	import flash.utils.getTimer;
	
	import aniPangShootingWorld.boss.BossObject;
	import aniPangShootingWorld.boss.OneRoundBoss;
	import aniPangShootingWorld.enemy.EnemyLine;
	import aniPangShootingWorld.enemy.EnemyObject;
	import aniPangShootingWorld.enemy.EnemyObjectUtil;
	import aniPangShootingWorld.obstacle.Meteo;
	import aniPangShootingWorld.obstacle.Obstacle;
	import aniPangShootingWorld.player.Player;
	import aniPangShootingWorld.player.PlayerState;
	import aniPangShootingWorld.resource.SoundResource;
	import aniPangShootingWorld.util.HPbar;
	import aniPangShootingWorld.util.ResultDlg;
	import aniPangShootingWorld.util.UtilFunction;
	
	import framework.animaiton.AtlasBitmapData;
	import framework.animaiton.MovieClip;
	import framework.background.BackGround;
	import framework.core.Framework;
	import framework.display.Image;
	import framework.display.ObjectType;
	import framework.display.Sprite;
	import framework.event.TouchEvent;
	import framework.event.TouchPhase;
	import framework.gameobject.BulletManager;
	import framework.sound.SoundManager;
	
	
	public class OneRound extends Sprite
	{
		//Note @유영선 배경 그라운드를 저장 할 변수
		private var _backGround : BackGround;
		//Note @유영선 게임 시작전 화면 
		private var _prevGameView : MovieClip;
		//Note @유영선 플레이어의 객체를 저장 할 변수
		private var _player : Player;
		//Note @유영선 플레이어 상태창 저장 할 변수
		private var _playerState : PlayerState;
		//Note @유영선 적들의 비트맵데이터를 저장할 변수
		private var _enemyAtlasVector : Vector.<AtlasBitmapData> = new Vector.<AtlasBitmapData>;
		//Note @유영선 적들의 라인을 저장 할 변수
		private var _enemyLine : EnemyLine = new EnemyLine();
		
		//Note @유영선 적들의 Type을  랜덤으로 저장 할 임시 변수
		private var _randomArray : Array = new Array(EnemyObjectUtil.ENEMY_RAT,EnemyObjectUtil.ENEMY_RAT,EnemyObjectUtil.ENEMY_RAT,EnemyObjectUtil.ENEMY_RAT,EnemyObjectUtil.ENEMY_RAT);
		//Note @유영선 적의 타입을 담고 있는 randomArray의 값을 조절하는 변수
		private var _randomArrayControl : Number = 0;
		//Note @유영선 적들의 Type을 저장 할 변수 초기화
		private var _typeArray : Array = new Array();
		
		private var _soundManager:SoundManager;
		//Note @유영선 적의 라인이 나온 횟수를 검사하는 변수
		private var _EnemyCnt : Number = 0;
		
		//Note @유영선 보스 나오기 전  화면을 조절하는 시간
		private var _bossWarningTime : Number = 0;
		private var _bossWarningView : Image;
		
		private const ENEMY_TWO_LEVEL : Number = 6;
		private const ENEMY_THREE_LEVEL : Number = 12;
		private const ENEMY_FOUR_LEVEL : Number = 18;
		private const ENEMY_BOSS_LEVEL : Number = 24;
		
		private const ENEMY_MAX_COUNT : Number = 3;
		//Note @유영선 보스 
		private var _boss:BossObject;
		//Note @유영선 보스의 체력바
		private var _bossHPbar:HPbar;
		
		private const METEO_INTERVAL_TIME : int = 8000; 
		private var _moteoTime : Number =0;
		
		//Note @유영선 결과창
		private var _resultView : ResultDlg;
		private var _resultTimer : Number;
		/**
		 * 적들의 LineCount를 초기화 하고 순서에 따라 화면에 뿌려줍니다.
		 */		
		public function OneRound()
		{
			this.objectType = ObjectType.ROUND_PREV;
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
			
			//Note @유영선 메테오를  시간을 설정 합니다.
			_moteoTime = getTimer();
			
			_soundManager = SoundManager.getInstance();
			// Note @jihwan.ryu BGM 반복 재생
		}
		
		/**
		 *Note @유영선 적들을 그립니다 
		 * 
		 */
		public override function render():void
		{
			super.render();
			if(super.children == null) return;
			
			if(_soundManager.loopedPlayingState == "stop");
				_soundManager.play(SoundResource.BGM_1, true);
			
			//8초당 메테오를 발사 합니다.
			if(this.objectType != ObjectType.ROUND_PREV && this.objectType != ObjectType.ROUND_CLEAR)
			{
				var curMeteoTime: int = getTimer();
				if(curMeteoTime - _moteoTime > METEO_INTERVAL_TIME)
				{
					ShootMeteo();
					_moteoTime = getTimer();
				}
			}
			
			//Note @유영선 플레이어의 파워 게이지가 가득 찾을 경우 (배경의 속도가 증가)
			if(PlayerState.sSuperPowerFlag == true) 
			{
				_backGround.step = Framework.viewport.height/30;
			}
			else
				_backGround.step = 1;
			
			//Note @유영선 시작 전 화면 구현
			if(this.objectType == ObjectType.ROUND_PREV)
			{
				if(_prevGameView.play == false)
					this.objectType = ObjectType.ROUND_GENERAL;
			}
			
			//Note @유영선 모든 적들이 지워졌는지 체크 (일반 몬스터 모드) 다 지워졌으면 몬스터 다시 그림
			else if(this.objectType == ObjectType.ROUND_GENERAL)
			{
				if(_prevGameView)
				{
					removeChild(_prevGameView,true);
					_prevGameView = null;
				}
				
				if(checkEnemy())
					CreateEnemyLine();
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
					this.objectType = ObjectType.ROUND_BOSS;
					removeChild(_bossWarningView);
					_bossWarningView.dispose();
					_bossWarningView = null;
				}
			}
			
			//Note @유영선 보스전 출력
			else if(this.objectType == ObjectType.ROUND_BOSS)
			{
				PlayerState.sPlayerPower = 0;
				bossDraw();
			}
			
			//Note @유영선 결과 창 구현
			else if(this.objectType == ObjectType.ROUND_CLEAR)
			{
				var curResultTimer : int = getTimer();
				//Note @유영선 보스 워닝 화면 5초간 출력
				if(curResultTimer - _resultTimer > 4000)
				{
					_resultView.visible = true;
						
					if(_resultView.calcPoint())
					{
						//Note @유영선 점수 결과 합산이 끝낱을 경우
						_resultView.totalDraw();
						_resultView.nextButtonDraw();
					}
				}
			}
			
		}
		
		private function resultViewDraw():void
		{
			_resultView = new ResultDlg();
			_resultView.visible = false;
			_resultTimer = getTimer();
			addChild(_resultView);
		}
		/**	 
		 * Note @유영선 게임 시작 전 화면을 구현 합니다.
		 */		
		private function prevGameStart():void
		{
			//Note @유영선 xml 있는지 검사
			if(!MenuView.sloadedImage.checkXml(("PrevStart_Sheet.xml"))) throw new Error("not found xml");
			
			_prevGameView = new MovieClip(new AtlasBitmapData(MenuView.sloadedImage.imageDictionary["PrevStart_Sheet.png"]
				,MenuView.sloadedImage.xmlDictionary["PrevStart_Sheet.xml"]),1,0,0,true);
			
			_prevGameView.width = Framework.viewport.width/2;
			_prevGameView.height = Framework.viewport.height/3;
			_prevGameView.x = Framework.viewport.width/2 - _prevGameView.width/2;
			_prevGameView.y = Framework.viewport.height/2 - _prevGameView.height/2;
			
			_prevGameView.start();
			addChild(_prevGameView);
		}
		
		private function ShootMeteo():void
		{
			// TODO Auto Generated method stub
			//Note @유영선 xml 있는지 검사
			//Note @유영선 메테오를 저장 할 변수 입니다.
			var meteoObstacle : Obstacle;
			
			if(!MenuView.sloadedImage.checkXml(("meteo_Sheet.xml"))) throw new Error("not found xml");
			
			meteoObstacle = new Meteo(new AtlasBitmapData(MenuView.sloadedImage.imageDictionary["meteo_Sheet.png"]
				,MenuView.sloadedImage.xmlDictionary["meteo_Sheet.xml"]),30,this);
			(meteoObstacle as Meteo).meteoShoot();
			//addChild(_meteoObstacle);
		}
		
		/**
		 *Note @유영선 보스를 화면에 출력 합니다.
		 */		
		private function bossDraw() : void
		{
			if(_boss == null)
			{
				_boss = new OneRoundBoss(
					new AtlasBitmapData(MenuView.sloadedImage.imageDictionary["boss_Sheet.png"],
						MenuView.sloadedImage.xmlDictionary["boss_Sheet.xml"]),
					10,
					new BulletManager(ObjectType.ENEMY_BULLET_IDLE, 100, MenuView.sloadedImage.imageDictionary["boss_missile.png"].bitmapData),
					this
				);
				
				_boss.x = Framework.viewport.width / 8;
				_boss.y = 0;
				_boss.width = Framework.viewport.width * 4 / 5;
				_boss.height = Framework.viewport.height / 4;
				_boss.start();
				addChild(_boss);
				
				_bossHPbar = new HPbar(0, 0, MenuView.sloadedImage.imageDictionary["100per.png"].bitmapData);
				_bossHPbar.hpBarInit(_boss);
				addChild(_bossHPbar);
			}
			
			_bossHPbar.calcHP(_boss.maxBossHp, _boss.bossHp);
		}
		
		/**
		 * @return true : 모두 사려졌을 경우
		 * Note @유영선 적들이 다 사라졌는지 체크합니다.
		 */		
		private function checkEnemy():Boolean
		{
			if(_enemyLine.enemyVector)
			{
				for(var i:Number = 0; i < _enemyLine.enemyVector.length; i++)
				{
					if(_enemyLine.enemyVector[i].objectType != ObjectType.ENEMY_REMOVE)
						return false;
				}
			}

			return true;
		}
		
		private function CreateEnemyLine():void
		{
			//Note @유영선 적 비트맵의 크기가 0이 아니면 적을 화면에서 삭제
			if(_enemyAtlasVector.length != 0)
			{
				enenmyRemove();
			}
			
			if(this.objectType == ObjectType.ROUND_GENERAL)
			{
				//Note @유영선 적들의 타입 배열을 랜덤하게 섞음
				for(var cnt : int =0 ; cnt < EnemyObjectUtil.MAX_LINE_COUNT; cnt++)
					_typeArray[cnt] = _randomArray[cnt]
				
				_typeArray = UtilFunction.shuffle(_typeArray,5);
				
				for(var i : Number =0; i < EnemyObjectUtil.MAX_LINE_COUNT; i++)
				{
					_enemyAtlasVector[i] = new AtlasBitmapData(MenuView.sloadedImage.imageDictionary[EnemyObjectUtil.ENEMY_SPRITENAME_ARRAY[_typeArray[i]]]
						,MenuView.sloadedImage.xmlDictionary[EnemyObjectUtil.ENEMY_XML_ARRAY[_typeArray[i]]]);
				}
				_enemyLine.setEnemyLine(_enemyAtlasVector,_typeArray, this);
				enenmyDraw();
			}
		}
		
		/**
		 * Note @유영선 enemyLine을 화면에 그립니다
		 */		
		private function enenmyDraw():void
		{
			if(this.objectType != ObjectType.ROUND_GENERAL) return;
			
			for(var i: int =0; i < EnemyObjectUtil.MAX_LINE_COUNT; i ++)
				addChild(_enemyLine.enemyVector[i]);
		}
		
		/**
		 * Note @유영선 화면에서 적을 지웁니다.
		 */		
		private function enenmyRemove() : void
		{
			for(var i: int =0; i < EnemyObjectUtil.MAX_LINE_COUNT; i ++)
			{
				if(getChildIndex(_enemyLine.enemyVector[i]) != -1)
				{
					_enemyLine.enemyVector[i].deleteHPBar();
					removeChild(_enemyLine.enemyVector[i],true);
				}	
			}
			_EnemyCnt++;	//Note @유영선 제거 개수 (라운드에 level 조절)
			roundUp();
		}
		
		/**
		 *Note @유영선 적 라인이 나온 개수를 체크하여 라운드의 난이도를 업시킵니다. 
		 */		
		private function roundUp() : void
		{
			switch(_EnemyCnt)
			{
				case ENEMY_TWO_LEVEL:
				{
					_randomArray[0]++;
					EnemyObject.sSpeed+=0.15;
					break;
				}
				case ENEMY_THREE_LEVEL:
				{
					_randomArray[1]++;
					EnemyObject.sSpeed+=0.15;
					break;
				}
				
				case ENEMY_FOUR_LEVEL:
				{
					_randomArray[2]++;
					EnemyObject.sSpeed+=0.15;
					break;
				}
					
				case ENEMY_BOSS_LEVEL:
				{
					_soundManager.stopLoopedPlaying();
					_soundManager.play(SoundResource.BOSS_WARNING);
					_bossWarningTime = getTimer();
					this.objectType = ObjectType.ROUND_BOSS_WARNING;
				}
			}
		}
		
		/**
		 * Note @유영선 Player를 그립니다 
		 */		
		private function playerDraw():void
		{
			var bulletMgr : BulletManager = new BulletManager(ObjectType.PLAYER_BULLET_IDLE,30,MenuView.sloadedImage.imageDictionary["Bulletone.png"].bitmapData);
			_player = new Player(new AtlasBitmapData(MenuView.sloadedImage.imageDictionary["Player.png"],MenuView.sloadedImage.xmlDictionary["Player.xml"]),5,
				bulletMgr,this);
			
			_player.width = Framework.viewport.width/6;
			_player.height = Framework.viewport.height/6;
			
			addEventListener(TouchEvent.TOUCH, onTouch);
			
			addChild(_player);
			_player.start();
			bulletMgr = null;
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
		
		/**
		 * Note @유영선 배경화면을 그립니다.
		 */		
		private function backGroundDraw():void
		{
			_backGround = new BackGround(2, 60, 1, MenuView.sloadedImage.imageDictionary["backtree.jpg"].bitmapData);
			addChild(_backGround);
			
			//Note @유영선 보스워닝뷰 라운드 화면에 등록 후 visble false
			_bossWarningView = new Image(0,0,MenuView.sloadedImage.imageDictionary["warning.png"].bitmapData);
			_bossWarningView.visible = false;
			addChild(_bossWarningView);
		}
		
		public override function dispose():void
		{
			super.dispose();
			
			_typeArray = null;
			_randomArray = null;
			
			_bossHPbar = null;
			_boss = null;
		}	
		public function set resultTimer(value:Number):void{_resultTimer = value;}
	}
}