
package aniPangShootingWorld.util
{
	import aniPangShootingWorld.round.MenuView;
	
	import json.JSON;
	
	public class RoundSetting
	{
		private static var _instance : RoundSetting;
		private static var _constructed : Boolean;
		private  var _roundObjectArray : Array;
		
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
		
		public function settingRound() : void
		{
			_roundObjectArray = json.JSON.decode(MenuView.sloadedImage.xmlDictionary["Round.xml"]);
			
			for (var key:Object in _roundObjectArray) {
				trace(_roundObjectArray[key].roundnum) ;
				trace(_roundObjectArray[key].background) ;      
			}
		}
		
		public function get roundObject():Array{return _roundObjectArray;}
	}
}