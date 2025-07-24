package com.kavalok.stuffCatalog.view
{
	import com.kavalok.Global;
	import com.kavalok.constants.Modules;
	import com.kavalok.constants.StuffTypes;
	import com.kavalok.dto.stuff.StuffTypeTO;
	import com.kavalok.events.EventSender;
	import com.kavalok.gameplay.KavalokConstants;
	import com.kavalok.gameplay.controls.ColorPicker;
	import com.kavalok.gameplay.controls.Spinner;
	import com.kavalok.gameplay.frame.bag.StuffList;
	import com.kavalok.gameplay.frame.bag.StuffSprite;
	import com.kavalok.localization.Localiztion;
	import com.kavalok.localization.ResourceBundle;
	import com.kavalok.stuffCatalog.CatalogConfig;
	import com.kavalok.ui.LoadingSprite;
	import com.kavalok.utils.GraphUtils;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import stuffCatalog.McCatalog;
	import stuffCatalog.McStufControls;
	
	public class CatalogView
	{
 		public var byeEnabled:Boolean = true; 
 		
		private var _closeEvent:EventSender = new EventSender();
		private var _buyEvent:EventSender = new EventSender();
 		
 		private var _content:McCatalog;
		private var _controls:McStufControls;
		private var _colorPicker:ColorPicker;
		private var _count:Spinner;
		
		private var _selectionWidth:int;
		private var _selectionHeight:int;
		private var _bundle:ResourceBundle = Localiztion.getBundle(Modules.STUFF_CATALOG);;

		private var _stuffList : StuffList;
		
		private var _config:CatalogConfig;
		private var _loading:LoadingSprite;

		public function CatalogView(config : CatalogConfig):void
		{
			_config = config;
			
			createContent();
			
			_controls.btnPrev.addEventListener(MouseEvent.MOUSE_DOWN, onPrevPress);
			_controls.btnNext.addEventListener(MouseEvent.MOUSE_DOWN, onNextPress);
			_controls.btnClose.addEventListener(MouseEvent.MOUSE_DOWN, _closeEvent.sendEvent);
			_controls.btnBuy.addEventListener(MouseEvent.MOUSE_DOWN, _buyEvent.sendEvent);
			
			_colorPicker.clickEvent.addListener(onColorChange);
			_stuffList.selectedItemChange.addListener(onSelectedItemChange);
			
			_bundle.registerButton(_controls.btnBuy, 'buy');
		}
		
		private function createContent():void
		{
			_content = new McCatalog();
			_loading = new LoadingSprite(_content.background.getBounds(_content));
			_content.addChild(_loading);
			GraphUtils.optimizeSprite(_content.background);
			
			_controls = _content.mcControls;
			_controls.mcOverFilter.visible = false;
			_controls.mcSelectedFilter.visible = false;
			_controls.mcPrice.visible = false;
			_controls.btnBuy.visible = false;
			_controls.visible = false;
			
			_colorPicker = new ColorPicker(_controls.colorPicker)
			_colorPicker.content.visible = false;
			
			_count = new Spinner(_controls.mcCount);
			_count.minValue = 1;
			_count.maxValue = 9;
			_count.content.visible = false;
			_count.changeEvent.addListener(onCountChange);
			_count.value = 1;
			
			_selectionWidth = _controls.mcSelection.width;
			_selectionHeight = _controls.mcSelection.height;
			
			_stuffList = new StuffList(_controls.mcItemsList, _config.rowCount, _config.columnCount);
			
			priceField.defaultTextFormat = priceField.getTextFormat(); 
			
			GraphUtils.removeChildren(_controls.mcItemsList);
			GraphUtils.removeChildren(_controls.mcSelection);
		}
		
		public function get selectedItem() : StuffSprite
		{
			return _stuffList.selectedItem;
		}
		
		public function setItems(value:Array):void
		{
			GraphUtils.detachFromDisplay(_loading);
			_controls.visible = true;
			_stuffList.setItems(value);
			if (value.length == 1)
				forceFirstItem();
			refresh();
		}
		
		private function forceFirstItem():void
		{
			var item:StuffSprite = _stuffList.items[0];
			if (item.enabled)
			{
				_stuffList.selectedItem = item;
				if (item.ready)
					onSelectedItemChange();
				else
					item.refreshEvent.addListener(onSelectedItemChange);
			}
		}
		
		public function refreshList():void
		{
			_stuffList.refresh();
			refresh();
		}
		
		private function refresh():void
		{
			if(_stuffList.pagesCount > 1)
			{
				_controls.mcPointer.x = _controls.mcLine.x +
				_controls.mcLine.width * _stuffList.pageIndex / (_stuffList.pagesCount - 1);
			}
			
			GraphUtils.setBtnEnabled(_controls.btnPrev, _stuffList.backEnabled );
			GraphUtils.setBtnEnabled(_controls.btnNext, _stuffList.nextEnabled);
		}
		
		private function onSelectedItemChange(sender:Object = null):void
		{
			GraphUtils.removeChildren(_controls.mcSelection);
			
			var itemSelected:Boolean = Boolean(_stuffList.selectedItem); 
			
			_controls.mcPrice.visible = itemSelected && !_config.futureItems;
			_controls.btnBuy.visible = itemSelected && byeEnabled && !_config.futureItems;
			_colorPicker.content.visible = itemSelected && _stuffList.selectedItem.hasColor;
			_count.content.visible = itemSelected && _config.countVisible;
				
			if (itemSelected)
			{
				_stuffList.selectedItem.color = _colorPicker.color;
				
				var itemInfo:StuffSprite = _stuffList.selectedItem;
				var pageSprite:ItemViewBase;
				if (itemInfo.item.type == StuffTypes.ROBOT)
					pageSprite = new RobotItemView(itemInfo);
				else if (itemInfo.item.type == StuffTypes.CLOTHES)
					pageSprite = new ClothesItemView(itemInfo);
				else if (itemInfo.item.type == StuffTypes.BUGS)
					pageSprite = new BugsItemView(itemInfo);
				else 
					pageSprite = new StuffItemView(itemInfo);
							
				_controls.mcSelection.addChild(pageSprite);
				GraphUtils.alignCenter(pageSprite,
					new Rectangle(0, 0, _selectionWidth, _selectionHeight));
				
				priceField.text = getPriceText();
			}
		}
		
		private function getPriceText():String
		{
			var result:String;
			var stuff:StuffTypeTO = selectedItem.item as StuffTypeTO;
			if (stuff.skuInfo)
			{
				var sign:String = Global.resourceBundles.currencies.messages[stuff.skuInfo.sign];
				result = stuff.skuInfo.price + sign;
			}
			else
			{
				result = (stuff.price * _count.value) + KavalokConstants.MONEY_CHAR
			}
			return result;			
		}
		
		private function onColorChange(sender:ColorPicker):void
		{
			onSelectedItemChange();
		}
		
		private function onCountChange(sender:Spinner):void
		{
			onSelectedItemChange();
		}
		
		private function onPrevPress(event:MouseEvent) : void
		{
			_stuffList.pageIndex--;
			refresh();
		}
		
		private function onNextPress(event:MouseEvent) : void
		{
			_stuffList.pageIndex++;
			refresh();
		}
		
		public function get priceField():TextField
		{
			return TextField(_controls.mcPrice.txtCaption);
		}
		
		public function get closeEvent():EventSender { return _closeEvent; }
		
		public function get content():Sprite { return _content; }
		public function get buyEvent():EventSender { return _buyEvent; }
		public function get count():int { return _count.value; }
	}
	
}