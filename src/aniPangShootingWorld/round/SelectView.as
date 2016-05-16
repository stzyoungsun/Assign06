package aniPangShootingWorld.round
{
	import aniPangShootingWorld.round.Setting.GameSetting;
	import aniPangShootingWorld.util.GameTexture;
	
	import framework.animaiton.MovieClip;
	import framework.core.Framework;
	import framework.display.Image;
	import framework.display.ImageTextField;
	import framework.display.Sprite;
	import framework.texture.FwTexture;
	import framework.texture.TextureManager;

	public class SelectView extends Sprite
	{
		private const NOT_CLEAR : Number = 0;
		private const ONE_START_CLEAR : Number = 1;
		private const TWO_STAR_CLEAR : Number = 2;
		private const THREE_STAR_CLEAR : Number = 3;
		private const CLICKED_STATE : Number = 4;
		
		private var _selectImage : Image;
		private var _decoClip : MovieClip;
		private var _sceneSetting : Object; 
		/**
		 * 스테이지를 선택 하는 창이 나옵니다.
		 */		
		public function SelectView()
		{
			ViewInit(0);
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
			drawStageButton();
			
			
			
		}
		
		public function drawStageButton():void
		{
			// TODO Auto Generated method stub
			for(var i : int =_sceneSetting.RoundStartNum; i < _sceneSetting.RoundStartNum+_sceneSetting.Roundcnt; i++)
			{
				trace("x : " + _sceneSetting.Round[i].x +",y : " + _sceneSetting.Round[i].y);
				var stageButton : Image = new Image(Framework.viewport.width*_sceneSetting.Round[i].x, Framework.viewport.width*_sceneSetting.Round[i].y, 
					checkState(_sceneSetting.Round[i].state));
				stageButton.width = Framework.viewport.width/6;
				stageButton.height = Framework.viewport.width/6;
			
				addChild(stageButton);
				var roundTextField : ImageTextField = new ImageTextField((stageButton.x + stageButton.width/2 -  Framework.viewport.width/50)/2
					, (stageButton.y + stageButton.height/2 -  Framework.viewport.width/40)/2
					, Framework.viewport.width/20 , Framework.viewport.width/20);
				roundTextField.text = String(i+1);
				addChild(roundTextField);
			}
		}
		
		private function checkState(stateNum : Number):FwTexture
		{
			// TODO Auto Generated method stub
			switch(stateNum)
			{
				case NOT_CLEAR:
				{
					return TextureManager.getInstance().textureDictionary["passyet.png"];
					break;
				}
					
				case ONE_START_CLEAR:
				{
					return TextureManager.getInstance().textureDictionary["passed1.png"];
					break;
				}
					
				case TWO_STAR_CLEAR:
				{
					return TextureManager.getInstance().textureDictionary["passed2.png"];
					break;
				}
					
				case THREE_STAR_CLEAR:
				{
					return TextureManager.getInstance().textureDictionary["passed3.png"];
					break;
				}
					
				case CLICKED_STATE:
				{
					return TextureManager.getInstance().textureDictionary["passing.png"];
					break;
				}
			}
			return null;
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
	}
}