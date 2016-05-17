package aniPangShootingWorld.enemy
{
	import aniPangShootingWorld.enemy.enemytype.EnemyMonkey;
	import aniPangShootingWorld.enemy.enemytype.EnemyPig;
	import aniPangShootingWorld.enemy.enemytype.EnemyRat;
	import aniPangShootingWorld.resourceName.AtlasResource;
	import aniPangShootingWorld.util.GameTexture;
	
	import framework.core.Framework;
	import framework.display.ObjectType;
	import framework.display.Sprite;
	import framework.gameobject.BulletManager;
	import framework.texture.TextureManager;

	/**
	 * Note @유영선 적 5명을 일렬로 세우기 위한 클래스 
	 */
	public class EnemyLine
	{
		private  var _enemyVector : Vector.<EnemyObject>;

		public function EnemyLine() {  
			
		}
		
		/**
		 * @param enemyBitmapDataVector 5명의 적의 비트맵을 담은 벡터
		 * @param enemyTypeArray 5명의 적의 Type 순서를 담은 배열
		 * Note @유영선 5명의 적을 Type 배열의 순서에 따라 일렬로 출력합니다.
		 */		
		public  function setEnemyLine(enemyTypeArray:Array, stage:Sprite) : void
		{
			//적들의 객체를 저장 할 벡터
			_enemyVector = new Vector.<EnemyObject>;
			
			//Note @유영선 한 라인 당 정해 놓은 갯수만큼 정해 놓은 TypeArray에 따라 객체를 생성하고 벡터에 저장 
			for(var i:int = 0; i < EnemyObjectUtil.MAX_LINE_COUNT; i++)
			{
				//Note @유영선 적들의 미사이를 설정하는 bulletManager 
				var bulletMgr:BulletManager;
				
				//Note @유영선 타입배열에 따라 설정 한 값으로 분기하여 객체를 생성 
				switch(enemyTypeArray[i])
				{
					case EnemyObjectUtil.ENEMY_RAT:
						_enemyVector.push(new EnemyRat(GameTexture.monsterRat, 10, stage));
						break;
					
					case EnemyObjectUtil.ENEMY_PIG:
							bulletMgr = new BulletManager(ObjectType.ENEMY_BULLET_IDLE, 1,
							TextureManager.getInstance().atlasTextureDictionary[AtlasResource.ITEM_MISSILE_METEOR].subTextures[AtlasResource.ITEM_MISSILE_METEOR_SUB_BULLET_8]);
						_enemyVector.push(new EnemyPig(GameTexture.monsterPig, 10, bulletMgr, stage));
						break;
					
					case EnemyObjectUtil.ENEMY_MONKEY:
						_enemyVector.push(new EnemyMonkey(GameTexture.monsterMoneky, 10, stage));
						break;
					
					case EnemyObjectUtil.ENEMY_DOG:
							bulletMgr = new BulletManager(ObjectType.ENEMY_BULLET_IDLE, 30,
							TextureManager.getInstance().atlasTextureDictionary[AtlasResource.ITEM_MISSILE_METEOR].subTextures[AtlasResource.ITEM_MISSILE_METEOR_SUB_BULLET_8]);
						_enemyVector.push(new EnemyMonkey(GameTexture.monsterDog, 10, stage));
						break;
						
				}
				//Note @유영선 각각의 적 객체의 크기 위치를 조절 
				_enemyVector[i].addHPBar();
				_enemyVector[i].width = Framework.viewport.width*4/25;
				_enemyVector[i].height = _enemyVector[i].width ;
				_enemyVector[i].x = Framework.viewport.width/30*(i+1) + _enemyVector[i].width*i;
				_enemyVector[i].y = 0;
			}
		}
		
		/**
		 * @return 저장된 enemy의 벡터를 반환합니다.
		 */		
		public  function get enemyVector():Vector.<EnemyObject> { return _enemyVector; }
	}
}