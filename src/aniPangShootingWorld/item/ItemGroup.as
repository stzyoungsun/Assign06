package aniPangShootingWorld.item
{
	import aniPangShootingWorld.util.GameTexture;
	import aniPangShootingWorld.util.UtilFunction;
	
	import framework.core.Framework;
	import framework.display.ObjectType;
	import framework.display.Sprite;

	public class ItemGroup  
	{
		private var _itemVector : Vector.<Item> = new Vector.<Item>;
		private var _itemCount : Number;
		private var _stage : Sprite;
		
		/**
		 * @param itemCount 적 폭파시 생기는 아이템 개수
		 * @param startx 적 폭파시 적의 x값
		 * @param starty 적 폭파시 적의 y값
		 * 폭파한 적위치의 따라 랜덤으로 아이템 개수가 증가 합니다.
		 */		
		public function ItemGroup(itemCount : Number, startx : Number, starty : Number, stage : Sprite)
		{
			_itemCount = itemCount;
			_stage = stage
				
			for(var i : Number =0; i < _itemCount; ++i)
			{
				var randomNumber : Number = UtilFunction.random(0,30,1);
				var randEndx : Number = UtilFunction.random(startx-Framework.viewport.width/4,startx+Framework.viewport.width/4,1);
				var randEndy : Number = UtilFunction.random(starty-Framework.viewport.height/4,starty - Framework.viewport.height/2,1);
				
				//30 개의 경우중 0~26까지는 코인을 생성합니다
				if(randomNumber>=0 && randomNumber < 27)
				{
					_itemVector.push(new Item(GameTexture.coin, 30, startx, starty, randEndx, randEndy, ObjectType.ITEM_COIN,_stage));
				}
				//30 개의 경우중  27만 하트를 생성합니다
				else if(randomNumber==27)
				{
					_itemVector.push(new Item(GameTexture.heart, 30, startx, starty, randEndx, randEndy, ObjectType.ITEM_HEART,_stage));
				}
				//나머지 경우에서 젤리를 생성합니다.
				else
				{
					_itemVector.push(new Item(GameTexture.power, 30, startx, starty, randEndx, randEndy, ObjectType.ITEM_POWER,_stage));
				}
			}
		}
		
		/** 
		 * 생성된 아이템들을 화면에 출력합니다.
		 */		
		public function drawItem() : void 
		{
			for(var i : Number =0; i < _itemCount; ++i)
			{
				_stage.addChild(_itemVector[i]);
			}
		}
	}
}