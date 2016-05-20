package aniPangShootingWorld.player
{
	import flash.utils.getTimer;
	
	import aniPangShootingWorld.resourceName.AtlasResource;
	import aniPangShootingWorld.util.GameTexture;
	
	import framework.core.Framework;
	import framework.display.Image;
	import framework.display.ImageTextField;
	import framework.display.ObjectType;
	import framework.display.Sprite;
	import framework.texture.AtlasTexture;
	import framework.texture.TextureManager;

	public class PlayerState extends Sprite
	{
		private var _mainStateDlg : Image;
		private var _heartDlg : Image;
		private var _powerDlg : Image;
		private var _coinDlg : ImageTextField;
		
		public static const MAX_HERAT : Number = 5;
		public static const MAX_POWER : Number = 5;
		
		public static var sGoldCount : Number = 0;
		public static var sTotalHeart : Number = 0;
		public static var sPlayerHeart : Number = PlayerState.MAX_HERAT;
		public static var sTotalPower : Number = 0;
		public static var sPlayerPower : Number = 0;
		
		public static var sSuperPowerFlag : Boolean = false;
		
		public function PlayerState()
		{
			_mainStateDlg = new Image(0, 0, GameTexture.playerState);
			_mainStateDlg.width = Framework.viewport.width/2;
			_mainStateDlg.height = Framework.viewport.height/15;
			
			_heartDlg = new Image(_mainStateDlg.width*197/1000, _mainStateDlg.height*8/140, GameTexture.playerHeart[5]);
			_heartDlg.width = Framework.viewport.width*3/13;
			_heartDlg.height = Framework.viewport.height/41;
			 
			_powerDlg = new Image(_heartDlg.x + _mainStateDlg.width/40, _heartDlg.height - _mainStateDlg.height/15, GameTexture.playerPower[0]);
			_powerDlg.width = Framework.viewport.width*3/13;
			_powerDlg.height = Framework.viewport.height/41;

			var numberAtlas:AtlasTexture = TextureManager.getInstance().atlasTextureDictionary[AtlasResource.NUMBER];
			_coinDlg = new ImageTextField(_powerDlg.x -_powerDlg.width/6 ,_powerDlg.y, Framework.viewport.width/30, Framework.viewport.width/30);
			
			addChild(_mainStateDlg);
			addChild(_heartDlg);
			addChild(_powerDlg);
			addChild(_coinDlg);
		}
		
		/**
		 * @param curHeart 현재 플레이어의 하트
		 * @param curPower 현재 플레이어의 파워
		 * 상태를 지속적으로 관찰하여 상태바를 변화 시킵니다.
		 */		
		public function observedState() : void
		{
			observedHeart();
			observedPower();
			observedCoin();
		}
		
		public override function render():void
		{
			super.render();
			if(super.children == null) return;
			
			observedState();
			
			if(sSuperPowerFlag == true)
			{
				var curTimer:int = getTimer();
				if(curTimer - _prevTime < 3000){	}
				else
				{
					Player.currentPlayer.objectType == ObjectType.PLAYER_SHIELD_MODE;
					sSuperPowerFlag = false;
					_prevTime = getTimer();
				}
			}
		}
		
		private function observedCoin():void
		{
			_coinDlg.text = String(sGoldCount);
		}
		
		/**
		 * @param curPower 현재 파워 게이지 상태
		 * Note @유영선 젤리 먹은 개수 만큼 파워 게이지를 조절 합니다
		 */		
		private function observedPower():void
		{
			if(sPlayerPower >5)
				sPlayerPower = 5;
			if(sPlayerPower < 0)
				sPlayerPower = 0;
			
			switch(sPlayerPower)
			{
				case 0:
				{
					_powerDlg.texture = GameTexture.playerPower[0];
					break;
				}
				case 1:
				{
					_powerDlg.texture = GameTexture.playerPower[1];
					break;
				}
				case 2:
				{
					_powerDlg.texture = GameTexture.playerPower[2];
					break;
				}
				case 3:
				{
					_powerDlg.texture = GameTexture.playerPower[3];
					break;
				}
				case 4:
				{
					_powerDlg.texture = GameTexture.playerPower[4];
					break;
				}
				case 5:
				{
					_powerDlg.texture = GameTexture.playerPower[5];
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
		private function observedHeart():void
		{
			if(sPlayerHeart >5)
				sPlayerHeart = 5;
			if(sPlayerHeart < 0)
				sPlayerHeart = 0;
			
			switch(sPlayerHeart)
			{
				case 0:
				{
					_heartDlg.texture = GameTexture.playerHeart[0];
					break;
				}
				case 1:
				{
					_heartDlg.texture = GameTexture.playerHeart[1];
					break;
				}
				case 2:
				{
					_heartDlg.texture = GameTexture.playerHeart[2];
					break;
				}
				case 3:
				{
					_heartDlg.texture = GameTexture.playerHeart[3];
					break;
				}
				case 4:
				{
					_heartDlg.texture = GameTexture.playerHeart[4];
					break;
				}
				case 5:
				{
					_heartDlg.texture = GameTexture.playerHeart[5];
					break;
				}
			}
		}
		
		public override function dispose():void
		{
			super.dispose();
		}
	}
}