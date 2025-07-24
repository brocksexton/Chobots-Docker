package com.kavalok.kongregateLoader
{
	import com.kavalok.Global;
	import com.kavalok.StartupInfo;
	import com.kavalok.URLHelper;
	import com.kavalok.gameplay.KavalokConstants;
	import com.kavalok.games.ReadyClient;
	import com.kavalok.kongregateLoader.utils.LoaderViewDecorator;
	import com.kavalok.loaders.ILoaderView;
	import com.kavalok.loaders.LocationLoaderView;
	import com.kavalok.loaders.SafeLoader;
	import com.kavalok.modules.LocationModule;
	import com.kongregate.as3.client.KongregateAPI;
	import com.kongregate.as3.client.events.KongregateEvent;
	
	import flash.display.Sprite;
	import flash.net.URLRequest;
	
	import mx.core.Singleton;
	import mx.resources.ResourceManagerImpl;
	
	import org.goverla.localization.Localiztion;
	import com.kavalok.constants.ConnectionConfig;

	public class KongregateGame extends Sprite
	{
		private var _loaderView : ILoaderView;
		private var _game : String;
		private var _location : String;
		private var _userName : String;
		private var _kongregateUser : Object;
		private var _api : KongregateAPI;
		
		public function KongregateGame(game : String, location : String)
		{
			super();
			ReadyClient;new LocationModule();
			Localiztion.urlFormat = "http://www.kavalok.com/game/resources/localization/{0}.{1}.xml"
			URLHelper.RESOURCES_PATH_FORMAT = "http://www.kavalok.com/game/resources/{0}/{1}.swf";
			URLHelper.MUSIC_PATH_FORMAT = "http://www.kavalok.com/game/resources/music/{0}.mp3";

//			Localiztion.urlFormat = "http://www.kavalok.com/game/resources/localization/{0}.{1}.xml";
			Singleton.registerClass("mx.resources::IResourceManager", ResourceManagerImpl);
			
			_game = game;
			_location = location;
			
			_api = new KongregateAPI();
			_api.addEventListener(KongregateEvent.COMPLETE, onApiComplete);
			addChild(_api);
			
		}
		
		private function onApiComplete(event : KongregateEvent) : void
		{
			_api.user.getPlayerInfo(onGetPlayerInfo);
		}
		private function onGetPlayerInfo(result : Object) : void
		{
			_kongregateUser = result;
			_loaderView = new LocationLoaderView();
			addChild(_loaderView.content);
			var decorator : LoaderViewDecorator = new LoaderViewDecorator(_loaderView, 0, 50);
			var loader : SafeLoader = new SafeLoader(decorator);
			loader.completeEvent.addListener(onLocationLoaded);
			loader.load(new URLRequest(URLHelper.locationUrl(_location)));
		}
		private function onLocationLoaded() : void
		{
			var decorator : LoaderViewDecorator = new LoaderViewDecorator(_loaderView, 50, 100);
			var loader : SafeLoader = new SafeLoader(decorator);
			loader.completeEvent.addListener(onGameLoaded);
			loader.load(new URLRequest(URLHelper.moduleUrl(_game)));
		}
		
		private function onGameLoaded() : void
		{
			Global.showTips = false;
			removeChild(_loaderView.content);
			
			var info:StartupInfo = new StartupInfo();
			if(_kongregateUser.isGuest)
			{
				info.prefix = "[kongregate]guest_";
			}
			else
			{
				info.login = "[kongregate]" + _kongregateUser.name.toLowerCase();
			}
			info.server = "Serv1";
			info.url = ConnectionConfig.buildRtmpUrl();
			info.errorLogEnabled = false;
			info.moduleId = _location;
//			info.moduleId = _game;
			info.locale = "enUS"
//			SafeLoader.rootUrl = "http://www.kavalok.com/game/"
			var instance:Kavalok = new Kavalok(info);
			addChild(instance);
		}
		
	}
}