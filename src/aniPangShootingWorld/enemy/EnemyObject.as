package aniPangShootingWorld.enemy
{
	import flash.display.BitmapData;
	
	import framework.core.Framework;
	import framework.display.Image;
	import framework.display.ObjectType;
	
	/**
	 * Note @유영선 적 클래스의 부모입니다. 공통 적으로 적용되는 autoMoving 함수가 있습니다.
	 */
	public class EnemyObject extends Image
	{
		public function EnemyObject(enemyBitmapData : BitmapData)
		{
			super(0,0,enemyBitmapData);
			this._objectType = ObjectType.ENEMY_GENERAL;
		}
		
		/**
		 *  Note @유영선 적의 이동 방향을 설정하는 함수 입니다. 모두 공통적으로 적용 됩니다.
		 */		
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