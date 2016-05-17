package aniPangShootingWorld.round.SelectViewSub
{
	import aniPangShootingWorld.ui.MessageBox;
	import aniPangShootingWorld.util.GameTexture;
	
	import framework.core.Framework;
	import framework.display.Button;
	import framework.display.Image;
	import framework.display.Sprite;

	public class StoreBox extends Sprite
	{
		private var _buyWingButton : Button;
		private var _chargeFreeCoin : Button;
		private var _WindowBox : MessageBox;
		
		public function StoreBox()
		{
			_WindowBox = new MessageBox("",25,false);
			addChild(_WindowBox);
			
			_buyWingButton = new Button("Buy Wing", Framework.viewport.width/35, Framework.viewport.width/35, GameTexture.messageBox[3]);
			_buyWingButton.y =  _WindowBox.height/5;
			addChild(_buyWingButton);
			
			_chargeFreeCoin = new Button("Charge Free Coin", Framework.viewport.width/35, Framework.viewport.width/35, GameTexture.messageBox[3]);
			_chargeFreeCoin.y =  _WindowBox.height/3;
			addChild(_chargeFreeCoin);
		}
	}
}