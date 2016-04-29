package framework.gameobject
{
	import framework.core.Framework;

	public class Collision
	{
		public function Collision()
		{
			
		}
		
		public static function bulletToWall(bullet : Bullet) : Boolean
		{
			if(bullet.y <= 0 || bullet.y >= Framework.viewport.height || bullet.x <= 0 || bullet.x >= Framework.viewport.width)
			{
				return true;
			}
			
			return false;
		}
	}
}