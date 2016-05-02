package framework.animaiton
{
	import flash.display.BitmapData;
	import flash.utils.getTimer;
	
	import framework.display.Image;
	import framework.display.ObjectType;
	
	public class MovieClip extends Image
	{
		private var _startFlag:Boolean;
		private var _spriteSheet:AtlasBitmapData;
		private var _imageCount:int;
		private var _movieClipWidth:int;
		private var _movieClipHeight:int;
		private var _curFrame:Number;
		private var _prevTime:Number;
		
		/**
		 * @param spriteSheet AtlasBitmapData의 객체
		 * @param x  Clip의 x 좌표
		 * @param y  Clip의 y 좌표
		 */		
		public function MovieClip(spriteSheet:AtlasBitmapData, frame:Number, x:Number = 0, y:Number = 0)
		{
			_spriteSheet = spriteSheet;
			
			super(x, y, _spriteSheet.getsubSpriteSheet[0] as BitmapData);
			
			if(frame == 0)
			{
				throw new Error("Frame value can not set 0");
			}
			
			_startFlag = false;
			_movieClipWidth = width;
			_movieClipHeight = height;
			
			_objectType = ObjectType.MOVIECLIP;
			_curFrame = frame;
			_prevTime = 0;
			_imageCount = 0;
		}
		
		/**
		 * 애니매이션 시작하는 함수
		 */		
		public function start() : void 
		{
			_startFlag = true;
		}
		
		/**
		 * 애니매이션 정지
		 */		
		public function stop() : void 
		{
			_startFlag = false;
		}
		
		public override function render():void
		{
			super.render();
			
			if(getTimer() - _prevTime > 1000 / _curFrame)
			{
				nextFrame();
				_prevTime = getTimer();
			}
		}
		
		public function nextFrame() : void
		{
			if(_startFlag == true)
			{
				bitmapData = _spriteSheet.getsubSpriteSheet[_imageCount++];
				width = _movieClipWidth;
				height = _movieClipHeight;
			}
			
			if(_imageCount == _spriteSheet.getsubCount)
			{
				_imageCount = 0;
			}
		}
		
		public function get movieClipHeight():int { return _movieClipHeight; }
		public function set movieClipHeight(value:int):void { _movieClipHeight = value; }
		
		public function get movieClipWidth():int { return _movieClipWidth; }
		public function set movieClipWidth(value:int):void { _movieClipWidth = value; }
	}
}