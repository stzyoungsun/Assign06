package framework.gameobject
{
	public class CollisionRectangle
	{
		private var _left : Number;
		private var _right : Number;
		private var _top : Number;
		private var _bottom : Number;
		
		public function CollisionRectangle(left:Number, right:Number, top:Number, bottom:Number)
		{
			_left = left;
			_right = right;
			_top = top;
			_bottom = bottom;
		}

		public function get bottom():Number{ return _bottom; }
		public function set bottom(value:Number):void{ _bottom = value; }

		public function get top():Number{ return _top; }
		public function set top(value:Number):void{ _top = value; }

		public function get right():Number{ return _right;}
		public function set right(value:Number):void{ _right = value; }

		public function get left():Number{ return _left; }
		public function set left(value:Number):void{ _left = value; }
	}
}