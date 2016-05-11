package framework.display
{
	import framework.animaiton.AtlasBitmapData;
	import framework.animaiton.MovieClip;

	public class TextImageField extends Sprite
	{
		private var _NumberImageVector : Vector.<MovieClip> = new Vector.<MovieClip>;
		private var _NumberImages:AtlasBitmapData;
		
		private var _NumWidth : int;
		private var _NumHeight : int;
		/**
		 * 
		 * @param x 첫 글자의 x
		 * @param y 첫 글자의 y
		 * @param width 한 글자당 크기
		 * @param height 한 글자 당 크기
		 * @param NumberImages 글자들을 담고 있는 아틀라스 비트맵
		 * 
		 */		
		public function TextImageField(x : int, y : int, width:int, height:int, NumberImages : AtlasBitmapData)
		{
			_NumberImages = NumberImages;
		
			super();
			
			this.x = x;
			this.y = y;
			
			_NumWidth = width;
			_NumHeight = height;
		}
		
		public function createTextImage(drawNumber : int):void
		{
			// TODO Auto Generated method stub
			var numberArray : Array = outArrayNumber(drawNumber);
			var centerNum : int = numberArray.length/2;
			if(_NumberImageVector)
				removeText();
			
			for(var i : int =0; i < numberArray.length; ++i)
			{
				_NumberImageVector.push(new MovieClip(_NumberImages,1,0,0));
				trace(Math.ceil(_NumWidth));
				_NumberImageVector[i].width = _NumWidth;
				_NumberImageVector[i].height = _NumHeight;
				_NumberImageVector[i].x = this.x + _NumberImageVector[i].width/2*i;
				_NumberImageVector[i].y = this.y;
				
				_NumberImageVector[i].showImageAt(numberArray[numberArray.length-(i+1)]);
				addChild(_NumberImageVector[i]);
			}
			
		}
		
		private function removeText():void
		{

			for(var i : int =0; i < _NumberImageVector.length; ++i)
			{
				if(getChildIndex(_NumberImageVector[i])!= -1)
				{
					removeChild(_NumberImageVector[i]);
				}
			}
			
			for(var j : int =0; j < _NumberImageVector.length; ++j)
			{
				_NumberImageVector.pop();
			}
		}
		
		private function outArrayNumber(drawNumber : int) : Array
		{
			var numberArray : Array = new Array();
			var tempNumber : int = 0;
			
			while(drawNumber != 0)
			{
				tempNumber = drawNumber%10;
				drawNumber = drawNumber/10;
				
				numberArray.push(tempNumber);
			}
			
			return numberArray;
		}
		public override function dispose():void
		{
			super.dispose();
			
			if(_NumberImageVector)
			{
				for(var i : Number = 0; i < _NumberImageVector.length; i++)
				{
					_NumberImageVector[i].dispose();
					_NumberImageVector[i] = null;
				}
				_NumberImageVector = null;
			}
		}
		
		public override function render():void
		{
			super.render();
				
		}
	}
}