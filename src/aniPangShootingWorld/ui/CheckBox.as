package aniPangShootingWorld.ui
{
	import flash.events.Event;
	
	import aniPangShootingWorld.util.GameTexture;
	
	import framework.core.Framework;
	import framework.display.DisplayObjectContainer;
	import framework.display.Image;
	import framework.display.ImageTextField;
	import framework.display.Sprite;
	import framework.event.TouchEvent;
	import framework.event.TouchPhase;
	
	public class CheckBox extends DisplayObjectContainer
	{
		private var _checkBoxCanvas:Sprite;
		private var _checkedImage:Image;
		private var _uncheckedImage:Image;
		private var _currentState:Boolean;
		private var _imageTextField:ImageTextField;
		
		public function CheckBox(text:String, initialState:Boolean=true)
		{
			_checkBoxCanvas = new Sprite();
			
			_checkedImage = new Image(0, 0, GameTexture.messageBox[6]);
			_checkedImage.width = Framework.viewport.width / 30;
			_checkedImage.height = Framework.viewport.width / 30;
			_checkedImage.visible = initialState;
			
			_uncheckedImage = new Image(0, 0, GameTexture.messageBox[7]);
			_uncheckedImage.width = Framework.viewport.width / 30;
			_uncheckedImage.height = Framework.viewport.width / 30;
			_uncheckedImage.visible = !initialState;
			
			_imageTextField = new ImageTextField(Framework.viewport.width / 50, 0, Framework.viewport.width / 40, Framework.viewport.height / 40);
			_imageTextField.text = text;
			_imageTextField.y = (Framework.viewport.width / 30 - Framework.viewport.height / 40) / 2;
			
			_currentState = initialState;
			
			_checkBoxCanvas.addChild(_checkedImage);
			_checkBoxCanvas.addChild(_uncheckedImage);
			_checkBoxCanvas.addChild(_imageTextField);
			
			addEventListener(TouchEvent.TOUCH, onCheck);
			addChild(_checkBoxCanvas);
		}
		
		public function onCheck(event:TouchEvent):void
		{
			if(event.touch.phase == TouchPhase.BEGAN)
			{
				_checkedImage.visible = !_checkedImage.visible;
				_uncheckedImage.visible = !_uncheckedImage.visible;
				currentState = !currentState;
			}
		}

		public function get currentState():Boolean { return _currentState; }

		public function set currentState(value:Boolean):void
		{
			_currentState = value;
			
			if(_currentState)
			{
				_checkedImage.visible = true;
				_uncheckedImage.visible = false;
			}
			else
			{
				_checkedImage.visible = false;
				_uncheckedImage.visible = true;
			}
			
			dispatchEvent(new Event("state_change"));
		}
	}
}