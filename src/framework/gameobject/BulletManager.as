package framework.gameobject
{
	import flash.display.BitmapData;

	public class BulletManager
	{
		private var _bulletVector : Vector.<Bullet> = new Vector.<Bullet>;
		private var _bulletNumVector : Vector.<Number> = new Vector.<Number>;
		
		private var _bulletBitmapData : BitmapData;
		private var _totalBullet : int = 0;
		
		public function BulletManager(totalBullet : int,bulletBitmap : BitmapData)
		{
			_totalBullet = totalBullet;
			_bulletBitmapData = bulletBitmap;
			
		}
		

		

		public  function createBullet(x:Number, y:Number) : void
		{
			for(var i :int =0; i< _totalBullet; i++)
			{
				_bulletVector.push(new Bullet(x,y,_bulletBitmapData));
				_bulletNumVector.push(i);
			}
			
		}
		
		public function dispose() : void
		{
			_bulletBitmapData = null;
		}
		
		public function get totalBullet():int{return _totalBullet;}
		public function get bulletVector():Vector.<Bullet>{return _bulletVector;}
		public function get bulletNumVector():Vector.<Number>{return _bulletNumVector;}
		public function set bulletNumVector(value:Vector.<Number>):void{_bulletNumVector = value;}
	}
}