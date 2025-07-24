package com.kavalok.services
{
	public class MoneyService extends SecuredRed5ServiceBase
	{
		public function MoneyService(resultHandler:Function = null)
		{
			super(resultHandler);
		}
		
		public function addMoney(money : int, reason : String) : void
		{
			doCall("addMoney", arguments);
		}

	}
}