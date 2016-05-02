package aniPangShootingWorld.round
{
	import flash.display.BitmapData;
	
	import aniPangShootingWorld.enemy.EnemyLine;
	import aniPangShootingWorld.enemy.EnemyObject;
	import aniPangShootingWorld.enemy.EnemyPig;
	import aniPangShootingWorld.enemy.EnemyRat;
	import aniPangShootingWorld.player.Player;
	
	import framework.animaiton.AtlasBitmapData;
	import framework.background.BackGround;
	import framework.core.Framework;
	import framework.display.ObjectType;
	import framework.display.Sprite;
	import framework.event.TouchEvent;
	import framework.event.TouchPhase;
	import framework.gameobject.BulletManager;
	import framework.scene.SceneManager;

	public class OneRound extends Sprite
	{
		private var _backGround : BackGround;
		private var _backSky : BackGround;
		
		private var _player : Player;
		
		private var _enemyBitmapDataVector : Vector.<BitmapData> = new Vector.<BitmapData>;
		
		private var _enemyLine : EnemyLine;
		
		public function OneRound()
		{
			backGroundDraw();
			playerDraw();
			CreateEnemyLine();
			
			backSkyDraw();
		}
		
		/**
		 *Note @유영선 적들을 그립니다 
		 * 
		 */		
		private function CreateEnemyLine():void
		{
			// TODO Auto Generated method stub
			
			_enemyBitmapDataVector[0] = MenuVIew.sloadedImage.imageDictionary["pig1.png"].bitmapData
			_enemyBitmapDataVector[1] = MenuVIew.sloadedImage.imageDictionary["pig1.png"].bitmapData;
			_enemyBitmapDataVector[2] = MenuVIew.sloadedImage.imageDictionary["pig1.png"].bitmapData;
			_enemyBitmapDataVector[3] = MenuVIew.sloadedImage.imageDictionary["pig1.png"].bitmapData;
			_enemyBitmapDataVector[4] = MenuVIew.sloadedImage.imageDictionary["pig1.png"].bitmapData;
			
			_enemyLine = new EnemyLine();
			_enemyLine.setEnemyLine(_enemyBitmapDataVector);
			
			addChild(_enemyLine.enemyVector[0]);
			addChild(_enemyLine.enemyVector[1]);
			addChild(_enemyLine.enemyVector[2]);
			addChild(_enemyLine.enemyVector[3]);
			addChild(_enemyLine.enemyVector[4]);
		}
		/**
		 *Note @유영선 배경 하늘을 그립니다 
		 * 
		 */		
		private function backSkyDraw():void
		{
			// TODO Auto Generated method stub
			
			addChild(_backSky);
		}
		
		/**
		 * Note @유영선 Player를 그립니다 
		 * 
		 */		
		private function playerDraw():void
		{
			// TODO Auto Generated method stub
			_backSky = new BackGround(2, 60, 10, MenuVIew.sloadedImage.imageDictionary["backSky.png"].bitmapData);
			
			var bulletMgr : BulletManager = new BulletManager(ObjectType.PLAYER_BULLET,30,MenuVIew.sloadedImage.imageDictionary["Bulletone.png"].bitmapData);
			_player = new Player(new AtlasBitmapData(MenuVIew.sloadedImage.imageDictionary["Player.png"],MenuVIew.sloadedImage.xmlDictionary["Player.xml"]),5,
				bulletMgr,this);
			_player.start();
			_player.movieClipWidth = Framework.viewport.width/6;
			_player.movieClipHeight = Framework.viewport.height/6;
			_player.addEventListener(TouchEvent.TOUCH, onTouch);
			_backSky.addEventListener(TouchEvent.TOUCH, onTouch);
			
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
			_backGround = new BackGround(2, 60, 1, MenuVIew.sloadedImage.imageDictionary["background1.jpg"].bitmapData);
			addChild(_backGround);
		}
		
		public override function dispose():void
		{
			super.dispose();
			_backGround.dispose();
			_backGround = null;
			
			_backSky.dispose();
			_backSky = null;
		}
	}
}