package aniPangShootingWorld.loader
{
	import flash.utils.Dictionary;

	public class LoadedImage
	{
		private var _imageDictionary : Dictionary = new Dictionary();
		private var _xmlDictionary : Dictionary = new Dictionary;
		private var _imageNameVector : Vector.<String> = new Vector.<String>; 
		
		public function LoadedImage()
		{
		}
		
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