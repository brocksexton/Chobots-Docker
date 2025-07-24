package com.kavalok.services
{

	public class CharService extends Red5ServiceBase
	{
		public function CharService(resultHandler:Function = null, faultHandler:Function = null)
		{
			super(resultHandler, faultHandler);
		}

		public function saveDance(value:String, index:int) : void
		{
			doCall("saveDance", arguments);
		}
		
		public function savePlayerCard(stuffId:int) : void
		{
			doCall("savePlayerCard", arguments);
		}
		
		public function saveSettings(musicVolume:int, soundVolume:int,
			acceptRequests:Boolean, showTips:Boolean, showCharNames : Boolean):void
		{
			doCall("saveSettings", arguments);
		}
		public function getMoneyReport() : void
		{
			doCall("getMoneyReport", arguments);
		}
		public function setLocale(locale:String) : void
		{
			doCall("setLocale", arguments);
		}
		
		public function getCharViewLogin(login:String) : void
		{
			doCall("getCharViewLogin", arguments);
		}

		public function getCharView(userId:int) : void
		{
			doCall("getCharView", arguments);
		}
		
		public function getFamilyInfo():void
		{
			doCall("getFamilyInfo", arguments);
		}	
		
		public function getCharStuffs() : void
		{
			doCall("getCharStuffs", arguments);
		}	
		
		public function saveCharStuffs(clothes : Array) : void
		{
			doCall("saveCharStuffs", arguments);
		}
		
		public function saveCharBody(body: String, color:int) : void
		{
			doCall("saveCharBody", arguments);
		}
		
		public function getCharHome(userId : int) : void
		{
			doCall("getCharHome", arguments);
		} 
//		public function getCharNames() : void
//		{
//			doCall("getCharNames", arguments);
//		}
	
		public function gK() : void
		{
			doCall("gK", arguments);
		}
		public function enterGame(charName : String) : void
		{
			doCall("enterGame", arguments);
		}
		
		public function getCharFriends():void
		{
			doCall("getCharFriends", arguments);
		}
		
		public function getCharMoney():void
		{
			doCall("getCharMoney", arguments);
		}

		public function setCharFriend(friendId:int):void
		{
			doCall("setCharFriend", arguments);
		}
		
		public function removeCharFriends(friendsList:Array):void
		{
			doCall("removeCharFriends", arguments);
		}
		
		public function getIgnoreList():void
		{
			doCall("getIgnoreList", arguments);
		}
		
		public function setIgnoreChar(userId:int):void
		{
			doCall("setIgnoreChar", arguments);
		}

		public function removeIgnoreChar(userId:int):void
		{
			doCall("removeIgnoreChar", arguments);
		}
		public function makePresent(userId:int, stuffId:int):void
		{
			doCall("makePresent", arguments);
		}
		
		public function setUserInfo(userId:int, enabled:Boolean,
				chatEnabledByParent:Boolean, isParent:Boolean):void
		{
			doCall("setUserInfo", arguments);
		}
		
		public function getRobotTeam():void
		{
			doCall("getRobotTeam", arguments);
		}
		
		public function getLastOnlineDay(userId:int):void
		{
			doCall("getLastOnlineDay", arguments);
		}
		
		public function getSessionTime(userId:int, date:Date):void
		{
			var date1:Date = new Date();
			date1.setDate(date.getDate());
			date1.hours = 0;
			date1.minutes = 0
			date1.seconds = 0;
			date1.milliseconds = 0;
			
			var date2:Date = new Date();
			date2.setDate(date1.getDate() + 1);
			date2.hours = 0;
			date2.minutes = 0
			date2.seconds = 0;
			date2.milliseconds = 0;
			
			doCall("getSessionTime", [userId, date1, date2]);
		}
	}
}