package aniPangShootingWorld.boss
{
	import framework.animaiton.AtlasBitmapData;
	import framework.animaiton.MovieClip;
	import framework.display.ObjectType;
	import framework.display.Sprite;

	public class BossObject extends MovieClip
	{
		public function BossObject(bossAtlas : AtlasBitmapData, frame : Number, stage : Sprite)
		{
			super(bossAtlas,frame,0,0);
			this.objectType = ObjectType.BOSS_GENERAL;
		}
	}
}