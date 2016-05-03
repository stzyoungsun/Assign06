package framework.gameobject
{
	import flash.display.BitmapData;
	
	import framework.core.Framework;
	import framework.display.Image;

	public class Bullet extends Image
	{
		private var _bulletBitmapData : BitmapData;
		private var _bulletArray:Vector.<Bullet> = new Vector.<Bullet>;
		private var _shootingState:Function;
		
		public function Bullet(objectType:String, x:int, y:int, bulletBitmap:BitmapData)
		{
			super(x, y, bulletBitmap);
			_bulletBitmapData = bulletBitmap;
			this._objectType = objectType;
		}
		
		public function initBullet(x:Number, y:Number, width:Number, height:Number) : void
		{
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
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