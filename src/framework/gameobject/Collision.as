package framework.gameobject
{
	import framework.core.Framework;
	import framework.display.DisplayObject;

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
		
		public static function bulletToObject(bullet : Bullet, object : DisplayObject) : Boolean
		{
			var tempwidth : Number  = object.width*0.9;				//물체의 스케일을  0.9로 하여 충돌 검사 (애매한 경우를 처리하기 위해서)
			var tempHeiht : Number  = object.height*0.9;
			var tempx : Number = object.x + (object.width*0.1)/2;
			var tempy : Number = object.y + (object.height*0.1)/2;
			
			var bulletRectangle : CollisionRectangle = new CollisionRectangle(bullet.x, bullet.x+bullet.width, bullet.y, bullet.y+bullet.height);
			var objectRectangle : CollisionRectangle = new CollisionRectangle(tempx, tempx+tempwidth, tempy, tempy+tempHeiht); 
			
			if(bulletRectangle.left < objectRectangle.right && bulletRectangle.top < objectRectangle.botton && 
				bulletRectangle.right > objectRectangle.left && bulletRectangle.botton > objectRectangle.top)
				return true;
				
			return false;
		}
	}
}