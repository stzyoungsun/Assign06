package framework.gameobject
{
	import framework.core.Framework;
	import framework.display.DisplayObject;

	public class Collision
	{
		public function Collision()
		{
			
		}
		
		public static function bulletToWall(bullet:Bullet):Boolean
		{
			if(bullet.y <= 0 || bullet.y >= Framework.viewport.height || bullet.x <= 0 || bullet.x >= Framework.viewport.width)
			{
				return true;
			}
			return false;
		}
		
		public static function ObjectToObject(object1:DisplayObject, object2:DisplayObject):Boolean
		{
			var tempwidth : Number  = object2.width*0.9;				//물체의 스케일을  0.9로 하여 충돌 검사 (애매한 경우를 처리하기 위해서)
			var tempHeiht : Number  = object2.height*0.9;
			var tempx : Number = object2.x + (object2.width*0.1)/2;
			var tempy : Number = object2.y - (object2.height*0.1)/2;
			
			
			var object1Rectangle : CollisionRectangle = new CollisionRectangle(object1.x, object1.x+object1.width, object1.y, object1.y+object1.height);
			var object2Rectangle : CollisionRectangle = new CollisionRectangle(tempx, tempx+tempwidth, tempy, tempy+tempHeiht); 
			
			if(object1Rectangle.left < object2Rectangle.right && object1Rectangle.top < object2Rectangle.bottom && 
				object1Rectangle.right > object2Rectangle.left && object1Rectangle.bottom > object2Rectangle.top)
				return true;
			
			return false;
		}
	}
}