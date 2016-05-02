package aniPangShootingWorld.player
{
	import flash.display.BitmapData;
	import flash.utils.getTimer;
	
	import framework.animaiton.AtlasBitmapData;
	import framework.animaiton.MovieClip;
	import framework.core.Framework;
	import framework.display.Sprite;
	import framework.gameobject.BulletManager;
	import framework.gameobject.Collision;

	/**
	 * @author user
	 * Note @유영선 플레이어 객체는 사용자의 마우스 움직임에 따라 X값이 자동으로 바뀌는 객체
	 */
	public class Player extends MovieClip
	{
		private var _playerAtlas:AtlasBitmapData;
		private var _bulletManager:BulletManager;
		private var _stage:Sprite;
		private var _prevTime:Number;
		
		public function Player(playerAtlas : AtlasBitmapData, frame : Number, bulletManager  : BulletManager,stage:Sprite )
		{	
			_playerAtlas = playerAtlas;
			_bulletManager = bulletManager;
			
			y = Framework.viewport.height - Framework.viewport.height/3;
			super(_playerAtlas, frame, 0, y);
			
			_bulletManager.createBullet(this.x,this.y);
			
			_stage=stage;
			_playerAtlas = null;
			_prevTime = 0;
		}
		
		public override function dispose():void
		{
			_stage = null;
		}
		
		public function shooting() : void
		{
			var bulletNum : Number = _bulletManager.bulletNumVector.pop();
			
			_bulletManager.bulletVector[bulletNum].initBullet(this.x+this.width/3,this.y,this.movieClipWidth/2, this.movieClipHeight/2);
			_stage.addChild(_bulletManager.bulletVector[bulletNum]);	
		}
		
		public function bulletFrame() : void
		{
			for(var i :int= 0; i < _bulletManager.totalBullet; i ++)
			{
				if(Collision.bulletToWall(_bulletManager.bulletVector[i]))
				{
					_stage.removeChild(_bulletManager.bulletVector[i]);
					_bulletManager.bulletNumVector.push(i);
				}
				else
				{
					_bulletManager.bulletVector[i].shootingState(bulletstate,i);
				}
			}
		}
		
		public function bulletstate(bulletNum : Number) : void
		{
			_bulletManager.bulletVector[bulletNum].y -= Framework.viewport.height/20;
		}
		
		public override function render():void
		{
			super.render();
			
			var curTimerBullet:int = getTimer();
			
			if(curTimerBullet - _prevTime > 100)
			{
				shooting();
				_prevTime = getTimer();
			}
			
			bulletFrame();
		}
	}
}