package aniPangShootingWorld.enemy
{
	/**
	 * Note @유영선 적 객체의 상수값을 설정하는 클래스 입니다.
	 */	
	public class EnemyObjectUtil
	{
		public static const ENEMY_SPRITENAME_ARRAY : Array = new Array ("Rat_Sprite.png","Pig_Sprite.png");
		public static const ENEMY_XML_ARRAY : Array = new Array ("Rat_Sprite.xml","Pig_Sprite.xml");
		
		public static const ENEMY_RAT : Number = 0;
		public static const ENEMY_PIG : Number = 1;
		public static const ENEMY_CHICK : Number = 2;
		public static const ENEMY_MONKEY : Number = 3;
		public static const ENEMY_DOG : Number = 4;
		
		public static const MAX_ENEMY_TYPE : int= 4;
		
		public static var _sRedraw : Boolean = true;
		public function EnemyObjectUtil()
		{
		}
	}
}