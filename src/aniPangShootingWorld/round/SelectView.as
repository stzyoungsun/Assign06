package aniPangShootingWorld.round
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import aniPangShootingWorld.round.SelectViewSub.ItemWindow;
	import aniPangShootingWorld.round.SelectViewSub.RoundButton;
	import aniPangShootingWorld.round.SelectViewSub.StoreBox;
	import aniPangShootingWorld.round.Setting.GameSetting;
	import aniPangShootingWorld.ui.ConfigureBox;
	import aniPangShootingWorld.ui.MessageBox;
	import aniPangShootingWorld.util.GameTexture;
	
	import framework.animaiton.MovieClip;
	import framework.core.Framework;
	import framework.display.Button;
	import framework.display.Image;
	import framework.display.Sprite;
	import framework.event.TouchEvent;
	import framework.texture.TextureManager;

	public class SelectView extends Sprite
	{
		//게임 상에 플레이어가 획득 한 누적 골드
		public static var sgameTotalGold : Number = 0;
		//게임을 플레이 할 수 있는 재화 (날개)
		public static var sgameWingCount : Number =0;
		
		private static var _current : Sprite;
		
		private var _selectImage : Image;
		private var _decoClip : MovieClip;
		private var _sceneSetting : Object;
		private var _nextButton : Button;
		private var _prevButton : Button;
		private var _storeButton : Button;
		private var _configureButton:Button;
		private var _viewNum : Number;
		
		/**
		 * 스테이지를 선택 하는 창이 나옵니다.
		 */		
		public function SelectView(ViewNum : Number)
		{
			_viewNum = ViewNum;
			_current = this;
			sgameTotalGold = GameSetting.instance.roundStateArray.GameTotalGold;
			sgameWingCount = GameSetting.instance.roundStateArray.GameWing;
			
			initView(ViewNum);
		}
		
		private function initView(viewNum : Number):void
		{
			_sceneSetting = GameSetting.instance.roundStateArray.Scene[viewNum];

			_selectImage = new Image(0, 0, TextureManager.getInstance().textureDictionary[_sceneSetting.ViewPng]);
			_selectImage.width = Framework.viewport.width;
			_selectImage.height = Framework.viewport.height;
			addChild(_selectImage);
			
			drawDeco();
			drawRoundButton();
			drawItemWindow();
			drawNextButton();
			drawPrevButton();
			drawStoreButton();
			drawConfigureButton();
			
			Framework.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function drawStoreButton():void
		{
			_storeButton = new Button("Store",Framework.viewport.width/35,Framework.viewport.width/35,GameTexture.messageBox[5]);
			_storeButton.width = Framework.viewport.width/3;
			_storeButton.height = Framework.viewport.height/15;
			_storeButton.x = Framework.viewport.width*0.66;
			_storeButton.y = Framework.viewport.height/12;
			_storeButton.addEventListener(TouchEvent.TRIGGERED, onClicked);
			addChild(_storeButton);
		}
		
		private function drawNextButton():void
		{
			if(GameSetting.instance.roundStateArray.GameTotalRound <= _sceneSetting.RoundStartNum + _sceneSetting.Roundcnt) return;
			
			_nextButton = new Button("Next", Framework.viewport.width/35, Framework.viewport.width/35, GameTexture.messageBox[3]);
			_nextButton.width = Framework.viewport.width/3;
			_nextButton.height = Framework.viewport.height/15;
			_nextButton.addEventListener(TouchEvent.TRIGGERED, onClicked);
			addChild(_nextButton);
		}
		
		private function drawPrevButton():void
		{
			if(_sceneSetting.RoundStartNum == 0) return;
			
			_prevButton = new Button("Prev", Framework.viewport.width/35, Framework.viewport.width/35, GameTexture.messageBox[4]);
			_prevButton.width = Framework.viewport.width/3;
			_prevButton.height = Framework.viewport.height/15;
			_prevButton.y = Framework.viewport.height*0.93;
			_prevButton.addEventListener(TouchEvent.TRIGGERED, onClicked);
			addChild(_prevButton);
		}
		
		protected function onClicked(event:Event):void
		{
			switch(event.currentTarget)
			{
				case _nextButton:
				{
					this.removeChildren(0,-1);
					initView(++_viewNum);
					break;
				}
					
				case _prevButton:
				{
					this.removeChildren(0,-1);
					initView(--_viewNum);
					break;
				}
					
				case _storeButton:
				{
					var storebox : StoreBox = new StoreBox();
					storebox.width = Framework.viewport.width/2;
					storebox.height = Framework.viewport.height/3;
					storebox.x = Framework.viewport.width / 4;
					storebox.y = Framework.viewport.height / 3;
					addChild(storebox);
					break;
 				}
					
				case _configureButton:
					var configureBox:ConfigureBox = new ConfigureBox();
					configureBox.width = Framework.viewport.width / 2;
					configureBox.height = Framework.viewport.height / 3;
					configureBox.x = Framework.viewport.width / 4;
					configureBox.y = Framework.viewport.height / 3;
					addChild(configureBox);
					break;
			}
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.BACK)
			{
				var exitBox:MessageBox = new MessageBox(
					"Exit Game",
					25,
					true,
					function():void { NativeApplication.nativeApplication.exit(); },
					function():void { Framework.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown); }
				);
				
				exitBox.width = Framework.viewport.width / 2;
				exitBox.height = Framework.viewport.height / 3;
				exitBox.x = Framework.viewport.width / 4;
				exitBox.y = Framework.viewport.height / 3;
				addChild(exitBox);
				
				Framework.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			}
		}
		
		private function drawItemWindow():void
		{
			addChild(new ItemWindow(Framework.viewport.width/2, Framework.viewport.height/50, ItemWindow.ITEM_COIN));
			addChild(new ItemWindow(Framework.viewport.width*3/4, Framework.viewport.height/50, ItemWindow.ITEM_WING));
		}
		
		private function drawRoundButton():void
		{
			for(var i : int =0; i < _sceneSetting.Roundcnt; i++)
			{
				var roundButton : RoundButton = new RoundButton(i+1, _sceneSetting, this);
				addChild(roundButton);
			}
		}
		
		private function drawDeco():void
		{
			_decoClip = new MovieClip(GameTexture.player,5,Framework.viewport.width/4,Framework.viewport.height*5/18);
			_decoClip.width = Framework.viewport.width/10;
			_decoClip.height = Framework.viewport.height/10;
			_decoClip.start();
			addChild(_decoClip);
		}
		
		private function drawConfigureButton():void
		{
			_configureButton = new Button("", 0, 0, GameTexture.subSelectViews[10]);
			_configureButton.x = Framework.viewport.width * 0.38;
			_configureButton.y = Framework.viewport.height / 45;
			_configureButton.width = Framework.viewport.height / 30;
			_configureButton.height = Framework.viewport.height / 30;
			_configureButton.addEventListener(TouchEvent.TRIGGERED, onClicked);
			addChild(_configureButton);
		}
		
		public static function get current():Sprite{return _current;}
	}
}