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
		private static var _sBoss2:Vector.<FwTexture>;
		private static var _sBoss3:Vector.<FwTexture>;
		private static var _sBoss3Object:Vector.<FwTexture>;
		//private static var _sBOSS_3:Vector.<FwTexture>;
		
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
		
		// message_box
		private static var _sMessageBox:Vector.<FwTexture>;
		
		//selecd Window
		private static var _sSubSelectViews:Vector.<FwTexture>;
		
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
			
			_sBoss2 = new <FwTexture>[
				textureManager.atlasTextureDictionary[AtlasResource.BOSS2].subTextures[AtlasResource.BOSS2_SUB_1],
				textureManager.atlasTextureDictionary[AtlasResource.BOSS2].subTextures[AtlasResource.BOSS2_SUB_2],
				textureManager.atlasTextureDictionary[AtlasResource.BOSS2].subTextures[AtlasResource.BOSS2_SUB_3]
			];
			
			_sBoss3 = new <FwTexture>[
				textureManager.atlasTextureDictionary[AtlasResource.BOSS3].subTextures[AtlasResource.BOSS3_SUB_1],
				textureManager.atlasTextureDictionary[AtlasResource.BOSS3].subTextures[AtlasResource.BOSS3_SUB_2]
			];
			
			_sBoss3Object = new <FwTexture>[
				textureManager.atlasTextureDictionary[AtlasResource.BOSS3].subTextures[AtlasResource.BOSS3_OBJECT_1],
				textureManager.atlasTextureDictionary[AtlasResource.BOSS3].subTextures[AtlasResource.BOSS3_OBJECT_2],
				textureManager.atlasTextureDictionary[AtlasResource.BOSS3].subTextures[AtlasResource.BOSS3_OBJECT_3],
				textureManager.atlasTextureDictionary[AtlasResource.BOSS3].subTextures[AtlasResource.BOSS3_OBJECT_4],
				textureManager.atlasTextureDictionary[AtlasResource.BOSS3].subTextures[AtlasResource.BOSS3_OBJECT_5],
				textureManager.atlasTextureDictionary[AtlasResource.BOSS3].subTextures[AtlasResource.BOSS3_OBJECT_6],
				textureManager.atlasTextureDictionary[AtlasResource.BOSS3].subTextures[AtlasResource.BOSS3_OBJECT_7]
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
			
			_sMessageBox = new <FwTexture>[
				textureManager.atlasTextureDictionary[AtlasResource.MESSAGE_BOX].subTextures[AtlasResource.MESSAGE_BOX_SUB_CONTENT],
				textureManager.atlasTextureDictionary[AtlasResource.MESSAGE_BOX].subTextures[AtlasResource.MESSAGE_BOX_SUB_TITLE_BAR],
				textureManager.atlasTextureDictionary[AtlasResource.MESSAGE_BOX].subTextures[AtlasResource.MESSAGE_BOX_SUB_BUTTON_CLOSE],
				textureManager.atlasTextureDictionary[AtlasResource.MESSAGE_BOX].subTextures[AtlasResource.MESSAGE_BOX_SUB_BUTTON_1],
				textureManager.atlasTextureDictionary[AtlasResource.MESSAGE_BOX].subTextures[AtlasResource.MESSAGE_BOX_SUB_BUTTON_2],
				textureManager.atlasTextureDictionary[AtlasResource.MESSAGE_BOX].subTextures[AtlasResource.MESSAGE_BOX_SUB_BUTTON_3],
				textureManager.atlasTextureDictionary[AtlasResource.MESSAGE_BOX].subTextures[AtlasResource.MESSAGE_BOX_SUB_CHECKED],
				textureManager.atlasTextureDictionary[AtlasResource.MESSAGE_BOX].subTextures[AtlasResource.MESSAGE_BOX_SUB_UNCHECKED],
			]
			
			_sSubSelectViews = new <FwTexture>[
				textureManager.atlasTextureDictionary[AtlasResource.SELECTVIEW_SUB].subTextures[AtlasResource.SELECTVIEW_SUB_COINWINDOW],
				textureManager.atlasTextureDictionary[AtlasResource.SELECTVIEW_SUB].subTextures[AtlasResource.SELECTVIEW_SUB_PASS],
				textureManager.atlasTextureDictionary[AtlasResource.SELECTVIEW_SUB].subTextures[AtlasResource.SELECTVIEW_SUB_PASSED1],
				textureManager.atlasTextureDictionary[AtlasResource.SELECTVIEW_SUB].subTextures[AtlasResource.SELECTVIEW_SUB_PASSED2],
				textureManager.atlasTextureDictionary[AtlasResource.SELECTVIEW_SUB].subTextures[AtlasResource.SELECTVIEW_SUB_PASSED3],
				textureManager.atlasTextureDictionary[AtlasResource.SELECTVIEW_SUB].subTextures[AtlasResource.SELECTVIEW_SUB_PASSING],
				textureManager.atlasTextureDictionary[AtlasResource.SELECTVIEW_SUB].subTextures[AtlasResource.SELECTVIEW_SUB_PASSYET],
				textureManager.atlasTextureDictionary[AtlasResource.SELECTVIEW_SUB].subTextures[AtlasResource.SELECTVIEW_SUB_POINT],
				textureManager.atlasTextureDictionary[AtlasResource.SELECTVIEW_SUB].subTextures[AtlasResource.SELECTVIEW_SUB_COIN],
				textureManager.atlasTextureDictionary[AtlasResource.SELECTVIEW_SUB].subTextures[AtlasResource.SELECTVIEW_SUB_WING],
				textureManager.atlasTextureDictionary[AtlasResource.SELECTVIEW_SUB].subTextures[AtlasResource.SELECTVIEW_SUB_CONFIGURE]
			]
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
		public static function get boss2():Vector.<FwTexture> { return _sBoss2; }
		public static function get boss3():Vector.<FwTexture> { return _sBoss3; }
		public static function get boss3Object():Vector.<FwTexture> { return _sBoss3Object; }
		public static function get meteor():Vector.<FwTexture> { return _sMeteor; }
		public static function get coin():Vector.<FwTexture> { return _sCoin; }
		public static function get power():Vector.<FwTexture> { return _sPower; }
		public static function get heart():Vector.<FwTexture> { return _sHeart; }
		public static function get readyNumber():Vector.<FwTexture> { return _sReadyNumber; }
		public static function get pressTouch():Vector.<FwTexture> { return _sPressTouch; }

		/**
		 * Single Texture
		 */
		/**
		 * <br/>[0]:ITEM_MISSILE_METEOR_SUB_BULLET_1<br/>
		 * [1]:ITEM_MISSILE_METEOR_SUB_BULLET_2<br/>
		 * [2]:ITEM_MISSILE_METEOR_SUB_BULLET_3<br/>
		 * [3]:ITEM_MISSILE_METEOR_SUB_BULLET_4<br/>
		 * [4]:ITEM_MISSILE_METEOR_SUB_BULLET_5<br/>
		 * [5]:ITEM_MISSILE_METEOR_SUB_BULLET_6<br/>
		 * [6]:ITEM_MISSILE_METEOR_SUB_BULLET_7<br/>
		 * [7]:ITEM_MISSILE_METEOR_SUB_BULLET_8<br/>
		 * [8]:ITEM_MISSILE_METEOR_SUB_BULLET_BOSS
		 */
		public static function get bullet():Vector.<FwTexture> { return _sBullet; }
		
		/**
		 * <br/>[0]:BOSS_SUB_PER_10<br/>
		 * [1]:BOSS_SUB_PER_20<br/>
		 * [2]:BOSS_SUB_PER_30<br/>
		 * [3]:BOSS_SUB_PER_40<br/>
		 * [4]:BOSS_SUB_PER_50<br/>
		 * [5]:BOSS_SUB_PER_60<br/>
		 * [6]:BOSS_SUB_PER_70<br/>
		 * [7]:BOSS_SUB_PER_80<br/>
		 * [8]:BOSS_SUB_PER_90<br/>
		 * [9]:BOSS_SUB_PER_100
		 */
		public static function get bossHpBar():Vector.<FwTexture> { return _sBossHpBar; }
		public static function get meteorLine():FwTexture { return _sMeteorLine; }
		public static function get meteorWarning():FwTexture { return _sMeteorWarning; }
		
		/**
		 * <br/>[0]:PLAYER_STATE_SUB_HEART_1<br/>
		 * [1]:PLAYER_STATE_SUB_HEART_2<br/>
		 * [2]:PLAYER_STATE_SUB_HEART_4<br/>
		 * [3]:PLAYER_STATE_SUB_HEART_6<br/>
		 * [4]:PLAYER_STATE_SUB_HEART_8<br/>
		 * [5]:PLAYER_STATE_SUB_HEART_10
		 */
		public static function get playerHeart():Vector.<FwTexture> { return _sPlayerHeart; }
		
		/**
		 * <br/>[0]:PLAYER_STATE_SUB_POWER_1<br/>
		 * [1]:PLAYER_STATE_SUB_POWER_2<br/>
		 * [2]:PLAYER_STATE_SUB_POWER_4<br/>
		 * [3]:PLAYER_STATE_SUB_POWER_6<br/>
		 * [4]:PLAYER_STATE_SUB_POWER_8<br/>
		 * [5]:PLAYER_STATE_SUB_POWER_10
		 */
		public static function get playerPower():Vector.<FwTexture> { return _sPlayerPower; }
		public static function get playerState():FwTexture { return _sPlayerState; }
		public static function get nextButton():FwTexture { return _sNextButton; }
		public static function get roundResult():FwTexture { return _sRoundResult; }
		
		/**
		 * <br/>[0]:MESSAGE_BOX_SUB_CONTENT<br/>
		 * [1]:MESSAGE_BOX_SUB_TITLE_BAR<br/>
		 * [2]:MESSAGE_BOX_SUB_BUTTON_CLOSE<br/>
		 * [3]:MESSAGE_BOX_SUB_BUTTON_1<br/>
		 * [4]:MESSAGE_BOX_SUB_BUTTON_2<br/>
		 * [5]:MESSAGE_BOX_SUB_BUTTON_3<br/>
		 * [6]:MESSAGE_BOX_SUB_CHECKED<br/>
		 * [7]:MESSAGE_BOX_SUB_UNCHECKED
		 */
		public static function get messageBox():Vector.<FwTexture> { return _sMessageBox; }
		
		/**
		 * <br/>[0]:SELECTVIEW_SUB_COINWINDOW<br/>
		 * [1]:SELECTVIEW_SUB_PASS<br/>
		 * [2]:SELECTVIEW_SUB_PASSED1<br/>
		 * [3]:SELECTVIEW_SUB_PASSED2<br/>
		 * [4]:SELECTVIEW_SUB_PASSED3<br/>
		 * [5]:SELECTVIEW_SUB_PASSING<br/>
		 * [6]:SELECTVIEW_SUB_PASSYET<br/>
		 * [7]:SELECTVIEW_SUB_POINT<br/>
		 * [8]:SELECTVIEW_SUB_COIN<br/>
		 * [9]:SELECTVIEW_SUB_WING<br/>
		 * [10]:SELECTVIEW_SUB_CONFIGURE
		 */
		public static function get subSelectViews():Vector.<FwTexture> { return _sSubSelectViews;}
	}
}