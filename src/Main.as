package
{
	import framework.display.Quad;
	import framework.display.Sprite;
	
	public class Main extends Sprite
	{
		public function Main()
		{
			addChild(new Quad(0.3, 0.3, 0xFFFFFF));
		}
	}
}