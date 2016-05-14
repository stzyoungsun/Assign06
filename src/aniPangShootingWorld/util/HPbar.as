package aniPangShootingWorld.util
{
	import framework.display.DisplayObject;
	import framework.display.Image;
	import framework.texture.FwTexture;

	public class HPbar extends Image
	{
		public function HPbar(x:int, y:int, texture:FwTexture)
		{
			super(x, y, texture);
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
				this.texture = GameTexture.bossHpBar[9];
			else if(maxHP*0.9 >= curHP && maxHP*0.8 < curHP)
				this.texture = GameTexture.bossHpBar[8];
			else if(maxHP*0.8 >= curHP && maxHP*0.7 < curHP)
				this.texture = GameTexture.bossHpBar[7];
			else if(maxHP*0.7 >= curHP && maxHP*0.6 < curHP)
				this.texture = GameTexture.bossHpBar[6];
			else if(maxHP*0.6 >= curHP && maxHP*0.5 < curHP)
				this.texture = GameTexture.bossHpBar[5];
			else if(maxHP*0.5 >= curHP && maxHP*0.4 < curHP)
				this.texture = GameTexture.bossHpBar[4];
			else if(maxHP*0.4 >= curHP && maxHP*0.3 < curHP)
				this.texture = GameTexture.bossHpBar[3];
			else if(maxHP*0.3 >= curHP && maxHP*0.2 < curHP)
				this.texture = GameTexture.bossHpBar[2];
			else if(maxHP*0.2 >= curHP && maxHP*0.1 < curHP)
				this.texture = GameTexture.bossHpBar[1];
			else if(maxHP*0.1 >= curHP && maxHP*0.0 < curHP)
				this.texture = GameTexture.bossHpBar[0];
			else
				this.visible = false; 
		}
	}
}