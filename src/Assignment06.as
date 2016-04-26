package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import framework.core.Framework;
	
	[SWF(width="800", height="600", frameRate="60", backgroundColor="#FFFFF0")]
	public class Assignment06 extends Sprite
	{
		public function Assignment06()
		{
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var fw:Framework = new Framework(Main, stage);
			fw.start();
		}
	}
}