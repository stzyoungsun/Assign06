package framework.texture
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	/**
	 * 스프라이트 시트 비트맵 데이터와 XML데이터를 이용해 각각의 서브텍스쳐를 생성하는 클래스
	 * @author jihwan.ryu youngsun.yoo
	 */
	public class AtlasTexture
	{
		private var _subTextureDictionary:Dictionary;
		private var _baseTexture:FwTexture;
		
		/**
		 * @param atlasBitmap 스프라이트 이미지들이 담긴 비트맵 데이터
		 * @param spriteXml
		 */
		public function AtlasTexture(spriteSheetBitmapData:BitmapData, atlasXmlData:String)
		{
			_baseTexture = FwTexture.fromBitmapData(spriteSheetBitmapData);
			_subTextureDictionary = new Dictionary();
			parseAtlasXml(XML(atlasXmlData));
		}
		
		/**
		 * 아틀라스 XML 데이터에 담긴 정보를 파싱한 후 그 데이터로 서브텍스쳐를 생성하는 메서드
		 * @param atlasXml - 서브텍스쳐의 정보가 담긴 XML 객체
		 */
		private function parseAtlasXml(atlasXml:XML):void
		{
			for(var i:int = 0; i < atlasXml.child("SubTexture").length(); i++)
			{
				var name:String = atlasXml.child("SubTexture")[i].attribute("name");
				var x:Number = parseFloat(atlasXml.child("SubTexture")[i].attribute("x"));
				var y:Number = parseFloat(atlasXml.child("SubTexture")[i].attribute("y"));
				var width:Number = parseFloat(atlasXml.child("SubTexture")[i].attribute("width"));
				var height:Number = parseFloat(atlasXml.child("SubTexture")[i].attribute("height"));
				
				var region:Rectangle = new Rectangle(x, y, width, height);
				_subTextureDictionary[name] = FwTexture.fromTexture(_baseTexture, region);
			}
		}
		
		public function get subTextures():Dictionary { return _subTextureDictionary; }
		public function get baseTexture():FwTexture { return _baseTexture; }
	}
}