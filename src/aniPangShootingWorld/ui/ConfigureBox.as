package aniPangShootingWorld.ui
{
	import flash.events.Event;
	
	import aniPangShootingWorld.round.Setting.GameSetting;
	
	import framework.core.Framework;

	public class ConfigureBox extends MessageBox
	{
		private var _vibrationCheckBox:CheckBox;
		private var _bgmCheckBox:CheckBox;
		private var _effectSoundCheckBox:CheckBox;
		private var _gameSetting:GameSetting;
		
		public function ConfigureBox()
		{
			super("", 0, true, okBtnFunction, closeBtnFunction);
			
			_gameSetting = GameSetting.instance;
			
			_vibrationCheckBox = new CheckBox("Vibration");
			_vibrationCheckBox.x = Framework.viewport.width / 50;
			_vibrationCheckBox.y = Framework.viewport.height / 15;
			_vibrationCheckBox.currentState = _gameSetting.vibration;
			
			_bgmCheckBox = new CheckBox("BGM");
			_bgmCheckBox.x = Framework.viewport.width / 50;
			_bgmCheckBox.y = Framework.viewport.height / 15 + _vibrationCheckBox.y;
			_bgmCheckBox.currentState = _gameSetting.bgm;
			
			_effectSoundCheckBox = new CheckBox("Effect Sound");
			_effectSoundCheckBox.x = Framework.viewport.width / 50;
			_effectSoundCheckBox.y = Framework.viewport.height / 15 + _bgmCheckBox.y;
			_effectSoundCheckBox.currentState = _gameSetting.effectSound;
			
			addChild(_vibrationCheckBox);
			addChild(_bgmCheckBox);
			addChild(_effectSoundCheckBox);
		}
		
		private function okBtnFunction():void
		{
			_gameSetting.vibration = _vibrationCheckBox.currentState;
			_gameSetting.bgm = _bgmCheckBox.currentState;
			_gameSetting.effectSound = _effectSoundCheckBox.currentState;
			
			dispatchEvent(new Event("resume"));
		}
		
		private function closeBtnFunction():void
		{
			dispatchEvent(new Event("resume"));
		}
		
		private function onClose(event:Event):void
		{
			dispatchEvent(new Event("resume"));
		}
	}
}