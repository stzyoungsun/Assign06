package aniPangShootingWorld.ui
{
	import flash.events.Event;
	
	import aniPangShootingWorld.round.BonusRound;
	import aniPangShootingWorld.round.MenuView;
	import aniPangShootingWorld.round.Round;
	import aniPangShootingWorld.round.Setting.GameSetting;
	import aniPangShootingWorld.util.GameTexture;
	
	import framework.core.Framework;
	import framework.display.Button;
	import framework.event.TouchEvent;
	import framework.scene.SceneManager;

	public class ConfigureBox extends MessageBox
	{
		private var _vibrationCheckBox:CheckBox;
		private var _bgmCheckBox:CheckBox;
		private var _effectSoundCheckBox:CheckBox;
		private var _gameSetting:GameSetting;
		private var _logoutButton:Button;
		
		public function ConfigureBox()
		{
			super("", 0, true, configureOkFunction, configureCancelFunction);
			
			_gameSetting = GameSetting.instance;
			
			_vibrationCheckBox = new CheckBox("Vibration");
			_vibrationCheckBox.x = Framework.viewport.width / 50;
			_vibrationCheckBox.y = Framework.viewport.height / 15;
			_vibrationCheckBox.currentState = _gameSetting.vibration;
			
			_bgmCheckBox = new CheckBox("BGM");
			_bgmCheckBox.x = Framework.viewport.width / 50;
			_bgmCheckBox.y = (Framework.viewport.height / 20) + _vibrationCheckBox.y;
			_bgmCheckBox.currentState = _gameSetting.bgm;
			
			_effectSoundCheckBox = new CheckBox("Effect Sound");
			_effectSoundCheckBox.x = Framework.viewport.width / 50;
			_effectSoundCheckBox.y = (Framework.viewport.height / 20) + _bgmCheckBox.y;
			_effectSoundCheckBox.currentState = _gameSetting.effectSound;
			
			_logoutButton = new Button("Log Out", Framework.viewport.width / 30, Framework.viewport.width / 30, GameTexture.messageBox[4]);
			_logoutButton.y = (Framework.viewport.height / 20) + _effectSoundCheckBox.y;
			_logoutButton.width = Framework.viewport.width / 4;
			_logoutButton.height = Framework.viewport.height / 20;
			_logoutButton.addEventListener(TouchEvent.TRIGGERED, onTriggerButton);
			
			addChild(_vibrationCheckBox);
			addChild(_bgmCheckBox);
			addChild(_effectSoundCheckBox);
			addChild(_logoutButton);
		}
		
		private function configureOkFunction():void
		{
			_gameSetting.vibration = _vibrationCheckBox.currentState;
			_gameSetting.bgm = _bgmCheckBox.currentState;
			_gameSetting.effectSound = _effectSoundCheckBox.currentState;
			
			dispatchEvent(new Event("resume"));
		}
		
		private function configureCancelFunction():void
		{
			dispatchEvent(new Event("resume"));
		}
		
		private function onTriggerButton(event:Event):void
		{
			var messageBox:MessageBox = new MessageBox("If you click the OK button you will logout from the game", 25, true, logoutOkFunction);
			addChild(messageBox);
			
			function logoutOkFunction():void
			{
				if(Framework.sceneStage is Round || Framework.sceneStage is BonusRound)
				{
					SceneManager.instance.sceneChange();
				}
				SceneManager.instance.sceneChange();
				(Framework.sceneStage as MenuView).logoutFromGame();
			}
		}
	}
}