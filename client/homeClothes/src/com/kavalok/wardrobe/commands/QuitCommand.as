package com.kavalok.wardrobe.commands
{
	import com.kavalok.Global;
	import com.kavalok.wardrobe.ModuleController;
	
	public class QuitCommand extends ModuleController
	{
		public function QuitCommand()
		{
			super();
		}
		
		public function execute():void
		{
			Global.charManager.clothes = wardrobe.usedClothes;
			Global.charManager.stuffs.updateItems(wardrobe.updateList);
			module.closeModule();
		}
		
	}
}