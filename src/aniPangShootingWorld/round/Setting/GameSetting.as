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
		
		public function GameSetting()
		{
			if (!_constructed) throw new Error("Singleton, use Scene.instance");
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
		
		private var _wingCnt : Number = 0;
		private var _goldCnt : Number = 0;
		
		private var _roundStateArray : Object ;
		
		public function gameSettingInit() : void
		{
			_roundStateArray = json.JSON.decode(TextureManager.getInstance().xmlDictionary["Game.xml"]);
		}
		
		public function SaveSetting() : void
		{
			var s : String = json.JSON.encode(_roundStateArray);
			var pattern : RegExp = /}/g;
			s = s.replace(pattern,"}\n");
			
			var path : File = new File(File.applicationDirectory.nativePath).resolvePath("./../src/resource/SettingXML/Game.xml");
			var fileStream : FileStream = new FileStream();
			fileStream.open(path, FileMode.WRITE);
			
			fileStream.writeUTFBytes(s);
			fileStream.close();
			
			path = null;
			fileStream = null;
		}
		
		public function get roundStateArray():Object{return _roundStateArray;}
		public function set roundStateArray(value:Object):void{_roundStateArray = value;}
	}
}