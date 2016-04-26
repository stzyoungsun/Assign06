package framework.display
{
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
		
		public function get stageWidth():int { return _width; }
		public function set stageWidth(value:int):void { _width = value; }
		
		public function get stageHeight():int { return _height; }
		public function set stageHeight(value:int):void { _height = value; }
	}
}