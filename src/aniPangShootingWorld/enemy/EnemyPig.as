
package aniPangShootingWorld.enemy
{
	import framework.animaiton.AtlasBitmapData;
	import framework.core.Framework;
	import framework.display.ObjectType;
	import framework.display.Sprite;
	import framework.gameobject.BulletManager;
	import framework.gameobject.Collision;
	
	/**
	 * Note @유영선 pig 적의 클래스 입니다. 
	 * PIG 적의 특징 : 사망시 한발의 미사일 투척
	 */
	public class EnemyPig extends EnemyObject
	{
		private var _enemyAtlas : AtlasBitmapData;
		private var _bulletManager : BulletManager;
		
		private var _stage:Sprite;
		private var _temp : int = 1;
		private var _enemyHP : Number = 1;
		
		public function EnemyPig(enemyAtlas : AtlasBitmapData, frame : Number, bulletManager : BulletManager, stage : Sprite)
		{
			//Note @유영선 적 객체의 비트맵데이터
			_enemyAtlas = enemyAtlas;
			//Note @유영선 적 들의 bulletManager
			_bulletManager = bulletManager;
			super(_enemyAtlas,frame,stage);
			//Note @유영선 적의 미사일의 시작 위치를 설정
			_bulletManager.createBullet(this.x,this.y);
			//Note @유영선 ronud의 stage
			_stage = stage;
			//Note @유영선 시간 조절을 위한 변수 (Displayobject 변수)
			_prevTime = 0;
		}
		
		/**
		 *미사일을 발사 하는 함수 입니다. 미리 생성해 놓은 미사일을 선택하여 발사 합니다. 
		 */		
		public function shooting() : void
		{
			//Note @유영선 발사 할 미사일 번호를 저장하는 변수
			var bulletNum : Number = _bulletManager.bulletNumVector.pop();
			
			//Note @유영선 선택 된 미사일을 ENEMY_BULLET_MOVING 상태로 설정
			_bulletManager.bulletVector[bulletNum].objectType = ObjectType.ENEMY_BULLET_MOVING;
			
			//Note @유영선 선택 된 미사일을 적들의 위치에 따라 재설정 그리고 크거 조절
			_bulletManager.bulletVector[bulletNum].initBullet(this.x+this.width/3,this.y,this.width/5, this.height/5);
			//Note @유영선 round의 stage에 addChild
			_stage.addChild(_bulletManager.bulletVector[bulletNum]);	
		}
		
		/**
		 * 미사일과 벽에 출동 미사일과 플레이어의 충돌을 검사하는 함수 입니다.
		 */		
		public function bulletFrame() : void
		{
			for(var i :int= 0; i < _bulletManager.totalBullet; i ++)
			{
				//Note @유영선 충돌 체크 매니져를 이용하여 벽과의 충돌과 미사일의 상태가 ENEMY_BULLET_COLLISION이면 stage에서 제거
				if((Collision.bulletToWall(_bulletManager.bulletVector[i])&& _bulletManager.bulletVector[i].objectType == ObjectType.ENEMY_BULLET_MOVING)|| _bulletManager.bulletVector[i].objectType == ObjectType.ENEMY_BULLET_COLLISION)
				{
					trace("돼지 미사일 충돌");
					_stage.removeChild(_bulletManager.bulletVector[i]);
					_bulletManager.bulletVector[i].objectType = ObjectType.PLAYER_BULLET_IDLE;
				}
				else
					//Note @유영선 충돌 상태가 아닐 경우 shootingState의 함수에 bulletstate 함수를 설정
					trace("돼지 미사일 충돌 X");
					_bulletManager.bulletVector[i].shootingState(bulletstate,i);
			}		
		}
		
		/**
		 * 
		 * @param bulletNum 미사일 번호
		 * 번호에 맞는 미사일에 상태를 설정 합니다.
		 */		
		public function bulletstate(bulletNum : Number) : void
		{
			_bulletManager.bulletVector[bulletNum].y += Framework.viewport.height/80;
		}
		
		/**
		 * 상태에 맞게 적 객체와 적 미사일을 그려주는 함수입니다.
		 */		
		public override function render():void
		{
			//Note @유영선 적이 일반 상태 일 경우 일반 상태에 맞는 비트맵으로 설정
			if(this.objectType == ObjectType.ENEMY_GENERAL)
			{
				this.showImageAt(0);
			}
			//Note @유영선 적이 충돌 상태일 경우 hp를 감소시키고 충돌 상태에 맞는 비트맵으로 설정
			else if(this.objectType == ObjectType.ENEMY_COLLISION)
			{
				this.objectType = ObjectType.ENEMY_GENERAL;
				_enemyHP--;
				this.showImageAt(1);
				//Note @유영선 적의 체력이 0 일 경우 상태를 ObjectType.COIN으로 변경
				if(_enemyHP == 0)
				{				
					shooting();
					this.objectType = ObjectType.ITEM_IDLE;
				}
				
				//Note @유영선 적 라인의 모든 적을이 죽었을 경우 _sRedraw의 상태를 true로 변경
			}
			
			if(_bulletManager.bulletVector[0].objectType != ObjectType.ENEMY_BULLET_IDLE) 
				bulletFrame();
			super.render();
		}
		
		public override function dispose():void
		{
			super.dispose();
			this.stop();
			
			if(_stage.getChildIndex(_bulletManager.bulletVector[0]) != -1)
				_stage.removeChild(_bulletManager.bulletVector[0]);
			
			_enemyAtlas.dispose();
			_enemyAtlas = null;
			_stage = null;
			_bulletManager.dispose();
			_bulletManager = null;
		}
		
	}
}