package framework.gameobject
{
	import flash.display.BitmapData;
	
	import framework.animaiton.AtlasBitmapData;
	import framework.core.Framework;
	import framework.display.Image;

	public class Player extends Image
	{
		private var _playBitmap : BitmapData;
		
		public function Player(playBitmap : BitmapData,x:Number=0,y:Number=0)
		{
			_playBitmap = playBitmap;
			y = Framework.viewport.height - _playBitmap.height;
			super(x,y,_playBitmap);
			
			this.playerflag = true;
		}
	
	}
}