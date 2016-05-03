package aniPangShootingWorld.loader
{
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import avmplus.getQualifiedClassName;
	
	/**
	 * 이미지와 xml 2가지를  분리하여 Dictionary에 저장
	 * 기존에 구현 했던 Loaderclass 수정
	 * 
	 */		
	public class LoaderControl
	{
		private var _currentCount : int = 0;
		public static var sImageMaxCount :int;
		
		private var _loadedImage : LoadedImage = new LoadedImage();  //로더에서 이미지 로드가 완료 된 xml과 image 파일이 저장 된 객체
		
		private var _urlImageArray:Array = new Array();					//파일명이 담긴 배열
		private var _urlXmlVector : Vector.<String> = new Vector.<String>;  //XML 한 개씩 출력으르 조절 하기 위한 변수
		
		private var _loaderXML:URLLoader;

		private var _onCompleteFunction:Function;
		private var _onProgressFunction:Function;
		
		private var _imageLength : Number = 0;
		
		public function LoaderControl(onCompleteFunction : Function, onProgressFunction : Function)
		{
			_onCompleteFunction = onCompleteFunction;
			_onProgressFunction = onProgressFunction;
		}
		
		public function resourceLoad(directoryName:String) : void
		{
			getFolderResource(File.applicationDirectory.resolvePath(directoryName));
			
			buildLoader();
			buildXMLLoader();
		}
		
		/**
		 * 
		 * @return 
		 * Note @유영선불러올 폴더명 지정
		 * 폴더 안에 이미지 로드
		 */		
		private function getFolderResource(...files):void
		{
			for each(var file:Object in files)
			{
				if(file["isDirectory"])
					getFolderResource.apply(this, file["getDirectoryListing"]());
				else if(getQualifiedClassName(file) == "flash.filesystem::File")
				{
				
					var url:String = file["url"] as String;6
					var extension:String = url.substr(url.lastIndexOf(".")+1, url.length);
					
					if(extension == "png" || extension == "jpg" || extension == "PNG" || extension == "JPG")
					{
						_imageLength++;
						trace("이미지 개수 : " + _imageLength);
						trace("image" + url);
						_urlImageArray.push(url);
					}
					else if(extension == "XML" || extension == "xml")
					{
						trace("xml" + file["url"]);
						_urlXmlVector.push(url);
					}
					else
					{
						trace("둘다 아님" + file["url"]);
					}
				}
				
				files = null;
			}
		}
	
		/**
		 *Note @유영선 XML 로드 
		 *(병훈님이 말씀하신 파일 실제 존재 유무는 LoadeImage 내에서 체크하는 함수를 만들었습니다. isSpriteSheet) 
		 */		
		private function buildXMLLoader():void
		{
			if(_urlXmlVector.length == 0)
			{
				trace("파일 내 xml 존재 하지 않음");
				return;
			}
			sImageMaxCount+=_urlXmlVector.length;
			_loaderXML = new URLLoader(new URLRequest(_urlXmlVector[0]));
			_loaderXML.addEventListener(Event.COMPLETE, onLoadXMLComplete);
		}
		/**
		 *Note @유영선 이미지 파일 로드 
		 * 
		 */		
		private function buildLoader():void
		{
			if(_urlImageArray.length == 0 )
			{
				trace("파일 내 Image 존재 하지 않음");
				return;
			}
			
			sImageMaxCount =_urlImageArray.length; 

			
			for(var i:int = 0; i<_urlImageArray.length; ++i)
			{
				var loader:Loader = new Loader();
				loader.load(new URLRequest(_urlImageArray[i]));
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);	
			}			
		}
		
		/**
		 * 
		 * @param e
		 * Note @유영선 한 이미지가 완료 후 다른 이미지 로딩 진행
		 */		
		private function onLoadComplete(e:Event):void
		{
			var loaderInfo:LoaderInfo = LoaderInfo(e.target);
			loaderInfo.removeEventListener(Event.COMPLETE, onLoadComplete);
			
			var filename:String = decodeURIComponent(loaderInfo.url);
			var extension:Array = filename.split('/');
			
			_loadedImage.imageNameVector.push(extension[extension.length-1]);
			_loadedImage.imageDictionary[extension[extension.length-1]] = e.target.content as Bitmap;
			
			loaderInfo.loader.unload();
			loaderInfo = null;
			
			chedckedImage();
		}
		
		/**
		 * 
		 * @param e
		 * Note @유영선 XML 로딩 진행 (순서에 따라 로딩을 위해 한개씩 로딩 진행)
		 */		
		private function onLoadXMLComplete(e:Event):void
		{

			_loaderXML.removeEventListener(Event.COMPLETE, onLoadXMLComplete);
			_loaderXML = null;
		
			var extension:Array = _urlXmlVector[0].split('/');
			_loadedImage.xmlDictionary[extension[extension.length-1]] = XML(e.currentTarget.data);
			_urlXmlVector.removeAt(0);
			
			chedckedImage();
			
			if(_urlXmlVector.length != 0)
			{
				_loaderXML = new URLLoader(new URLRequest(_urlXmlVector[0]));
				_loaderXML.addEventListener(Event.COMPLETE, onLoadXMLComplete)
			}	
		}
		
		/**
		 * 
		 * Note @유영선 이미지가 모두 로딩 된 후에 Mainclass에 완료 함수 호출
		 */		
		private function chedckedImage() : void
		{
			_currentCount++;
			
			if(_currentCount == 1)
				_onProgressFunction(60)	;
				
			if(_currentCount == Math.round(sImageMaxCount*(0.6)))
				_onProgressFunction(90);
				
			if(_currentCount == sImageMaxCount) 
			{
				_onCompleteFunction();6
				_onCompleteFunction = null;
				_onProgressFunction = null;
			}
		}
		
		public function dispose() : void
		{
			// TODD @유영선 해제 필요 하면 여기다 추가
			trace("로더 클래스 해제");
			
			_loaderXML.removeEventListener(Event.COMPLETE,onLoadXMLComplete);
			
			_urlXmlVector = null;
			_urlImageArray = null;
			
			_loadedImage.dispose();
			_loadedImage = null;
		}
		/**
		 * 
		 * @return  이미지 로드가 완료 된 객체
		 *  
		 */		
		public function get loadedImage():LoadedImage{return _loadedImage;}
	}
}