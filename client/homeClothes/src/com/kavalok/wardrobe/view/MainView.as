package com.kavalok.wardrobe.view
{
	import assets.wardrobe.McWardrobe;
	
	import com.kavalok.Global;
	import com.kavalok.constants.ResourceBundles;
	import com.kavalok.gameplay.KavalokConstants;
	import com.kavalok.gameplay.ToolTips;
	import com.kavalok.gameplay.commands.CitizenWarningCommand;
	import com.kavalok.gameplay.controls.CheckBox;
	import com.kavalok.gameplay.controls.RadioGroup;
	import com.kavalok.utils.GraphUtils;
	import com.kavalok.wardrobe.ModuleController;
	import com.kavalok.wardrobe.commands.QuitCommand;
	import com.kavalok.wardrobe.commands.RemoveItemCommand;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class MainView extends ModuleController
	{
		private var _content:McWardrobe;
		private var _charView:CharView;
		private var _recycleView:RecycleView;
		private var _groupSelector:RadioGroup;
		
		private var _itemsContainer:Sprite;
		private var _newPos:Sprite;
		private var _dragBounds:Rectangle;
		
		public function MainView():void
		{
			initContent();
			attachItems();
			
			_content.btnClose.addEventListener(MouseEvent.MOUSE_DOWN, onCloseClick);
			_groupSelector.clickEvent.addListener(onSelectorClick);
			
			ToolTips.registerObject(_content.btnClose, 'close', ResourceBundles.KAVALOK);
			
			GraphUtils.optimizeBackground(_content.background);
		}
		
		private function initContent():void
		{
			_content = new McWardrobe();
			_content.mcNewPos1.visible = false;
			_content.mcNewPos2.visible = false;
			_content.recycle.stop();
			
			_dragBounds = new Rectangle(10, 10,
				KavalokConstants.SCREEN_WIDTH - 20,
				KavalokConstants.SCREEN_HEIGHT - 20);
			
			_newPos = _content.mcNewPos1;
			_charView = new CharView(_content);
			_recycleView = new RecycleView(_content.recycle);
			
			_itemsContainer = new Sprite();
			_content.addChild(_itemsContainer);
			
			_groupSelector = new RadioGroup();
			_groupSelector.addButton(new CheckBox(_content.checkBox1));
			_groupSelector.addButton(new CheckBox(_content.checkBox2));
			_groupSelector.addButton(new CheckBox(_content.checkBox3));
			_groupSelector.addButton(new CheckBox(_content.checkBox4));
			_groupSelector.addButton(new CheckBox(_content.checkBox5));
			_groupSelector.selectedIndex = 0;
		}
		
		private function onSelectorClick(sender:Object):void
		{
			attachItems();
		}
		
		private function attachItems():void
		{
			GraphUtils.removeChildren(_itemsContainer);
			var items:Array = wardrobe.getItems(_groupSelector.selectedIndex);
			for each (var item:ItemSprite in items)
			{
				if (!item.initialized)
					initItem(item);
				_itemsContainer.addChild(item);
			}
		}
		
		public function initItem(item:ItemSprite):void
		{
			item.initialize();
			item.startDragEvent.addListener(onStartDrag);
			item.finishDragEvent.addListener(onFinishDrag);
			item.dragEvent.addListener(onDrag);
			item.dragManager.bounds = _dragBounds;
			
			if (item.isNewStaff)
			{
				_newPos = (_newPos == _content.mcNewPos1)
					? _content.mcNewPos2
					: _content.mcNewPos1;
				
				item.position = GraphUtils.objToPoint(_newPos);
			}
		}
		
		private function onStartDrag(item:ItemSprite):void
		{
			item.selected = true;
			GraphUtils.bringToFront(item);
		}
		
		private function onDrag(item:ItemSprite):void
		{
			var recycled:Boolean = _recycleView.hitTestItem(item);
			if (recycled != item.recycled)
			{
				item.recycled = recycled;
				if (item.recycled)
					_recycleView.open();
				else
					_recycleView.close();
			}
		}
		
		private function onFinishDrag(item:ItemSprite):void
		{
			item.selected = false;
			
			if (_recycleView.hitTestItem(item))
			{
				new RemoveItemCommand(item).execute();
			}
			else if (_charView.hitTestItem(item))
			{
				if (item.enabled)
					wardrobe.useItem(item);
				else{
					if (Global.charManager.isGuest || Global.charManager.isNotActivated)
						new QuitCommand().execute();
					new CitizenWarningCommand("wardrobe").execute();
				}
				item.dragManager.undoDrag();
			}
			else
			{
				item.updatePosition();
				wardrobe.addToUpdateList(item);
			}
		}
		
		public function closeRecycle():void
		{
			_recycleView.playToEnd();
		}
		
		private function onCloseClick(e:MouseEvent):void
		{
			new QuitCommand().execute();
		}
		
		public function get content():Sprite { return _content; }
		
	}
	
}