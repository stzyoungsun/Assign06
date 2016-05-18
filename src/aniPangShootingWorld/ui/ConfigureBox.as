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
		
		private var _vibration:Boolean;
		private var _bgm:Boolean;
		private var _effectSound:Boolean;
		private var _gameSetting:GameSetting;
		
		public function ConfigureBox()
		{
			super("", 0, true);
			
			_gameSetting = GameSetting.instance;
			
			_vibrationCheckBox = new CheckBox("Vibration");
			_vibrationCheckBox.x = Framework.viewport.width / 50;
			_vibrationCheckBox.y = Framework.viewport.height / 15;
			_vibrationCheckBox.addEventListener("state_change", onStateChange);
			
			_bgmCheckBox = new CheckBox("BGM");
			_bgmCheckBox.x = Framework.viewport.width / 50;
			_bgmCheckBox.y = Framework.viewport.height / 15 + _vibrationCheckBox.y;
			_bgmCheckBox.addEventListener("state_change", onStateChange);
			
			_effectSoundCheckBox = new CheckBox("Effect Sound");
			_effectSoundCheckBox.x = Framework.viewport.width / 50;
			_effectSoundCheckBox.y = Framework.viewport.height / 15 + _bgmCheckBox.y;
			_effectSoundCheckBox.addEventListener("state_change", onStateChange);
			
			addChild(_vibrationCheckBox);
			addChild(_bgmCheckBox);
			addChild(_effectSoundCheckBox);
		}
		
		private function onStateChange(event:Event):void
		{
			var checkBox:CheckBox = event.currentTarget as CheckBox;
			
			switch(checkBox)
			{
				case _vibrationCheckBox:
					_gameSetting.vibration = _vibrationCheckBox.currentState;
					break;
				case _bgmCheckBox:
					_gameSetting.bgm = _bgmCheckBox.currentState;
					break;
				case _effectSoundCheckBox:
					_gameSetting.effectSound = _effectSoundCheckBox.currentState;
					break;
			}
		}
	}
}