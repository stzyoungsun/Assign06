package framework.display
{
	final public class ObjectType
	{
		public static const PLAYER_GENERAL:String = "player";
		public static const PLAYER_COLLISION : String = "player_collision";
		
		public static const ENEMY_GENERAL : String = "enemy_general";
		public static const ENEMY_COLLISION : String = "enemy_conllision";
		
		public static const PLAYER_BULLET_IDLE : String = "player_bullet_idle";
		public static const PLAYER_BULLET_MOVING : String = "player_bullet_moving";
		public static const PLAYER_BULLET_COLLISION : String = "player_bullet_collision";
		
		public static const ENEMY_BULLET_IDLE : String = "enemy_bullet_idle";
		public static const ENEMY_BULLET_MOVING : String = "enemy_bullet_moving";
		public static const ENEMY_BULLET_COLLISION : String = "enemy_bullet_collision";
		
		public static const	ITEM_IDLE : String = "item_idle";
		public static const	ITEM_COLLISON : String = "item_collison";
		
		public static const ROUND_GENERAL : String = "round_general";
		public static const ROUND_BOSS : String = "round_boss";
		
		public static const BOSS:String = "boss";
		
		public static const BACKGROUND:String = "background";
		public static const NONE : String = "none";
		
		public function ObjectType() { throw new Error("Abstract Class"); }
	}
}