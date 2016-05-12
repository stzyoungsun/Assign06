package framework.gameobject
{
	import framework.display.Image;
	import framework.texture.FwTexture;

	public class Bullet extends Image
	{
		private var _bulletArray:Vector.<Bullet> = new Vector.<Bullet>;
		private var _shootingState:Function;
		private var _angle:Number;
		private var _speed:Number;
		
		public function Bullet(objectType:String, x:int, y:int, texture:FwTexture)
		{
			super(x, y, texture);
			this._objectType = objectType;
		}
		
		public function initBullet(x:Number, y:Number, width:Number, height:Number, angle:Number = 0, speed:Number = 1) : void
		{
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
			this.angle = angle;
			this.speed = speed;
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
		
		public function get speed():Number { return _speed; }
		public function set speed(value:Number):void { _speed = value; }
		
		public function get angle():Number { return _angle; }
		public function set angle(value:Number):void { _angle = value; }
	}
}