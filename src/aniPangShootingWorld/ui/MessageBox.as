package aniPangShootingWorld.ui
{
	import aniPangShootingWorld.util.GameTexture;
	
	import framework.core.Framework;
	import framework.display.Button;
	import framework.display.DisplayObjectContainer;
	import framework.display.Image;
	import framework.display.ImageTextField;
	import framework.display.Sprite;
	
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
		
		/**
		 * 생성자 - 화면에 렌더링할 외형을 설정하고 각 버튼들에 이벤트 리스너를 등록한다. 
		 * @param systemMessage - 사용자에게 보여줄 시스템 메시지
		 * @param maxLength - 한 줄에 입력가능한 최대 글자 수
		 * @param hasButton - 하단에 확인, 취소 버튼을 만들것인지 결정하는 변수
		 */
		public function MessageBox(systemMessage:String, maxLength:int = 25, hasButton:Boolean = false)
		{
			// MessageBox 내의 모든 자식 객체를 담는 Sprite 객체
			_messageBoxCanvas = new Sprite();
			
			// 타이틀 바 쪽에 위치하는 객체들을 담는 Sprite 객체
			_titleBarCanvas = new Sprite();
			// 타이틀바 이미지
			_titleBarImage = new Image(0, 0, GameTexture.messageBox[1]);
			// 타이틀바 우측에 위치하는 닫기 버튼
			_closeBtn = new Button("", 0, 0, GameTexture.messageBox[2]);
			_closeBtn.x = _titleBarImage.width - _closeBtn.width;
			// 타이틀바 Sprite 객체에 addChild
			_titleBarCanvas.addChild(_titleBarImage);
			_titleBarCanvas.addChild(_closeBtn);
			
			// 컨텐츠 쪽에 위치하는 객체들을 담는 Sprite 객체
			_contentCanvas = new Sprite();
			// 타이틀바의 아래에 위치하도록 y값 설정
			_contentCanvas.y = _titleBarImage.height;
			// 컨텐츠 이미지
			_contentImage = new Image(0, 0, GameTexture.messageBox[0]);
			// 시스템 메시지 출력을 위한 이미지텍스트필드 객체 생성 & 텍스트 설정
			_systemMessageTextField = new ImageTextField(_contentImage.x + 10, _contentImage.y + 10, Framework.viewport.width / 40, Framework.viewport.height / 40);
			
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
			}
			_systemMessageTextField.text = newLineTreatedString;
			
			// 컨텐츠 Sprite 객체에 addChild
			_contentCanvas.addChild(_contentImage);
			_contentCanvas.addChild(_systemMessageTextField);
			
			// hasButton이 true면 하단에 OK, CANCLE 버튼을 생성
			if(hasButton)
			{
				// 확인 버튼
				_okBtn = new Button("OK", Framework.viewport.width / 40, Framework.viewport.height / 40, GameTexture.messageBox[5]);
				_okBtn.y = _contentImage.height;
				// 취소 버튼
				_cancelBtn = new Button("CANCLE", Framework.viewport.width / 40, Framework.viewport.height / 40, GameTexture.messageBox[3]);
				_cancelBtn.x = _cancelBtn.width;
				_cancelBtn.y = _contentImage.height;
				
				_contentCanvas.addChild(_okBtn);
				_contentCanvas.addChild(_cancelBtn);
			}

			// _messageBoxCanvas에 addChild
			_messageBoxCanvas.addChild(_titleBarCanvas);
			_messageBoxCanvas.addChild(_contentCanvas);
			
			// _messageBoxCanvas를 addChild
			addChild(_messageBoxCanvas);
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