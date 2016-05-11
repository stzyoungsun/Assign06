package framework.core
{
	import framework.animaiton.AtlasBitmapData;
	import framework.display.TextImageField;

	public class FrameWorkDrawCall extends TextImageField
	{
		private static var _sCurrent:FrameWorkDrawCall;
		
		[Embed(source="../../Number_Sprite.png")]
		public static const NUMBERIMAGE:Class;
		
		[Embed(source="../../Number_Sprite.xml", mimeType="application/octet-stream")]
		public var NUMBERXML:Class;
		public function FrameWorkDrawCall(x : int, y : int, width:int, height:int)
		{
			var numberAtlas : AtlasBitmapData = new AtlasBitmapData((new NUMBERIMAGE()), XML(new NUMBERXML()));
			super(x,y,width, height,numberAtlas);
			_sCurrent = this;
		}

		public static function get sCurrent():FrameWorkDrawCall{return _sCurrent;}
	}
}