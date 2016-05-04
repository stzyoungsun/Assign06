package aniPangShootingWorld.loader
{
	import flash.utils.Dictionary;
	
	/** 
	 * Note @유영선 이미지 로드 할 때 imge와 xml name을 묶기 위한 클래스
	 */	
	public class LoadedImage
	{
		//Note @유영선 이미지를 저장
		private var _imageDictionary : Dictionary = new Dictionary();
		//Note @유영선 xml을 저장
		private var _xmlDictionary : Dictionary = new Dictionary;
		//Note @유영선 이미지,xml의 이름 저장
		private var _imageNameVector : Vector.<String> = new Vector.<String>; 
		
		public function LoadedImage()
		{
		}
		
		//이미지와 이름이 같은 xml이 존재하는지 검사합니다.
		public function checkXml(xmlName : String) : Boolean
		{
			if(_xmlDictionary[xmlName])
				return true;
			else
				return false;
		}
		
		public function dispose() : void
		{
			_imageDictionary = null;
			_xmlDictionary = null;
			_imageNameVector = null;
		}
		
		public function get imageNameVector():Vector.<String>{return _imageNameVector;}
		public function set imageNameVector(value:Vector.<String>):void{_imageNameVector = value;}

		public function get xmlDictionary():Dictionary{return _xmlDictionary;}
		public function set xmlDictionary(value:Dictionary):void{_xmlDictionary = value;}

		public function get imageDictionary():Dictionary{return _imageDictionary;}
		public function set imageDictionary(value:Dictionary):void{_imageDictionary = value;}
	}
}