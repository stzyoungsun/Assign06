package framework.display
{
	import framework.texture.AtlasTexture;
	import framework.texture.FwTexture;
	import framework.util.ImageCharacterResource;

	public class ImageTextField extends Sprite
	{
		private var _characterTextureVector:Vector.<FwTexture>;
		private var _numWidth : int;
		private var _numHeight : int;
		
		/**
		 * @param x 첫 글자의 x
		 * @param y 첫 글자의 y
		 * @param width 한 글자당 크기
		 * @param height 한 글자 당 크기
		 * @param atlasTexture 글자들을 담고 있는 아틀라스 텍스쳐
		 */		
		public function ImageTextField(x:int, y:int, width:int, height:int, atlasTexture:AtlasTexture = null)
		{
			this.x = x;
			this.y = y;
			
			_numWidth = width;
			_numHeight = height;
			
			_characterTextureVector = new Vector.<FwTexture>();
			
			if(atlasTexture == null)
			{
				atlasTexture = new AtlasTexture(FwTexture.fromBitmapData((new ImageCharacterResource.NUMBER_IMAGE()).bitmapData), XML((new ImageCharacterResource.NUMBER_XML)));
			}
			
			for (var i:int = 0; i < 10; i++)
			{
				_characterTextureVector.push(atlasTexture.subTextures[i + ".png"]);
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
			
			var numberArray:Array = pushNumber(int(value));
			
			for(var i : int = 0; i < textLength; i++)
			{
				var number:Number = numberArray.pop();
				if(numChildren == 0 || numChildren <= i)
				{
					var image:Image = new Image(this.x + _numWidth * 0.75 * i, this.y, _characterTextureVector[number]);
					image.width = _numWidth;
					image.height = _numHeight;
					
					addChild(image);
				}
				else
				{
					image = children[i] as Image;
					image.texture = _characterTextureVector[number];
				}
			}
		}
		
		private function pushNumber(drawNumber:int):Array
		{
			var numberArray : Array = new Array();
			var tempNumber : int = 0;
			
			if(drawNumber == 0)
			{
				numberArray.push(0);
				return numberArray;
			}
			
			while(drawNumber != 0)
			{
				tempNumber = drawNumber % 10;
				drawNumber = drawNumber / 10;
				
				numberArray.push(tempNumber);
			}
			
			return numberArray;
		}
	}
}