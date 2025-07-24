package com.kavalok.gameplay
{
	import com.kavalok.Global;
	import com.kavalok.URLHelper;
	
	public class Music
	{
		static public const LOCATION:Array = ['cho2', 'cho1_main', 'newmelody'];
		static public const MISSION:Array = ['mission'];
		static public const BUFFER_TIME:int = 15;
		
		private var _currentList:Array;
		private var _currentIndex:int;
		private var _sound:StreamSound = new StreamSound();
		private var _loadFlag:Boolean = false;
		
		public function Music()
		{
			_sound.bufferTime = BUFFER_TIME;
			_sound.completeEvent.addListener(playNext);
		}
		
		public function play(playList:Array):void
		{
			if (playList == _currentList && !_loadFlag || Global.startupInfo.isBot)
				return;
				
			_currentList = playList;
			_currentIndex = -1;
			_sound.volume = Global.musicVolume / 100.0;
			
			_loadFlag = (_sound.volume == 0);
			
			if (!_loadFlag)
				playNext();
		}
		
		private function playNext(sender:Object = null):void
		{
			if (++_currentIndex == _currentList.length)
				_currentIndex = 0;
			
			var url:String = URLHelper.musicURL(_currentList[_currentIndex]) 
			_sound.load(url);
		}
		
		public function stop():void
		{
			_sound.stop();
			_currentList = [];
		}
		
		public function set volume(value:Number):void
		{
			_sound.volume = value;
			
			if (_loadFlag)
				play(_currentList);	
		}

	}
}