package com.kavalok.guitarIdol.data
{
	import com.kavalok.collections.ArrayList;
	import com.kavalok.events.EventSender;
	import com.kavalok.utils.ReflectUtil;
	import com.kavalok.utils.Strings;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	
	public class SongInfo
	{
		public var bpm : Number;
		public var items : ArrayList = new ArrayList();
		public var sounds : ArrayList = new ArrayList();
		public var source : XML;
		
		private var _soundsToLoad : int = 0;
		
		private var _loadedEvent : EventSender = new EventSender();
		
		
		public function SongInfo(source : XML)
		{
			bpm = source.@bpm;
			this.source = source;
			var soundsConfig : Array = String(source.@sounds).split(",");
			for each(var soundName : String in soundsConfig)
			{
				loadSound(soundName);
			}
			
				
			var currentTick : int = 0;
			
			for each(var child : XML in source.children())
			{
				if(!Strings.isBlank(child.@button))
				{
					var buttons : Array = String(child.@button).split(",");
					for each(var button : String in buttons)
						items.addItem(new NippleInfo(button, currentTick, child.@soundDuration, child.@longNote == true));
				}
				
				currentTick += Number(child.@soundDuration);
			}
		}

		public function get loadedEvent() : EventSender
		{
			return _loadedEvent;
		}
		public function get loaded() : Boolean
		{
			return _soundsToLoad == 0;
		}
		
		private function loadSound(sourceName : String) : void
		{
			var type : Class;
			var sound : Sound
			try
			{
				type = ReflectUtil.getTypeByName(sourceName);
			 	sound = new type();
			}
			catch(e : ReferenceError)
			{
				sound = new Sound();
				sound.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
				sound.addEventListener(Event.COMPLETE, onLoadComplete);
			
				var context:SoundLoaderContext = new SoundLoaderContext(1000000);
				sound.load(new URLRequest(sourceName), context);
				_soundsToLoad++;
			}
			sounds.push(sound);
		}
		
		private function onLoadComplete(event : Event) : void
		{
			_soundsToLoad--;
			if(loaded)
				loadedEvent.sendEvent();
		}
		private function onLoadError(event : IOErrorEvent) : void
		{
			throw new Error("File not found");
		}

	}
	
}