package aniPangShootingWorld.round.SelectViewSub
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import aniPangShootingWorld.resourceName.AtlasResource;
	import aniPangShootingWorld.round.Round;
	import aniPangShootingWorld.round.SelectView;
	import aniPangShootingWorld.round.Setting.GameSetting;
	import aniPangShootingWorld.ui.MessageBox;
	import aniPangShootingWorld.util.GameTexture;
	
	import framework.core.Framework;
	import framework.display.Button;
	import framework.display.Image;
	import framework.event.TouchEvent;
	import framework.scene.SceneManager;
	import framework.texture.FwTexture;
	import framework.texture.TextureManager;

	public class RoundButton extends Button
	{
		public static const NOT_CLEAR : Number = 0;
		public static const ONE_START_CLEAR : Number = 1;
		public static const TWO_STAR_CLEAR : Number = 2;
		public static const THREE_STAR_CLEAR : Number = 3;
		public static const CLICKED_STATE : Number = 4;
		
		private var _roundNum : Number =0;
		
		private var _roundButtonSetting : Object;
		
		/**
		 * @param roundOrder 현재 View 안에서의 roundButton의 번호
		 * @param roundButtonSetting roundButton의 세팅 값
		 */		
		public function RoundButton(roundOrder : Number, roundButtonSetting : Object)
		{
			super(String(roundOrder + roundButtonSetting.RoundStartNum),Framework.viewport.width/20,Framework.viewport.width/20,checkState(roundButtonSetting.Round[roundOrder-1].state)
				, TextureManager.getInstance().atlasTextureDictionary[AtlasResource.SELECTVIEW_SUB]);
			
			this.width = Framework.viewport.width/6;
			this.height = Framework.viewport.width/6;
			this.x = Framework.viewport.width*roundButtonSetting.Round[roundOrder-1].x;
			this.y = Framework.viewport.height*roundButtonSetting.Round[roundOrder-1].y;
			
			_roundNum = roundOrder-1 + roundButtonSetting.RoundStartNum;	//라운드에 삽입 할 실질적인 라운드 (0 ~ 라운드 개수만큼)
			_roundButtonSetting = roundButtonSetting;
			
			addEventListener(TouchEvent.TRIGGERED, onClicked);
		}
		
//		private function calcStep():Number
//		{
//			// TODO Auto Generated method stub
//			if(_roundNum - 1 < 0 ) return 0;
//			
//			var x : Number = Framework.viewport.width;
//			var y : Number = Framework.viewport.height;
//			
//			var gapX : Number = (_roundButtonSetting.Round[_roundNum].x*x)-(_roundButtonSetting.Round[_roundNum-1].x*x);
//			var gapY : Number = (_roundButtonSetting.Round[_roundNum].y*y)-(_roundButtonSetting.Round[_roundNum-1].y*y);
//			var step : Number = (Math.sqrt(Math.pow(gapX,2) + Math.pow(gapY,2)))/2;
//			trace(Math.pow(2,gapX))
//			 
//			return step;
//		}
		
		/**
		 * 클릭 한 라운드 버튼 번호에 상태에 따라 상태에 맞는 이벤트 출력
		 */		
		protected function onClicked(event:Event):void
		{
			switch(_roundButtonSetting.Round[_roundNum].state)
			{
				case NOT_CLEAR:
				{
					if(_roundNum-1 >= 0)
					{
						if(_roundButtonSetting.Round[_roundNum-1].state != NOT_CLEAR && _roundButtonSetting.Round[_roundNum-1].state != CLICKED_STATE
							&& _roundButtonSetting.Round[_roundNum].state == NOT_CLEAR)
						{
							this.buttonBackground.texture = checkState(CLICKED_STATE);
							_roundButtonSetting.Round[_roundNum].state = CLICKED_STATE;
						}	
					}
					else
					{	
						var messageBox : MessageBox = new MessageBox("123",25,true);
						messageBox.x = Framework.viewport.width/2;
						messageBox.y = Framework.viewport.height/2;
						addChild(messageBox);
						//this.buttonBackground.texture = checkState(CLICKED_STATE);
						//_roundButtonSetting.Round[_roundNum].state = CLICKED_STATE;
					}
					break;
				}
					
				default: 
				{
//					var messageBox : MessageBox = new MessageBox("123",true);
//					SelectView.current.addChild(messageBox);
//					
//					trace(messageBox.width);
//					messageBox.x = Framework.viewport.width/2 - messageBox.width/2;
//					messageBox.y = Framework.viewport.height/2 - messageBox.height/2;
					
					GameSetting.instance.roundStateArray.GameWing--;
					trace(GameSetting.instance.roundStateArray.GameWing);
					this.parent.dispose();
					var roundObject : Round = new Round(_roundNum);
					SceneManager.instance.addScene(roundObject);
					SceneManager.instance.sceneChange();
				}
			}
			
		}
		
		/**
		 * @param stateNum 라운드의 클리어 상태
		 * @return 클리어 상태에 따른 텍스쳐 값
		 */		
		private function checkState(stateNum : Number):FwTexture
		{
	
			switch(stateNum)
			{
				case NOT_CLEAR:
				{
					return GameTexture.subSelectViews[6];
					break;
				}
					
				case ONE_START_CLEAR:
				{
					return GameTexture.subSelectViews[2];
					break;
				}
					
				case TWO_STAR_CLEAR:
				{
					return GameTexture.subSelectViews[3];
					break;
				}
					
				case THREE_STAR_CLEAR:
				{
					return GameTexture.subSelectViews[4];
					break;
				}
					
				case CLICKED_STATE:
				{
					return GameTexture.subSelectViews[5];
					break;
				}
			}
			return null;
		}
		
		public override function dispose():void
		{
			super.dispose();
		}
	}
}