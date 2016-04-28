package framework.Anmaiton
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import flash.geom.Point;
	
	
	public class AtlasBitmapData
	{
		private var _sprtieSheet:Bitmap;
		private var _subSpriteSheet: Dictionary;
		private var _subBitmapNames:Vector.<String >;
		
		public function AtlasBitmapData(sprtieSheet:Bitmap, spriteXml:XML = null)
		{
			_subSpriteSheet = new  Dictionary();
			_sprtieSheet = sprtieSheet;
			
			if (spriteXml)
			{
				parseAtlasXml(spriteXml);
			}
		}
		
		protected function parseAtlasXml(spriteXml:XML):void
		{
			var region:Rectangle = new Rectangle();
		
			for(var i : int =0; i < spriteXml.child("SubTexture").length(); i++)
			{
				var name:String = spriteXml.child("SubTexture")[i].attribute("name");
				var x:Number = parseFloat(spriteXml.child("SubTexture")[i].attribute("x"));
				var y:Number = parseFloat(spriteXml.child("SubTexture")[i].attribute("y"));
				var width:Number = parseFloat(spriteXml.child("SubTexture")[i].attribute("width"));
				var height:Number = parseFloat(spriteXml.child("SubTexture")[i].attribute("height"));
				
				region.setTo(x,y,width,height);
				createSubBitmap(name, region);
			}
			
		}
		
		public function createSubBitmap(name : String, region:Rectangle):void
		{
			var tempBitmapData : BitmapData = new BitmapData(region.width,region.height);
			
			tempBitmapData.copyPixels(_sprtieSheet.bitmapData,region,new Point(0,0));
			_subSpriteSheet[name] =  tempBitmapData;
		}
		
		public function get getsubSpriteSheet() :Dictionary
		{
			return _subSpriteSheet;
		}
	}
}