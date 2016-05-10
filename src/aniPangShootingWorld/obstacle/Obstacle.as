package aniPangShootingWorld.obstacle
{
	import framework.animaiton.AtlasBitmapData;
	import framework.animaiton.MovieClip;
	import framework.display.ObjectType;
	import framework.display.Sprite;

	public class Obstacle extends MovieClip
	{
		private var _stage : Sprite;
		
		public function Obstacle(meteoAtlas : AtlasBitmapData, frame : Number, stage:Sprite)
		{
			_stage = stage;
			
			super(meteoAtlas, frame, 0, 0);
			this.objectType = ObjectType.OBSTACLE_IDLE;
		}
		
		public override function render():void
		{
			super.render();
			
			if(this.objectType == ObjectType.OBSTACLE_COLLISON)
				_stage.removeChild(this);
		}
	}
}