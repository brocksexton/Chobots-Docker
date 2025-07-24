package com.kavalok.dto
{
	import flash.net.registerClassAlias;

	public class ClientServerConfigTO
	{
		public static function initialize() : void
		{
			registerClassAlias("com.kavalok.dto.ClientServerConfigTO", ClientServerConfigTO);
		}

		public var guestsEnabled : Boolean;
		public var registrationEnabled : Boolean;

		public function ClientServerConfigTO()
		{
		}
	}
}