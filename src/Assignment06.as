package
{
	import com.lpesign.Extension;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import aniPangShootingWorld.round.MenuView;
	import aniPangShootingWorld.util.PrevLoadImage;
	
	import framework.core.Framework;

	[SWF(width="768", height="1004", frameRate="60"]
	
	public class Assignment06 extends Sprite
	{
		private var fw:Framework = new Framework(MenuView, stage);
		private var _pushMessage : Extension = new Extension();
		public function Assignment06()
		{
			super();
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			addEventListener(Event.ACTIVATE, activateListener);
			addEventListener(Event.DEACTIVATE, deactivateListener);
			fw.showStats(true);
		}
		
		private function deactivateListener(event:Event):void
		{
			// TODO Auto-generated method stub
			_pushMessage.push(new PrevLoadImage.icon().bitmapData,"30초 동안 기다렸어요ㅠㅠ","얼른 와서 몬스터를 처치해 주세요~~",30000);
			fw.stop();
		}
		
		private function activateListener(event:Event):void
		{
			// TODO Auto-generated method stub
			fw.start();
		}
	}
}