package aniPangShootingWorld.obstacle
{
	import framework.animaiton.MovieClip;
	import framework.display.ObjectType;
	import framework.display.Sprite;
	import framework.texture.FwTexture;

	public class Obstacle extends MovieClip
	{
		private var _stage :Sprite;
		
		public function Obstacle(textureVector:Vector.<FwTexture>, frame:Number, stage:Sprite)
		{
			_stage = stage;
			
			super(textureVector, frame, 0, 0);
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