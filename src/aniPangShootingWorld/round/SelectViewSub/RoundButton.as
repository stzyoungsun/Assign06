package aniPangShootingWorld.round.SelectViewSub
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	import aniPangShootingWorld.resourceName.AtlasResource;
	import aniPangShootingWorld.round.BonusRound;
	import aniPangShootingWorld.round.Round;
	import aniPangShootingWorld.round.Setting.GameSetting;
	import aniPangShootingWorld.ui.MessageBox;
	import aniPangShootingWorld.util.GameTexture;
	
	import framework.core.Framework;
	import framework.display.Button;
	import framework.display.Sprite;
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
		public static const BONUS_ROUND : Number = 5;
		
		private var _roundNum : Number =0;
		private var _roundArrayOrder : Number = 0;
		
		private var _roundButtonSetting : Object;
		private var _stage : Sprite;
		private var _backFunction : Function;
		
		private var _roundName : String;
		/**
		 * @param roundOrder 현재 View 안에서의 roundButton의 번호
		 * @param roundButtonSetting roundButton의 세팅 값
		 */		
		public function RoundButton(roundOrder : Number, roundButtonSetting : Object, stage : Sprite, backFunc : Function)
		{
			_roundArrayOrder = roundOrder-1;
			_roundNum = roundOrder + roundButtonSetting.RoundStartNum;	
			var roundName : String; 
			if(_roundNum == 4)
			{
				roundButtonSetting.Round[roundOrder-1].state = 5;
				roundName  = "Bouns";
			}
			else
				roundName  = String(roundOrder + roundButtonSetting.RoundStartNum);
					
			super(roundName,Framework.viewport.width/45,Framework.viewport.width/45,checkState(roundButtonSetting.Round[roundOrder-1].state)
				, TextureManager.getInstance().atlasTextureDictionary[AtlasResource.SELECTVIEW_SUB]);
	
			_stage = stage;
			this.width = Framework.viewport.width/6;
			this.height = Framework.viewport.width/6;
			this.x = Framework.viewport.width*roundButtonSetting.Round[roundOrder-1].x;
			this.y = Framework.viewport.height*roundButtonSetting.Round[roundOrder-1].y;
			
			//Select View 화면에서의 순서의 배열 번호
			
			//전체 게임을 기준으로 Round 번호
			
			_roundButtonSetting = roundButtonSetting;
			_backFunction = backFunc;
			addEventListener(TouchEvent.TRIGGERED, onClicked);
		}
		
		/**
		 * 클릭 한 라운드 버튼 번호에 상태에 따라 상태에 맞는 이벤트 출력
		 */		
		protected function onClicked(event:Event):void
		{
			var message : MessageBox;
			
			switch(_roundButtonSetting.Round[_roundArrayOrder].state)
			{
				case NOT_CLEAR:
				{
					if(_roundArrayOrder-1 >= 0)
					{
						if(_roundButtonSetting.Round[_roundArrayOrder-1].state != NOT_CLEAR && _roundButtonSetting.Round[_roundArrayOrder-1].state != CLICKED_STATE)
						{
							if(_roundNum > 4) 
							{
								message = new MessageBox("Not Update Please Waiting",25);
								message.x = Framework.viewport.width/2 - message.width/2;
								message.y = Framework.viewport.height/2 - message.height/2;
								_stage.addChild(message);
							}
						
							else
							{
								message = new MessageBox("Move to "+(_roundNum)+" Round",25,true,onOKFunction);
								
								message.x = Framework.viewport.width/2 - message.width/2;
								message.y = Framework.viewport.height/2 - message.height/2;
								_stage.addChild(message);
							}
						}
						
						else
						{
							message = new MessageBox("Prev "+(_roundNum-1)+" Round Not Clear",25);
							message.x = Framework.viewport.width/2 - message.width/2;
							message.y = Framework.viewport.height/2 - message.height/2;
							_stage.addChild(message); 
						}
					}
					else
					{	
						if(_roundNum > 4) 
						{
							message = new MessageBox("Not Update Please Waiting",25);
							message.x = Framework.viewport.width/2 - message.width/2;
							message.y = Framework.viewport.height/2 - message.height/2;
							_stage.addChild(message);
						}
						else if(_roundNum == 4)
						{
							message = new MessageBox("Move to Bonus Round (Boss)",25,true,onOKFunction);
							message.x = Framework.viewport.width/2 - message.width/2;
							message.y = Framework.viewport.height/2 - message.height/2;
							_stage.addChild(message); 
						}
						else
						{
							message = new MessageBox("Move to "+(_roundNum)+" Round",25,true,onOKFunction);
							message.x = Framework.viewport.width/2 - message.width/2;
							message.y = Framework.viewport.height/2 - message.height/2;
							_stage.addChild(message); 
						}
					}
					break;
				}
					
				default: 
				{
					if(_roundNum == 4) 
						message = new MessageBox("Start Bouns Round",25,true,onOKFunction);
					else
						message = new MessageBox("Start"+(_roundNum)+" Round",25,true,onOKFunction);
					
					message.x = Framework.viewport.width/2 - message.width/2;
					message.y = Framework.viewport.height/2 - message.height/2;
					_stage.addChild(message); 
				}
			}
		}
		
		public function onOKFunction() : void
		{
			var message : MessageBox;
			
			switch(_roundButtonSetting.Round[_roundArrayOrder].state)
			{
				case NOT_CLEAR:
				{
					if(_roundArrayOrder-1 >= 0)
					{
						if(_roundButtonSetting.Round[_roundArrayOrder-1].state != NOT_CLEAR && _roundButtonSetting.Round[_roundArrayOrder-1].state != CLICKED_STATE)
						{
							this.buttonBackground.texture = checkState(CLICKED_STATE);
							_roundButtonSetting.Round[_roundArrayOrder].state = CLICKED_STATE;
						}	
					}
					
					else
					{	
						this.buttonBackground.texture = checkState(CLICKED_STATE);
						_roundButtonSetting.Round[_roundArrayOrder].state = CLICKED_STATE;
					}
					break;
				}
					
				default: 
				{
					if(GameSetting.instance.roundStateArray.GameWing <= 0)
					{
						message = new MessageBox("Not Wing You But Wing in Store",25);
						message.x = Framework.viewport.width/2 - message.width/2;
						message.y = Framework.viewport.height/2 - message.height/2;
						_stage.addChild(message); 
					}
					else
					{
						Framework.stage.removeEventListener(KeyboardEvent.KEY_DOWN, _backFunction);
						GameSetting.instance.roundStateArray.GameWing--;
						//this.parent.dispose();
						SceneManager.instance.addScene((this.parent as Sprite));
						var roundObject : Sprite;
						
						if(_roundNum == 4) roundObject = new BonusRound();
						else roundObject = new Round(_roundNum-1);
						
						SceneManager.instance.addScene(roundObject);
						SceneManager.instance.sceneChange();
					}
				}
			}
		}
		
		/**
		 * @param stateNum 라운드의 클리어 상태
		 * @return 클리어 상태에 따른 텍스쳐 값
		 */		
		public function checkState(stateNum : Number):FwTexture
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
				
			    case BONUS_ROUND:
				{
					return GameTexture.subSelectViews[1];
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