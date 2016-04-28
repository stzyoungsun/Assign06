package framework.display
{
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class DisplayObject extends EventDispatcher
	{
		private var _x:Number;
		private var _y:Number;
		private var _rotation:Number;
		private var _parent:DisplayObjectContainer;
		private var _width : Number;
		private var _height : Number;
		private var _visible:Boolean;
		
		public function DisplayObject()
		{
			_x = _y = _rotation = 0.0;
			_visible = true;
		}
		
		public function render():void
		{
			// Abstract Method
		}
		
		public function nextFrame() : void
		{
			trace("디스플레이오브젝트 프레임 함수");
		}
		public function dispatchTouchEvent(type:String):void
		{
			dispatchEvent(new MouseEvent(type));
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
		
		public function get height():Number{ return _height; }
		public function set height(value:Number):void{ _height = value; }
		
		public function get width():Number{ return _width; }
		public function set width(value:Number):void{ _width = value; }
		
		public function get x():Number { return _x; }
		public function set x(x:Number):void { _x = x; }
		
		public function get y():Number { return _y; }
		public function set y(y:Number):void { _y = y; }
		
		public function get rotation():Number { return _rotation; }
		public function set rotation(rotation:Number):void { _rotation = rotation; }
		
		public function get visible():Boolean { return _visible; }
		public function set visible(visible:Boolean):void { _visible = visible; }
		
		public function get bounds():Rectangle { return null; }
	}
}