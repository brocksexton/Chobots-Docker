package com.kavalok.kongregateLoader
{
	import com.kavalok.gameplay.KavalokConstants;
	import com.kavalok.loaders.LocationLoaderView;
	import com.kavalok.loaders.ViewLoader;
	
	import flash.display.Sprite;
	import flash.net.URLRequest;
	import flash.system.Security;
	
	import org.goverla.utils.Strings;

	public class KongregatePreloader extends Sprite
	{
		private static const SCREEN_HEIGHT : Number = 420;
		private static const SCREEN_WIDTH : Number = 700;
		private static const FILE_FORMAT : String = "http://www.kavalok.com/game/{0}.swf";
		
		private var _view : LocationLoaderView;
		private var _loader : ViewLoader;
		
		public function KongregatePreloader(gameName : String)
		{
			super();
			Security.allowDomain("www.kavalok.com", "www.chobots.com");
			scaleX = SCREEN_WIDTH / KavalokConstants.SCREEN_WIDTH;
			scaleY = scaleX;
			this.y = (SCREEN_HEIGHT - KavalokConstants.SCREEN_HEIGHT * scaleX) / 2;

			var url : String = Strings.substitute(FILE_FORMAT, gameName);
			_view = new LocationLoaderView();
			addChild(_view.content);
			_loader = new ViewLoader(_view);
			addChild(_loader);
			_loader.load(new URLRequest(url));
			
			_loader.completeEvent.addListener(onComplete);
			
		}
		
		private function onComplete() : void
		{
			removeChild(_view.content);
			_view = null;
			removeChild(_loader);
			addChild(_loader.content);
		}
		
	}
}