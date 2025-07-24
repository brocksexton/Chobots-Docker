package com.kavalok.char.commands
{
	import com.kavalok.Global;
	import com.kavalok.dialogs.DialogYesNoView;
	import com.kavalok.dialogs.Dialogs;
	import com.kavalok.messenger.commands.TeleportMessage;
	import com.kavalok.services.MessageService;
	
	public class TeleportRequest extends CharCommandBase
	{
		override public function execute():void
		{
			var text:String = Global.messages.teleportSend;
			var dialog:DialogYesNoView = Dialogs.showYesNoDialog(text);
			dialog.yes.addListener(sendTeleport);
		}
		
		private function sendTeleport(e:Object = null):void
		{
			var command:TeleportMessage = new TeleportMessage();
			new MessageService().sendCommand(char.userId, command, false);
		}

	}
}