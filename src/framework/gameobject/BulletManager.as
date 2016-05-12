package framework.gameobject
{
	import framework.texture.FwTexture;

	public class BulletManager
	{
		private var _bulletVector:Vector.<Bullet> = new Vector.<Bullet>;
		private var _bulletNumVector:Vector.<Number> = new Vector.<Number>;
		private var _texture:FwTexture;
		private var _totalBullet:int;
		private var _objectType:String;
		
		public function BulletManager(objectType:String, totalBullet:int, texture:FwTexture)
		{
			_totalBullet = totalBullet;
			_texture = texture;
			_objectType = objectType;
		}

		public  function createBullet(x:Number, y:Number):void
		{
			for(var i:int =0; i < _totalBullet; i++)
			{
				_bulletVector.push(new Bullet(_objectType, x, y, _texture));
				_bulletNumVector.push(i);
			}
		}
		
		public function dispose():void
		{
			_texture = null;
		}
		
		public function get totalBullet():int{ return _totalBullet; }
		public function get bulletVector():Vector.<Bullet>{ return _bulletVector; }
		public function get bulletNumVector():Vector.<Number>{ return _bulletNumVector; }
		public function set bulletNumVector(value:Vector.<Number>):void{ _bulletNumVector = value; }
	}
}