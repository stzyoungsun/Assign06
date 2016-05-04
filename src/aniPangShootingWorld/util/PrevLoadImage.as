package aniPangShootingWorld.util
{
	/**
	 * Note @유영선 로딩 전 이미지를 불러 옵니다.
	 */	
	public class PrevLoadImage
	{
		[Embed(source="../../menuView.png")]
		public static const MENUVIEW:Class;
		
		[Embed(source="../../loading1.png")]
		public static const LOADING30:Class;
		
		[Embed(source="../../loading2.png")]
		public static const LOADING60:Class;
		
		[Embed(source="../../loading3.png")]
		public static const LOADING90:Class;
		
		[Embed(source="../../loading4.png")]
		public static const LOADING100:Class;
	
		public function PrevLoadImage()
		{
		}
	}
}