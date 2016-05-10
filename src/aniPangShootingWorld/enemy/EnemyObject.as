package aniPangShootingWorld.enemy
{
	import aniPangShootingWorld.player.PlayerState;
	import aniPangShootingWorld.round.MenuView;
	import aniPangShootingWorld.util.UtilFunction;
	
	import framework.animaiton.AtlasBitmapData;
	import framework.animaiton.MovieClip;
	import framework.core.Framework;
	import framework.display.ObjectType;
	import framework.display.Sprite;
	
	/**
	 * Note @유영선 적 클래스의 부모입니다. 공통 적으로 적용되는 autoMoving 함수가 있습니다.
	 */
	public class EnemyObject extends MovieClip
	{
		private var _stage : Sprite;
		
		public static var sSpeed : Number = 1;
		public function EnemyObject(enemyAtlas : AtlasBitmapData, frame : Number, stage : Sprite)
		{
			super(enemyAtlas,frame,0,0);
			_stage = stage;
			this._objectType = ObjectType.ENEMY_GENERAL;
		}
		
		/**
		 *  Note @유영선 적의 이동 방향을 설정하는 함수 입니다. 모두 공통적으로 적용 됩니다.
		 */		
		public function autoMoving():void
		{
			if(PlayerState.sSuperPowerFlag == false)
				this.y+=Framework.viewport.height/110*sSpeed;
			else
				this.y+=Framework.viewport.height/50;
			
			if(this.y > Framework.viewport.height)
			{
				this.objectType = ObjectType.ENEMY_REMOVE;
			}
		}
		/**
		 *Note @유영선 몬스터가 죽어서 아이템이 되었을 경우에는 공통 적인 부분 이므로 부모 클래스에서 처리합니다. 
		 * 
		 */		
		public override function render():void
		{
			//Note @유영선 적의 상태가 coin일 경우 적이 사망하여 재화를 뿌림
			autoMoving();
			
			if(this.objectType == ObjectType.ENEMY_REMOVE) return;
			
			switch(this.objectType)
			{
				case ObjectType.ITEM_IDLE:
				{
					var randomNumber : Number = UtilFunction.random(0,10,1);
					if(randomNumber>=0 && randomNumber < 9)
					{
						this.spriteSheet = new AtlasBitmapData(MenuView.sloadedImage.imageDictionary["Coin_Sprite.png"],MenuView.sloadedImage.xmlDictionary["Coin_Sprite.xml"]);
						this.objectType = ObjectType.ITEM_COIN;
					}
						
					else if(randomNumber==9)
					{
						this.spriteSheet = new AtlasBitmapData(MenuView.sloadedImage.imageDictionary["heartEat_Sprite.png"],MenuView.sloadedImage.xmlDictionary["heartEat_Sprite.xml"]);
						this.objectType = ObjectType.ITEM_HEART;
					}
						
					else
					{
						this.spriteSheet = new AtlasBitmapData(MenuView.sloadedImage.imageDictionary["powerEat_Sprite.png"],MenuView.sloadedImage.xmlDictionary["powerEat_Sprite.xml"]);
						this.objectType = ObjectType.ITEM_POWER;
					}
					
					this.start();
					break;
				}
				
				case ObjectType.ITEM_COIN_COLLISON:
				{
		
					this.objectType = ObjectType.ENEMY_REMOVE;
					PlayerState.sGoldCount+=1;
					break;
				}
				
				case ObjectType.ITEM_HERAT_COLLISON:
				{
					
					this.objectType = ObjectType.ENEMY_REMOVE;
					PlayerState.sPlayerHeart++;
					break;
				}
					
				case ObjectType.ITEM_POWER_COLLISON:
				{
					this.objectType = ObjectType.ENEMY_REMOVE;
					PlayerState.sPlayerPower++;
					break;
				}
			}
	
			super.render();
		}
		
		public override function dispose():void
		{
			super.dispose();
 
		}
	}
}