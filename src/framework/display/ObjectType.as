package framework.display
{
	final public class ObjectType
	{
		public static const PLAYER_GENERAL:String = "player";
		public static const PLAYER_COLLISION : String = "player_collision";
		public static const PLAYER_SHIELD_MODE : String = "player_shield_mode";
		
		public static const ENEMY_GENERAL : String = "enemy_general";
		public static const ENEMY_COLLISION : String = "enemy_conllision";
		public static const ENEMY_REMOVE : String = "enemy_remove";
		
		public static const PLAYER_BULLET_IDLE : String = "player_bullet_idle";
		public static const PLAYER_BULLET_MOVING : String = "player_bullet_moving";
		public static const PLAYER_BULLET_COLLISION : String = "player_bullet_collision";
		
		public static const ENEMY_BULLET_IDLE : String = "enemy_bullet_idle";
		public static const ENEMY_BULLET_MOVING : String = "enemy_bullet_moving";
		public static const ENEMY_BULLET_COLLISION : String = "enemy_bullet_collision";
		
		public static const	ITEM_IDLE : String = "item_idle";
		public static const	ITEM_COIN : String = "item_coin";
		public static const	ITEM_HEART : String = "item_heart";
		public static const	ITEM_POWER : String = "item_poser";
		public static const	ITEM_COIN_COLLISON : String = "item_coin_collison";
		public static const	ITEM_HERAT_COLLISON : String = "item_heart_collison";
		public static const	ITEM_POWER_COLLISON : String = "item_power_collison";
		
		public static const ROUND_PREV : String = "round_prev";
		public static const ROUND_GENERAL : String = "round_general";
		public static const ROUND_BOSS_WARNING : String = "round_boss_warning";
		public static const ROUND_BOSS : String = "round_boss";
		
		public static const BOSS_GENERAL:String = "boss_general";
		public static const BOSS_COLLISION:String = "boss_collision";
		public static const BOSS_DIE:String = "boss_die";
		
		public static const OBSTACLE_IDLE : String = "obstacle_general";
		public static const OBSTACLE_MOVING : String = "obstacle_moving";
		public static const OBSTACLE_COLLISON : String = "obstacle_collison";
		
		public static const BACKGROUND:String = "background";
		public static const NONE : String = "none";
		
		public function ObjectType() { throw new Error("Abstract Class"); }
	}
}