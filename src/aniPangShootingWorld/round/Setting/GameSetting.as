package aniPangShootingWorld.round.Setting
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import framework.texture.TextureManager;
	
	import json.JSON;

	/**
	 * 전체 적인 게임을 세팅하는 클래스입니다.
	 * JSON을 파싱하여 저장 및 로드를 합니다.
	 */	
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
		private var _pause:Boolean;
		private var _userName:String ="";
		
		public function GameSetting()
		{
			if (!_constructed) throw new Error("Singleton, use Scene.instance");
			_pause = false;
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
		
		/** 
		 * 세팅 값을 파일 로드 하여 object 객체에 저장합니다.
		 */		
		public function gameSettingInit() : void
		{
			var stream : FileStream = new FileStream();
			var path:File = File.applicationStorageDirectory.resolvePath( "data/" + _userName + "_Game.xml" );
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
			
			_vibration = true;
			_bgm = true;
			_effectSound = true;
		}
		
		/** 
		 * object 객체를 파일에 JSON 형태로 저장합니다.
		 */		
		public function saveSetting() : void
		{
			if(_userName == "") return;
			
			var save : String = json.JSON.encode(_roundStateArray);
			
			var pattern : RegExp = /}/g;
			save = save.replace(pattern,"}\n");
			
			var path:File = File.applicationStorageDirectory.resolvePath("data/" + _userName + "_Game.xml" );
			var fileStream : FileStream = new FileStream();
			fileStream.open(path, FileMode.WRITE);
			fileStream.writeUTFBytes(save);
			
			path = File.applicationStorageDirectory.resolvePath("data/current_user.data");
			fileStream.open(path, FileMode.WRITE);
			fileStream.writeUTFBytes(_userName);
			fileStream.close();
		}
		
		public function get roundStateArray():Object{return _roundStateArray;}
		public function set roundStateArray(value:Object):void{_roundStateArray = value;}

		public function get vibration():Boolean { return _vibration; }
		public function set vibration(value:Boolean):void { _vibration = value; }

		public function get bgm():Boolean { return _bgm; }
		public function set bgm(value:Boolean):void { _bgm = value; }

		public function get effectSound():Boolean { return _effectSound; }
		public function set effectSound(value:Boolean):void { _effectSound = value; }

		public function get pause():Boolean { return _pause; }
		public function set pause(value:Boolean):void { _pause = value; }

		public function set userName(value:String):void { _userName = value; }
	}
}