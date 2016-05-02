package framework.scene
{
	import flash.utils.Dictionary;
	
	import framework.display.Sprite;

	public class Scene
	{
		private static var _instance : Scene;
		private static var _isConstructing : Boolean;
		private var _sceneDictionary : Dictionary = new Dictionary();
		private var _sceneNumber : Number;
		
		public function Scene()
		{
			if (!_isConstructing) throw new Error("Singleton, use Scene.instance");
		}
		
		public static function get instance():Scene
		{
			if (_instance == null)
			{
				_isConstructing = true;
				_instance = new Scene();
				_isConstructing = false;
			}
			return _instance;
		}

		public function addScene(scene : Sprite , sceneNumber : Number) : void
		{
			_sceneDictionary[sceneNumber] = scene;
		}
		
		public function get sceneDictionary():Dictionary{ return _sceneDictionary; }
	}
}