package framework.display
{
	import flash.display.BitmapData;
	
	public class Image extends Quad
	{
		public function Image(bitmapData:BitmapData)
		{
			this.bitmapData = bitmapData;
			super(0.3, 0.3);
		}
	}
}