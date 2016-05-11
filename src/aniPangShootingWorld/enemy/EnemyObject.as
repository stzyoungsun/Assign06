package aniPangShootingWorld.enemy
{
	import aniPangShootingWorld.item.ItemGroup;
	import aniPangShootingWorld.player.PlayerState;
	import aniPangShootingWorld.round.MenuView;
	import aniPangShootingWorld.util.HPbar;
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
		private var _enemyHPbar:HPbar;
		
		private var _maxHP: Number;
		private var _enemyHP : Number;
		
		public function EnemyObject(enemyAtlas : AtlasBitmapData, frame : Number, stage : Sprite)
		{
			super(enemyAtlas,frame,0,0);
			_stage = stage;
			this._objectType = ObjectType.ENEMY_GENERAL;
		}
		
		/**
		 *  Note @유영선 적의 이동 방향을 설정하는 함수 입니다. 모두 공통적으로 적용 됩니다.
		 */		
		private function autoMoving():void
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
		
		public function addHPBar() : void
		{
			_enemyHP = _maxHP;
			_enemyHPbar = new HPbar(-999, 0, MenuView.sloadedImage.imageDictionary["100per.png"].bitmapData);
			_stage.addChild(_enemyHPbar);
		}
		
		public function deleteHPBar() : void
		{
			if(_stage.getChildIndex(_enemyHPbar) != -1)
			{
				_stage.removeChild(_enemyHPbar,true);
				_enemyHPbar = null;
			}
		}
		/**
		 *Note @유영선 몬스터가 죽어서 아이템이 되었을 경우에는 공통 적인 부분 이므로 부모 클래스에서 처리합니다. 
		 * 
		 */		
		public override function render():void
		{
			//Note @유영선 적의 상태가 coin일 경우 적이 사망하여 재화를 뿌림
			
			switch(this.objectType)
			{
				case ObjectType.ITEM_IDLE:
				{
					var randomNumber : Number = UtilFunction.random(0,2,1);
					var item : ItemGroup = new ItemGroup(randomNumber,this.x, this.y,_stage);
					item.drawItem();
					this.x = -999;
					this.objectType = ObjectType.ENEMY_REMOVE;
					break;
				}
					
				case ObjectType.ENEMY_REMOVE:
				{
					_enemyHPbar.x = -999;
					break;
				}
					
				default:
				{
					super.render();
					autoMoving();
					_enemyHPbar.hpBarInit(this);
					_enemyHPbar.calcHP(_maxHP,_enemyHP);
				}
			}
		}
		
		public override function dispose():void
		{
			super.dispose();
	
		}
		
		public function get maxHP():Number{return _maxHP;}
		public function set maxHP(value:Number):void{_maxHP = value;}
		
		public function get enemyHP():Number{return _enemyHP;}
		public function set enemyHP(value:Number):void{_enemyHP = value;}
	}
}