package framework.gameobject
{

	public class Collision
	{
		public function Collision()
		{
			
		}
		
		public static function bulletToWall(bullet : Bullet) : Boolean
		{
			if(bullet.y <= 0)
			{
				return true;
			}
			
			return false;
		}
	}
}