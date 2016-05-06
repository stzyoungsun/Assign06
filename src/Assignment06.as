package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import aniPangShootingWorld.round.MenuView;
	
	import framework.core.Framework;
	
	[SWF(width="768", height="1004", frameRate="60"]
	
	public class Assignment06 extends Sprite
	{
		public function Assignment06()
		{
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var fw:Framework = new Framework(MenuView, stage);
			fw.start();
		}
	}
}