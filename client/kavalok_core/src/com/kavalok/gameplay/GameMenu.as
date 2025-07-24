package com.kavalok.gameplay
{
	import com.kavalok.Global;
	import com.kavalok.dialogs.Dialogs;
	import com.kavalok.dialogs.McMenu;
	import com.kavalok.gameplay.commands.ChangePasswordCommand;
	import com.kavalok.gameplay.controls.Scroller;
	import com.kavalok.gameplay.controls.StateButton;
	import com.kavalok.localization.Localiztion;
	import com.kavalok.services.CharService;
	import com.kavalok.utils.GraphUtils;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class GameMenu
	{
		private var _content:McMenu = new McMenu();
		private var _soundVolume:Scroller = new Scroller(_content.mcSoundVolume);
		private var _musicVolume:Scroller = new Scroller(_content.mcMusicVolume);
		private var _charNamesCheckBox:StateButton = new StateButton(_content.charNamesCheckBox);
		private var _requestCheckBox:StateButton = new StateButton(_content.requestCheckBox);
		
		private var _quality:Array = [
			_content.quality0,
			_content.quality1,
			_content.quality2,
		]
		
		private var _locales:Object = {
			uaUA: _content.uaUA,
			enUS: _content.enUS,
			deDE: _content.deDE,
			ruRU: _content.ruRU
		}		
		
		public function GameMenu()
		{
//			_content.deDE.mouseChildren = false;
//			_content.deDE.mouseEnabled = false;
			 _soundVolume.position = Global.soundVolume / 100.0;
			 _soundVolume.changeEvent.addListener(onSoundVolume);
			 
			 _musicVolume.position = Global.musicVolume / 100.0;
			 _musicVolume.changeEvent.addListener(onMusicVolume);
			 
			 _charNamesCheckBox.state = Global.showCharNames ? 2 : 1;
			 _charNamesCheckBox.stateEvent.addListener(onCharNames);
			 
			 _requestCheckBox.state = Global.acceptRequests ? 2 : 1;
			 _requestCheckBox.stateEvent.addListener(onRequestClick);
			 
			 _content.passwordButton.addEventListener(MouseEvent.CLICK, onPasswordClick);
			 _content.mc_okButton.addEventListener(MouseEvent.CLICK, onCloseClick);
			 
			for (var i:int = 0; i < _quality.length; i++)
			{
				_quality[i] = new StateButton(_quality[i]);
				StateButton(_quality[i]).stateEvent.addListener(onQualityClick);
			}
			
			for (var locale:String in _locales)
			{
				_locales[locale] = new StateButton(_locales[locale]);
				StateButton(_locales[locale]).stateEvent.addListener(onLocaleClick);
			}
			 
			 refresh();
		}
		
		public function get content():McMenu
		{
			 return _content;
		}
		
		public function onRequestClick(sender:StateButton):void
		{
			Global.acceptRequests = !Global.acceptRequests;
		}
		
		private function onSoundVolume(sender:Scroller):void
		{
			Global.soundVolume = sender.position * 100;
		}
		
		private function onMusicVolume(sender:Scroller):void
		{
			Global.musicVolume = sender.position * 100;
			Global.music.volume = sender.position;
		}
		
		private function onCharNames(sender:Object):void
		{
			Global.showCharNames = (_charNamesCheckBox.state == 2)
			if(Global.locationManager.location)
				Global.locationManager.location.refresh();
		}
		
		private function onQualityClick(sender:Object):void
		{
			var quality:int = _quality.indexOf(sender);
			Global.performanceManager.quality = quality;
			Global.localSettings.quality = quality;
			
			refresh();
		}
		
		private function onLocaleClick(sender:Object):void
		{
			Localiztion.locale = StateButton(sender).content.name;
			new CharService().setLocale(Localiztion.locale);
			refresh();
		}
		
		private function refresh():void
		{
			for (var i:int = 0; i < _quality.length; i++)
			{
				StateButton(_quality[i]).state = (Global.performanceManager.quality == i)
					? 2
					: 1; 
			}
			
			for (var locale:String in _locales)
			{
				StateButton(_locales[locale]).state = (Localiztion.locale == locale) 
					? 2
					: 1; 
			}
		}
		
		private function onPasswordClick(e:MouseEvent):void
		{
			Dialogs.hideDialogWindow(_content);
			new ChangePasswordCommand().execute();
		}
		
		private function onCloseClick(e:Event):void
		{
			Global.saveSettings();
		}
		
	}
}