package aniPangShootingWorld.round.SelectViewSub
{
	import aniPangShootingWorld.resourceName.AtlasResource;
	import aniPangShootingWorld.util.GameTexture;
	
	import framework.core.Framework;
	import framework.display.Button;
	import framework.texture.FwTexture;
	import framework.texture.TextureManager;

	public class RoundButton extends Button
	{
		private static const NOT_CLEAR : Number = 0;
		private static const ONE_START_CLEAR : Number = 1;
		private static const TWO_STAR_CLEAR : Number = 2;
		private static const THREE_STAR_CLEAR : Number = 3;
		private static const CLICKED_STATE : Number = 4;
		
		private var _roundNum : Number =0;
		public function RoundButton(roundNum : Number, roundButtonSetting : Object)
		{
			super(String(roundNum),Framework.viewport.width/20,Framework.viewport.width/20,checkState(roundButtonSetting.state)
				,TextureManager.getInstance().atlasTextureDictionary[AtlasResource.SELECTVIEW_SUB]);
			
			this.width = Framework.viewport.width/6;
			this.height = Framework.viewport.width/6;
			this.x = Framework.viewport.width*roundButtonSetting.x;
			this.y = Framework.viewport.height*roundButtonSetting.y;
			
			_roundNum = roundNum;
		}
		
		private function checkState(stateNum : Number):FwTexture
		{
			// TODO Auto Generated method stub
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