package com.kavalok.dialogs
{
	import com.kavalok.Global;
	import com.kavalok.char.Char;
	import com.kavalok.char.CharModel;
	import com.kavalok.char.CharModels;
	import com.kavalok.char.Directions;
	import com.kavalok.gameplay.KavalokConstants;
	import com.kavalok.games.McChar;
	import com.kavalok.games.McFinishScreen;
	import com.kavalok.utils.GraphUtils;
	import com.kavalok.utils.ResourceScanner;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class Dialogs
	{
		private static const MAX_PLAYERS : uint = 5;
		
		public static var BUY_ACCOUNT_OPENED : Boolean = false;

		public static function showNewsDialog() : DialogNews
		{
			return DialogNews(showDialog(new DialogNews(true)));
		}

		public static function showBuyAccountDialog(source : String) : DialogBuyAccount
		{
			BUY_ACCOUNT_OPENED = true;
			return DialogBuyAccount(showDialog(new DialogBuyAccount(source, true), false));
		}

		public static function showInviteDialog() : DialogInviteFriend
		{
			return DialogInviteFriend(showDialog(new DialogInviteFriend()));
		}

		public static function showProlongAccountDialog(source : String) : DialogProlongAccount
		{
			BUY_ACCOUNT_OPENED = true;
			return DialogProlongAccount(showDialog(new DialogProlongAccount(source, true), false));
		}

		public static function showCitizenStatusDialog(source : String, modal : Boolean = true) : DialogCitizenStatus
		{
			BUY_ACCOUNT_OPENED = true;
			return DialogCitizenStatus(showDialog(new DialogCitizenStatus(source, modal), false));
		}

		public static function showOkDialog(text : String, okVisible : Boolean = true, content : MovieClip = null, modal : Boolean = true) : DialogOkView
		{
			return DialogOkView(showDialog(new DialogOkView(text, okVisible, content, modal)));
		}

		public static function showYesNoDialog(text : String = null, modal : Boolean = true) : DialogYesNoView
		{
			return DialogYesNoView(showDialog(new DialogYesNoView(text, modal)));
		}
		
		public static function hideDialogWindow(dialog : DisplayObject) : void
		{
			GraphUtils.detachFromDisplay(dialog);
		}

		public static function centerWindow(window : DisplayObject) : void
		{
			window.x = (KavalokConstants.SCREEN_WIDTH - window.width)/2;
			window.y = (KavalokConstants.SCREEN_HEIGHT - window.height)/2;
		}
		
		public static function showGameResults(result : Array, charStates : Object) : DialogOkView
		{
			var view:McFinishScreen = new McFinishScreen();
			var dialog:DialogOkView = Dialogs.showOkDialog(null, true, view);

			for (var i:int = 0; i < MAX_PLAYERS; i++)
			{
				var mc:McChar = view['mcChar' + (i + 1)];
				
				if (i < result.length)
				{
					var charId:String = result[i]; 
					var stateId : String = Global.charManager.getCharStateId(charId);
					var state:Object = charStates[stateId];
					
					var char:Char = new Char(state);
					
					var model:CharModel = new CharModel(char);
					
					if (i==0)
						model.setModel(CharModels.DANCE_VICTORY);
					else
						model.setModel(CharModels.STAY, Directions.DOWN);
					
					model.scale = 1.5;
					model.position = mc.mcCharZone;
					
					mc.txtName.text = charId;
					mc.mcCharZone.visible = false;
					mc.addChild(model);
				}
				else
				{
					mc.visible = false;
				}
			}
			return dialog;
		}
		
		public static function showDialogWindow(dialog : Sprite, modal:Boolean = true, container : Sprite = null, docenterWindow : Boolean = true) : void
		{
			if(container == null)
				container = Global.dialogsContainer;
				
			new ResourceScanner().apply(dialog);
			
			if(modal)
				GraphUtils.attachModalShadow(dialog, docenterWindow);
			
			if(docenterWindow)
				centerWindow(dialog);
			
			if(Global.stage)
				Global.stage.focus = null;
			
			if(Global.root)
				container.addChild(dialog);
		}
		
		private static function showDialog(dialog : DialogViewBase, centerWindow : Boolean = true) : DialogViewBase
		{
			dialog.show(centerWindow);
			return dialog;
		}

	}
}