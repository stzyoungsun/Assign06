package aniPangShootingWorld.obstacle
{
	import framework.animaiton.AtlasBitmapData;
	import framework.animaiton.MovieClip;
	import framework.display.ObjectType;

	public class Obstacle extends MovieClip
	{
		
		public function Obstacle(meteoAtlas : AtlasBitmapData, frame : Number)
		{
			super(meteoAtlas, frame, 0, 0);
			this.objectType = ObjectType.OBSTACLE_IDLE;
		}
		
		public override function render():void
		{
			super.render();
		}
	}
}