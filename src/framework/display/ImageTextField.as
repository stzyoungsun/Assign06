package framework.display
{
	import flash.utils.Dictionary;
	
	import framework.texture.AtlasTexture;
	import framework.texture.FwTexture;
	import framework.util.ImageCharacterResource;

	public class ImageTextField extends Sprite
	{
		private var _characterTextureDic:Dictionary;
		private var _numWidth : int;
		private var _numHeight : int;
		
		/**
		 * @param x 첫 글자의 x
		 * @param y 첫 글자의 y
		 * @param width 한 글자당 크기
		 * @param height 한 글자 당 크기
		 * @param atlasTexture 글자들을 담고 있는 아틀라스 텍스쳐
		 */		
		public function ImageTextField(x:int, y:int, width:int, height:int, numberTexture:AtlasTexture = null, alphabetTexture : AtlasTexture = null)
		{
			this.x = x;
			this.y = y;
			
			_numWidth = width;
			_numHeight = height;
			
			_characterTextureDic = new Dictionary;
			
			if(numberTexture == null)
			{
				numberTexture = new AtlasTexture(FwTexture.fromBitmapData((new ImageCharacterResource.NUMBER_IMAGE()).bitmapData), XML((new ImageCharacterResource.NUMBER_XML)));
			}
			
			if(alphabetTexture ==  null)
			{
				alphabetTexture = new AtlasTexture(FwTexture.fromBitmapData((new ImageCharacterResource.ALPHABET_IMAGE()).bitmapData), XML((new ImageCharacterResource.ALPHABET_XML)));
			}
			
			for (var i:int = 0; i < 10; i++)
			{
				_characterTextureDic[i + ".png"] = numberTexture.subTextures[i + ".png"];
			}
			
			for(var key : Object in alphabetTexture.subTextures)
			{
				_characterTextureDic[key] = alphabetTexture.subTextures[key];
			}
			
		}
		
		public function set text(value:String):void
		{
			var numChildren:Number = children.length;
			var textLength:Number = value.length;
		
			if(numChildren > textLength )
			{
				removeChildren(textLength, numChildren, true);
				numChildren = textLength;
			}
			
			for(var i : int = 0; i < textLength; i++)
			{
				if(numChildren == 0 || numChildren <= i)
				{
					var image:Image = new Image(this.x + _numWidth * 0.75 * i, this.y, _characterTextureDic[value.charAt(i)+".png"]);
					image.width = _numWidth;
					image.height = _numHeight;
					
					addChild(image);
				}
				else
				{
					image = children[i] as Image;
					image.texture = _characterTextureDic[value.charAt(i)+".png"];
				}
			}
		}
	}
}