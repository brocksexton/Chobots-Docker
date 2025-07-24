package com.kavalok.remoting.commands
{
	import com.kavalok.Global;
	import com.kavalok.dialogs.Dialogs;

	public class ServerSafeModeCommand extends ServerCommandBase
	{

		public function ServerSafeModeCommand()
		{
			super();
		}

		override public function execute():void
		{
			var disableChat:Boolean="true" == String(parameter);

			Global.charManager.serverChatDisabled=disableChat;
			Global.charManager.serverDrawDisabled=disableChat;

			Dialogs.showOkDialog(disableChat ? Global.resourceBundles.kavalok.messages.gameSafeModeOn : Global.resourceBundles.kavalok.messages.gameSafeModeOff);
		}

	}
}

