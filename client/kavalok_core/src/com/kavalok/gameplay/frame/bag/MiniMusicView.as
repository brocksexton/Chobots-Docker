package com.kavalok.gameplay.frame.bag
{
	import com.kavalok.Global;
	import com.kavalok.char.actions.MusicAction;
	import com.kavalok.events.EventSender;
	import com.kavalok.utils.ResourceScanner;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	public class MiniMusicView
	{
		static private const NUM_ITEMS:int = 3;
		static private const BTN:String = 'btn';
		
		private var _content:McMusic = new McMusic();
		private var _applyEvent:EventSender = new EventSender();
		
		public function MiniMusicView()
		{
			new ResourceScanner().apply(_content);
			initButtons();
		}
		
		private function initButtons():void
		{
			for (var i:int = 0; i < NUM_ITEMS; i++)
			{
				var button:SimpleButton = _content[BTN + (i+1)];
				button.addEventListener(MouseEvent.CLICK, onButtonClick);
			}
		}
		
		private function onButtonClick(e:MouseEvent):void
		{
			var musicNum:String = SimpleButton(e.currentTarget).name.replace(BTN, '');
			var musicName:String = Global.charManager.instrument;
			
			Global.locationManager.location.sendUserAction(
				MusicAction, {name: musicName, num: musicNum});
			
			_applyEvent.sendEvent();
		}
		
		
		public function get applyEvent():EventSender { return _applyEvent; }
		public function get content():MovieClip { return _content; }

	}
}
