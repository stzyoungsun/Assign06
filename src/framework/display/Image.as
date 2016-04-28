package framework.display
{
	import flash.display.BitmapData;
	
	public class Image extends Quad
	{
		public function Image(x:int, y:int,bitmapData:BitmapData)
		{
			this.bitmapData = bitmapData;
			super(x,y);
		}
		
		public  override function nextFrame() : void
		{
			//bitmapData = _spriteSheet[14];
				trace("이미지 프레임");
		}
	}
}