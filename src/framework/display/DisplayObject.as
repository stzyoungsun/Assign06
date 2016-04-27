package framework.display
{
	import flash.events.EventDispatcher;
	
	import framework.Rendering.Painter;

	public class DisplayObject extends EventDispatcher
	{
		private var _x:Number;
		private var _y:Number;
		private var _rotation:Number;
		private var _parent:DisplayObjectContainer;
		private var _width : Number;
		private var _heigth : Number;
		
		
		public function DisplayObject()
		{
			_x = _y = _rotation = 0.0;
	
		}
		
		public function render():void
		{
			// Abstract Method
		}
		
		
		public function get heigth():Number{return _heigth;}
		public function set heigth(value:Number):void{_heigth = value;}
		
		public function get width():Number{return _width;}
		public function set width(value:Number):void{_width = value;}
		
		public function get x():Number { return _x; }
		public function set x(x:Number):void { _x = x; }
		
		public function get y():Number { return _y; }
		public function set y(y:Number):void { _y = y; }
		
		public function get rotation():Number { return _rotation; }
	}
}