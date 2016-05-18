package aniPangShootingWorld.round
{
	import aniPangShootingWorld.loader.ResourceLoader;
	import aniPangShootingWorld.round.Setting.GameSetting;
	import aniPangShootingWorld.round.Setting.RoundSetting;
	import aniPangShootingWorld.util.GameTexture;
	import aniPangShootingWorld.util.PrevLoadImage;
	
	import framework.animaiton.MovieClip;
	import framework.core.Framework;
	import framework.display.Image;
	import framework.display.Sprite;
	import framework.event.TouchEvent;
	import framework.event.TouchPhase;
	import framework.scene.SceneManager;
	import framework.texture.AtlasTexture;
	import framework.texture.FwTexture;
	
	/**
	 * Note @유영선 게임의 첫 화면인 메인화면 클래스 입니다. 리소스 로드 및 게임 시작 이미지를 구현 합니다.
	 */
	public class MenuView extends Sprite
	{
		//Note @유영선 리소스를 로드하는 LoaderControl 생성
		private var _resourceLoader : ResourceLoader;
		
		//Note @유영선 메뉴 화면 이미지
		private var _menuImage : Image;
		//로딩 중 이미지
		private var _loadingImage : Image;
		//Note @유영선 화면을 터치해주세요 이미지
		private var _menuText : MovieClip;
		
		private var _loadingGaugeTexture:AtlasTexture;
		
		/**
		 * 로드 전 이미지를 불러와서 화면에 출력합니다.
		 */
		public function MenuView()
		{
			_menuImage = new Image(0, 0, FwTexture.fromBitmapData(new PrevLoadImage.MENUVIEW().bitmapData));
			_menuImage.width = Framework.viewport.width;
			_menuImage.height = Framework.viewport.height;
			addChild(_menuImage);
			
			_loadingGaugeTexture = new AtlasTexture(FwTexture.fromBitmapData((new PrevLoadImage.LOADING_GAUGE()).bitmapData), new PrevLoadImage.LOADING_XML);
			_loadingImage = new Image(Framework.viewport.width / 4, Framework.viewport.height * 3 / 4, _loadingGaugeTexture.subTextures[30]);
			_loadingImage.width = Framework.viewport.width / 2;
			_loadingImage.height = Framework.viewport.height / 20;
			addChild(_loadingImage);
			
			_resourceLoader = new ResourceLoader(onLoaderComplete, onProgress);
			_resourceLoader.resourceLoad("resource");
		}
		/**
		 * Note @유영선 이미지 로드 중일때 콜하는 함수
		 */		
		private function onProgress(progressCount : Number) : void
		{
			//Note @유영선 각각 상태 카운터에 따라 로딩 이미지를 설정
			if(progressCount == 60)
			{
				_loadingImage.texture = _loadingGaugeTexture.subTextures[60];
				_loadingImage.width = Framework.viewport.width / 2;
				_loadingImage.height = Framework.viewport.height / 20;
				Framework.current.render();
			}
			else
			{
				_loadingImage.texture = _loadingGaugeTexture.subTextures[90];
				_loadingImage.width = Framework.viewport.width / 2;
				_loadingImage.height = Framework.viewport.height / 20;
				Framework.current.render();
			}
			
			_loadingImage.width = Framework.viewport.width / 2;
			_loadingImage.height = Framework.viewport.height / 20;
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
			
			GameTexture.createGameTexture();

			_menuText = new MovieClip(GameTexture.pressTouch, 10, Framework.viewport.width / 4, Framework.viewport.height * 3 / 4);
			_menuText.width = Framework.viewport.width/2;
			_menuText.height = Framework.viewport.height/10;
			_menuText.start();
			addChild(_menuText);
			addEventListener(TouchEvent.TOUCH, onTouch);
			
			RoundSetting.instance.settingRound();
			GameSetting.instance.gameSettingInit();
			
			_resourceLoader = null;
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
					var selectView:SelectView = new SelectView(0);
					
//					PlayerState.sPlayerHeart = 5;
//					PlayerState.sPlayerPower = 0;
//					PlayerState.sGoldCount = 0;
//					PlayerState.sTotalHeart = 0;
//					PlayerState.sTotalPower = 0;
					
					SceneManager.instance.addScene(selectView);
					SceneManager.instance.sceneChange(); 
					break;
			}
		}
		
		public override function dispose() : void
		{
			super.dispose();
			
			_menuImage.dispose();
			_menuImage = null;
			
			_menuText.stop();
			_menuText.dispose();
			_menuText = null;
		}
	}
}