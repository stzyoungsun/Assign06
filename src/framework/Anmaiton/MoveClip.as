package framework.Anmaiton
{
	import flash.display.BitmapData;
	import framework.display.Image;

	public class MoveClip extends Image
	{
		private var _startFlag : Boolean = false;
		private var _spriteSheet : AtlasBitmapData;
		private var _frameCount : int = 0;
		
		private var _moveClipWidth: int =0;
		private var _moveClipHeight: int =0;
		
		public function MoveClip(spriteSheet : AtlasBitmapData,x:Number=0,y:Number=0)
		{
			_spriteSheet = spriteSheet;
			super(x,y,_spriteSheet.getsubSpriteSheet[0] as BitmapData);
			_moveClipWidth = this.width;
			_moveClipHeight = this.height;
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
			if(_startFlag == true)
			{
				bitmapData = _spriteSheet.getsubSpriteSheet[_frameCount++];
			
				this.width = _moveClipWidth;
				this.height = _moveClipHeight;
			}
				
			if(_frameCount == _spriteSheet.getsubCount)
				_frameCount = 0;
		}
		
		public  function set clipheight(value:Number):void{ _moveClipHeight = value; }
		public  function set clipwidth(value:Number):void{ _moveClipWidth = value; }
	}
}