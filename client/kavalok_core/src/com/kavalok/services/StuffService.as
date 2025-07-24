package com.kavalok.services
{
	import com.kavalok.dto.stuff.StuffItemLightTO;
	
	public class StuffService extends Red5ServiceBase
	{
		public function StuffService(resultHandler:Function=null, faultHandler:Function=null)
		{
			super(resultHandler, faultHandler);
		}

		public function buyItem(id:int, count:int = 1, color:int = -1) : void
		{
			doCall("buyItem", arguments);
		}
	}
}