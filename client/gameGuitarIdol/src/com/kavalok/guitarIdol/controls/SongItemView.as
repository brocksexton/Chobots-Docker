package com.kavalok.guitarIdol.controls
{
	import com.kavalok.events.EventSender;
	import com.kavalok.gameplay.controls.FlashViewBase;
	
	import flash.events.MouseEvent;

	public class SongItemView extends FlashViewBase
	{
		private var _content : McSongItem = new McSongItem();

		private var _selectEvent : EventSender = new EventSender();
		
		public function SongItemView(name : String)
		{
			super(_content);
			text = name;
			_content.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		public function get selectEvent() : EventSender
		{
			return _selectEvent;
		}
		public function get text() : String
		{
			return _content.nameField.text;
		}
		public function set text(value : String) : void
		{
			_content.nameField.text = value;
		}
		
		private function onClick(event : MouseEvent) : void
		{
			selectEvent.sendEvent(text);
		}
		
	}
}