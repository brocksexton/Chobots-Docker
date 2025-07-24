package
{
	
	import com.kavalok.modules.WindowModule;
	import com.kavalok.wardrobe.Wardrobe;
	import com.kavalok.wardrobe.view.MainView;
	
	public class HomeClothes extends WindowModule
	{
		static private var _instance:HomeClothes;
		static public function get instance():HomeClothes
		{
			return _instance;
		}
		
		private var _wardrobe:Wardrobe;
		private var _mainView:MainView;
		
		public function HomeClothes()
		{
		}
		
		override public function initialize():void
		{
			_instance = this;
			_wardrobe = new Wardrobe();
			_mainView = new MainView();
			addChild(_mainView.content);
			readyEvent.sendEvent();
		}
		
		/*
		private function onAddClothes(newItem:ItemSprite):void
		{
			stuffs.mergeClothes([newItem.stuff]);
			refresh();
		}
		
		private function onUndo():void
		{
			if (_usedItems.length > 0)
			{
				var item:StuffItemLightTO = _usedItems.pop();
				item.used = false;
				refresh();
			}
		}
*/		
		
		public function get wardrobe():Wardrobe { return _wardrobe; }
		public function get mainView():MainView { return _mainView; }
		
	}
	
}