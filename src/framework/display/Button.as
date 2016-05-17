package framework.display
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import framework.core.Framework;
	import framework.event.Touch;
	import framework.event.TouchEvent;
	import framework.event.TouchPhase;
	import framework.texture.AtlasTexture;
	import framework.texture.FwTexture;
	
	/**
	 * 간단한 버튼 UI를 구현한 클래스. 
	 * @author jihwan.ryu youngsun.yoo
	 */
	public class Button extends DisplayObjectContainer
	{
		private var _buttonBackground:Image;
		private var _buttonImageText:ImageTextField;
		private var _valid:Boolean;
		private var _originalWidth:Number;
		private var _originalHeight:Number;
		private var _buttonContents:Sprite;
		private var _buttonBounds:Rectangle;
		
		private static var _sMatrix:Matrix = new Matrix();
		private static var _sPoint:Point = new Point();
		
		/**
		 * 생성자. 버튼을 구성하는 외형을 설정
		 * @param text - 버튼에 입력할 텍스트
		 * @param textWidth - 텍스트 하나의 너비
		 * @param textHeight - 텍스트 하나의 높이
		 * @param texture - 버튼에 적용할 텍스쳐. 기본 값은 null
		 */
		public function Button(text:String, textWidth:Number, textHeight:Number, texture:FwTexture = null, textTexture : AtlasTexture = null)
		{
			_buttonContents = new Sprite();
			if(textTexture == null)
				_buttonImageText = new ImageTextField(0, 0, textWidth, textHeight);
			else
				_buttonImageText = new ImageTextField(0, 0, textWidth, textHeight, textTexture);
			
			_buttonImageText.text = text;
			
			// texture가 null이면 회색 배경을 텍스쳐로 적용한다.
			if(texture == null)
			{
				_buttonBackground = new Image(0, 0, FwTexture.fromBitmapData(new BitmapData(128, 128, false, 0xBBBBBB)));
				// 텍스트 전체 길이보다 좀 더 크게 설정
				_buttonBackground.width = (text.length + 1) * textWidth * 0.75;
				_buttonBackground.height = textHeight * 1.2;
			}
			else
			{
				_buttonBackground = new Image(0, 0, texture);
				// ImageTextField의 길이가 버튼 텍스쳐보다 크면 길이를 더 늘려준다.
				// 너비
				if(_buttonImageText.width > _buttonBackground.width)
				{
					_buttonBackground.width = _buttonImageText.width * 1.3;
				}
				// 높이
				if(_buttonImageText.height > _buttonBackground.height)
				{
					_buttonBackground.height = _buttonImageText.height * 1.2;
				}
			}
			
			// 이미지텍스트필드의 위치 설정
			_buttonImageText.x = (_buttonBackground.width - _buttonImageText.width) / 2;
			_buttonImageText.y = (_buttonBackground.height - _buttonImageText.height) / 2;
			
			_buttonContents.addChild(_buttonBackground);
			_buttonContents.addChild(_buttonImageText);
			
			addChild(_buttonContents);
			// 터치 이벤트 등록
			addEventListener(TouchEvent.TOUCH, onTouchButton);
			
			_buttonBounds = new Rectangle();
		}
		
		/**
		 * 버튼을 터치했을 시에 호출되는 메서드 
		 * @param event - 발생한 이벤트 정보를 담은 TouchEvent 객체
		 */
		private function onTouchButton(event:TouchEvent):void
		{
			var touch:Touch = event.touch;
			
			// 터치 시작 시에는 _valid를 _true로 설정하고 버튼의 크기를 작아지도록 설정
			if(touch.phase == TouchPhase.BEGAN)
			{
				_valid = true;
				_sMatrix.identity();
				
				var currentObject:DisplayObject = this;
				while(currentObject != Framework.stage)
				{
					if(currentObject == null) break;
					
					_sMatrix.concat(currentObject.transformationMatrix);
					currentObject = currentObject.parent;
				}
				
				var bounds:Rectangle = new Rectangle(0, 0, width, height);
				var minX:Number = Number.MAX_VALUE, maxX:Number = -Number.MAX_VALUE;
				var minY:Number = Number.MAX_VALUE, maxY:Number = -Number.MAX_VALUE;
				
				minX = _sMatrix.a * bounds.x + _sMatrix.c * bounds.y + _sMatrix.tx;
				maxX = _sMatrix.a * bounds.width + _sMatrix.c * bounds.y + _sMatrix.tx;
				minY = _sMatrix.d * bounds.y + _sMatrix.b * bounds.x + _sMatrix.ty;
				maxY = _sMatrix.d * bounds.height + _sMatrix.b * bounds.x + _sMatrix.ty;
				
				_buttonBounds.setTo(minX, minY, maxX - minX, maxY - minY);
				
				setPushView();
			}
			// 터치가 끝날 때, _valid가 true이면 TRIGGERED 이벤트 발생하도록 설정
			else if(touch.phase == TouchPhase.ENDED && _valid == true)
			{
				setOriginalView();
				dispatchEvent(new Event(TouchEvent.TRIGGERED));
			}
			// 터치 중 움직이면, 터치의 위치에 따라 _valid와 버튼의 외형을 결정한다.
			else if(touch.phase == TouchPhase.MOVED)
			{
				_sPoint.x = touch.globalX;
				_sPoint.y = touch.globalY;
				
				if(_buttonBounds.containsPoint(_sPoint))
				{
					if(_valid == false)	setPushView();
					_valid = true;
				}
				else
				{
					_valid = false;
					setOriginalView();
				}
			}
		}
		
		/**
		 * 현재 터치의 위치가 Button의 범위에 해당하는지 체크하는 메서드 
		 * @param point - 현재 터치 위치를 담은 Point 객체
		 * @return 해당하면 true, 아니면 false 반환
		 */
		private function checkButtonBounds(point:Point):Boolean
		{
			if(_buttonBackground == _buttonBackground.hitTest(point)) return true;
			else return false;
		}
		
		/**
		 * 버튼의 스케일을 줄여 크기를 작게 보이도록 하는 메서드. 버튼이 눌러진 상태에서 호출된다.
		 */
		private function setPushView():void
		{
			_buttonContents.x = _buttonContents.width / 10;
			_buttonContents.y = _buttonContents.height / 10;
			
			_originalWidth = _buttonBackground.width;
			_originalHeight = _buttonBackground.height;
			
			_buttonContents.width = _originalWidth * 0.8;
			_buttonContents.height = _originalHeight * 0.8;
		}
		
		/**
		 * 버튼을 원래의 크기로 되돌리는 메서드 
		 */
		private function setOriginalView():void
		{
			_buttonContents.x = 0;
			_buttonContents.y = 0;
			
			_buttonContents.width = _originalWidth;
			_buttonContents.height = _originalHeight;
		}
		
		public override function set width(value:Number):void
		{
			super.width = value;
			// ImageTextField 위치 조절
			_buttonImageText.x = (this.width - _buttonImageText.width) / 2;
		}
		
		public override function set height(value:Number):void
		{
			super.height = value;
			// ImageTextField 위치 조절
			_buttonImageText.y = (this.height - _buttonImageText.height) / 2;
		}
		
		public function get buttonImageText():ImageTextField{return _buttonImageText;}
		public function set buttonImageText(value:ImageTextField):void{_buttonImageText = value;}
		public function get buttonBackground():Image{return _buttonBackground;}
		public function set buttonBackground(value:Image):void{_buttonBackground = value;}
	}
}