package framework.scene
{
	import framework.core.Framework;

	public class SceneManager
	{
		public function SceneManager()
		{
		}
		
		public static function sceneChange(sceneNumber : Number) : void
		{
			Framework.sceneStage = Scene.instance.sceneDictionary[sceneNumber];
		}
	}
}