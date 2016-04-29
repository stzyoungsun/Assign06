package framework.gameobject
{
	import flash.display.BitmapData;
	
	import framework.display.DisplayObject;
	import framework.display.Image;

	public class Bullet extends Image
	{
		private var _bulletBitmapData : BitmapData;
		private var _bulletArray : Vector.<Bullet> = new Vector.<Bullet>;
		private var _bulletCount : int = 0;
	
		private var _shootingState : Function;
		
		public function Bullet(x:int,y:int,bulletBitmap : BitmapData)
		{
			super(x,y,bulletBitmap);
		}
		
		public function initBullet(object : DisplayObject) : void
		{
			this.x = object.x;
			this.y = object.y;
		}
		public function shootingState(state : Function = null, bulletNum : Number =0) : void 
		{
			
			_shootingState = state;
			if(state == null)
				this.y -= 5;
			
			else
				_shootingState(bulletNum);
		}
		
		public override function dispose():void
		{
			_shootingState = null;
			super.dispose();
		}
	}
}