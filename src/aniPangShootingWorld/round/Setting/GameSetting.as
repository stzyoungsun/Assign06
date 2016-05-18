package aniPangShootingWorld.round.Setting
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import framework.texture.TextureManager;
	
	import json.JSON;

	public class GameSetting
	{
		private static var _instance : GameSetting;
		private static var _constructed : Boolean;
		
		private var _wingCnt : Number = 0;
		private var _goldCnt : Number = 0;
		private var _roundStateArray:Object;
		
		private var _vibration:Boolean;
		private var _bgm:Boolean;
		private var _effectSound:Boolean;
		
		public function GameSetting()
		{
			if (!_constructed) throw new Error("Singleton, use Scene.instance");
			
			_vibration = true;
			_bgm = true;
			_effectSound = true;
		}
	
		public static function get instance():GameSetting
		{
			if (_instance == null)
			{
				_constructed = true;
				_instance = new GameSetting();
				_constructed = false;
			}
			return _instance;
		}
		
		public function gameSettingInit() : void
		{
			var stream : FileStream = new FileStream();
			var path:File = File.applicationStorageDirectory.resolvePath( "data/Game.xml" );
			var xmlData : String;
			if(path.exists)
			{
				stream.open(path,FileMode.READ);
				xmlData = stream.readMultiByte(stream.bytesAvailable,"utf-8");
				if(xmlData == "null")
				{
					_roundStateArray = json.JSON.decode(TextureManager.getInstance().xmlDictionary["Game.xml"]);
				}
				else _roundStateArray = json.JSON.decode(xmlData);
			}
			else
			{
				_roundStateArray = json.JSON.decode(TextureManager.getInstance().xmlDictionary["Game.xml"]);
			}
		}
		
		public function SaveSetting() : void
		{
			var s : String = json.JSON.encode(_roundStateArray);
			
			var pattern : RegExp = /}/g;
			s = s.replace(pattern,"}\n");
			
			var path:File = File.applicationStorageDirectory.resolvePath( "data/Game.xml" );
			var fileStream : FileStream = new FileStream();
			fileStream.open(path, FileMode.WRITE);
			
			fileStream.writeUTFBytes(s);
			fileStream.close();
			
			path = null;
			fileStream = null;
		}
		
		public function get roundStateArray():Object{return _roundStateArray;}
		public function set roundStateArray(value:Object):void{_roundStateArray = value;}

		public function get vibration():Boolean { return _vibration; }
		public function set vibration(value:Boolean):void { _vibration = value; }

		public function get bgm():Boolean { return _bgm; }
		public function set bgm(value:Boolean):void { _bgm = value; }

		public function get effectSound():Boolean { return _effectSound; }
		public function set effectSound(value:Boolean):void { _effectSound = value; }
	}
}