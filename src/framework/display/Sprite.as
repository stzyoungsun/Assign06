package framework.display
{
	public class Sprite extends DisplayObjectContainer
	{
		public function Sprite()
		{
			super();
		}
		
		public override function render():void
		{
			super.render();
			trace("sprite");
		}
	}
}