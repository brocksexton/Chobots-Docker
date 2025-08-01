package com.kavalok.login.redesign
{
	import com.kavalok.Global;
	import com.kavalok.constants.Modules;
	import com.kavalok.dialogs.Dialogs;
	import com.kavalok.events.EventSender;
	import com.kavalok.gameplay.KavalokConstants;
	import com.kavalok.gameplay.controls.CheckBoxStates;
	import com.kavalok.gameplay.controls.EnabledButton;
	import com.kavalok.gameplay.controls.StateButton;
	import com.kavalok.localization.Localiztion;
	import com.kavalok.localization.ResourceBundle;
	import com.kavalok.login.McLoginView;
	import com.kavalok.utils.Strings;
	
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	public class LoginView extends CharPageBase
	{
		private static var bundle:ResourceBundle = Localiztion.getBundle(Modules.LOGIN);

		private var _registerEvent : EventSender = new EventSender();
		private var _loginEvent : EventSender = new EventSender();
		private var _messageEvent : EventSender = new EventSender();
		
		private var _content : McLoginView;
		private var _loginCheckBox:StateButton;
		
		private var _errorEvent : EventSender = new EventSender(String);
		private var _restorePasswordEvent : EventSender = new EventSender();
		
		
		public function LoginView(content:McLoginView)
		{
			_content = content;
			super(content);
			_loginCheckBox = new StateButton(_content.loginCheckBox);
			initForm();
			Global.stage.focus = _content.txtLogin;
		}
		
		public function get restorePasswordEvent() : EventSender
		{
			return _restorePasswordEvent;
		}
		public function get messageEvent() : EventSender
		{
			return _messageEvent;
		}
		public function get errorEvent() : EventSender
		{
			return _errorEvent;
		}

		public function get loginEvent() : EventSender
		{
			return _loginEvent;
		}
		
		public function get registerEvent() : EventSender
		{
			return _registerEvent;
		}
		
		override public function get login():String
		{
			return Strings.trim(_content.loginField.text).toLowerCase();
		}

		override public function set login(value:String) : void
		{
			super.login = value;
			_content.loginField.text = value;

		}
		
		public function set passw(value:String) : void
		{
			 _content.passwField.text = value;
		}
		public function get passw():String
		{
			 return Strings.trim(_content.passwField.text);
		}

		public function set guestEnabled(value : Boolean) : void
		{
			_content.guestButton.visible = value;
		}
		
		public function set registrationEnabled(value : Boolean) : void
		{
			_content.newButton.visible = value;
			_content.registerField.visible = value;
		}
		
		protected function initForm():void
		{
			login = Global.localSettings.login || '';
			var passw:String = Global.localSettings.passw || '';
			
						
			new EnabledButton(_content.newButton);
			new EnabledButton(_content.playButton);
			
			_loginCheckBox.state = (login.length > 0) ? 2 : 1;
			_loginCheckBox.stateEvent.addListener(onLoginSaveClick);  
			
			_content.loginField.maxChars = KavalokConstants.LOGIN_LENGTH;
			_content.loginField.text = login;
			_content.loginField.setSelection(0, login.length);
			_content.loginField.addEventListener(FocusEvent.FOCUS_OUT, updateCharModel);
			
			_content.passwField.maxChars = KavalokConstants.PASSWORD_LENGTH;
			_content.passwField.text = passw;
			_content.passwField.displayAsPassword = true;
			//_content.passwField.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			//_content.loginField.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			_content.newButton.addEventListener(MouseEvent.CLICK, registerEvent.sendEvent);
			_content.membershipButton.addEventListener(MouseEvent.CLICK, onMembershipClick);
			
			
			_content.playButton.addEventListener(MouseEvent.CLICK, onPlayClick);
//			_content.guestButton.addEventListener(MouseEvent.CLICK, onGuestClick);
			_content.forgotButton.addEventListener(MouseEvent.CLICK, onForgotClick);
			_content.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			updateCharModel();
		}
		
		private function onKeyUp(event: KeyboardEvent) : void
		{
			if(event.charCode == Keyboard.ENTER)
				tryLogin();
		}
		
		private function onMembershipClick(event: MouseEvent) : void
		{
			Global.externalCalls.tryLoadMembership();
//			Global.moduleManager.loadModule(Modules.MEMBERSHIP, {showClose : true});
		}
		private function onPlayClick(event: MouseEvent) : void
		{
			tryLogin();
		}
		
		protected function tryLogin():void
		{
			saveParameters();
			
			if (checkFields())
				loginEvent.sendEvent();
		}
		
		private function onForgotClick(e:Event):void
		{
			restorePasswordEvent.sendEvent();
		}
		
		private function checkFields():Boolean
		{
			if (login.length == 0)
			{
				errorEvent.sendEvent(bundle.messages.pleaseEnterLogin);
				return false;
			}
			
			if (passw.length == 0)
			{
				errorEvent.sendEvent(bundle.messages.badPassw);
				return false;
			}
			
			return true;
		}
		
		private function onLoginSaveClick(sender:Object = null):void
		{
			saveParameters();
		}	
		
		protected function saveParameters():void
		{
			Global.localSettings.login = (_loginCheckBox.state == CheckBoxStates.SELECTED) ? login : '';
			Global.localSettings.passw = (_loginCheckBox.state == CheckBoxStates.SELECTED) ? passw : '';
		}
		
	}
}