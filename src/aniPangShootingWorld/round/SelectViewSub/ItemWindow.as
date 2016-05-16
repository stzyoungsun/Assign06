package aniPangShootingWorld.round.SelectViewSub
{
	import aniPangShootingWorld.round.SelectView;
	import aniPangShootingWorld.util.GameTexture;
	
	import framework.core.Framework;
	import framework.display.Image;
	import framework.display.ImageTextField;
	import framework.display.Sprite;
	import framework.texture.FwTexture;

	public class ItemWindow extends Sprite
	{
		public static const ITEM_COIN : Number = 0;
		public static const ITEM_WING : Number = 1;
		
		private var _enumItem : Number = 0;
		private var _itemTextField : ImageTextField;
		private var _itemWindow : Image;
		
		public function ItemWindow(x : Number, y: Number, enumItem : Number)
		{
			_enumItem = enumItem;
			
			_itemWindow = new Image(x, y, GameTexture.subSelectViews[0]);
			_itemWindow.width = Framework.viewport.width/5;
			_itemWindow.height = Framework.viewport.height/25;
			addChild(_itemWindow);
			
			var item : Image = new Image(x, y, checkEnum(enumItem));
			item.width = _itemWindow.height*1.5;
			item.height = _itemWindow.height*1.5;
			item.x = x - item.width/2;
			item.y = y - item.height/6;
			addChild(item);
			
			_itemTextField = new ImageTextField((item.x+item.width)/2, (item.y+item.height/3)/2, Framework.viewport.width/45, Framework.viewport.width/45);
			addChild(_itemTextField);
		}
		
		public override function render() : void
		{
			super.render();
			
			drawtext(_enumItem);
		}
		private function drawtext(enumItem:Number):void
		{
			// TODO Auto Generated method stub
			switch(enumItem)
			{
				case ITEM_COIN:
				{
					_itemTextField.text = String(SelectView.sgameTotalGold);
					break;
				}
					
				case ITEM_WING:
				{
					_itemTextField.text = String(SelectView.sgameWingCount);
					break;
				}
			}
		}
		
		private function checkEnum(enumItem : Number):FwTexture
		{
			// TODO Auto Generated method stub
			switch(enumItem)
			{
				case ITEM_COIN:
				{
					return GameTexture.subSelectViews[8];
					break;
				}
					
				case ITEM_WING:
				{
					return GameTexture.subSelectViews[9];
					break;
				}
			}
			return null;
		}
	}
}