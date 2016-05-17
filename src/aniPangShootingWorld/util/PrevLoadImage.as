package aniPangShootingWorld.util
{
	/**
	 * Note @유영선 로딩 전 이미지를 불러 옵니다.
	 */	
	public class PrevLoadImage
	{
		[Embed(source="../../menuView.png")]
		public static const MENUVIEW:Class;
		
		[Embed(source="../../loading_gauge.png")]
		public static const LOADING_GAUGE:Class;
		
		[Embed(source="../../panda.png")]
		public static const ICON:Class;
		
		[Embed(source="../../loading_gauge.xml", mimeType="application/octet-stream")]
		public static const LOADING_XML:Class;
	
		public function PrevLoadImage()	{ throw new Error("Abstract Class"); }
	}
}