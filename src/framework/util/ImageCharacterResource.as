package framework.util
{
	public class ImageCharacterResource
	{
		[Embed(source="../../Number_Sprite.png")]
		public static const NUMBER_IMAGE:Class;
		
		[Embed(source="../../Number_Sprite.xml", mimeType="application/octet-stream")]
		public static const NUMBER_XML:Class;
	}
}