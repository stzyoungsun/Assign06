package framework.util
{
	/**
	 * pivot 설정에 쓰이는 const를 설정한 클래스 
	 * @author jihwan.ryu
	 */
	public class Align
	{
		// 객체 생성 불가
		public function Align() { throw new Error("Abstract Class"); }
		
		// 왼쪽
		public static const LEFT:String = "left";
		// 오른쪽
		public static const RIGHT:String = "right";
		// 위
		public static const TOP:String = "top";
		// 아래
		public static const BOTTOM:String = "bottom";
		// 중심
		public static const CENTER:String = "center";
	}
}