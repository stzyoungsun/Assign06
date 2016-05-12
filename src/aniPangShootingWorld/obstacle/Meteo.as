package aniPangShootingWorld.obstacle
{
	import flash.utils.getTimer;
	
	import aniPangShootingWorld.player.Player;
	import aniPangShootingWorld.round.MenuView;
	
	import framework.animaiton.AtlasBitmapData;
	import framework.core.Framework;
	import framework.display.Image;
	import framework.display.ObjectType;
	import framework.display.Sprite;
	import framework.texture.FwTexture;

	public class Meteo extends Obstacle
	{
		private var _stage : Sprite;
		private var _meteoLine : Image;	//메테오 조정 선
		private var _meteoWarrning : Image;	//메테오 경고 창
		
		private var _shootFlag : Boolean = false;
		
		/**
		 * @param meteoAtlas 메테오의 아틀라스 비트맵
		 * @param frame 메테오의 회전 속도
		 * @param stage 메테오를 쏠 stage
		 */		
		public function Meteo(meteoAtlas : AtlasBitmapData, frame : Number, stage:Sprite)
		{
			super(meteoAtlas, frame, stage);
			_stage = stage;
			_meteoLine = new Image(0, 0, FwTexture.fromBitmapData(MenuView.sloadedImage.imageDictionary["meteoLine.png"].bitmapData));
			_meteoWarrning = new Image(0, 0, FwTexture.fromBitmapData(MenuView.sloadedImage.imageDictionary["meteowarning.png"].bitmapData));
			
			_stage.addChild(_meteoLine);
			_stage.addChild(_meteoWarrning);
			
			_meteoLine.visible = false;
			_meteoWarrning.visible = false;
		}
		
		/** 
		 * Note @유영선 메테오 발사를 시작 합니다
		 */		
		public function meteoShoot() : void
		{
			_meteoLine.x = Player.currentPlayer.x;
			this.x = -999;
			
			_shootFlag = true;
			_prevTime = getTimer();
			
			_stage.addChild(this);
		}
		
		public override function render():void
		{
			if(_shootFlag == true)
			{
				var curTimer:int = getTimer();
				
				//Note @유영선  3초간 메테오를 조준 합니다.
				if(curTimer - _prevTime < 3000)
				{
					aimMeteo();
				}
				//Note @유영선 1초간 메테오의 경고창을 출력 합니다
				else if(curTimer - _prevTime > 3000 && curTimer - _prevTime < 5000)
				{
					drawWarrning();
				}
				//Note @유영선 메테오를 발사합니다.
				else
				{
					shootMeteo();	
				}
			}
			
			if(this.objectType != ObjectType.OBSTACLE_IDLE)
			{
				super.render();
				autoMoving();
			}
		}
		
		private function autoMoving():void
		{
			// TODO Auto Generated method stub
			this.y+=Framework.viewport.height/60;
			
			if(this.y > Framework.viewport.height)
			{
				_stage.removeChild(this);
			}
		}
		
		private function shootMeteo():void
		{
			// TODO Auto Generated method stub
			this.objectType = ObjectType.OBSTACLE_MOVING;
			_meteoWarrning.visible = false;
			_meteoLine.visible = false;
			_shootFlag = false;
			this.width = Framework.viewport.width/3;
			this.height = Framework.viewport.height/4;
			
			this.x = _meteoLine.x - this.width/4;
			this.y = -this.height;
			
			this.start();
			
		}
		
		private function drawWarrning():void
		{
			// TODO Auto Generated method stub
			_meteoWarrning.visible = true;
			_meteoWarrning.width = Framework.viewport.width/10;
			_meteoWarrning.height = Framework.viewport.width/10;
			
			_meteoWarrning.x = _meteoLine.x;
			_meteoWarrning.y = _meteoWarrning.height;
		}
		
		private function aimMeteo():void
		{
			// TODO Auto Generated method stub
			_meteoLine.visible = true;
			_meteoLine.y = 0;
			_meteoLine.width = Framework.viewport.width/10;
			_meteoLine.height = Framework.viewport.height;
			
			if(Player.currentPlayer.x > _meteoLine.x+_meteoLine.width/8)
				_meteoLine.x+=_meteoLine.width/8;
			else if(Player.currentPlayer.x < _meteoLine.x-_meteoLine.width/8)
				_meteoLine.x-=_meteoLine.width/8;
		}
	}
}