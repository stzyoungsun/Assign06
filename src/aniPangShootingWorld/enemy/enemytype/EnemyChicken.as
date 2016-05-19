package aniPangShootingWorld.enemy.enemytype
{
	import aniPangShootingWorld.enemy.EnemyObject;
	import aniPangShootingWorld.enemy.EnemyObjectUtil;
	import aniPangShootingWorld.util.GameTexture;
	import aniPangShootingWorld.util.UtilFunction;
	
	import framework.core.Framework;
	import framework.display.Sprite;
	import framework.texture.FwTexture;

	public class EnemyChicken extends EnemyObject
	{
		private var _stage : Sprite;
		private var _chickenVector : Vector.<EnemyChicken> = new Vector.<EnemyChicken>;
		private var _subChickenVector : Vector.<EnemyObject> = new Vector.<EnemyObject>;
		
		public function EnemyChicken(textureVector:Vector.<FwTexture>, frame:Number, stage:Sprite)
		{
			super(textureVector, frame, stage);
			_stage = stage;
			_prevTime = 0;
			
			_pEnemyType = EnemyObjectUtil.ENEMY_CHICK;
			
			maxHP = 2;
		}
		
		public function devide() : void
		{
			var randomx : Number = 0;
			var randomy : Number = 0;
			
			var randomCnt : int = UtilFunction.random(0,2,1);
			for(var i : int =0 ; i < randomCnt ; ++i)
			{
				randomx = UtilFunction.random(0,Framework.viewport.width - this.width/2, 1);
				randomy = UtilFunction.random(0 ,this.y, 1);
				_subChickenVector.push(new EnemyChicken(GameTexture.monsterChick, 10, _stage)); 
				_subChickenVector[i].addHPBar();
				
				_subChickenVector[i].x = randomx;
				_subChickenVector[i].y = randomy;
				
				_subChickenVector[i].width = Framework.viewport.width*4/25;
				_subChickenVector[i].height = Framework.viewport.width*4/25;
				
				_stage.addChild(_subChickenVector[i]);
			}	
		}
		
		public override function dispose():void
		{
			super.dispose();
			
			for(var i : int =0; i < _subChickenVector.length; i++)
			{
				_subChickenVector[i].deleteHPBar();
				_stage.removeChild(_subChickenVector[i], true);
			}
			_subChickenVector = null;
		}
	}
}