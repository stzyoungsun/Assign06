package framework.Anmaiton
{
	import flash.display.BitmapData;
	import flash.utils.Dictionary;
	
	import framework.display.Image;

	public class MoveClip extends Image
	{
		private var _startFlag : Boolean = false;
		private var _spriteSheet : Dictionary;
		private var _frameCount : int = 0;
		
		public function MoveClip(x:Number,y:Number,spriteShett : Dictionary )
		{
			_spriteSheet = spriteShett;
			super(x,y,_spriteSheet[0] as BitmapData);
		}
		
		public function start() : void 
		{
			
			_startFlag = true;
		}
		
		public function stop() : void 
		{
			_startFlag = false;
		}
		
		public override function nextFrame() : void
		{
			//bitmapData = _spriteSheet[14];
			if(_startFlag == true)
				bitmapData = _spriteSheet[_frameCount++];
			
			if(_frameCount == 10)
				_frameCount = 0;
		}
	}
}