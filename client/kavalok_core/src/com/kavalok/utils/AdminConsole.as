package com.kavalok.utils
{
	import com.kavalok.Global;
	import com.kavalok.char.LocationChar;
	import com.kavalok.char.actions.CharPropertyAction;
	import com.kavalok.char.actions.CharsModifierAction;
	import com.kavalok.char.actions.CharsPropertyAction;
	import com.kavalok.char.actions.LoadExternalContent;
	import com.kavalok.char.actions.LocationPropertyAction;
	import com.kavalok.char.actions.PropertyActionBase;
	import com.kavalok.location.LocationBase;
	import com.kavalok.location.commands.FlyingPromoCommand;
	import com.kavalok.location.commands.MoveToLocCommand;
	
	public class AdminConsole
	{
		public function AdminConsole()
		{
		}
		
		public function process(message:String):void
		{
			var commands:Array = message.split(';');
			
			for each (var command:String in commands)
			{
				processCommand(command);
			}
		}
		
		private function processCommand(command:String):void
		{
			var tokens:Array = command.split(' ');
			var methodName:String = String(tokens[0]).substr(1);
			tokens.splice(0, 1);
			var method:Function = this[methodName];
			method.apply(this, tokens);
		}
		
		public function moveTo(locId:String):void
		{
			var command:MoveToLocCommand = new MoveToLocCommand();
			command.locId = locId;
			location.sendCommand(command);
		}
		
		public function godmode(mode:String):void
		{
			if (mode == 'on')
				InteractiveCharMoving.instance.started = true;
			else if (mode == 'off')
				InteractiveCharMoving.instance.started = false;
		}
		
		public function reset():void
		{
			if (Global.locationManager.location)
				Global.locationManager.location.sendResetObjectPositions();
		}
		
		public function promo(text:String):void
		{
			var command:FlyingPromoCommand = new FlyingPromoCommand();
			command.text = text;
			Global.locationManager.location.sendCommand(command);	
		}
		
		public function swf(url:String):void
		{
			location.sendUserAction(LoadExternalContent, {url: url});
		}
		
		public function goto(locName:String):void
		{
			Global.moduleManager.loadModule(locName);
		}
		
		public function char(charId:String, token:String):void
		{
			var tokens:Array = token.split('=');
			
			location.sendUserAction(CharPropertyAction,
				{sender: userId, charId:charId, path: tokens[0], value: tokens[1]});
		}
		
		public function my(token:String):void
		{
			var tokens:Array = token.split('=');
			
			location.sendUserAction(CharPropertyAction,
				{sender: userId, charId:userId, path: tokens[0], value: tokens[1]});
		}
		
		public function modifier(className:String):void
		{
			location.sendUserAction(CharsModifierAction,
				{sender: userId, className:className});
		}
		
		public function chars(token:String):void
		{
			var tokens:Array = token.split('=');
			
			location.sendUserAction(CharsPropertyAction,
				{sender: userId, path: tokens[0], value: tokens[1]});
		}
		
		public function loc(token:String):void
		{
			var tokens:Array = token.split('=');
			
			location.sendUserAction(LocationPropertyAction,
				{sender: userId, path: tokens[0], value: tokens[1]});
		}
		
		public function global(token:String):void
		{
			var tokens:Array = token.split('=');
			
			location.sendUserAction(PropertyActionBase,
				{sender: userId, path: tokens[0], value: tokens[1]});
		}
		
		public function get userId():String
		{
			 return Global.charManager.charId;
		}
		
		public function get location():LocationBase
		{
			 return LocationBase(Global.locationManager.reference.value);
		}
		
		public function get user():LocationChar
		{
			 return location.user;
		}
	}
}