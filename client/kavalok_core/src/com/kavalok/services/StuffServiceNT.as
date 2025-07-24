package com.kavalok.services
{
	import com.kavalok.dto.stuff.StuffItemLightTO;
	
	public class StuffServiceNT extends Red5ServiceBase
	{
		public function StuffServiceNT(resultHandler:Function=null, faultHandler:Function=null)
		{
			super(resultHandler, faultHandler);
		}
		
		public function retriveItemWithColor(staffName:String, color : int):void
		{
			doCall("retriveItemWithColor", arguments);
		}
		public function retriveItemByIdWithColor(staffId:int, color : int):void
		{
			doCall("retriveItemByIdWithColor", arguments);
		}
		public function retriveItem(staffName:String):void
		{
			doCall("retriveItem", arguments);
		}
		public function retriveItemById(staffId:int):void
		{
			doCall("retriveItemById", arguments);
		}

		public function updateStuffItem(item : StuffItemLightTO) : void 
		{
			doCall("updateStuffItem", arguments);
		}
		
		public function getStuffTypes(shopName : String) : void
		{
			doCall("getStuffTypes", arguments);
		}
		
		public function removeItem(itemId:int):void
		{
			doCall("removeItem", arguments);
		}
		
		public function getItem(itemId:int):void
		{
			doCall("getItem", arguments);
		}

		public function getItemOfTheMonthType():void
		{
			doCall("getItemOfTheMonthType", arguments);
		}
		
		public function getStuffType(fileName:String):void
		{
			doCall("getStuffType", arguments);
		}

	}
}