package framework.display
{
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class DisplayObject extends EventDispatcher
	{
		private var _x:Number;
		private var _y:Number;
		private var _width:Number;
		private var _height:Number;
		private var _scaleX:Number;
		private var _scaleY:Number;
		private var _pivotX:Number;
		private var _pivotY:Number;
		private var _rotation:Number;
		private var _visible:Boolean;
		private var _parent:DisplayObjectContainer;
		
		protected var _objectType : String = ObjectType.NONE;
		
		public function DisplayObject()
		{
			_x = _y = _rotation = _pivotX = _pivotY = 0.0;
			_scaleX = _scaleY = 1.0;
			_visible = true;
		}

		public virtual function render():void
		{
			// Abstract Method
		}
		
		public function hitTest(localPoint:Point):DisplayObject
		{
			if (!_visible)
			{
				return null;
			}
			
			if (bounds.containsPoint(localPoint))
			{
				return this;
			}
			
			return null;
		}
		
		public function dispose():void
		{
			//해제가 필요한 부분 입력
		}
		
		public function get x():Number { return _x; }
		public function set x(x:Number):void { _x = x; }
		
		public function get y():Number { return _y; }
		public function set y(y:Number):void { _y = y; }
		
		public function get scaleX():Number { return _scaleX; }
		public function set scaleX(value:Number):void { _scaleX = value; }
		
		public function get scaleY():Number { return _scaleY; }
		public function set scaleY(value:Number):void { _scaleY = value; }
		
		public function get pivotX():Number { return _pivotX; }
		public function set pivotX(value:Number):void { _pivotX = value; }
		
		public function get pivotY():Number { return _pivotY; }
		public function set pivotY(value:Number):void { _pivotY = value; }
		
		public function get rotation():Number { return _rotation; }
		public function set rotation(value:Number):void
		{
			while (value < -Math.PI) value += Math.PI * 2.0;
			while (value >  Math.PI) value -= Math.PI * 2.0;
			_rotation = value;
		}
		
		public function get width():Number { return _height; }
		public function set width(value:Number):void { _width = value; }
		
		public function get height():Number { return _height; }
		public function set height(value:Number):void { _height = value; }
		
		public function get visible():Boolean { return _visible; }
		public function set visible(visible:Boolean):void { _visible = visible; }
		
		public function get bounds():Rectangle { return null; }
		
		public function get objectType():String { return _objectType; }
		
		internal function set parent(value:DisplayObjectContainer):void { _parent = value; }
	}
}