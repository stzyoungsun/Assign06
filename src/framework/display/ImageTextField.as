package framework.display
{
	import flash.utils.Dictionary;
	
	import framework.texture.AtlasTexture;
	import framework.texture.FwTexture;
	import framework.util.ImageCharacterResource;

	public class ImageTextField extends Sprite
	{
		private var _characterTextureDic:Dictionary;
		private var _characterWidth:int;
		private var _characterHeight:int;
		
		/**
		 * @param x - 첫 글자의 x
		 * @param y - 첫 글자의 y
		 * @param width - 한 글자당 크기
		 * @param height - 한 글자 당 크기
		 * @param numberTexture, alphabetTexture - 글자들을 담고 있는 아틀라스 텍스쳐. null이면 Framework에서 제공하는 기본 아틀라스 텍스쳐를 사용한다.
		 */		
		public function ImageTextField(x:int, y:int, characterWidth:int, characterHeight:int, numberTexture:AtlasTexture = null, alphabetTexture:AtlasTexture = null)
		{
			this.x = x;
			this.y = y;
			
			_characterWidth = characterWidth;
			_characterHeight = characterHeight;
			_characterTextureDic = new Dictionary;
			
			// null이면 기본 텍스쳐사용
			if(numberTexture == null)
			{
				numberTexture = new AtlasTexture(FwTexture.fromBitmapData((new ImageCharacterResource.NUMBER_IMAGE()).bitmapData), XML((new ImageCharacterResource.NUMBER_XML)));
			}
			
			if(alphabetTexture ==  null)
			{
				alphabetTexture = new AtlasTexture(FwTexture.fromBitmapData((new ImageCharacterResource.ALPHABET_IMAGE()).bitmapData), XML((new ImageCharacterResource.ALPHABET_XML)));
			}
			
			// dictionary객체에 텍스쳐 입력
			for (var keyNumber : Object in numberTexture.subTextures)
			{
				_characterTextureDic[keyNumber] = numberTexture.subTextures[keyNumber];
			}
			
			for(var keyAlphabet : Object in alphabetTexture.subTextures)
			{
				_characterTextureDic[keyAlphabet] = alphabetTexture.subTextures[keyAlphabet];
			}
		}
		
		/**
		 * 텍스트 필드에 나타낼 텍스트를 설정하는 메서드
		 * @param value - 출력할 텍스트 값
		 */
		public function set text(value:String):void
		{
			var numChildren:Number = children.length;
			var textLength:Number = value.length;
			var currentIndex:Number = 0;
			
			// 현재 입력된 자식의 수가 텍스트의 길이를 넘으면 넘은만큼 자식을 제거
			if(numChildren > textLength )
			{
				removeChildren(textLength, numChildren, true);
				numChildren = textLength;
			}
			
			// 개행 문자를 구분하여 문자열을 배열로 나눔
			var stringArray:Array = value.split("\n");
			
			// 배열에 담긴 문자열에서 각 문자에 해당하는 텍스쳐로 이미지 객체 생성
			for(var i:int = 0; i < stringArray.length; i++)
			{
				for(var j:int = 0; j < stringArray[i].length; j++)
				{
					// 문자 하나 가져옴
					var character:String = stringArray[i].charAt(j);
					
					if(! _characterTextureDic[character + ".png"] && !_characterTextureDic["null.png"]) throw new Error("숫자 또는 알파벳만 가능합니다.");
					
					// 자식이 아예 없거나 현재 참조하는 문자의 인덱스가 기존 children Vector의 길이를 넘어서면 새로운 이미지 객체를 생성
					if(numChildren == 0 || numChildren <= currentIndex)
					{
						var image:Image;
						
						if(character == ' ') image = new Image(0, 0, _characterTextureDic["null.png"]);
						else image = new Image(0, 0, _characterTextureDic[character + ".png"]);
						
						image.width = _characterWidth;
						image.height = _characterHeight;
						
						addChild(image);
					}
					// 그렇지 않다면, 이미 생성된 자식의 텍스쳐를 변환
					else
					{
						image = children[currentIndex] as Image;
						if(character == ' ') image.texture = _characterTextureDic["null.png"];
						else image.texture = _characterTextureDic[character + ".png"];
					}
					
					image.x = this.x + _characterWidth * 0.75 * j;
					image.y = this.y + _characterHeight * i;
					// 현재 참조하는 인덱스 증가
					currentIndex++;
				}
			}
		}
		
		public override function dispose():void
		{
			_characterTextureDic = null;
		}
	}
}