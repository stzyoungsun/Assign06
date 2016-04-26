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
	}
}