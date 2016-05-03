package aniPangShootingWorld.round
{
	import flash.display.BitmapData;
	
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
		private var _backGround : BackGround;
		private var _backSky : BackGround;
		
		private var _player : Player;
		
		private var _enemyBitmapDataVector : Vector.<BitmapData> = new Vector.<BitmapData>;
		
		private var _enemyLine : EnemyLine = new EnemyLine();;
		
		private var _randomArray : Array;
		public function OneRound()
		{
			backGroundDraw();
			playerDraw();
			CreateEnemyLine();
		}
		
		
		/**
		 *Note @유영선 적들을 그립니다 
		 * 
		 */
		public override function render():void
		{
			super.render();
			
			if(EnemyObjectUtil._sRedraw == true)
			{
				CreateEnemyLine()
				EnemyObjectUtil._sRedraw = false;
			}
		}
		
		private function CreateEnemyLine():void
		{
			// TODO Auto Generated method stub
			if(_enemyBitmapDataVector.length != 0)
			{
				enenmyRemove();
				removeChild(_backSky);
			}
					
			_randomArray = new Array(0,0,0,0,1);
			_randomArray = UtilFunction.shuffle(_randomArray,5);
			
			for(var i : Number =0; i < 5; i++)
			{
				_enemyBitmapDataVector[i] = MenuVIew.sloadedImage.imageDictionary[EnemyObjectUtil.ENEMY_TYPE_ARRAY[_randomArray[i]]].bitmapData
			}
			_enemyLine.setEnemyLine(_enemyBitmapDataVector);
			enenmyDraw();
			addChild(_backSky);
		}
		
		private function enenmyRemove() : void
		{
			removeChild(_enemyLine.enemyVector[0]);
			removeChild(_enemyLine.enemyVector[1]);
			removeChild(_enemyLine.enemyVector[2]);
			removeChild(_enemyLine.enemyVector[3]);
			removeChild(_enemyLine.enemyVector[4]);
		}
		
		/**
		 * Note @유영선 enemyLine을 등록합니다.
		 * 
		 */		
		private function enenmyDraw():void
		{
			// TODO Auto Generated method stub
			addChild(_enemyLine.enemyVector[0]);
			addChild(_enemyLine.enemyVector[1]);
			addChild(_enemyLine.enemyVector[2]);
			addChild(_enemyLine.enemyVector[3]);
			addChild(_enemyLine.enemyVector[4]);

		}
		
		/**
		 * Note @유영선 Player를 그립니다 
		 * 
		 */		
		private function playerDraw():void
		{
			// TODO Auto Generated method stub
			_backSky = new BackGround(2, 60, 10.24, MenuVIew.sloadedImage.imageDictionary["backskycur.png"].bitmapData);
			
			var bulletMgr : BulletManager = new BulletManager(ObjectType.PLAYER_BULLET_MOVING,30,MenuVIew.sloadedImage.imageDictionary["Bulletone.png"].bitmapData);
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
			// TODO Auto-generated method stub
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
		 * 
		 * Note @유영선 배경화면을 그립니다.
		 */		
		private function backGroundDraw():void
		{
			// TODO Auto Generated method stub
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
		}
		
	}
}