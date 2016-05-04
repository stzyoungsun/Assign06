package aniPangShootingWorld.round
{
	import flash.display.BitmapData;
	import flash.utils.getTimer;
	
	import aniPangShootingWorld.enemy.EnemyLine;
	import aniPangShootingWorld.enemy.EnemyObjectUtil;
	import aniPangShootingWorld.player.Player;
	import aniPangShootingWorld.util.UtilFunction;
	
	import framework.animaiton.AtlasBitmapData;
	import framework.background.BackGround;
	import framework.core.Framework;
	import framework.display.ObjectType;
	import framework.display.Sprite;
	import framework.event.TouchEvent;
	import framework.event.TouchPhase;
	import framework.gameobject.BulletManager;
	

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
		
		private const ENEMY_MAX_LEVEL : Number = 1;
		private const ENEMY_MAX_COUNT : Number = 3;
		/**
		 * 적들의 LineCount를 초기화 하고 순서에 따라 화면에 뿌려줍니다.
		 */		
		public function OneRound()
		{
			this.objectType = ObjectType.ROUND_GENERAL;
			
			EnemyLine._sCurLineCount = 5;
			_prevTime = getTimer();
			//Note @유영선 배경 그라운드를 화면에 출력
			backGroundDraw();
			//Note @유영선 플레이어를 화면에 출력
			playerDraw();
			//Note @유영선 적 라인을 설정 하고 적들을 화면에 출력하고 배경 스카이를 출력
			CreateEnemyLine();
		}
		
		/**
		 *Note @유영선 적들을 그립니다 
		 * 
		 */
		public override function render():void
		{
			super.render();
			
			var curTimer:int = getTimer();
		
			//@Note 유영선 스테이지 난이도 시간에 따라 조절
			if(curTimer - _prevTime > 10000 && EnemyObjectUtil._sRedraw == true)
			{
				//난이도 상승 임시 방편 (아직 몬스터 객체가 얼마 없어서)
				if(_randomArray[ENEMY_MAX_COUNT-1] < ENEMY_MAX_LEVEL)
				{
					_randomArray[_randomArrayControl]++;
					_randomArrayControl++;
					if(_randomArrayControl == 5) _randomArrayControl = 0;
					_prevTime = getTimer();
				}
				
				else
				{
					//boss 모드 구현
					this.objectType = ObjectType.ROUND_BOSS;
					EnemyObjectUtil._sRedraw = false
					enenmyRemove();
				}
			}
			
			if(this.objectType == ObjectType.ROUND_BOSS)
				trace("보스모드 랜더");
			
			//Note @유영선 _sRedraw의 값에 따라 화면에 적을 지우고 다시 그립니다.
			if(EnemyObjectUtil._sRedraw == true)
			{
				CreateEnemyLine()
				EnemyObjectUtil._sRedraw = false;
			}
			
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
			for(var cnt : int =0 ; cnt < EnemyLine._sCurLineCount; cnt++)
				_typeArray[cnt] = _randomArray[cnt]
					
				_typeArray = UtilFunction.shuffle(_typeArray,5);
			
			for(var i : Number =0; i < EnemyLine._sCurLineCount; i++)
			{
				_enemyAtlasVector[i] = new AtlasBitmapData(MenuVIew.sloadedImage.imageDictionary[EnemyObjectUtil.ENEMY_SPRITENAME_ARRAY[_typeArray[i]]]
					,MenuVIew.sloadedImage.xmlDictionary[EnemyObjectUtil.ENEMY_XML_ARRAY[_typeArray[i]]]);
			}
			_enemyLine.setEnemyLine(_enemyAtlasVector,_typeArray, this);
			enenmyDraw();
			addChild(_backSky);
		}
		
		private function enenmyRemove() : void
		{
			for(var i: int =0; i < EnemyLine._sCurLineCount; i ++)
			{
				if(getChildIndex(_enemyLine.enemyVector[i]) != -1)
					removeChild(_enemyLine.enemyVector[i]);
			}
		}
		
		/**
		 * Note @유영선 enemyLine을 등록합니다.
		 */		
		private function enenmyDraw():void
		{
			for(var i: int =0; i < EnemyLine._sCurLineCount; i ++)
				addChild(_enemyLine.enemyVector[i]);
		}
		
		/**
		 * Note @유영선 Player를 그립니다 
		 */		
		private function playerDraw():void
		{
			_backSky = new BackGround(2, 60, 10.24, MenuVIew.sloadedImage.imageDictionary["backskycur.png"].bitmapData);
			
			var bulletMgr : BulletManager = new BulletManager(ObjectType.PLAYER_BULLET_IDLE,30,MenuVIew.sloadedImage.imageDictionary["Bulletone.png"].bitmapData);
			_player = new Player(new AtlasBitmapData(MenuVIew.sloadedImage.imageDictionary["Player.png"],MenuVIew.sloadedImage.xmlDictionary["Player.xml"]),5,
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
			_backGround = new BackGround(2, 60, 1, MenuVIew.sloadedImage.imageDictionary["backtree.jpg"].bitmapData);
			addChild(_backGround);
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
		}
		
	}
}