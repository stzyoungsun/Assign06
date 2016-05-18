package framework.background
{
	import flash.utils.getTimer;
	
	import framework.core.Framework;
	import framework.display.Image;
	import framework.display.Sprite;
	import framework.texture.FwTexture;

	/**
	 * 배경을 나타내는 클래스. 같은 텍스쳐를 사용하는 두 개의 이미지 객체를 이용해 배경의 움직임을 나타낸다.
	 * @author jihwan.ryu youngsun.yoo
	 */
	public class BackGround extends Sprite
	{
		private var _firstImage:Image;
		private var _secondImage:Image;
		private var _startPoint:Number;
		private var _frame:Number;
		private var _step:Number;
		private var _move:Boolean;
		
		/**
		 * 생성자 - 변수 초기화와 이미지 객체 생성. backgroundTexture를 텍스쳐로 설정하는 두 개의 이미지를 생성 후 자식으로 등록한다.
		 * @param frame - 프레임 값
		 * @param step - 배경이 움직이는 속도를 결정하는 값
		 * @param backgroudTexture - 배경에 적용할 텍스쳐
		 * @param move - 배경을 움직일지 멈출지 결정하는 변수. 기본 값은 true
		 */
		public function BackGround(frame:Number, step:Number, backgroudTexture:FwTexture, move:Boolean = true)
		{
			_frame = frame;
			_step = step;
			_move = move;
			_prevTime = 0;
			
			// 시작 지점 설정
			_startPoint = -Framework.viewport.height;
			
			// 첫 번째 이미지
			_firstImage = new Image(0, 0, backgroudTexture);
			_firstImage.width = Framework.viewport.width;
			_firstImage.height = Framework.viewport.height;
			
			// 두 번째 이미지
			_secondImage = new Image(0, _startPoint, backgroudTexture);
			_secondImage.width = Framework.viewport.width;
			_secondImage.height = Framework.viewport.height;
			
			addChild(_firstImage);
			addChild(_secondImage);
		}
		
		/**
		 * 렌더링 메서드. _move가 false면 구문을 수행하지 않는다.
		 */
		public override function render():void
		{
			super.render();
			
			if(!isMoving) return;
			
			var curTimerBackGround:int = getTimer();
			
			if(curTimerBackGround - _prevTime > 1000 / _frame)
			{
				// 첫 번째 이미지가 두 번째 이미지보다 아래에 위치할 때
				if(isFirstUnderSecond)
				{
					_firstImage.y += _step;
					// 두 번째 이미지를 첫 번째 이미지의 윗 부분과 연결되도록 한다.
					_secondImage.y = _firstImage.y + _startPoint;
				}
				// 두 번째 이미지가 첫 번째 이미지보다 아래에 위치할 때
				else
				{
					_secondImage.y += _step;
					// 첫 번째 이미지를 두 번째 이미지의 윗 부분과 연결되도록 한다.
					_firstImage.y = _secondImage.y + _startPoint;
				}
				
				// 각각의 이미지가 화면의 끝에 도달하면 y값을 시작지점으로 설정한다.
				if(_firstImage.y >= -_startPoint)	_firstImage.y = _startPoint;
				if(_secondImage.y >= -_startPoint)	_secondImage.y = _startPoint;
				
				_prevTime = curTimerBackGround;
			}
		}
		
		public function set step(value:Number):void { _step = value; }
		public function get isFirstUnderSecond():Boolean { return _firstImage.y > _secondImage.y }
		public function get isMoving():Boolean { return _move; }
		public function set move(value:Boolean):void { _move = value; }
	}
}