package com.kavalok.loaders
{
	import com.kavalok.Global;
	import com.kavalok.URLHelper;
	import com.kavalok.constants.ResourceBundles;
	import com.kavalok.dialogs.Dialogs;
	import com.kavalok.localization.Localiztion;
	import com.kavalok.localization.ResourceBundle;
	import com.kavalok.utils.GraphUtils;
	import com.kavalok.utils.Maths;
	import com.kavalok.utils.ResourceScanner;
	import com.kavalok.utils.Timers;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class AdvertisementLoaderView extends LoaderViewBase
	{
		private static const INVITE_FRIEND_INDEX : uint = 5;
		private static const LOADERS_TIME : uint = 10000;
		private static const LOADERS_COUNT : uint = 7;
		private static var bundle : ResourceBundle = Localiztion.getBundle(ResourceBundles.LOADERS);
		
		public static var initialized : Boolean = false;
		private static var _index : int;
		
		public static function initialize() : void
		{
			var loaders : Array = [];
			_index = Maths.random(LOADERS_COUNT);
			loaders.push(URLHelper.loaderURL(_index));
			Global.classLibrary.callbackOnReady(onLoadLoaders, loaders);
		}
		
		private static function onLoadLoaders() : void
		{
			initialized = true;
		}
		
		private var _content : McAdvertisementLoader = new McAdvertisementLoader();
		private var _ready : Boolean = false;
		
		public function AdvertisementLoaderView()
		{
			new ResourceScanner().apply(_content);
			Timers.callAfter(setReady, LOADERS_TIME);
			var animationClass : Class = Global.classLibrary.getClass(URLHelper.loaderURL(_index), "McLoaderAnimation");
			var animation : MovieClip = new animationClass();
			GraphUtils.removeChildren(_content.animation);
			_content.animation.addChild(animation); 
			bundle.registerTextField(_content.field1, 'page' + _index + "_1");
			bundle.registerTextField(_content.field2, 'page' + _index + "_2");
			_content.learnMoreButton.addEventListener(MouseEvent.CLICK, onLearnMoreClick);
		}
		
		override public function get ready():Boolean
		{
			return _ready;
		}

		override public function set text(value:String):void
		{
			_content.progressBar.textField.text = value;
		}
		override public function set percent(value:int):void
		{
			_content.progressBar.percentsField.text = value + "%";
			_content.progressBar.gotoAndStop(value);
		}
		
		override public function get content():Sprite
		{
			return _content;
		}
		
		private function onLearnMoreClick(event : MouseEvent) : void
		{
			if(_index == 5)
				Dialogs.showInviteDialog()
			else
				Dialogs.showBuyAccountDialog("loader");
		}
		private function setReady() : void
		{
			_ready = true;
			readyEvent.sendEvent();
		}
		
	}
}