package aniPangShootingWorld.enemy
{
	import flash.display.BitmapData;
	
	import framework.core.Framework;
	import framework.display.Image;
	import framework.display.ObjectType;

	public class EnemyObject extends Image
	{
		public function EnemyObject(enemyBitmapData : BitmapData)
		{
			super(0,0,enemyBitmapData);
			this._objectType = ObjectType.ENEMY_GENERAL;
		}
		
		public function autoMoving():void
		{
			
			this.y+=Framework.viewport.height/110;
			
			if(this.y > Framework.viewport.height)
			{
				EnemyObjectUtil._sRedraw = true;
				EnemyLine._sCurLineCount = 5;
				this.y = 0;
			}
			
		}
	}
}