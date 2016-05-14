package framework.core
{
	import framework.display.ImageTextField;
	import framework.texture.AtlasTexture;
	import framework.texture.FwTexture;

	public class FrameWorkDrawCall extends ImageTextField
	{
		private static var _sCurrent:FrameWorkDrawCall;
		
		[Embed(source="../../Number_Sprite.png")]
		public static const NUMBERIMAGE:Class;
		
		[Embed(source="../../Number_Sprite.xml", mimeType="application/octet-stream")]
		public var NUMBERXML:Class;
		public function FrameWorkDrawCall(x:int, y:int, width:int, height:int)
		{
			super(x, y, width, height, new AtlasTexture(FwTexture.fromBitmapData((new NUMBERIMAGE()).bitmapData), XML(new NUMBERXML())));
			_sCurrent = this;
		}

		public static function get sCurrent():FrameWorkDrawCall{return _sCurrent;}
	}
}