package framework.display
{
	import flash.events.EventDispatcher;
	
	import framework.core.Framework;

	public class DisplayObject extends EventDispatcher
	{
		private var _x:Number;
		private var _y:Number;
		private var _scaleX:Number;
		private var _scaleY:Number;
		private var _rotation:Number;
		private var _parent:DisplayObjectContainer;
		public var _painter:Painter;
		
		public function DisplayObject()
		{
			_x = _y = _rotation = 0.0;
			_scaleX = _scaleY = 1.0;
		}
		
		public function render():void
		{
			// Abstract Method
		}
		

		
		public function get x():Number { return _x; }
		public function set x(x:Number):void { _x = x; }
		
		public function get y():Number { return _y; }
		public function set y(y:Number):void { _y = y; }
		
		public function get scaleX():Number { return _scaleX; }
		public function set scaleX(scaleX:Number):void { _scaleX = scaleX; }
		
		public function get scaleY():Number { return _scaleY; }
		public function set scaleY(scaleY:Number):void { _scaleY = scaleY; }
		
		public function get rotation():Number { return _rotation; }
	}
}