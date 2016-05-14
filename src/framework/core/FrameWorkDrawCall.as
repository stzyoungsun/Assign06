package framework.core
{
	import framework.display.ImageTextField;
	import framework.texture.AtlasTexture;

	public class FrameWorkDrawCall extends ImageTextField
	{
		private static var _sCurrent:FrameWorkDrawCall;
		
		public function FrameWorkDrawCall(x:int, y:int, width:int, height:int, atlasTexture:AtlasTexture = null)
		{
			super(x, y, width, height, atlasTexture);
			_sCurrent = this;
		}

		public static function get sCurrent():FrameWorkDrawCall{return _sCurrent;}
	}
}