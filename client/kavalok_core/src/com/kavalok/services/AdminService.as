package com.kavalok.services
{
	public class AdminService extends Red5ServiceBase
	{
		public function AdminService(resultHandler:Function=null, faultHandler:Function=null)
		{
			super(resultHandler, faultHandler);
		}
		
		public function getServerLimit():void
		{
			doCall("getServerLimit", arguments);
		}
		public function kickOut(userId : int, banned :  Boolean = false) : void
		{
			doCall("kickOut", arguments);
		}
		
		public function addBan(userId : int) : void
		{
			doCall("addBan", arguments);
		}
		
		public function reportUser(userId:int, text:String) : void
		{
			doCall("reportUser", arguments);
		}
		
		public function clearSharedObject(id:String) : void
		{
			doCall("clearSharedObject", arguments);
		}
		
		public function getConfig() : void
		{
			doCall("getConfig", arguments);
		}
		
		public function changePassword(oldPassword:String, newPassword:String):void
		{
			doCall("changePassword", arguments);
		}
		
		public function getClientConfig() : void
		{
			doCall("getClientConfig", arguments);
		}
		
	}
}