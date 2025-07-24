package com.kavalok.guitarIdol
{
	import com.kavalok.collections.ArrayList;
	import com.kavalok.events.EventSender;
	import com.kavalok.gameplay.controls.FlashViewBase;
	import com.kavalok.guitarIdol.controls.SongItemView;
	import com.kavalok.layout.VBoxLayout;
	import com.kavalok.utils.GraphUtils;

	public class SongChooserView extends FlashViewBase
	{
		
		private var _content : McSongChooser = new McSongChooser();
		private var _listLayout : VBoxLayout;
		
		private var _songs : ArrayList = new ArrayList(["TST", "PUNK", "PUNK2", "ALT_ROCK", "ALT_ROCK2", "EMO", "POP_ROCK", "CLOCK"]);
		
		private var _selectEvent : EventSender = new EventSender();
		
		public function SongChooserView()
		{
			_listLayout = new VBoxLayout(_content.songsList);
			GraphUtils.removeAllChildren(_content.songsList);
			super(_content);
			for each(var song : String in _songs)
			{
				var item : SongItemView = new SongItemView(song);
				_content.songsList.addChild(item.content);
				item.selectEvent.addListener(selectEvent.sendEvent);
			}
			_listLayout.apply();
		}
		
		public function get selectEvent() : EventSender
		{
			return _selectEvent;
		}
		
	}
}