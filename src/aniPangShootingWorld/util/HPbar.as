package aniPangShootingWorld.util
{
	import flash.display.BitmapData;
	
	import aniPangShootingWorld.round.MenuView;
	
	import framework.display.DisplayObject;
	import framework.display.Image;
	import framework.texture.FwTexture;

	public class HPbar extends Image
	{
		public function HPbar(x:int, y:int,bitmapData:BitmapData)
		{
			super(x,y,FwTexture.fromBitmapData(bitmapData));
		}
		
		public function hpBarInit(object : DisplayObject) : void
		{

			this.width = object.width;
			this.height = object.height/8;
			this.x = object.x;
			this.y = object.y + object.height;
		}
		/**
		 * 
		 * @param maxHP 오브젝트의 최대 hp
		 * @param curHP 오브젝트의 현제 hp
		 * 
		 * Note @유영선 오브젝트의 체력의 퍼센트에 따른 비트맵 출력
		 */		
		public function calcHP(maxHP : Number, curHP:Number) : void
		{
			if(maxHP*1 >= curHP && maxHP*0.9 < curHP)
				this.texture = FwTexture.fromBitmapData(MenuView.sloadedImage.imageDictionary["100per.png"].bitmapData);
			else if(maxHP*0.9 >= curHP && maxHP*0.8 < curHP)
				this.texture = FwTexture.fromBitmapData(MenuView.sloadedImage.imageDictionary["90per.png"].bitmapData);
			else if(maxHP*0.8 >= curHP && maxHP*0.7 < curHP)
				this.texture = FwTexture.fromBitmapData(MenuView.sloadedImage.imageDictionary["80per.png"].bitmapData);
			else if(maxHP*0.7 >= curHP && maxHP*0.6 < curHP)
				this.texture = FwTexture.fromBitmapData(MenuView.sloadedImage.imageDictionary["70per.png"].bitmapData);
			else if(maxHP*0.6 >= curHP && maxHP*0.5 < curHP)
				this.texture = FwTexture.fromBitmapData(MenuView.sloadedImage.imageDictionary["60per.png"].bitmapData);
			else if(maxHP*0.5 >= curHP && maxHP*0.4 < curHP)
				this.texture = FwTexture.fromBitmapData(MenuView.sloadedImage.imageDictionary["50per.png"].bitmapData);
			else if(maxHP*0.4 >= curHP && maxHP*0.3 < curHP)
				this.texture = FwTexture.fromBitmapData(MenuView.sloadedImage.imageDictionary["40per.png"].bitmapData);
			else if(maxHP*0.3 >= curHP && maxHP*0.2 < curHP)
				this.texture = FwTexture.fromBitmapData(MenuView.sloadedImage.imageDictionary["30per.png"].bitmapData);
			else if(maxHP*0.2 >= curHP && maxHP*0.1 < curHP)
				this.texture = FwTexture.fromBitmapData(MenuView.sloadedImage.imageDictionary["20per.png"].bitmapData);
			else if(maxHP*0.1 >= curHP && maxHP*0.0 < curHP)
				this.texture = FwTexture.fromBitmapData(MenuView.sloadedImage.imageDictionary["10per.png"].bitmapData);
			else
				this.visible = false; 
		}
	}
}