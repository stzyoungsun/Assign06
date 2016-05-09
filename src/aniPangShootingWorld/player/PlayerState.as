package aniPangShootingWorld.player
{
	import flash.utils.getTimer;
	
	import aniPangShootingWorld.round.MenuView;
	
	import framework.core.Framework;
	import framework.display.Image;
	import framework.display.Stage;

	public class PlayerState extends Stage
	{
		private var _mainStateDlg : Image;
		private var _heartDlg : Image;
		private var _powerDlg : Image;
		
		public static const MAX_HERAT : Number = 5;
		public static const MAX_POWER : Number = 5;
		
		public static var sGoldCount : Number = 0;
		public static var sPlayerHeart : Number = PlayerState.MAX_HERAT;
		public static var sPlayerPower : Number = 0;
		
		public static var sSuperPowerFlag : Boolean = false;
		public function PlayerState()
		{
			super(0,0);
	
			_mainStateDlg = new Image(0,0, MenuView.sloadedImage.imageDictionary["state.png"].bitmapData);
			_mainStateDlg.width = Framework.viewport.width/3;
			_mainStateDlg.height = Framework.viewport.height/15;
			
			_heartDlg = new Image(_mainStateDlg.width*198/1000,_mainStateDlg.height*8/140,MenuView.sloadedImage.imageDictionary["heart10.png"].bitmapData);
			_heartDlg.width = Framework.viewport.width*2/13;
			_heartDlg.height = Framework.viewport.height/41;
			 
			_powerDlg = new Image(_heartDlg.x + _mainStateDlg.width/40,_heartDlg.height - _mainStateDlg.height/15,MenuView.sloadedImage.imageDictionary["power1.png"].bitmapData);
			_powerDlg.width = Framework.viewport.width*2/13;
			_powerDlg.height = Framework.viewport.height/41;
			
			addChild(_mainStateDlg);
			addChild(_heartDlg);
			addChild(_powerDlg);
		}
		
		/**
		 * @param curHeart 현재 플레이어의 하트
		 * @param curPower 현재 플레이어의 파워
		 * 상태를 지속적으로 관찰하여 상태바를 변화 시킵니다.
		 */		
		public function observedState() : void
		{
			observedHeart(sPlayerHeart);
			observedPower(sPlayerPower);
		}
		
		public override function render():void
		{
			super.render();
			observedState();
			
			if(sSuperPowerFlag == true)
			{
				var curTimer:int = getTimer();
				if(curTimer - _prevTime < 3000)
				{
					trace("슈퍼파워");
				}
				else
				{
					trace("슈퍼파워 아님");
					sSuperPowerFlag = false;
					_prevTime = getTimer();
				}
			}
		}
		
		/**
		 * @param curPower 현재 파워 게이지 상태
		 * Note @유영선 젤리 먹은 개수 만큼 파워 게이지를 조절 합니다
		 */		
		private function observedPower(curPower):void
		{
			// TODO Auto Generated method stub
			if(curPower >5)
				curPower = 5;
			if(curPower < 0)
				curPower = 0;
			
			switch(curPower)
			{
				case 0:
				{
					_powerDlg.bitmapData = MenuView.sloadedImage.imageDictionary["power1.png"].bitmapData;
					break;
				}
				case 1:
				{
					_powerDlg.bitmapData = MenuView.sloadedImage.imageDictionary["power2.png"].bitmapData;
					break;
				}
				case 2:
				{
					_powerDlg.bitmapData = MenuView.sloadedImage.imageDictionary["power4.png"].bitmapData;
					break;
				}
				case 3:
				{
					_powerDlg.bitmapData = MenuView.sloadedImage.imageDictionary["power6.png"].bitmapData;
					break;
				}
				case 4:
				{
					_powerDlg.bitmapData = MenuView.sloadedImage.imageDictionary["power8.png"].bitmapData;
					break;
				}
				case 5:
				{
					_powerDlg.bitmapData = MenuView.sloadedImage.imageDictionary["power10.png"].bitmapData;
					sSuperPowerFlag = true;
					sPlayerPower = 0;
					this._prevTime = getTimer();
					break;
				}
			}
		}
		
		/**
		 * @param curHeart 현재 체력 상태
		 * Note @유영선 플레이어의 현재 체력 만큼 체력 게이지를 조절 합니다
		 */		
		private function observedHeart(curHeart:Number):void
		{
			// TODO Auto Generated method stub
			if(curHeart >5)
				curHeart = 5;
			if(curHeart < 0)
				curHeart = 0;
			
			switch(curHeart)
			{
				case 0:
				{
					_heartDlg.bitmapData = MenuView.sloadedImage.imageDictionary["heart1.png"].bitmapData
					break;
				}
				case 1:
				{
					_heartDlg.bitmapData = MenuView.sloadedImage.imageDictionary["heart2.png"].bitmapData
					break;
				}
				case 2:
				{
					_heartDlg.bitmapData = MenuView.sloadedImage.imageDictionary["heart4.png"].bitmapData
					break;
				}
				case 3:
				{
					_heartDlg.bitmapData = MenuView.sloadedImage.imageDictionary["heart6.png"].bitmapData
					break;
				}
				case 4:
				{
					_heartDlg.bitmapData = MenuView.sloadedImage.imageDictionary["heart8.png"].bitmapData
					break;
				}
				case 5:
				{
					_heartDlg.bitmapData = MenuView.sloadedImage.imageDictionary["heart10.png"].bitmapData
					break;
				}
			}
		}
	}
}