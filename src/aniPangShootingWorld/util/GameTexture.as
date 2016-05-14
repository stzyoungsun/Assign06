package aniPangShootingWorld.util
{
	import aniPangShootingWorld.resourceName.AtlasResource;
	
	import framework.texture.FwTexture;
	import framework.texture.TextureManager;

	public class GameTexture
	{
		private static var _sCreated:Boolean = false;
		
		/**
		 * Animation Texture
		 */
		
		// character
		private static var _sPlayer:Vector.<FwTexture>;
		private static var _sMonsterRat:Vector.<FwTexture>;
		private static var _sMonsterPig:Vector.<FwTexture>;
		private static var _sMonsterDog:Vector.<FwTexture>;
		private static var _sMonsterMoneky:Vector.<FwTexture>;
		private static var _sMonsterChick:Vector.<FwTexture>;
		
		// boss
		private static var _sBoss1:Vector.<FwTexture>;
//		private static var _sBOSS_2:Vector.<FwTexture>;
//		private static var _sBOSS_3:Vector.<FwTexture>;
		
		// item_missile_meteor
		private static var _sMeteor:Vector.<FwTexture>;
		private static var _sCoin:Vector.<FwTexture>;
		private static var _sPower:Vector.<FwTexture>;
		private static var _sHeart:Vector.<FwTexture>;
		
		// ready_number
		private static var _sReadyNumber:Vector.<FwTexture>;
		
		// press_touch
		private static var _sPressTouch:Vector.<FwTexture>;
		
		/**
		 * Single Texture
		 */
		// boss
		private static var _sBossHpBar:Vector.<FwTexture>;
		
		// missile_item_meteor
		private static var _sBullet:Vector.<FwTexture>;
		private static var _sMeteorLine:FwTexture;
		private static var _sMeteorWarning:FwTexture;
		
		// player_state
		private static var _sPlayerHeart:Vector.<FwTexture>;
		private static var _sPlayerPower:Vector.<FwTexture>;
		private static var _sPlayerState:FwTexture;
		
		// result
		private static var _sNextButton:FwTexture;
		private static var _sRoundResult:FwTexture;
		
		public function GameTexture() { throw new Error("Abstract Class"); }

		public static function createGameTexture():void
		{
			if(_sCreated)
			{
				return;
			}
			
			var textureManager:TextureManager = TextureManager.getInstance();
			
			/**
			 * Animation Textures
			 */
			_sPlayer = new <FwTexture>[
				textureManager.atlasTextureDictionary[AtlasResource.CHARACTER].subTextures[AtlasResource.CHARACTER_SUB_MAO_1],
				textureManager.atlasTextureDictionary[AtlasResource.CHARACTER].subTextures[AtlasResource.CHARACTER_SUB_MAO_2],
				textureManager.atlasTextureDictionary[AtlasResource.CHARACTER].subTextures[AtlasResource.CHARACTER_SUB_MAO_3],
				textureManager.atlasTextureDictionary[AtlasResource.CHARACTER].subTextures[AtlasResource.CHARACTER_SUB_MAO_4]
			];
			
			_sMonsterRat = new <FwTexture>[
				textureManager.atlasTextureDictionary[AtlasResource.CHARACTER].subTextures[AtlasResource.CHARACTER_SUB_RAT1],
				textureManager.atlasTextureDictionary[AtlasResource.CHARACTER].subTextures[AtlasResource.CHARACTER_SUB_RAT2]
			];
			
			_sMonsterPig = new <FwTexture>[
				textureManager.atlasTextureDictionary[AtlasResource.CHARACTER].subTextures[AtlasResource.CHARACTER_SUB_PIG1],
				textureManager.atlasTextureDictionary[AtlasResource.CHARACTER].subTextures[AtlasResource.CHARACTER_SUB_PIG2]
			];
			
			_sMonsterDog = new <FwTexture>[
				textureManager.atlasTextureDictionary[AtlasResource.CHARACTER].subTextures[AtlasResource.CHARACTER_SUB_DOG1],
				textureManager.atlasTextureDictionary[AtlasResource.CHARACTER].subTextures[AtlasResource.CHARACTER_SUB_DOG2]
			];
			
			_sMonsterMoneky = new <FwTexture>[
				textureManager.atlasTextureDictionary[AtlasResource.CHARACTER].subTextures[AtlasResource.CHARACTER_SUB_MONKEY1],
				textureManager.atlasTextureDictionary[AtlasResource.CHARACTER].subTextures[AtlasResource.CHARACTER_SUB_MONKEY2]
			];
			
			_sMonsterChick = new <FwTexture>[
				textureManager.atlasTextureDictionary[AtlasResource.CHARACTER].subTextures[AtlasResource.CHARACTER_SUB_CHICK_1],
				textureManager.atlasTextureDictionary[AtlasResource.CHARACTER].subTextures[AtlasResource.CHARACTER_SUB_CHICK_2]
			];
			
			_sBoss1 = new <FwTexture>[
				textureManager.atlasTextureDictionary[AtlasResource.BOSS].subTextures[AtlasResource.BOSS_SUB_1],
				textureManager.atlasTextureDictionary[AtlasResource.BOSS].subTextures[AtlasResource.BOSS_SUB_2],
				textureManager.atlasTextureDictionary[AtlasResource.BOSS].subTextures[AtlasResource.BOSS_SUB_3]
			];
			
			_sMeteor = new <FwTexture>[
				textureManager.atlasTextureDictionary[AtlasResource.ITEM_MISSILE_METEOR].subTextures[AtlasResource.ITEM_MISSILE_METEOR_SUB_METEOR_1],
				textureManager.atlasTextureDictionary[AtlasResource.ITEM_MISSILE_METEOR].subTextures[AtlasResource.ITEM_MISSILE_METEOR_SUB_METEOR_2],
				textureManager.atlasTextureDictionary[AtlasResource.ITEM_MISSILE_METEOR].subTextures[AtlasResource.ITEM_MISSILE_METEOR_SUB_METEOR_3],
				textureManager.atlasTextureDictionary[AtlasResource.ITEM_MISSILE_METEOR].subTextures[AtlasResource.ITEM_MISSILE_METEOR_SUB_METEOR_4]
			];
			
			_sCoin = new <FwTexture>[
				textureManager.atlasTextureDictionary[AtlasResource.ITEM_MISSILE_METEOR].subTextures[AtlasResource.ITEM_MISSILE_METEOR_SUB_COIN_1],
				textureManager.atlasTextureDictionary[AtlasResource.ITEM_MISSILE_METEOR].subTextures[AtlasResource.ITEM_MISSILE_METEOR_SUB_COIN_2],
			];
			
			_sPower = new <FwTexture>[
				textureManager.atlasTextureDictionary[AtlasResource.ITEM_MISSILE_METEOR].subTextures[AtlasResource.ITEM_MISSILE_METEOR_SUB_JELLY_1],
				textureManager.atlasTextureDictionary[AtlasResource.ITEM_MISSILE_METEOR].subTextures[AtlasResource.ITEM_MISSILE_METEOR_SUB_JELLY_2],
				textureManager.atlasTextureDictionary[AtlasResource.ITEM_MISSILE_METEOR].subTextures[AtlasResource.ITEM_MISSILE_METEOR_SUB_JELLY_3],
				textureManager.atlasTextureDictionary[AtlasResource.ITEM_MISSILE_METEOR].subTextures[AtlasResource.ITEM_MISSILE_METEOR_SUB_JELLY_4]
			];
			
			_sHeart = new <FwTexture>[
				textureManager.atlasTextureDictionary[AtlasResource.ITEM_MISSILE_METEOR].subTextures[AtlasResource.ITEM_MISSILE_METEOR_SUB_HEART_1],
				textureManager.atlasTextureDictionary[AtlasResource.ITEM_MISSILE_METEOR].subTextures[AtlasResource.ITEM_MISSILE_METEOR_SUB_HEART_2]
			];
			
			_sReadyNumber = new <FwTexture>[
				textureManager.atlasTextureDictionary[AtlasResource.READY_NUMBER].subTextures[AtlasResource.READY_NUMBER_SUB_READY_1],
				textureManager.atlasTextureDictionary[AtlasResource.READY_NUMBER].subTextures[AtlasResource.READY_NUMBER_SUB_READY_2],
				textureManager.atlasTextureDictionary[AtlasResource.READY_NUMBER].subTextures[AtlasResource.READY_NUMBER_SUB_READY_3],
				textureManager.atlasTextureDictionary[AtlasResource.READY_NUMBER].subTextures[AtlasResource.READY_NUMBER_SUB_START],
			];
			
			_sPressTouch = new <FwTexture>[
				textureManager.atlasTextureDictionary[AtlasResource.PRESS_TOUCH].subTextures[AtlasResource.PRESS_TOUCH_SUB_1],
				textureManager.atlasTextureDictionary[AtlasResource.PRESS_TOUCH].subTextures[AtlasResource.PRESS_TOUCH_SUB_2],
			];
			
			/**
			 * Single Textures
			 */
			_sBossHpBar = new <FwTexture>[
				textureManager.atlasTextureDictionary[AtlasResource.BOSS].subTextures[AtlasResource.BOSS_SUB_PER_10],
				textureManager.atlasTextureDictionary[AtlasResource.BOSS].subTextures[AtlasResource.BOSS_SUB_PER_20],
				textureManager.atlasTextureDictionary[AtlasResource.BOSS].subTextures[AtlasResource.BOSS_SUB_PER_30],
				textureManager.atlasTextureDictionary[AtlasResource.BOSS].subTextures[AtlasResource.BOSS_SUB_PER_40],
				textureManager.atlasTextureDictionary[AtlasResource.BOSS].subTextures[AtlasResource.BOSS_SUB_PER_50],
				textureManager.atlasTextureDictionary[AtlasResource.BOSS].subTextures[AtlasResource.BOSS_SUB_PER_60],
				textureManager.atlasTextureDictionary[AtlasResource.BOSS].subTextures[AtlasResource.BOSS_SUB_PER_70],
				textureManager.atlasTextureDictionary[AtlasResource.BOSS].subTextures[AtlasResource.BOSS_SUB_PER_80],
				textureManager.atlasTextureDictionary[AtlasResource.BOSS].subTextures[AtlasResource.BOSS_SUB_PER_90],
				textureManager.atlasTextureDictionary[AtlasResource.BOSS].subTextures[AtlasResource.BOSS_SUB_PER_100],
			];
			
			_sBullet = new <FwTexture>[
				textureManager.atlasTextureDictionary[AtlasResource.ITEM_MISSILE_METEOR].subTextures[AtlasResource.ITEM_MISSILE_METEOR_SUB_BULLET_1],
				textureManager.atlasTextureDictionary[AtlasResource.ITEM_MISSILE_METEOR].subTextures[AtlasResource.ITEM_MISSILE_METEOR_SUB_BULLET_2],
				textureManager.atlasTextureDictionary[AtlasResource.ITEM_MISSILE_METEOR].subTextures[AtlasResource.ITEM_MISSILE_METEOR_SUB_BULLET_3],
				textureManager.atlasTextureDictionary[AtlasResource.ITEM_MISSILE_METEOR].subTextures[AtlasResource.ITEM_MISSILE_METEOR_SUB_BULLET_4],
				textureManager.atlasTextureDictionary[AtlasResource.ITEM_MISSILE_METEOR].subTextures[AtlasResource.ITEM_MISSILE_METEOR_SUB_BULLET_5],
				textureManager.atlasTextureDictionary[AtlasResource.ITEM_MISSILE_METEOR].subTextures[AtlasResource.ITEM_MISSILE_METEOR_SUB_BULLET_6],
				textureManager.atlasTextureDictionary[AtlasResource.ITEM_MISSILE_METEOR].subTextures[AtlasResource.ITEM_MISSILE_METEOR_SUB_BULLET_7],
				textureManager.atlasTextureDictionary[AtlasResource.ITEM_MISSILE_METEOR].subTextures[AtlasResource.ITEM_MISSILE_METEOR_SUB_BULLET_8],
				textureManager.atlasTextureDictionary[AtlasResource.ITEM_MISSILE_METEOR].subTextures[AtlasResource.ITEM_MISSILE_METEOR_SUB_BULLET_BOSS]
			];
			
			_sMeteorLine = textureManager.atlasTextureDictionary[AtlasResource.ITEM_MISSILE_METEOR].subTextures[AtlasResource.ITEM_MISSILE_METEOR_SUB_METEOR_LINE];
			
			_sMeteorWarning = textureManager.atlasTextureDictionary[AtlasResource.ITEM_MISSILE_METEOR].subTextures[AtlasResource.ITEM_MISSILE_METEOR_SUB_METEOR_WARNING];
			
			_sPlayerHeart = new <FwTexture>[
				textureManager.atlasTextureDictionary[AtlasResource.PLAYER_STATE].subTextures[AtlasResource.PLAYER_STATE_SUB_HEART_1],
				textureManager.atlasTextureDictionary[AtlasResource.PLAYER_STATE].subTextures[AtlasResource.PLAYER_STATE_SUB_HEART_2],
				textureManager.atlasTextureDictionary[AtlasResource.PLAYER_STATE].subTextures[AtlasResource.PLAYER_STATE_SUB_HEART_4],
				textureManager.atlasTextureDictionary[AtlasResource.PLAYER_STATE].subTextures[AtlasResource.PLAYER_STATE_SUB_HEART_6],
				textureManager.atlasTextureDictionary[AtlasResource.PLAYER_STATE].subTextures[AtlasResource.PLAYER_STATE_SUB_HEART_8],
				textureManager.atlasTextureDictionary[AtlasResource.PLAYER_STATE].subTextures[AtlasResource.PLAYER_STATE_SUB_HEART_10],
			];
			
			_sPlayerPower = new <FwTexture>[
				textureManager.atlasTextureDictionary[AtlasResource.PLAYER_STATE].subTextures[AtlasResource.PLAYER_STATE_SUB_POWER_1],
				textureManager.atlasTextureDictionary[AtlasResource.PLAYER_STATE].subTextures[AtlasResource.PLAYER_STATE_SUB_POWER_2],
				textureManager.atlasTextureDictionary[AtlasResource.PLAYER_STATE].subTextures[AtlasResource.PLAYER_STATE_SUB_POWER_4],
				textureManager.atlasTextureDictionary[AtlasResource.PLAYER_STATE].subTextures[AtlasResource.PLAYER_STATE_SUB_POWER_6],
				textureManager.atlasTextureDictionary[AtlasResource.PLAYER_STATE].subTextures[AtlasResource.PLAYER_STATE_SUB_POWER_8],
				textureManager.atlasTextureDictionary[AtlasResource.PLAYER_STATE].subTextures[AtlasResource.PLAYER_STATE_SUB_POWER_10],
			];
			
			_sPlayerState = textureManager.atlasTextureDictionary[AtlasResource.PLAYER_STATE].subTextures[AtlasResource.PLAYER_STATE_SUB_GAUGE_STATE];
			
			_sNextButton = textureManager.atlasTextureDictionary[AtlasResource.RESULT].subTextures[AtlasResource.RESULT_SUB_NEXT_BUTTON];
			
			_sRoundResult = textureManager.atlasTextureDictionary[AtlasResource.RESULT].subTextures[AtlasResource.RESULT_SUB_ROUND_RESULT];
			
			_sCreated = true;
		}

		/**
		 * Animation Texture
		 */
		public static function get player():Vector.<FwTexture> { return _sPlayer; }
		public static function get monsterRat():Vector.<FwTexture> { return _sMonsterRat; }
		public static function get monsterPig():Vector.<FwTexture> { return _sMonsterPig; }
		public static function get monsterDog():Vector.<FwTexture> { return _sMonsterDog; }
		public static function get monsterMoneky():Vector.<FwTexture> { return _sMonsterMoneky; }
		public static function get monsterChick():Vector.<FwTexture> { return _sMonsterChick; }
		public static function get boss1():Vector.<FwTexture> { return _sBoss1; }
		public static function get meteor():Vector.<FwTexture> { return _sMeteor; }
		public static function get coin():Vector.<FwTexture> { return _sCoin; }
		public static function get power():Vector.<FwTexture> { return _sPower; }
		public static function get heart():Vector.<FwTexture> { return _sHeart; }
		public static function get readyNumber():Vector.<FwTexture> { return _sReadyNumber; }
		public static function get pressTouch():Vector.<FwTexture> { return _sPressTouch; }

		/**
		 * Single Texture
		 */
		public static function get bullet():Vector.<FwTexture> { return _sBullet; }
		public static function get bossHpBar():Vector.<FwTexture> { return _sBossHpBar; }
		public static function get meteorLine():FwTexture { return _sMeteorLine; }
		public static function get meteorWarning():FwTexture { return _sMeteorWarning; }
		public static function get playerHeart():Vector.<FwTexture> { return _sPlayerHeart; }
		public static function get playerPower():Vector.<FwTexture> { return _sPlayerPower; }
		public static function get playerState():FwTexture { return _sPlayerState; }
		public static function get nextButton():FwTexture { return _sNextButton; }
		public static function get roundResult():FwTexture { return _sRoundResult; }
	}
}