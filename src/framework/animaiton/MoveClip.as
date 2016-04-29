package framework.animaiton
{
	import flash.display.BitmapData;
	
	import framework.display.Image;
	import framework.display.ObjectType;

	public class MoveClip extends Image
	{
		private var _startFlag : Boolean = false;
		private var _spriteSheet : AtlasBitmapData;
		private var _imageCount : int = 0;
		
		private var _moveClipWidth: int =0;
		private var _moveClipHeight: int =0;
		/**
		 * 
		 * @param spriteSheet AtlasBitmapData의 객체
		 * @param x  Clip의 x 좌표
		 * @param y  Clip의 y 좌표
		 * 
		 */		
		public function MoveClip(spriteSheet : AtlasBitmapData,frame:Number,x:Number=0,y:Number=0)
		{
			_spriteSheet = spriteSheet;
		
			
			super(x,y,_spriteSheet.getsubSpriteSheet[0] as BitmapData);
			
			_moveClipWidth = this.width;
			_moveClipHeight = this.height;
			
			this._objectType = ObjectType.MOVIECLIP;
			this.curFrame = frame;
		}
		/**
		 * 
		 * 애니매이션 시작하는 함수
		 */		
		public function start() : void 
		{
			_startFlag = true;
		}
		/**
		 *애니매이션 정지 
		 * 
		 */		
		public function stop() : void 
		{
			_startFlag = false;
		}
		
		public override function nextFrame() : void
		{
			if(_startFlag == true)
			{
				bitmapData = _spriteSheet.getsubSpriteSheet[_imageCount++];
				this.width = _moveClipWidth;
				this.height = _moveClipHeight;
			}
				
			if(_imageCount == _spriteSheet.getsubCount)
				_imageCount = 0;
		}
		/**
		 * @param value MoveClip width
		 */		
		public  function set clipheight(value:Number):void{ _moveClipHeight = value; }
		/**
		 * @param value MoveClip Height
	    */		
		public  function set clipwidth(value:Number):void{ _moveClipWidth = value; }
		
		public function get frame() : Number {return this.curFrame;};
		public function set frame(value:Number) : void {this.curFrame = value;}
		;
	}
}