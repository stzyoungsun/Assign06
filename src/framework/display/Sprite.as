package framework.display
{
	public class Sprite extends DisplayObjectContainer
	{
		private var _resultTimer : Number;
		
		public function Sprite()
		{
			super();
		}
		
		public function get resultTimer():Number{return _resultTimer;}
		public function set resultTimer(value:Number):void{_resultTimer = value;}
	}
}