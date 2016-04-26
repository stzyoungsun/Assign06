package framework.display
{
	import flash.events.EventDispatcher;

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
			
		}
		
		public function render():void
		{
			// Abstract Method
		}
	}
}