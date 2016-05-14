package aniPangShootingWorld.util
{
	import aniPangShootingWorld.player.PlayerState;
	
	import framework.core.Framework;
	import framework.display.Image;
	import framework.display.ImageTextField;
	import framework.display.Sprite;

	public class ResultDlg extends Sprite
	{
		private var _resultMain : Image;
		private var _nextButton : Image;
		
		private var _curPower : int = 0;
		private var _curHeart : int = 0;
		private var _curCoin : int = 0;
		
		private var _textHeartField : ImageTextField;
		private var _textPowerField : ImageTextField;
		private var _textCoinField : ImageTextField;
		private var _textTotalField : ImageTextField;
		
		public function ResultDlg()
		{
			super();
			
			_resultMain = new Image(0, 0, GameTexture.roundResult);
			_nextButton = new Image(0, 0, GameTexture.nextButton);
			
			_resultMain.width = Framework.viewport.width;
			_resultMain.height = Framework.viewport.height;
			
			_nextButton.width = Framework.viewport.width/3;
			_nextButton.height = Framework.viewport.height/15;
			_nextButton.x = Framework.viewport.width/3;
			_nextButton.y = Framework.viewport.height - _nextButton.height*2;
			
			_nextButton.visible =false;

			_textHeartField = new ImageTextField(Framework.viewport.width*5/16,Framework.viewport.height*238/1000, Framework.viewport.width/30,Framework.viewport.width/30);
			_textPowerField = new ImageTextField(Framework.viewport.width*5/16,Framework.viewport.height*260/1000, Framework.viewport.width/30,Framework.viewport.width/30);
			_textCoinField = new ImageTextField(Framework.viewport.width*5/16,Framework.viewport.height*285/1000, Framework.viewport.width/30,Framework.viewport.width/30);
			_textTotalField = new ImageTextField(Framework.viewport.width*7/32,Framework.viewport.height*11/30, Framework.viewport.width/15,Framework.viewport.width/15);
			
			addChild(_resultMain);
			addChild(_nextButton);
			addChild(_textHeartField);
			addChild(_textPowerField);
			addChild(_textCoinField);
			addChild(_textTotalField);
		}
		
		public function calcPoint() : Boolean
		{
			if(_curHeart <= PlayerState.sTotalHeart)
			{
				_textHeartField.text = String(_curHeart++);
				return false;
			}
			
			else if(_curPower <= PlayerState.sTotalPower)
			{
				_textPowerField.text = String(_curPower++);
				return false;
			}
			
			else if(_curCoin <= PlayerState.sGoldCount)
			{
				_textCoinField.text = String(_curCoin++);
				return false;
			}
			else
			{
				return true;
			}
		}
		
		public function totalDraw() : void
		{
			_textTotalField.text = String(PlayerState.sTotalHeart*10 + PlayerState.sTotalPower*5 + PlayerState.sGoldCount);
		}
		
		public function nextButtonDraw() : void
		{
			_nextButton.visible = true;
		}
		
		public function get nextButton():Image{return _nextButton;}
	}
}