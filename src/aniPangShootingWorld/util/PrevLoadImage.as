package aniPangShootingWorld.util
{
	/**
	 * Note @유영선 로딩 전 이미지를 불러 옵니다.
	 */	
	public class PrevLoadImage
	{
		[Embed(source="../../menuView.png")]
		public static const MENUVIEW:Class;
		
		[Embed(source="../../resource_loading_gauge.png")]
		public static const LOADING_GAUGE:Class;
		
		[Embed(source="../../panda.png")]
		public static const icon:Class;
		
		public static const LOADING_XML:XML = new XML(
			<TextureAtlas imagePath="resource_loading_gauge.png">
				<SubTexture height="31" width="438" y="0" x="0" name="100"/>
				<SubTexture height="31" width="438" y="32" x="0" name="30"/>
				<SubTexture height="31" width="438" y="64" x="0" name="60"/>
				<SubTexture height="31" width="438" y="96" x="0" name="90"/>
			</TextureAtlas>
		);
	
		public function PrevLoadImage()	{ throw new Error("Abstract Class"); }
	}
}