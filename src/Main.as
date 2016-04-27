package
{
	import framework.display.Quad;
	import framework.display.Sprite;
	
	public class Main extends Sprite
	{
		public function Main()
		{
			addChild(new Quad(0.1, 0.1, 0xFFFFFF));
			
			addChild(new Quad(0.5, 0.5, 0xFFFFFF));
			
			addChild(new Quad(-0.5, -0.5, 0xFFFFFF));
			
			addChild(new Quad(-0.1, -0.1, 0xFFFFFF));
		}
	}
}