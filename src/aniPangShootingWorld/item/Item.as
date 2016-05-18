package aniPangShootingWorld.item
{
	import aniPangShootingWorld.player.PlayerState;
	import aniPangShootingWorld.round.Setting.GameSetting;
	
	import framework.animaiton.MovieClip;
	import framework.core.Framework;
	import framework.display.ObjectType;
	import framework.display.Sprite;
	import framework.texture.FwTexture;

	public class Item extends MovieClip
	{
		private var _startx : Number;
		private var _starty : Number;
		private var _endx : Number;
		private var _endy : Number;
		private var _stepx : Number;
		private var _stepy : Number;
		private var _upFlag : Boolean = true;
		private var _stage : Sprite;
		
		/**
		 * @param itemAtlas	아이템의 아틀라스 비트캡
		 * @param frame	아이템 번쩍거림의 속도	
		 * @param startx 아이템의 시작 x
		 * @param starty 아이템의 시작 y
		 * @param endx 아이템이 튀어오르는 x
		 * @param endy 아이템이 튀어오르는 y
		 * @param objectType 아이템의 타입
		 * @param stage 라운드의 스테이지
		 */		
		public function Item(textureVector:Vector.<FwTexture>, frame : Number, startx : Number, starty : Number, endx : Number, endy : Number, objectType : String, stage : Sprite)
		{
			super(textureVector, 30, startx, starty);
			
			this.objectType = objectType;
			this.start();
			
			_stage = stage;
			_startx = startx;
			_starty = starty;
			_endx = endx;
			_endy = endy;
			
			this.width = Framework.viewport.width/8;
			this.height = Framework.viewport.width/8;
			
			_stepx = (Math.abs(_endx - _startx))/20;
			
			if(_endx <= _startx)
				_stepx = -_stepx;
			
			_stepy = (Math.abs(_endy - _starty))/20;
		}
		
		public override function render():void
		{
			super.render();
			
			if(GameSetting.instance.pause) return;
			
			switch(this.objectType)
			{
				case ObjectType.ITEM_COIN_COLLISON:
				{
					_stage.removeChild(this);
					this.dispose();
					PlayerState.sGoldCount+=1;
					break;
				}
					
				case ObjectType.ITEM_HERAT_COLLISON:
				{
					_stage.removeChild(this);
					this.dispose();
					PlayerState.sPlayerHeart++;
					PlayerState.sTotalHeart++;
					break;
				}
					
				case ObjectType.ITEM_POWER_COLLISON:
				{
					_stage.removeChild(this);
					this.dispose();
					PlayerState.sPlayerPower++;
					PlayerState.sTotalPower++;
					break;
				}
			}
			if(this)
				autoMoving();
		}
		
		/**
		 * Note @유영선 아이템이 지정된 위치까지 티어 오른 후 떨어 집니다.
		 */		
		private function autoMoving():void
		{
			if(this.x < 0)
				this.x = 0;
			if(this.x > Framework.viewport.width - this.width)
				this.x = Framework.viewport.width - this.width;
			
			if(this.y < 0)
			{
				
			}
			if(_upFlag)
			{
				this.x -= _stepx;
				this.y -= _stepy;
				
				if(this.y <= _endy)
					_upFlag = false;
			}
			
			else
			{
				this.x -= _stepx/2;
				this.y += _stepy;
			}
			if(this.y >= Framework.viewport.height)
			{
				if(_stage.getChildIndex(this) != -1)
					_stage.removeChild(this,true);
			}
				
		}
		
		public override function dispose():void
		{
			super.dispose();
		}
		public function get endy():Number{return _endy;}
		public function set endy(value:Number):void{_endy = value;}

		public function get endx():Number{return _endx;}
		public function set endx(value:Number):void{_endx = value;}

		public function get starty():Number{return _starty;}
		public function set starty(value:Number):void{_starty = value;}

		public function get startx():Number{return _startx;}
		public function set startx(value:Number):void{_startx = value;}
	}
}