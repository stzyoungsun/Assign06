package framework.display
{
	import flash.geom.Point;

	public class Stage extends DisplayObjectContainer
	{
		private var _width:int;
		private var _height:int;
		private var _color:uint;
		
		public function Stage(width:int, height:int, color:uint=0)
		{
			_width = width;
			_height = height;
			_color = color;
		}
		
		public override function hitTest(localPoint:Point):DisplayObject
		{
			if (!visible) return null;
			
			// locations outside of the stage area shouldn't be accepted
			if (localPoint.x < 0 || localPoint.x > _width ||
				localPoint.y < 0 || localPoint.y > _height)
				return null;
			
			// if nothing else is hit, the stage returns itself as target
			var target:DisplayObject = super.hitTest(localPoint);
			return target ? target : this;
		}
		
		public function get stageWidth():int { return _width; }
		public function set stageWidth(value:int):void { _width = value; }
		
		public function get stageHeight():int { return _height; }
		public function set stageHeight(value:int):void { _height = value; }
		
		public function get color():uint { return _color; }
		public function set color(value:uint):void { _color = value; }
	}
}