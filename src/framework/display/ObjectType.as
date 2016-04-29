package framework.display
{
	final public class ObjectType
	{
		public static const PLAYER:String = "player";
		public static const ENEMY:String = "enemy";
		public static const BOSS:String = "boss";
		public static const BACKGROUND:String = "background";
		public static const NONE : String = "none";
		public static const MOVIECLIP : String = "movieclip";
		
		public function ObjectType() { throw new Error("Abstract Class"); }
	}
}