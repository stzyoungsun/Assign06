package aniPangShootingWorld.player
{
	import aniPangShootingWorld.round.MenuView;
	
	import framework.core.Framework;
	import framework.display.Image;
	import framework.display.Stage;

	public class PlayerState extends Stage
	{
		private var _mainStateDlg : Image;
		private var _heartDlg : Image;
		private var _powerDlg : Image;
		
		public function PlayerState()
		{
			super(0,0);
	
			_mainStateDlg = new Image(0,0, MenuView.sloadedImage.imageDictionary["state.png"].bitmapData);
			_mainStateDlg.width = Framework.viewport.width/3;
			_mainStateDlg.height = Framework.viewport.height/15;
			
			_heartDlg = new Image(_mainStateDlg.width*198/1000,_mainStateDlg.height*8/140,MenuView.sloadedImage.imageDictionary["heart10.png"].bitmapData);
			_heartDlg.width = Framework.viewport.width*2/13;
			_heartDlg.height = Framework.viewport.height/41;
			 
			_powerDlg = new Image(_heartDlg.x + _mainStateDlg.width/40,_heartDlg.height - _mainStateDlg.height/15,MenuView.sloadedImage.imageDictionary["power1.png"].bitmapData);
			_powerDlg.width = Framework.viewport.width*2/13;
			_powerDlg.height = Framework.viewport.height/41;
			
			addChild(_mainStateDlg);
			addChild(_heartDlg);
			addChild(_powerDlg);
			
		}
	}
}