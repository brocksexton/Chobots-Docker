package com.kavalok.gameplay.frame
{
	import com.kavalok.Global;
	import com.kavalok.dto.stuff.StuffItemLightTO;
	import com.kavalok.events.EventSender;
	import com.kavalok.gameplay.frame.bag.StuffList;
	import com.kavalok.gameplay.frame.bag.StuffSprite;
	import com.kavalok.utils.Arrays;
	import com.kavalok.utils.GraphUtils;
	import com.kavalok.utils.converting.ConstructorConverter;
	
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class PagedStuffsView
	{
		private var _applyEvent:EventSender = new EventSender(StuffItemLightTO);
		
		private var _content:Sprite;
		private var _stuffList:StuffList;
		private var _applyEnabled:Boolean = true;
		
		public function PagedStuffsView(content:Sprite, rowCount:int, columnsCount:int)
		{
			_content = content;
			
			_stuffList = new StuffList(itemsClip, rowCount, columnsCount);
			_stuffList.selectedItemChange.addListener(refresh);
			_stuffList.setItems([]);
			
			Global.resourceBundles.kavalok.registerButton(useButton, "use");
			
			prevButton.addEventListener(MouseEvent.CLICK, onPrevClick);
			nextButton.addEventListener(MouseEvent.CLICK, onNextClick);
			useButton.addEventListener(MouseEvent.CLICK, applyStuff);
			
			refresh();
		}
		
		public function set items(value:Array):void
		{
			var stuffs:Array = Arrays.getConverted(value, new ConstructorConverter(StuffSprite));
				
			_stuffList.setItems(stuffs);
			refresh();
		}
		
		public function get viewItems():Array
		{
			 return _stuffList.items;
		}
		
		public function refresh(sender:Object = null):void
		{
			GraphUtils.setBtnEnabled(prevButton, _stuffList.backEnabled);
			GraphUtils.setBtnEnabled(nextButton, _stuffList.nextEnabled);
			GraphUtils.setBtnEnabled(useButton, _applyEnabled && _stuffList.selectedItem != null);
		}
		
		public function set applyEnabled(value:Boolean):void
		{
			 _applyEnabled = value;
			 refresh();
		}
		
		private function applyStuff(e:MouseEvent):void
		{
			_applyEvent.sendEvent(_stuffList.selectedItem.item);
		}
		
		private function onPrevClick(event:MouseEvent):void
		{
			_stuffList.pageIndex--;
			refresh();
		}
		
		private function onNextClick(event:MouseEvent):void
		{
			_stuffList.pageIndex++;
			refresh();
		}
		
		public function get itemsClip():Sprite
		{
			 return _content.getChildByName('itemsClip') as Sprite;
		}
		
		public function get useButton():SimpleButton
		{
			 return _content.getChildByName('useButton') as SimpleButton;
		}
		
		public function get prevButton():SimpleButton
		{
			 return _content.getChildByName('prevButton') as SimpleButton;
		}
		
		public function get nextButton():SimpleButton
		{
			 return _content.getChildByName('nextButton') as SimpleButton;
		}

		public function get applyEvent():EventSender { return _applyEvent; }
	}
}