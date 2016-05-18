package aniPangShootingWorld.ui
{
	import flash.events.Event;
	
	import aniPangShootingWorld.util.GameTexture;
	
	import framework.core.Framework;
	import framework.display.Button;
	import framework.display.DisplayObjectContainer;
	import framework.display.Image;
	import framework.display.ImageTextField;
	import framework.display.Sprite;
	import framework.event.TouchEvent;
	
	/**
	 * 사용자에게 시스템 메시지를 UI를 통해 보여주는 클래스
	 * @author jihwan.ryu youngsun.yoo
	 */
	public class MessageBox extends DisplayObjectContainer
	{
		private var _messageBoxCanvas:Sprite;
		
		private var _titleBarCanvas:Sprite;
		private var _titleBarImage:Image;
		private var _closeBtn:Button;
		
		private var _contentCanvas:Sprite;
		private var _contentImage:Image;
		private var _systemMessageTextField:ImageTextField;
		private var _okBtn:Button;
		private var _cancelBtn:Button;
		
		private var _okFunction:Function;
		private var _cancelFunction:Function;
		
		/**
		 * 생성자 - 화면에 렌더링할 외형을 설정하고 각 버튼들에 이벤트 리스너를 등록한다. 
		 * @param systemMessage - 사용자에게 보여줄 시스템 메시지
		 * @param maxLength - 한 줄에 입력가능한 최대 글자 수
		 * @param hasButton - 하단에 확인, 취소 버튼을 만들것인지 결정하는 변수
		 */
		public function MessageBox(systemMessage:String, maxLength:int = 25, hasButton:Boolean = false, okFunction:Function = null, cancelFunction:Function = null)
		{
			// MessageBox 내의 모든 자식 객체를 담는 Sprite 객체
			
			_messageBoxCanvas = new Sprite();
			
			// 타이틀 바 쪽에 위치하는 객체들을 담는 Sprite 객체
			_titleBarCanvas = new Sprite();
			// 타이틀바 이미지
			_titleBarImage = new Image(0, 0, GameTexture.messageBox[1]);
			_titleBarImage.width = Framework.viewport.width / 2;
			_titleBarImage.height = Framework.viewport.height / 40;
			// 타이틀바 우측에 위치하는 닫기 버튼
			_closeBtn = new Button("", 0, 0, GameTexture.messageBox[2]);
			_closeBtn.width = Framework.viewport.height / 40;
			_closeBtn.height = Framework.viewport.height / 40;
			_closeBtn.x = Framework.viewport.width / 2 - Framework.viewport.height / 40;
			_closeBtn.addEventListener(TouchEvent.TRIGGERED, onTriggeredButton);
			// 타이틀바 Sprite 객체에 addChild
			_titleBarCanvas.addChild(_titleBarImage);
			_titleBarCanvas.addChild(_closeBtn);
			
			// 컨텐츠 쪽에 위치하는 객체들을 담는 Sprite 객체
			_contentCanvas = new Sprite();
			// 타이틀바의 아래에 위치하도록 y값 설정
			_contentCanvas.y = _titleBarImage.height;
			// 컨텐츠 이미지
			_contentImage = new Image(0, 0, GameTexture.messageBox[0]);
			_contentImage.width = Framework.viewport.width / 2;
			_contentImage.height = Framework.viewport.height / 4;
			// 시스템 메시지 출력을 위한 이미지텍스트필드 객체 생성 & 텍스트 설정
			_systemMessageTextField = new ImageTextField(
				_contentImage.x + Framework.viewport.width / 300,
				_contentImage.y + Framework.viewport.width / 120,
				Framework.viewport.width / 40,
				Framework.viewport.height / 40
			);
			
			// 메시지의 문자열의 길이가 maxLength보다 크면 메시지 문자열을 maxLength의 크기만큼 나눈 후 나눈 문자열의 끝에 개행문자를 덧붙여준다.
			if(maxLength < systemMessage.length)
			{
				// 반복할 횟수 지정
				var count:int = Math.ceil(systemMessage.length / maxLength);
				// 개행처리된 문자열들이 저장될 변수
				var newLineTreatedString:String = "";
				
				while(count != 0)
				{
					// 0 ~ maxLength만큼 자른 문자열에 개행문자를 더한 후 newLineTreatedString에 더함 
					newLineTreatedString += systemMessage.substring(0, maxLength) + "\n";
					// maxLength 이후부터 끝까지 문자열을 자른 후 대입
					systemMessage = systemMessage.substring(maxLength, systemMessage.length);
					count--;
				}
				
				systemMessage = newLineTreatedString;
			}
			
			_systemMessageTextField.text = systemMessage;
			
			// 컨텐츠 Sprite 객체에 addChild
			_contentCanvas.addChild(_contentImage);
			_contentCanvas.addChild(_systemMessageTextField);
			
			// hasButton이 true면 하단에 OK, CANCLE 버튼을 생성
			if(hasButton)
			{
				// 확인 버튼
				_okBtn = new Button("OK", Framework.viewport.width / 40, Framework.viewport.height / 40, GameTexture.messageBox[5]);
				_okBtn.y = Framework.viewport.height / 4;
				_okBtn.width = Framework.viewport.width / 4;
				_okBtn.height = Framework.viewport.height / 20;
				// 취소 버튼
				_cancelBtn = new Button("CANCLE", Framework.viewport.width / 40, Framework.viewport.height / 40, GameTexture.messageBox[3]);
				_cancelBtn.x = Framework.viewport.width / 4;
				_cancelBtn.y = Framework.viewport.height / 4;
				_cancelBtn.width = Framework.viewport.width / 4;
				_cancelBtn.height = Framework.viewport.height / 20;
				
				_okBtn.addEventListener(TouchEvent.TRIGGERED, onTriggeredButton);
				_cancelBtn.addEventListener(TouchEvent.TRIGGERED, onTriggeredButton);
				
				_contentCanvas.addChild(_okBtn);
				_contentCanvas.addChild(_cancelBtn);
			}
			
			// _messageBoxCanvas에 addChild
			_messageBoxCanvas.addChild(_titleBarCanvas);
			_messageBoxCanvas.addChild(_contentCanvas);
			
			// _messageBoxCanvas를 addChild
			addChild(_messageBoxCanvas);
			
			_okFunction = okFunction;
			_cancelFunction = cancelFunction;
		}
		
		public function onTriggeredButton(event:Event):void
		{
			var button:Button = event.currentTarget as Button;
			
			switch(button)
			{
				case _okBtn:
					if(_okFunction != null) _okFunction();
					break;
				case _cancelBtn:
					if(_cancelBtn != null) _cancelFunction();
					break;
				case _closeBtn:
					this.dispose();
					removeFromParent();
					break;
			}
		}
		
		/**
		 * 시스템 메시지를 변경하는 메서드 
		 * @param value - 변경할 메시지
		 */
		public function set systemMessage(value:String):void
		{
			_systemMessageTextField.text = value;
		}
	}
}