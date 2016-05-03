package framework.scene
{
	import flash.utils.Dictionary;
	
	import framework.core.Framework;
	import framework.display.Sprite;

	public class SceneManager
	{
		private static var _instance : SceneManager;
		private static var _isConstructing : Boolean;
		private var _sceneVector : Vector.<Sprite> = new Vector.<Sprite>;
		private var _sceneNumber : Number;
		
		public function SceneManager()
		{
			if (!_isConstructing) throw new Error("Singleton, use Scene.instance");
		}
		
		public static function get instance():SceneManager
		{
			if (_instance == null)
			{
				_isConstructing = true;
				_instance = new SceneManager();
				_isConstructing = false;
			}
			return _instance;
		}

		public function addScene(scene : Sprite) : void
		{
			_sceneVector.push(scene);
		}
		
		public  function sceneChange() : void
		{
			Framework.sceneStage = _sceneVector.pop();
		}
		

	}
}