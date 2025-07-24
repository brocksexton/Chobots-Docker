package com.kavalok.gameplay.frame.bag
{
	import com.kavalok.Global;
	import com.kavalok.dto.stuff.StuffItemLightTO;
	import com.kavalok.events.EventSender;
	import com.kavalok.gameplay.frame.PagedStuffsView;
	
	public class MiniBagView
	{
		protected var _rowCount:int = 2; 
		protected var _colCount:int = 3; 
		
		public var content:MiniBag = new MiniBag();
		
		private var _stuffs:PagedStuffsView;
		private var _applyEvent:EventSender = new EventSender();
		
		public function MiniBagView()
		{
			_stuffs = new PagedStuffsView(content, _rowCount, _colCount);
			_stuffs.applyEvent.addListener(onApplyClick);
			
			Global.charManager.stuffs.refreshEvent.addListener(refresh);
			refresh();
		}
		
		private function onApplyClick(item:StuffItemLightTO):void
		{
			apply(item);
			_applyEvent.sendEvent()
		}
		
		public function refresh() : void
		{
			_stuffs.items = getItems();
		}
		
		protected function getItems():Array
		{
			return Global.charManager.stuffs.getBagStuffs();
		}
		
		protected function apply(item:StuffItemLightTO):void
		{
			Global.charManager.stuffs.useItem(item);
		}
		
		public function get applyEvent():EventSender { return _applyEvent; }
	}
}