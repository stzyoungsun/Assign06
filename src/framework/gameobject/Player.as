package framework.gameobject
{
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	
	import framework.core.Framework;
	import framework.display.Image;
	import framework.display.ObjectType;
	import framework.display.Sprite;

	/**
	 * 
	 * @author user
	 * Note @유영선 플레이어 객체는 사용자의 마우스 움직임에 따라 X값이 자동으로 바뀌는 객체
	 */
	public class Player extends Image
	{
		private var _playBitmapData : BitmapData;
		private var _bulletManager : BulletManager;
		
		private var _stage:Sprite;
		
		
		public function Player(playBitmapData : BitmapData, bulletManager  : BulletManager,stage:Sprite )
		{
			_playBitmapData = playBitmapData;
			_bulletManager = bulletManager;
			
			y = Framework.viewport.height - _playBitmapData.height*2;
			super(0,y,_playBitmapData);
			
			addEventListener(MouseEvent.MOUSE_OVER,onOver);
			
			_bulletManager.createBullet(this.x,this.y);
			
			_stage=stage;
			_playBitmapData = null;
		}
		public override function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			this._objectType = ObjectType.PLAYER;
			super.addEventListener(type,listener);
		}
		
		private function onOver(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			this.x= Framework.mousex;
		}
		
		public override function dispose():void
		{
			_stage = null;
		}
		
		public override function shooting() : void
		{
			// Abstract Method
			var bulletNum : Number = _bulletManager.bulletNumVector.pop();
			
			_bulletManager.bulletVector[bulletNum].initBullet(this);
			_stage.addChild(_bulletManager.bulletVector[bulletNum]);	
		}
		
		public override function bulletFrame() : void
		{
			// Abstract Method
			for(var i :int= 0; i < _bulletManager.totalBullet; i ++)
			{
				if(Collision.bulletToWall(_bulletManager.bulletVector[i]))
				{
					_stage.removeChild(_bulletManager.bulletVector[i]);
					_bulletManager.bulletNumVector.push(i);
				}
				else
					_bulletManager.bulletVector[i].shootingState();
			}		
		}
	}
}