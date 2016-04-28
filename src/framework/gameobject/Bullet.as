package framework.gameobject
{
	import flash.display.BitmapData;
	
	import framework.display.Image;

	public class Bullet extends Image
	{
		public function Bullet(x:Number, y: Number,bulletBitmap : BitmapData)
		{
			super(x,y,bulletBitmap);
			
		}
		
		public override function shooting() : void
		{
			// Abstract Method
			this.y--;
		}
	}
}