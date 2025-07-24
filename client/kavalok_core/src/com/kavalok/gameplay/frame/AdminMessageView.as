package com.kavalok.gameplay.frame
{
	import com.kavalok.Global;
	import com.kavalok.dialogs.AdminMessageDialog;
	import com.kavalok.dialogs.Dialogs;
	import com.kavalok.gameplay.KavalokConstants;
	import com.kavalok.services.MessageService;
	import com.kavalok.utils.GraphUtils;
	import com.kavalok.utils.Strings;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class AdminMessageView
	{
		private static const MAX_CHARS : uint = KavalokConstants.MAX_TEXT_LENGTH;
		
		public var content : AdminMessageDialog;
		
		public function AdminMessageView()
		{
			content = new AdminMessageDialog();
			Global.resourceBundles.kavalok.registerTextField(content.titleField, "pleaseEnterYourMessage");
			Global.resourceBundles.kavalok.registerButton(content.sendButton, "send");
			GraphUtils.attachModalShadow(content, true);
			
			content.sendButton.enabled = false;
			content.cancelButton.addEventListener(MouseEvent.CLICK, onCancelClick);
			content.sendButton.addEventListener(MouseEvent.CLICK, onSendClick);
			content.inputField.addEventListener(Event.CHANGE, onTextChange);
			content.inputField.maxChars = MAX_CHARS;
			content.inputField.text = "";
		}
		
		public function show() : void
		{
			Dialogs.showDialogWindow(content);
			content.stage.focus = content.inputField;
		}

		public function destroy() : void
		{
			content.stage.focus = null;
			Dialogs.hideDialogWindow(content);
		}
		
		private function onTextChange(event : Event) : void
		{
			content.sendButton.enabled = Strings.trim(content.inputField.text).length > 0;
		}
		
		private function onSendClick(event : MouseEvent) : void
		{
			Global.isLocked = true;
			new MessageService(onResult).sendAdminMessage(content.inputField.text);
		}
		
		private function onResult(result:Object):void
		{
			Global.isLocked = false;
			destroy();
			
			Dialogs.showOkDialog(Global.messages.sent);
		}
		
		private function onCancelClick(event : MouseEvent) : void
		{
			destroy();
		}
	}
}