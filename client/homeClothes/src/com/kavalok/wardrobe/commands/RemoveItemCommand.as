package com.kavalok.wardrobe.commands
{
	import com.kavalok.Global;
	import com.kavalok.dialogs.DialogYesNoView;
	import com.kavalok.dialogs.Dialogs;
	import com.kavalok.gameplay.commands.AddMoneyCommand;
	import com.kavalok.utils.GraphUtils;
	import com.kavalok.utils.Strings;
	import com.kavalok.wardrobe.ModuleController;
	import com.kavalok.wardrobe.view.ItemSprite;
	
	import gs.TweenLite;

	public class RemoveItemCommand extends ModuleController
	{
		private var _item:ItemSprite;
		
		public function RemoveItemCommand(item:ItemSprite)
		{
			_item = item;
		}
		
		public function execute():void
		{
			if (_item.stuff.shopName == 'itemOfTheMonth'
			 || _item.stuff.shopName == 'paidAaccessoriesShop'
			 || _item.stuff.shopName == 'payedItems')
			{
				Dialogs.showOkDialog(Global.messages.cannotDeletePaidItem);
			}
			else
			{
				var text:String = Strings.substitute(Global.messages.recycleWarning, _item.stuff.backPrice);
				var dialog:DialogYesNoView = Dialogs.showYesNoDialog(text);
				dialog.yes.addListener(doRecycle);
			}
		}
		
		private function doRecycle():void
		{
			hideItem();
			wardrobe.removeItem(_item);
			module.mainView.closeRecycle();
			
			new AddMoneyCommand(_item.stuff.backPrice, "recycle " + _item.stuff.fileName, false, null, false).execute();
		}
		
		private function hideItem():void
		{
			_item.deactivate();
			TweenLite.to(_item, 1.0, {
				alpha: 0.0,
				onComplete:function():void {
					GraphUtils.detachFromDisplay(_item);
				}
			});
		}
		
	}
}