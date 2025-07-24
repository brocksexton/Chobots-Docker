package com.kavalok.gameplay.frame.bag
{
	import com.kavalok.Global;
	import com.kavalok.dto.stuff.StuffItemLightTO;
	
	public class MiniCardsView extends MiniBagView
	{
		public function MiniCardsView()
		{
			_rowCount = 1; 
			_colCount = 3;
			
			super(); 
		}
		
		override protected function getItems():Array
		{
			var items:Array = Global.charManager.stuffs.getCards();
			items.sortOn('id', Array.NUMERIC | Array.DESCENDING); 
			return items;
		}
		
		override protected function apply(item:StuffItemLightTO):void
		{
			Global.charManager.playerCard = item;
		}
	}
}