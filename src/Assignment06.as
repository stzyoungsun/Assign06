package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import aniPangShootingWorld.round.MenuView;
	
	import framework.core.Framework;
	
	[SWF(width="768", height="1004", frameRate="60"]
	
	public class Assignment06 extends Sprite
	{
		private var fw:Framework = new Framework(MenuView, stage);
		public function Assignment06()
		{
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			addEventListener(Event.ACTIVATE, activateListener);
//			addEventListener(Event.DEACTIVATE, deactivateListener);
			fw.showStats(true);
		}
		
		private function deactivateListener(event:Event):void
		{
			// TODO Auto-generated method stub
			trace("종료");
			fw.stop();
		}
		
		private function activateListener(event:Event):void
		{
			// TODO Auto-generated method stub
			trace("시작");
			fw.start();
		}
	}
}