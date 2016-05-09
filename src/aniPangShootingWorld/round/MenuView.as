package aniPangShootingWorld.round
{
	
	import aniPangShootingWorld.enemy.EnemyObject;
	import aniPangShootingWorld.loader.LoadedImage;
	import aniPangShootingWorld.loader.LoaderControl;
	import aniPangShootingWorld.player.PlayerState;
	import aniPangShootingWorld.util.PrevLoadImage;
	
	import framework.animaiton.AtlasBitmapData;
	import framework.animaiton.MovieClip;
	import framework.core.Framework;
	import framework.display.Image;
	import framework.display.Sprite;
	import framework.event.TouchEvent;
	import framework.event.TouchPhase;
	import framework.scene.SceneManager;
	
	/**
	 * Note @유영선 게임의 첫 화면인 메인화면 클래스 입니다. 리소스 로드 및 게임 시작 이미지를 구현 합니다.
	 */
	public class MenuView extends Sprite
	{
		//Note @유영선 리소스를 로드하는 LoaderControl 생성
		private var _loaderControl : LoaderControl;		
		
		//Note @유영선 static 변수로 로드한 이미지 들을 저장
		private  static var _sloadedImage : LoadedImage;
		
		//Note @유영선 메뉴 화면 이미지
		private var _menuImage : Image;
		//로딩 중 이미지
		private var _loadingImage : Image;
		//Note @유영선 화면을 터치해주세요 이미지
		private var _menuText : MovieClip;
		
		/**
		 * 로드 전 이미지를 불러와서 화면에 출력합니다.
		 */		
		public function MenuView()
		{
			_menuImage = new Image(0,0,(new PrevLoadImage.MENUVIEW()).bitmapData);
			addChild(_menuImage);
			_menuImage.width = Framework.viewport.width;
			_menuImage.height = Framework.viewport.height;
			
			_loadingImage = new Image(Framework.viewport.width/4,Framework.viewport.height*3/4,(new PrevLoadImage.LOADING30()).bitmapData);
			addChild(_loadingImage);
			_loadingImage.width = Framework.viewport.width/2;
			_loadingImage.height = Framework.viewport.height/20;
			
			_loaderControl = new LoaderControl(onLoaderComplete, onProgress);
			_loaderControl.resourceLoad("resource");
		}
		
		/**
		 * Note @유영선 이미지 로드 중일때 콜하는 함수
		 */		
		private function onProgress(progressCount : Number) : void
		{
			//Note @유영선 각각 상태 카운터에 따라 로딩 이미지를 설정
			if(progressCount == 60)
			{
				_loadingImage.bitmapData = (new PrevLoadImage.LOADING60()).bitmapData;
				_loadingImage.width = Framework.viewport.width/2;
				_loadingImage.height = Framework.viewport.height/20;
				Framework.current.render();
			}
			else
			{
				_loadingImage.bitmapData = (new PrevLoadImage.LOADING90()).bitmapData;
				_loadingImage.width = Framework.viewport.width/2;
				_loadingImage.height = Framework.viewport.height/20;
				Framework.current.render();
			}
			
			_loadingImage.width = Framework.viewport.width/2;
			_loadingImage.height = Framework.viewport.height/20;
		}
		
		/**
		 * Note @유영선 이미지 로드가 완료 되었을 때 콜하는 함수
		 * 
		 */		
		private function onLoaderComplete() : void
		{
			removeChild(_loadingImage);
			_loadingImage.dispose();
			_loadingImage = null;
			
			_sloadedImage = _loaderControl.loadedImage;
			
			if(!_sloadedImage.checkXml(("MenuText.xml"))) throw new Error("not found xml");
			
			_menuText = new MovieClip(new AtlasBitmapData(_sloadedImage.imageDictionary["MenuText.png"],_sloadedImage.xmlDictionary["MenuText.xml"]),
				10,Framework.viewport.width/4,Framework.viewport.height*3/4);
			addChild(_menuText);
			
			_menuText.width = Framework.viewport.width/2;;
			_menuText.height = Framework.viewport.height/10;
			_menuText.start();
			
			addEventListener(TouchEvent.TOUCH, onTouch);
			
			_loaderControl = null;
		}
		
		/**
		 * 
		 * @param event
		 * Note @유영선 화면을 터치 했을 경우 게임 시작
		 */		
		private function onTouch(event:TouchEvent):void
		{
			//Note @유영선 로드 완료 후 화면을 터치 하면 oneRound로 넘어 갑니다.
			switch(event.touch.phase)
			{
				case TouchPhase.ENDED:
					SceneManager.instance.addScene(this);
					var oneRound : OneRound = new OneRound();
					PlayerState.sPlayerHeart = 5;
					PlayerState.sPlayerPower = 0;
					PlayerState.sGoldCount = 0;
					EnemyObject.sSpeed = 1;
					SceneManager.instance.addScene(oneRound);
					SceneManager.instance.sceneChange(); 
					break;
			}
		}
		
		public override function dispose() : void
		{
			super.dispose();
			
			_sloadedImage.dispose();
			_sloadedImage = null;
			
			_menuImage.dispose();
			_menuImage = null;
			
			_menuText.stop();
			_menuText.dispose();
			_menuText = null;
		}
		
		public static function get sloadedImage():LoadedImage{return _sloadedImage;}
	}
}