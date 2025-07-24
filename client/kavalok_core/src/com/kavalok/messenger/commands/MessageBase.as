package com.kavalok.messenger.commands
{
	import com.kavalok.Global;
	import com.kavalok.dialogs.Dialogs;
	import com.kavalok.messenger.McInfoMessage;
	import com.kavalok.messenger.McYesNoMessage;
	import com.kavalok.remoting.RemoteCommand;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	public class MessageBase extends RemoteCommand
	{
		public var sender:String = Global.charManager.charId;
		public var senderUserId:int = Global.charManager.userId;
		public var text:String;
		public var dateTime:Date;
		public var readed:Boolean = false;
		
		protected var _dialog:Sprite;
		
		override public function execute():void
		{
			Global.inbox.addMessage(this);
		}
		
		public function getCaption():String
		{
			 return sender || Global.messages.chobotsTeam;
		}
		
		public function getText():String
		{
			 return text;
		}
		
		public function getTooltip():String
		{
			 return getText();
		}
		
		public function getIcon():Class
		{
			return null;
		}
		
		public function show():void
		{
			showInfo(sender, text);
		}
		
		protected function messageExists():Boolean
		{
			var thisClass:Class = getDefinitionByName(getQualifiedClassName(this)) as Class;
			
			for each (var message:MessageBase in Global.inbox.messages)
			{
				if (message is thisClass && message.sender == this.sender)
					return true;
			}
			
			return false;
		}
		
		protected function showConfirmation(
			caption:String,
			text:String,
			onCommit:Function,
			onCancel:Function = null,
			yes:String = 'yes',
			no:String = 'no'):void
		{
			var view:McYesNoMessage = new McYesNoMessage(); 
			
			view.captionField.text = String(caption);
			Global.resourceBundles.kavalok.registerButton(view.commitButton, yes);
			Global.resourceBundles.kavalok.registerButton(view.cancelButton, no);
			
			view.messageField.text = String(text);
			
			if (onCancel == null)
				onCancel = closeDialog;
			
			view.commitButton.addEventListener(MouseEvent.CLICK, onCommit);
			view.cancelButton.addEventListener(MouseEvent.CLICK, onCancel);
			
			showDialog(view);
		}
		
		protected function showInfo(
			caption:String,
			text:String,
			onClose:Function = null):void
		{
			var view:McInfoMessage  = new McInfoMessage();
			view.captionField.text = String(caption);
			view.messageField.htmlText = String(text);
			
			if (onClose == null)
				onClose = closeDialog;
				
			view.closeButton.addEventListener(MouseEvent.CLICK, onClose);
			showDialog(view); 
		}
		
		protected function closeDialog(e:Event = null):void
		{
			Dialogs.hideDialogWindow(_dialog);
			_dialog = null;
		}
		
		protected function showDialog(view:Sprite):void
		{
			_dialog = view;
			Dialogs.showDialogWindow(_dialog);
		}
		
	}
}