package aniPangShootingWorld.round.Setting
{
	import framework.texture.TextureManager;
	
	import json.JSON;
	
	/** 
	 * 각각의 라운드의 세팅 값입니다.
	 * JSON 구조로 저장되어있는 XML를 로드하여 사용합니다.
	 */	
	public class RoundSetting
	{
		private static var _instance : RoundSetting;
		private static var _constructed : Boolean;
		private var _userName:String;
	
		public function RoundSetting()
		{
			if (!_constructed) throw new Error("Singleton, use Scene.instance");
		}
		
		/**
		 * RoundSetting 객체를 생성하는 메서드. 프로그램 중에 단 한번만 생성됨
		 * @return RoundSetting 객체 반환
		 */
		public static function get instance():RoundSetting
		{
			if (_instance == null)
			{
				_constructed = true;
				_instance = new RoundSetting();
				_constructed = false;
			}
			return _instance;
		}
		
		private  var _roundObjectArray : Array;
		
		public function settingRound() : void
		{
			_roundObjectArray = json.JSON.decode(TextureManager.getInstance().xmlDictionary["Round.xml"]);
		}
		
		public function get roundObject():Array{return _roundObjectArray;}
		public function set userName(value:String):void { _userName = value; }
	}
}