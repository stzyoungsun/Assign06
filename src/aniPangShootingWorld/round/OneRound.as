package aniPangShootingWorld.round
{
	import flash.display.BitmapData;
	import flash.utils.getTimer;
	
	import aniPangShootingWorld.boss.BossObject;
	import aniPangShootingWorld.boss.OneRoundBoss;
	import aniPangShootingWorld.enemy.EnemyLine;
	import aniPangShootingWorld.enemy.EnemyObjectUtil;
	import aniPangShootingWorld.enemy.EnemyPig;
	import aniPangShootingWorld.player.Player;
	import aniPangShootingWorld.resource.SoundResource;
	import aniPangShootingWorld.util.HPbar;
	import aniPangShootingWorld.util.UtilFunction;
	
	import framework.animaiton.AtlasBitmapData;
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
		//Note @유영선 배경 스카이를 저장 할 변수
		private var _backSky : BackGround;
		//Note @유영선 플레이어의 객체를 저장 할 변수
		private var _player : Player;
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
		
		private const ENEMY_TWO_LEVEL : Number = 3;
		private const ENEMY_THREE_LEVEL : Number = 6;
		private const ENEMY_BOSS_LEVEL : Number = 9;
		
		private const ENEMY_MAX_COUNT : Number = 3;
		//Note @유영선 보스 
		private var _boss : Vector.<OneRoundBoss> = new Vector.<OneRoundBoss>;
		//Note @유영선 보스의 체력바
		private var _bossHPbar : Vector.<HPbar> = new Vector.<HPbar>;
		
		/**
		 * 적들의 LineCount를 초기화 하고 순서에 따라 화면에 뿌려줍니다.
		 */		
		public function OneRound()
		{
			this.objectType = ObjectType.ROUND_GENERAL;
			//Note @유영선 배경 그라운드를 화면에 출력
			backGroundDraw();
			//Note @유영선 플레이어를 화면에 출력
			playerDraw();
			//Note @유영선 적 라인을 설정 하고 적들을 화면에 출력하고 배경 스카이를 출력
			CreateEnemyLine();
			
			_soundManager = SoundManager.getInstance();
			// Note @jihwan.ryu BGM 반복 재생
			_soundManager.play(SoundResource.BGM_1, true);
		}
		
		/**
		 *Note @유영선 적들을 그립니다 
		 * 
		 */
		public override function render():void
		{
			super.render();
			if(super.children == null) return;
			//Note @유영선 모든 적들이 지워졌는지 체크 (일반 몬스터 모드)
			if(checkEnemy() && this.objectType == ObjectType.ROUND_GENERAL)
			{
				CreateEnemyLine();
			}
			
			//Note @유영선 보스 전 시작 경고 화면
			if(this.objectType == ObjectType.ROUND_BOSS_WARNING)
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
			if(this.objectType == ObjectType.ROUND_BOSS)
			{
				bossDraw();
			}
		}
		
		/**
		 *Note @유영선 보스를 화면에 출력 합니다.
		 */		
		private function bossDraw() : void
		{
			if(OneRoundBoss.sBossLevel == 0)
			{
				if(_boss[0].visible == false)
					_boss[0].visible = true;
				if(_boss[0].play == false);
					_boss[0].start();
				if(_bossHPbar[0].visible == false)
					_bossHPbar[0].visible = true;
							
			    _bossHPbar[0].calcHP(OneRoundBoss.ONE_BOSS_HP,_boss[0].oneBossHP);
			}
			
			else 
			{
				_boss[0].visible = false;
				_bossHPbar[0].visible = false;
				for(var i : Number = 1; i < 3; i++)
				{
					if(_boss[i].objectType == ObjectType.BOSS_DIE)
					{
						_boss[i].visible = false;
						_bossHPbar[i].visible = false;
					}
					
					else
					{
						
					 if(_boss[i].play == false);
						_boss[i].start();
					
						_boss[i].visible = true;
						_bossHPbar[i].visible = true;
						
						_bossHPbar[i].calcHP(OneRoundBoss.ONE_BOSS_HP,_boss[i].oneBossHP);
					}
				}
			}
		}
		
		/**
		 * @return true : 모두 사려졌을 경우
		 * Note @유영선 적들이 다 사라졌는지 체크합니다.
		 */		
		private function checkEnemy():Boolean
		{
			for(var i:Number = 0; i < 5; i++)
			{
				if(_enemyLine.enemyVector[i].objectType != ObjectType.ENEMY_REMOVE)
					return false;
			}
			return true;
		}
		
		private function CreateEnemyLine():void
		{
			//Note @유영선 적 비트맵의 크기가 0이 아니면 적을 화면에서 삭제
			if(_enemyAtlasVector.length != 0)
			{
				enenmyRemove();
				removeChild(_backSky);
			}
			
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
			addChild(_backSky);
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
					break;
				}
				case ENEMY_THREE_LEVEL:
				{
					_randomArray[1]++;
					break;
				}
				
				case ENEMY_BOSS_LEVEL:
				{
					_soundManager.stopLoopedPlaying();
					_soundManager.play(SoundResource.BOSS_WARNING);
					_bossWarningTime = getTimer();
					this.objectType = ObjectType.ROUND_BOSS_WARNING;
					enenmyRemove();
					
					bossInit();
				}
			}
		}
		// Note @유영선 보스 슬라임의 초기화
		private function bossInit():void
		{
			var bulletMgr : BulletManager = new BulletManager(ObjectType.ENEMY_BULLET_IDLE,1,MenuView.sloadedImage.imageDictionary["Bulletfour.png"].bitmapData);
			//Note @유영선 1 -> 2 쪼개지는 보스 까지 포함한 3마리의 초기화
			for(var i : Number = 0; i < 3; ++i)
			{
				_boss.push(new OneRoundBoss(new AtlasBitmapData(MenuView.sloadedImage.imageDictionary["boss_Sheet.png"]
					,MenuView.sloadedImage.xmlDictionary["boss_Sheet.xml"]),10,bulletMgr,this));
				
				switch(i)
				{
					case 0:
					{
						_boss[i].x =Framework.viewport.width/8;
						_boss[i].y = 0;
						_boss[i].width = Framework.viewport.width*3/4;
						_boss[i].height = Framework.viewport.height/3;
						break;
					}
					case 1:
					case 2:
					{
						_boss[i].width = Framework.viewport.width*3/8;
						_boss[i].height = Framework.viewport.height/6;
						_boss[i].x = _boss[i].width/3+_boss[i].width*(i-1);
						_boss[i].y = 0;
						break;
					}
				}
				_boss[i].visible = false;
				
				addChild(_boss[i]);
				
				_bossHPbar.push(new HPbar(0,0,MenuView.sloadedImage.imageDictionary["100per.png"].bitmapData));
				_bossHPbar[i].hpBarInit(_boss[i]);
				_bossHPbar[i].visible = false;
				addChild(_bossHPbar[i]);
			}
			bulletMgr = null;
		}
		
		/**
		 * Note @유영선 Player를 그립니다 
		 */		
		private function playerDraw():void
		{
			_backSky = new BackGround(2, 60, 10.24, MenuView.sloadedImage.imageDictionary["backskycur.png"].bitmapData);
			
			var bulletMgr : BulletManager = new BulletManager(ObjectType.PLAYER_BULLET_IDLE,30,MenuView.sloadedImage.imageDictionary["Bulletone.png"].bitmapData);
			_player = new Player(new AtlasBitmapData(MenuView.sloadedImage.imageDictionary["Player.png"],MenuView.sloadedImage.xmlDictionary["Player.xml"]),5,
				bulletMgr,this);
			
			_player.width = Framework.viewport.width/6;
			_player.height = Framework.viewport.height/6;
			_player.start();
			
			addEventListener(TouchEvent.TOUCH, onTouch);
			
			addChild(_player);
			
			bulletMgr = null;
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
			_backGround.dispose();
			_backGround = null;
			
			_backSky.dispose();
			_backSky = null;
			
			_enemyLine = null;
			
			_player.dispose();
			_player = null;
			
			_typeArray = null;
			_randomArray = null;
			
			for(var i : Number = 0; i < 3; ++i)
			{
				if(_bossHPbar.length != 0 && _boss.length != 0)
				{
					_bossHPbar[i].dispose();
					_bossHPbar[i] = null;
					_boss[i].dispose();
					_boss[i] = null;
				}
			}
			_bossHPbar = null;
			_boss = null;
		}	
	}
}