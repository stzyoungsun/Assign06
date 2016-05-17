package aniPangShootingWorld.round
{
	import flash.events.Event;
	
	import aniPangShootingWorld.round.SelectViewSub.ItemWindow;
	import aniPangShootingWorld.round.SelectViewSub.RoundButton;
	import aniPangShootingWorld.round.SelectViewSub.StoreBox;
	import aniPangShootingWorld.round.Setting.GameSetting;
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
		
		private var _selectImage : Image;
		private var _decoClip : MovieClip;
		private var _sceneSetting : Object; 
		
		private var _nextButton : Button;
		private var _prevButton : Button;
		
		private var _storeButton : Button;
		private var _viewNum : Number = 0;
		
		private static var _current : Sprite;
		/**
		 * 스테이지를 선택 하는 창이 나옵니다.
		 */		
		public function SelectView(ViewNum : Number)
		{
			_viewNum = ViewNum;
			_current = this;
			sgameTotalGold = GameSetting.instance.roundStateArray.GameTotalGold;
			sgameWingCount = GameSetting.instance.roundStateArray.GameWing;
			
			ViewInit(ViewNum);
		}
		
		private function ViewInit(viewNum : Number):void
		{
			// TODO Auto Generated method stub
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
		}
		
		private function drawStoreButton():void
		{
			_storeButton = new Button("Store",Framework.viewport.width/35,Framework.viewport.width/35,GameTexture.messageBox[5]);
			_storeButton.x = Framework.viewport.width -_storeButton.width;
			_storeButton.y = Framework.viewport.height/12;
			addChild(_storeButton);
			
			_storeButton.addEventListener(TouchEvent.TRIGGERED, onClicked);
		}
		
		private function drawNextButton():void
		{
			// TODO Auto Generated method stub
			if(GameSetting.instance.roundStateArray.GameTotalRound <= _sceneSetting.RoundStartNum + _sceneSetting.Roundcnt) return;
			
			_nextButton = new Button("Next", Framework.viewport.width/35, Framework.viewport.width/35, GameTexture.messageBox[3]);
			addChild(_nextButton);
			
			_nextButton.addEventListener(TouchEvent.TRIGGERED, onClicked);
		}
		
		private function drawPrevButton():void
		{
			// TODO Auto Generated method stub
			if(_sceneSetting.RoundStartNum == 0) return;
			
			_prevButton = new Button("Prev", Framework.viewport.width/35, Framework.viewport.width/35, GameTexture.messageBox[4]);
			_prevButton.y = Framework.viewport.height - _prevButton.height;
			addChild(_prevButton);
			
			_prevButton.addEventListener(TouchEvent.TRIGGERED, onClicked);
		}
		
		protected function onClicked(event:Event):void
		{
			// TODO Auto-generated method stub
			switch(event.currentTarget)
			{
				case _nextButton:
				{
					this.removeChildren(0,-1);
					ViewInit(++_viewNum);
					break;
				}
					
				case _prevButton:
				{
					this.removeChildren(0,-1);
					ViewInit(--_viewNum);
					break;
				}
					
				case _storeButton:
				{
					var storebox : StoreBox = new StoreBox();
					storebox.width = Framework.viewport.width/2;
					storebox.height = Framework.viewport.height/3;
					trace(Framework.viewport.width);
					trace(Framework.viewport.height);
					storebox.x = (Framework.viewport.width - Framework.viewport.width/2)/2;
					storebox.y = Framework.viewport.height/2 - Framework.viewport.height/3/2;
					
					addChild(storebox);
 				}
			}
				
			
		}
		private function drawItemWindow():void
		{
			// TODO Auto Generated method stub
			var coinWindow : ItemWindow = new ItemWindow(Framework.viewport.width/2, Framework.viewport.height/50, ItemWindow.ITEM_COIN);
			addChild(coinWindow);
			
			var wingWindow : ItemWindow = new ItemWindow(Framework.viewport.width*3/4, Framework.viewport.height/50, ItemWindow.ITEM_WING);
			addChild(wingWindow);
		}
		
		public function drawRoundButton():void
		{
			// TODO Auto Generated method stub
			for(var i : int =0; i < _sceneSetting.Roundcnt; i++)
			{
				var roundButton : RoundButton = new RoundButton(i+1, _sceneSetting);
				addChild(roundButton);
			}
		}
		
		private function drawDeco():void
		{
			// TODO Auto Generated method stub
			switch(0)
			{
				case 0:
				{
					_decoClip = new MovieClip(GameTexture.player,5,Framework.viewport.width/4,Framework.viewport.height*5/18);
					break;
				}
					
				default:
				{
					break;
				}
			}
			
			_decoClip.width = Framework.viewport.width/10;
			_decoClip.height = Framework.viewport.height/10;
			_decoClip.start();
			addChild(_decoClip);
		}
		
		public override function dispose():void
		{
			super.dispose();
		}
		
		public static function get current():Sprite{return _current;}
	}
}