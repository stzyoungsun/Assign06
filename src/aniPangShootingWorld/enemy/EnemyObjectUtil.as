package aniPangShootingWorld.enemy
{
	/**
	 * Note @유영선 적 객체의 상수값을 설정하는 클래스 입니다.
	 */	
	public class EnemyObjectUtil
	{
		public static const ENEMY_RAT : Number = 0;
		public static const ENEMY_PIG : Number = 1;
		public static const ENEMY_MONKEY : Number = 2;
		public static const ENEMY_DOG : Number = 3;
		public static const ENEMY_CHICK : Number = 4;
		
		
		public static const MAX_LINE_COUNT : int = 5;
		public static const MAX_ENEMY_TYPE : int = 5;
		
		public function EnemyObjectUtil() { throw new Error("Abstract Class"); }
	}
}