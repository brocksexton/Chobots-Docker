package com.kavalok.location.commands
{
	import com.kavalok.Global;
	import com.kavalok.utils.GraphUtils;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	public class PlaySwfCommand extends RemoteLocationCommand
	{
		public var url:String
		
		private var _loader:Loader;
		
		public function PlaySwfCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			_loader.load(new URLRequest(url));
		}
		
		private function onLoadComplete(e:Event):void
		{
			var movie:MovieClip = LoaderInfo(e.target).content as MovieClip;
			movie.mouseEnabled = false;
			movie.mouseChildren = false;
			Global.locationContainer.addChild(movie);
			movie.addEventListener(Event.ENTER_FRAME, onMovieFrame);
		}
		
		private function onMovieFrame(e:Event):void
		{
			var movie:MovieClip = e.target as MovieClip;
			if (movie.currentFrame == movie.totalFrames)
			{
				GraphUtils.stopAllChildren(movie);
				GraphUtils.detachFromDisplay(movie);
				movie.removeEventListener(Event.ENTER_FRAME, onMovieFrame);
			}
		}
	}
}