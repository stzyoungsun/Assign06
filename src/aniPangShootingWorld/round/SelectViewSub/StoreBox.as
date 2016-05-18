package aniPangShootingWorld.round.SelectViewSub
{
	import aniPangShootingWorld.round.SelectView;
	import aniPangShootingWorld.ui.MessageBox;
	import aniPangShootingWorld.util.GameTexture;
	
	import framework.core.Framework;
	import framework.display.Button;
	import framework.event.Touch;
	import framework.event.TouchEvent;
	import framework.event.TouchPhase;

	public class StoreBox extends MessageBox
	{
		private var _buyWingButton : Button;
		private var _chargeFreeCoin : Button;
		
		public function StoreBox()
		{
			super("",25,false);
			
			_buyWingButton = new Button("50G Buy Wing", Framework.viewport.width/35, Framework.viewport.width/35, GameTexture.messageBox[3]);
			_buyWingButton.width = this.width;
			_buyWingButton.height = this.height/3;
			_buyWingButton.y =  this.height/5;
			_buyWingButton.addEventListener(TouchEvent.TOUCH, onClicked);
			addChild(_buyWingButton);
			
			_chargeFreeCoin = new Button("Charge Free Coin", Framework.viewport.width/35, Framework.viewport.width/35, GameTexture.messageBox[3]);
			_chargeFreeCoin.width = this.width;
			_chargeFreeCoin.height = this.height/3;
			_chargeFreeCoin.y =  this.height*0.7;
			_chargeFreeCoin.addEventListener(TouchEvent.TOUCH, onClicked);
			addChild(_chargeFreeCoin);
		}
		
		protected function onClicked(event:TouchEvent):void
		{
			// TODO Auto-generated method stub
			var touch:Touch = event.touch;
			var messageBox : MessageBox;
			if(touch.phase == TouchPhase.ENDED)
			{
				switch(event.currentTarget)
				{
					case _buyWingButton:
					{
						if(SelectView.sgameTotalGold < 50)
						{
							messageBox = new MessageBox("Gold Lack",25);
							addChild(messageBox);
						}
						else
						{
							SelectView.sgameWingCount +=1;
							SelectView.sgameTotalGold -=50;
						}
						
						break;
					}
						
					case _chargeFreeCoin:
					{
						if(SelectView.sgameTotalGold < 50 && SelectView.sgameWingCount <= 0)
						{
							SelectView.sgameTotalGold +=500;
						}
						else
						{
							messageBox = new MessageBox("Charge Free Coin is available less than 50 Gold and 0 Wing ",25);
							addChild(messageBox);
						}
						
						break;
					}
				}
			}
			
		}
		
		public override function dispose():void
		{
			super.dispose();
		}
	}
}