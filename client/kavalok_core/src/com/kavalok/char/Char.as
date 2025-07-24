package com.kavalok.char
{
	import com.kavalok.Global;
	import com.kavalok.dto.pet.PetTO;
	import com.kavalok.dto.stuff.StuffItemLightTO;
	import com.kavalok.remoting.DataObject;

	public class Char extends DataObject
	{
		public var id:String;
		public var userId:Number;
		public var isCitizen:Boolean;
		public var isModerator:Boolean;
		public var isAgent:Boolean;
		public var isParent:Boolean;
		public var isGuest:Boolean;
		public var locale:String;
		public var chatEnabled:Boolean;
		public var chatEnabledByParent:Boolean;
		public var enabled:Boolean;
		public var acceptRequests:Boolean;
		public var age:Number;
		public var server:String;
		public var hasRobot:Boolean;
		public var teamName:String;
		public var teamColor:int;
	
		public var isOnline:Boolean;
		public var moodId:String;
		
		public var body:String = CharManager.DEFAULT_BODY;
		public var color:int = 0xAAAAAA;
		public var tool:String;
		public var clothes:Array/*of String*/ = [];
		public var pet:PetTO;
		public var playerCard:StuffItemLightTO;
		
		public function get isUser():Boolean
		{
			return (id == Global.charManager.charId);
		}
		
		public function Char(data:Object = null)
		{
			super(data);
			
			if (data)
			{
				if ('agent' in data)
					this.isAgent = data.agent;
				if ('moderator' in data)
					this.isModerator = data.moderator;
				if ('citizen' in data)
					this.isCitizen = data.citizen;
				if ('guest' in data)
					this.isGuest = data.guest;
				if ('online' in data)
					this.isOnline = data.online;
				if ('parent' in data)
					this.isParent = data.parent;
			}
				
		}
		
	}
}