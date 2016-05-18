package framework.animaiton
{
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import framework.display.Image;
	import framework.texture.FwTexture;
	
	public class MovieClip extends Image
	{
		private var _play:Boolean;
		private var _textureVector:Vector.<FwTexture>;
		private var _imageCount:int;
		private var _curFrame:Number;
		private var _prevTime:Number;
		private var _playOnce:Boolean;
		
		/**
		 * 생성자 - 스프라이트 시트와 프레임 값 등을 설정
		 * @param spriteSheet - AtlasBitmapData의 객체
		 * @param frame - 애니메이션의 Frame 값 (재생 속도)
		 * @param x - Clip의 x 좌표
		 * @param y - Clip의 y 좌표
		 * @param playOnce - 애니메이션을 한번만 재생시키려면 이 값을 true로 설정
		 */
		public function MovieClip(textureVector:Vector.<FwTexture>, frame:Number, x:Number = 0, y:Number = 0, playOnce:Boolean = false)
		{
			super(x, y, textureVector[0]);
			
			if((_curFrame = frame) == 0)
			{
				throw new Error("Frame value should not set to 0");
			}
			
			_textureVector = textureVector;
			_playOnce = playOnce;
			_play = false;
			_prevTime = 0;
			_imageCount = 0;
		}

		/**
		 * 애니매이션 시작하는 함수
		 */		
		public function start() : void 
		{
			_play = true;
		}
		
		/**
		 * 애니매이션 정지
		 */		
		public function stop() : void 
		{
			_play = false;
			_prevTime = 0;
			dispatchEvent(new Event("stop"));
		}
		
		/**
		 * 렌더링 버퍼에 데이터를 입력하는 메서드 <br/>
		 * _play가 true일 때, 특정 주기마다 nextFrame 메서드를 호출해서 버퍼에 입력되는 비트맵 데이터를 바꿔준다
		 */
		public override function render():void
		{
			super.render();
			
			if(_play)
			{
				if(getTimer() - _prevTime > 1000 / _curFrame)
				{
					nextFrame();
					_prevTime = getTimer();
				}
			}
		}
		
		/**
		 * 화면에 출력할 비트맵 데이터 (이미지)를 변경하는 메서드
		 */
		public function nextFrame() : void
		{
			texture = _textureVector[_imageCount++];
			
			if(_imageCount == _textureVector.length)
			{
				_imageCount = 0;
				// 한번만 재생시킴
				if(_playOnce)	stop();
			}
		}
		
		/**
		 * 애니메이션 재생을 멈추고 특정 인덱스의 이미지를 고정으로 출력시키는 메서드 
		 * @param index - 보여주려는 이미지의 인덱스 (스프라이트 시트 상의 인덱스)
		 */
		public function showImageAt(index:int):void
		{
			stop();
			
			// 인덱스가 시트의 범위를 벗어나면 Error throw
			if(index < 0 && index >= _textureVector.length)
			{
				throw new Error("Invalid index value");
			}
			
			_imageCount = index;
			texture = _textureVector[_imageCount];
		}
		
		public function get play():Boolean{return _play;}
		
		public function get playOnce():Boolean { return _playOnce; }
		public function set playOnce(value:Boolean):void { _playOnce = value; }
		
		public function get currentIndex():int { return _imageCount; }

		public function get textureVector():Vector.<FwTexture> { return _textureVector; }
		public function set textureVector(value:Vector.<FwTexture>):void { _textureVector = value; _imageCount = 0; }
	}
}