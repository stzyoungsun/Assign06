package aniPangShootingWorld.enemy
{
	import flash.display.BitmapData;
	
	import framework.display.Image;
	import framework.display.ObjectType;

	public class EnemyObject extends Image
	{
		public function EnemyObject(enemyBitmapData : BitmapData)
		{
			super(0,0,enemyBitmapData);
			this._objectType = ObjectType.ENEMY;
		}
	}
}