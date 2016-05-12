package aniPangShootingWorld.util
{
	import flash.display.BitmapData;
	
	import aniPangShootingWorld.player.PlayerState;
	import aniPangShootingWorld.round.MenuView;
	
	import framework.animaiton.AtlasBitmapData;
	import framework.core.Framework;
	import framework.display.Image;
	import framework.display.Sprite;
	import framework.display.TextImageField;
	import framework.texture.FwTexture;

	public class ResultDlg extends Sprite
	{
		private var _resultMain : Image;
		private var _nextButton : Image;
		
		private var _curPower : int = 0;
		private var _curHeart : int = 0;
		private var _curCoin : int = 0;
		
		private var _textHeartField : TextImageField;
		private var _textPowerField : TextImageField;
		private var _textCoinField : TextImageField;
		
		private var _textTotalField : TextImageField;
		public function ResultDlg()
		{
			super();

			trace(this.x + "," + this.width);
			
			_resultMain = new Image(0,0, FwTexture.fromBitmapData(MenuView.sloadedImage.imageDictionary["resultMain.png"].bitmapData));
			_nextButton = new Image(0,0, FwTexture.fromBitmapData(MenuView.sloadedImage.imageDictionary["nextButton.png"].bitmapData));
			
			_resultMain.width = Framework.viewport.width;
			_resultMain.height = Framework.viewport.height;
			
			_nextButton.width = Framework.viewport.width/3;
			_nextButton.height = Framework.viewport.height/15;
			_nextButton.x = Framework.viewport.width/3;
			_nextButton.y = Framework.viewport.height - _nextButton.height*2;
			
			_nextButton.visible =false;
			
			if(MenuView.sloadedImage.checkXml("Number_Sprite.xml"))
			{
				var numberAtlas : AtlasBitmapData = new AtlasBitmapData(MenuView.sloadedImage.imageDictionary["Number_Sprite.png"],MenuView.sloadedImage.xmlDictionary["Number_Sprite.xml"])
			}
			
			_textHeartField = new TextImageField(Framework.viewport.width*5/16,Framework.viewport.height*238/1000, Framework.viewport.width/30,Framework.viewport.width/30,numberAtlas);
			_textPowerField = new TextImageField(Framework.viewport.width*5/16,Framework.viewport.height*260/1000, Framework.viewport.width/30,Framework.viewport.width/30,numberAtlas);
			_textCoinField = new TextImageField(Framework.viewport.width*5/16,Framework.viewport.height*285/1000, Framework.viewport.width/30,Framework.viewport.width/30,numberAtlas);
			_textTotalField = new TextImageField(Framework.viewport.width*7/32,Framework.viewport.height*11/30, Framework.viewport.width/15,Framework.viewport.width/15,numberAtlas);
			
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
				_textHeartField.createTextImage(_curHeart++);
				return false;
			}
			
			else if(_curPower <= PlayerState.sTotalPower)
			{
				_textPowerField.createTextImage(_curPower++);
				return false;
			}
			
			else if(_curCoin <= PlayerState.sGoldCount)
			{
				_textCoinField.createTextImage(_curCoin++);
				return false;
			}
			else
			{
				return true;
			}
		}
		
		public function totalDraw() : void
		{
			_textTotalField.createTextImage(PlayerState.sTotalHeart*10 + PlayerState.sTotalPower*5 + PlayerState.sGoldCount);
		}
		
		public function nextButtonDraw() : void
		{
			_nextButton.visible = true;
		}
		
		public function get nextButton():Image{return _nextButton;}
	}
}