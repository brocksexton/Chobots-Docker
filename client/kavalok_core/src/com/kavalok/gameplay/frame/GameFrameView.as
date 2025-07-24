package com.kavalok.gameplay.frame
{
	import com.kavalok.Global;
	import com.kavalok.border.McBorder;
	import com.kavalok.constants.Locations;
	import com.kavalok.constants.Modules;
	import com.kavalok.constants.ResourceBundles;
	import com.kavalok.dialogs.DialogMoneyView;
	import com.kavalok.dialogs.Dialogs;
	import com.kavalok.events.EventSender;
	import com.kavalok.gameplay.GameMenu;
	import com.kavalok.gameplay.MoodPanel;
	import com.kavalok.gameplay.ToolTips;
	import com.kavalok.gameplay.commands.CitizenWarningCommand;
	import com.kavalok.gameplay.commands.RegisterGuestCommand;
	import com.kavalok.gameplay.frame.bag.MiniBagView;
	import com.kavalok.gameplay.frame.bag.MiniCardsView;
	import com.kavalok.gameplay.frame.bag.MiniDanceView;
	import com.kavalok.gameplay.frame.bag.MiniMagicView;
	import com.kavalok.gameplay.frame.bag.MiniMusicView;
	import com.kavalok.gameplay.frame.tips.TipsWindowView;
	import com.kavalok.gameplay.tips.TipWindow;
	import com.kavalok.localization.Localiztion;
	import com.kavalok.localization.ResourceBundle;
	import com.kavalok.messenger.Messenger;
	import com.kavalok.ui.Window;
	import com.kavalok.utils.ResourceScanner;
	import com.kavalok.utils.Strings;
	
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	
	public class GameFrameView 
	{
		private static const MONEY_FORMAT : String = "{0}";
		
		private var _content : McBorder;
		private var _messageWindowView:MessageWindowView;
		private var _miniBag:MiniBagView;
		private var _miniCards:MiniCardsView;
		private var _miniDance:MiniDanceView;
		private var _miniMusic:MiniMusicView;
		private var _miniMagic:MiniMagicView;
		private var _moodPanel:MoodPanel;
		private var _rightPanel:RightPanelView;
		private var _tips:TipsWindowView;
		private var _bundle:ResourceBundle;
		
		private var _moodEvent:EventSender = new EventSender();
		private var _initialized:Boolean = false;
		
		public function GameFrameView()
		{
		}
		
		public function get initialized():Boolean
		{
			return _initialized;
		}

		public function get tipsVisible():Boolean
		{
			return _content.helpButton.visible;
		}

		public function setFocus():void
		{
			if(_messageWindowView)
				_messageWindowView.setFocus();
		}

		public function initialize():void
		{
			if(_initialized)
				return;
			_initialized = true;
			
			_content = new McBorder();
			new ResourceScanner().apply(_content);
			_bundle = Global.resourceBundles.kavalok; //don't move to static
			
			_tips = new TipsWindowView(_content.helpButton);
			_content.addChildAt(_tips.content, 0);
			
			_moodPanel = new MoodPanel();
			_moodPanel.moodEvent.addListener(_moodEvent.sendEvent);
			
			_rightPanel = new RightPanelView(_content.rightPanel);
			
			_miniBag = new MiniBagView();
			_miniBag.applyEvent.addListener(onUseMiniView);
			
			_miniCards = new MiniCardsView();
			_miniCards.applyEvent.addListener(onUseMiniView);
			
			_miniDance = new MiniDanceView();
			_miniDance.applyEvent.addListener(onUseMiniView);
			_miniDance.openEvent.addListener(onMiniViewOpen);
			_miniMusic = new MiniMusicView();
			_miniMusic.applyEvent.addListener(onUseMiniView);
			_miniMagic = new MiniMagicView();
			_miniMagic.applyEvent.addListener(onUseMiniView);
			
			_messageWindowView = new MessageWindowView(_content.messageWindow);
			
			initInbox();
			initButtons();
			
			Global.charManager.moneyChangeEvent.addListener(refreshMoney);
			Global.charManager.instrumentChangeEvent.addListener(refresh);
			Global.charManager.magicItemChangeEvent.addListener(refresh);
			Global.charManager.magicStuffItemRainChangeEvent.addListener(refresh);
			Global.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			Global.locationManager.locationChange.addListener(refresh);
			Global.locationManager.locationDestroy.addListener(refresh);
			Global.moduleManager.moduleReadyEvent.addListener(refresh);
			
			refresh();
			refreshMoney();
		}
		
		private function initButtons():void
		{
			initButton(_content.menuButton, onMenuClick, 'menu');
			initButton(_content.homeButton, onHomeClick, 'home');
			initButton(_content.moodButton, onMoodClick, 'emoIcons');
			initButton(_content.mapButton, onMapClick, 'map');
			initButton(_content.stuffButton, onBagClick, 'bag');
			initButton(_content.newsButton, onNewsClick, 'news');
			initButton(_content.adminMsgButton, onAdminMessageClick, 'adminMsg');
			initButton(_content.friendsButton, onFriendsClick, 'friends');
			initButton(_content.helpButton, onHelpClick, 'help');
			initButton(_content.danceButton, onDanceClick, 'dance');
			initButton(_content.familyButton, onFamilyClick, 'family');
			initButton(_content.musicButton, onMusicClick, 'musicAction');
			initButton(_content.magicButton, onMagicClick, 'magicAction');
			initButton(_content.mcTopPanel.academyButton, onAcademyClick, 'academy');
			initButton(_content.mcTopPanel.statusButton, onStatusClick, 'status');
			initButton(_content.mcTopPanel.moneyButton, onMoneyClick, 'money');
			initButton(_content.mcMessageButton, onMessageClick, 'messages');
			
			_content.mapButton.addEventListener(MouseEvent.MOUSE_OVER, onMapOver);
			onMapOver(null);
		}
		
		private function onMapOver(e:MouseEvent):void
		{
			var tipText:String = Global.messages.map + ' - '
				+ Localiztion.getBundle("serverSelect").messages[Global.loginManager.server];
				 
			ToolTips.registerObject(_content.mapButton, tipText);
		}
		
		private function initButton(button:InteractiveObject, handler:Function, tip:String):void
		{
			button.addEventListener(MouseEvent.CLICK, handler);
			if (tip)
				ToolTips.registerObject(button, tip, ResourceBundles.KAVALOK);
		}
		
		private function onFamilyClick(e:Event):void
		{
			if (Global.charManager.isGuest || Global.charManager.isNotActivated)
				new RegisterGuestCommand().execute();
			else
				Global.moduleManager.loadModule(Modules.FAMILY);
		}
		
		private function initInbox():void
		{
			var inboxContent:Sprite = Global.inbox.content;
			inboxContent.x = _content.mcMessageButton.x;
			inboxContent.y = _content.mcMessageButton.y;
			Global.inbox.messageEvent.addListener(onInboxChange);
			onInboxChange();
			_content.addChild(inboxContent);
			_content.mcMessageButton.buttonMode = true;
		}
		
		public function onKeyDown(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.F1)
				onHelpClick();
		}
		
		private function onDanceClick(event : MouseEvent) : void
		{
			openRightPanel(_miniDance.content);
			event.stopPropagation();
		}
		
		private function onMusicClick(event:MouseEvent):void
		{
			if (Global.charManager.isCitizen)
			{
				openRightPanel(_miniMusic.content);
				event.stopPropagation();
			}
			else
			{
				new CitizenWarningCommand("instruments", null).execute();
			}
		}
		
		private function onMagicClick(event:MouseEvent):void
		{
			_miniMagic.refresh();
			openRightPanel(_miniMagic.content);
			event.stopPropagation();
		}
		
		private function onBagClick(event:MouseEvent):void
		{
			openRightPanel(_miniBag.content);
			event.stopPropagation();
		}
		
		public function openCards():void
		{
			openRightPanel(_miniCards.content);
		}
		
		private function onMessageClick(e:Event):void
		{
			if (!Global.inbox.visible)
				Global.inbox.visible = true;
		}
		
		private function onInboxChange():void
		{
			var clip:MovieClip = _content.mcMessageButton;
			
			if (Global.inbox.messages.length == 0)
				clip.gotoAndStop(4);
			else if (Global.inbox.hasNewMessages)
				clip.gotoAndStop(2);
			else
				clip.gotoAndStop(3);
		}
		
		private function onMenuClick(e:Event):void
		{
			Dialogs.showOkDialog(null, true, new GameMenu().content); 
		}
		
		private function onMiniViewOpen():void
		{
			_rightPanel.setOpen();
		}
		private function onUseMiniView():void
		{
			if (!_rightPanel.isPin)
				_rightPanel.open = false;
		}
		
		private function onHelpClick(e:MouseEvent = null):void
		{
			_tips.visible = !_tips.visible;
		}
		
		private function onAdminMessageClick(e:MouseEvent):void
		{
			var view : AdminMessageView = new AdminMessageView();
			view.show();
		}
		
		private function onHomeClick(e:MouseEvent):void
		{
			if (Global.charManager.isGuest)
				new RegisterGuestCommand().execute();
			else
				Global.locationManager.goHome();
		}
		
		private function onNewsClick(event:MouseEvent):void
		{
			//Global.moduleManager.loadModule(Modules.NEWS_PAPER);
    	   Dialogs.showNewsDialog();
		}
		
		public function refresh():void
		{
			var locId:String = (Global.locationManager.locationExists)
				? Global.locationManager.locationId : '';
			
			var isHome:Boolean = (locId == Modules.HOME);
			var isLocation:Boolean = Locations.isLocation(locId) && !isHome;
			var isMission:Boolean = locId.indexOf('mission') == 0;
			var isGame:Boolean = locId.indexOf('game') == 0;
			
			
			_content.moodButton.visible		= isLocation || isMission || isHome || isGame;
			_content.helpButton.visible		= isLocation || isMission || isHome || isGame;
			_content.messageWindow.visible	= isLocation || isMission || isHome || isGame;
			
			_content.stuffButton.visible	= isLocation || isMission || isHome;
			_content.newsButton.visible		= isLocation || isMission || isHome;
			_content.adminMsgButton.visible = isLocation || isMission || isHome;
			_content.mcTopPanel.visible		= isLocation || isMission || isHome;
			_content.danceButton.visible	= isLocation || isMission || isHome;
			_content.helpButton.visible		= isLocation || isMission || isHome;
			_content.menuButton.visible		= isLocation || isMission || isHome;
			_content.familyButton.visible	= isLocation || isMission || isHome;
			
			_content.musicButton.visible	= (isLocation || isMission || isHome)
				&& Global.charManager.instrument;
			if (!_content.musicButton.visible && _rightPanel.childContent == _miniMusic.content)
				_rightPanel.open = false;
			
			_content.magicButton.visible	= (isLocation || isMission || isHome)
				&& (Global.charManager.magicItem || Global.charManager.magicStuffItemRain);
			if (!_content.magicButton.visible && _rightPanel.childContent == _miniMagic.content)
				_rightPanel.open = false;
			
			_rightPanel.content.visible = !isGame;
			_content.homeButton.visible		= (isLocation || isMission);
			_content.mapButton.visible		= (isLocation || isHome);
			
			var windowsVisible:Boolean = isLocation || isMission || isHome;
			
			_content.friendsButton.visible = windowsVisible;
			_content.mcMessageButton.visible = windowsVisible; 
			
			if (!windowsVisible)
				Global.windowManager.hideAll();
			else
				Global.windowManager.showAll();
			
			refreshStatus();
		}
		
		public function refreshStatus():void
		{
			var messageId:String = (Global.charManager.isAgent)
				? 'statusAgent' : (Global.charManager.isCitizen)
				? 'statusCitizen'	: 'statusJunior';
				
			_bundle.registerTextField(_content.mcTopPanel.statusField, messageId);
		}
		
		private function onMapClick(event:MouseEvent):void
		{
			Global.locationManager.location.getOutFromEntryPoint();
			Global.moduleManager.loadModule(Modules.MAP);
			//openRightPanel(_miniMap.content);
			//event.stopPropagation();
		}
		
		private function openRightPanel(content : MovieClip) : void
		{
			if(!_rightPanel.open || _rightPanel.childContent == content)
			{
				_rightPanel.open = !_rightPanel.open;
			}
			_rightPanel.childContent = content;
		}
		
		private function onMoodClick(e:MouseEvent):void
		{
			if (_moodPanel.visible)
				_moodPanel.hide();
			else
				_moodPanel.show();
		}
		
		private function onFriendsClick(e:MouseEvent):void
		{
			if (Global.charManager.isGuest || Global.charManager.isNotActivated)
			{
				new RegisterGuestCommand().execute();
			}
			else
			{
				var window:Window = Global.windowManager.getWindow(Messenger.ID);
				if (window)
					Global.windowManager.activateWindow(window)
				else
					Global.windowManager.showWindow(new Messenger());
			}
		}
		
		public function set visible(value:Boolean):void
		{
			_content.visible = value;
		}
		public function get visible():Boolean
		{
			 return _content && _content.visible;
		}
		
		private function onAcademyClick(e:MouseEvent):void
		{
			var window : TipWindow = new TipWindow();
			window.loadTip(0);
			Dialogs.showDialogWindow(window.content);
		}
		
		private function onMoneyClick(e:MouseEvent):void
		{
			var dialog : DialogMoneyView = new DialogMoneyView();
			dialog.show();
		}
		
		private function onStatusClick(e:MouseEvent):void
		{
			if (Global.charManager.isGuest || Global.charManager.isNotActivated)
				new RegisterGuestCommand().execute();
			else if(!Global.charManager.isCitizen)
				Dialogs.showBuyAccountDialog("status");
			else{
				Dialogs.showCitizenStatusDialog("status");
			}
		}
		
		private function onConfirmExtendMembership() : void
		{
			Dialogs.showBuyAccountDialog("extend");
		}
		
		private function refreshMoney() : void
		{
			var field:TextField = _content.mcTopPanel.moneyField 
			field.text = Strings.substitute(MONEY_FORMAT, Global.charManager.money);
			
			_content.mcTopPanel.coin.x = field.x + 0.5 * field.width + 0.5 * field.textWidth + 2; 
		}
		
		public function get content():Sprite { return _content; }
		public function get tips():TipsWindowView { return _tips; }
		public function get moodEvent():EventSender { return _moodEvent; }
		
	}
}