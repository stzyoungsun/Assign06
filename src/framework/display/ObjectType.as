package framework.display
{
	final public class ObjectType
	{
		public static const PLAYER_GENERAL:String = "player";
		public static const PLAYER_COLLISION : String = "player_collision";
		
		public static const ENEMY_GENERAL : String = "enemy_general";
		public static const ENEMY_COLLISION : String = "enemy_conllision";
		
		public static const PLAYER_BULLET_MOVING : String = "player_bullet_moving";
		public static const PLAYER_BULLET_COLLISION : String = "player_bullet_collision";
		
		public static const COIN : String = "coin";
		public static const STAR : String = "star";
		public static const HEART : String = "heart";
		
		public static const BOSS:String = "boss";
		public static const BACKGROUND:String = "background";
		public static const NONE : String = "none";
		
		public static const ENEMY_BULLET : String = "enemy_bullet";
		public function ObjectType() { throw new Error("Abstract Class"); }
	}
}