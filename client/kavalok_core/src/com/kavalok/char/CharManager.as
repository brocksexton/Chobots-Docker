package com.kavalok.char
{
	import com.kavalok.Global;
	import com.kavalok.char.modifiers.DanceModifier;
	import com.kavalok.constants.StuffTypes;
	import com.kavalok.dto.friend.FriendTO;
	import com.kavalok.dto.pet.PetTO;
	import com.kavalok.dto.stuff.StuffItemLightTO;
	import com.kavalok.dto.stuff.StuffTypeTO;
	import com.kavalok.events.EventSender;
	import com.kavalok.gameplay.KavalokConstants;
	import com.kavalok.gameplay.chat.BubbleStyles;
	import com.kavalok.gameplay.commands.StartupMessageCommand;
	import com.kavalok.gameplay.frame.bag.dance.DanceSerializer;
	import com.kavalok.loaders.AdvertisementLoaderView;
	import com.kavalok.login.LoginManager;
	import com.kavalok.messenger.commands.CitizenMembershipEndMessage;
	import com.kavalok.messenger.commands.TipMessage;
	import com.kavalok.remoting.RemoteCommand;
	import com.kavalok.remoting.commands.LoadQuestCommand;
	import com.kavalok.robots.Robot;
	import com.kavalok.services.CharService;
	import com.kavalok.services.SecuredRed5ServiceBase;
	import com.kavalok.services.StuffServiceNT;
	import com.kavalok.utils.Timers;
	
	import flash.utils.getQualifiedClassName;

	public class CharManager
	{
		static public const CHAR_STATE_PREFIX:String='char_';
		static public const GUEST:String='GUEST';
		static public const DEFAULT_BODY:String='default';


		private var _addModifierEvent:EventSender=new EventSender();
		private var _removeModifiearEvent:EventSender=new EventSender();
		private var _drawEnabledChangeEvent:EventSender=new EventSender();
		private var _moneyChangeEvent:EventSender=new EventSender();
		private var _playerCardChangeEvent:EventSender=new EventSender();
		private var _charViewChangeEvent:EventSender=new EventSender();
		private var _robotChangeEvent:EventSender=new EventSender();

		private var _initialized:Boolean;
		private var _charId:String;
		private var _userId:Number;
		private var _age:Number=-1;
		private var _email:String;
		private var _modifiers:Object={};
		private var _isGuest:Boolean;
		private var _isNotActivated:Boolean;
		private var _isParent:Boolean;
		private var _isAgent:Boolean;
		private var _isCitizen:Boolean;
		private var _isModerator:Boolean;
		private var _homeLevel:int;
		private var _citizenExpirationDate:Date;
		private var _citizenTryCount:int;
		private var _created:Date;
		private var _drawEnabled:Boolean;
		private var _baned:Boolean;
		private var _friends:Friends=new Friends();
		private var _ignores:Ignores=new Ignores();
		private var _stuffs:Stuffs=new Stuffs();
		private var _instrument:String=null;
		private var _magicItem:String=null;
		private var _magicStuffItemRain:String=null;
		private var _magicStuffItemRainCount:int=0;
		private var _dances:Array=[null, null, null];
		private var _robot:Robot;
		private var _robotTeam:RobotTeam = new RobotTeam();

		private var _money:Number;
		private var _body:String;
		private var _color:int;
		private var _tool:String;
		private var _actionsTime:Object={};
		private var _moodId:String;
		private var _helpEnabled:Boolean;
		private var _firstLogin:Boolean;
		private var _finishingNotification:Boolean;
		private var _finishedNotification:Boolean;
		private var _playerCard:StuffItemLightTO;

		private var _serverChatDisabled:Boolean;
		private var _serverDrawDisabled:Boolean;
		private var _nonCitizenChatDisabled:Boolean;
		private var _chatEnabledByMod:Boolean;
		private var _chatEnabledByParent:Boolean;

		private var _readyEvent:EventSender=new EventSender();
		private var _citizenChangeEvent:EventSender=new EventSender();
		private var _toolChangeEvent:EventSender=new EventSender();
		private var _instrumentChangeEvent:EventSender=new EventSender();
		private var _magicItemChangeEvent:EventSender=new EventSender();
		private var _magicStuffItemRainChangeEvent:EventSender=new EventSender();

		public function CharManager()
		{
		}

		public function get dances():Array
		{
			return _dances;
		}

		private function onMood(moodId:String):void
		{
			_moodId=moodId;
		}
		
		public function get bubleStyle():String
		{
			if (isModerator)
				return BubbleStyles.MODERATOR;
			else if (isCitizen && isAgent)	
				return BubbleStyles.CITIZEN_AGENT;
			else if (isCitizen)	
				return BubbleStyles.CITIZEN;
			else if (isAgent)
				return BubbleStyles.AGENT;
			else
				return BubbleStyles.DEFAULT;
		}

		public function get modifiersList():Array
		{
			var list:Array=[];
			for each(var info:Object in _modifiers)
			{
				list.push(info);
			}
			return list;
		}

		public function getCharStateId(charId:String):String
		{
			return CHAR_STATE_PREFIX + charId;
		}

		public function addModifier(className:String, parameter:Object):void
		{
			if (className in _modifiers)
				delete _actionsTime[className];

			var info:Object={className:className, parameter:parameter}
			_modifiers[className]=info;
			_addModifierEvent.sendEvent(info);
		}

		public function removeModifier(className:String):void
		{
			delete _modifiers[className];
			delete _actionsTime[className];
			_removeModifiearEvent.sendEvent(className);
		}

		public function initialize():void
		{
			_charId=Global.loginManager.userLogin;
			if (_initialized)
			{
				new CharService(onGetKey).gK();
			}
			else
			{
				_initialized=true;
				new CharService(onEnterGame).enterGame(charId);
				_stuffs.refreshEvent.addListener(onStuffsRefresh);
			}
		}
		
		private function onStuffsRefresh():void
		{
//			if (_playerCard && _stuffs.getById(_playerCard.id) == null)
//				playerCard = null;
		}

		private function executeCommands(commands:Array):void
		{
			for each(var properties:Object in commands)
			{
				RemoteCommand.createInstance(properties).execute();
			}
		}

		public function enableChat():void
		{
			_baned=false;
			if (canHaveTextChat)
				Global.notifications.chatEnabled=true;
		}

		private function createQuests(quests:Array):void
		{
			for each(var questName:String in quests)
			{
				var command:LoadQuestCommand=new LoadQuestCommand();
				command.parameter=questName;
				command.execute();
			}
		}

		private function getLoginTip():void
		{
			var command:TipMessage=new TipMessage();
			command.tipId=int(Math.random() * KavalokConstants.TIPS_COUNT);
			command.execute();
		}

		private function onBotClothes(items:Array):void
		{
			var botStuffs:Array=[];

			var item:StuffTypeTO=items[int(Math.random() * items.length)];

			var clothe:StuffItemLightTO=new StuffItemLightTO();
			clothe.fileName=item.fileName;
			clothe.color=int(Math.random() * 0xFFFFFF);
			clothe.used=true;
			clothe.type=StuffTypes.CLOTHES;

			botStuffs.push(clothe);

			_body=DEFAULT_BODY;
			_color=Math.random() * 0xFFFFFF;
			_stuffs.setList(botStuffs);
		}

		public function refreshMoney():void
		{
			new CharService(onGetMoney).getCharMoney();
		}

		private function onGetMoney(result:Number):void
		{
			money=result;
		}

		public function removeStaticModifiers():void
		{
			for each(var modifier:Object in modifiersList)
			{
				var danceModifier:String=getQualifiedClassName(DanceModifier);
				if (modifier.className == danceModifier)
					Global.charManager.removeModifier(danceModifier);
			}
		}

		public function setBan(banLeftTime:int):void
		{
			_baned=true;
			Global.notifications.chatEnabled=false;
			Timers.callAfter(enableChat, banLeftTime);
		}

		private function onGetKey(result:Object):void
		{
			SecuredRed5ServiceBase.securityKey=result.securityKey;
			Global.chatSecurityKey=result.chatSecurityKey;
			_readyEvent.sendEvent();
		}

		private function onEnterGame(result:Object):void
		{

			if(result==null){			
				LoginManager.showError();
				return;
			}
			
			AdvertisementLoaderView.initialize();

			_serverChatDisabled=result.serverInSafeMode;
			_serverDrawDisabled=result.serverInSafeMode;
			_nonCitizenChatDisabled=result.nonCitizenChatDisabled;

			SecuredRed5ServiceBase.securityKey=result.securityKey;
			Global.chatSecurityKey=result.chatSecurityKey;
			_baned=result.chatBanLeftTime > 0
	

			_chatEnabledByMod = result.chatEnabled;
			_chatEnabledByParent = result.chatEnabledByParent;
			
			var frnd : Array = [];
			for (var i:int = 0; i < result.friends.length; i++)
			{
				var friend:FriendTO = new FriendTO(result.friends[i]);
				frnd.push(friend);
			}
			_friends.list=frnd;
			_ignores.list=result.ignoreList
			_firstLogin=result.firstLogin;
			_helpEnabled=result.helpEnabled;
			_isGuest=result.isGuest;
			_isNotActivated=result.notActivated;
			_isParent=result.isParent;
			_isAgent=result.isAgent;
			_isModerator=result.isModerator;
			_isCitizen=result.isCitizen;
			_drawEnabled=result.drawEnabled;
			_citizenExpirationDate=result.citizenExpirationDate;
			_citizenTryCount=result.citizenTryCount;
			_email=result.email;
			_homeLevel=result.homeLevel;
			_created=result.created;
			_money=result.money;
			_finishingNotification=result.finishingNotification;
			_finishedNotification=result.finishedNotification;
			_userId=result.userId;
			_age=result.age;
			_playerCard = result.playerCard;
			if(!_isGuest){
				_robotTeam.list = result.robotTeam;
				_robotTeam.color = result.teamColor;
				if (result.robot)
					_robot = new Robot(result.robot);
			}
			
			
			_dances=[];
			for each(var dance:String in result.dances)
			{
				_dances.push(new DanceSerializer().deserialize(dance));
			}
			
			if (_baned && result.chatEnabledByParent)
				setBan(result.chatBanLeftTime);
			else
				Global.notifications.chatEnabled = canHaveTextChat && result.chatEnabled && result.chatEnabledByParent && !result.notActivated;

			Global.musicVolume = result.musicVolume;
			Global.soundVolume = result.soundVolume;
			Global.showTips = result.showTips;
			Global.showCharNames = result.showCharNames;
			Global.acceptRequests = result.acceptRequests;
			Global.superUser = result.superUser;


			var serverTime:Date=result.serverTime;
			serverTime.setTime(serverTime.getTime() - serverTime.timezoneOffset * 60 * 1000);
			Global.serverTimeDiff=(result.serverTime as Date).time - new Date().time;

			executeCommands(result.commands);
			createQuests(result.quests);

			if (!isCitizen && result.pet)
				PetTO(result.pet).atHome=true;
			Global.petManager.initialzie(result.pet);

			Global.localSettings.userId=charId;
			if (Global.showTips && !Global.startupInfo.isBot)
				getLoginTip();
			Global.frame.moodEvent.addListener(onMood);

			if (result.body == GUEST)
				result.body='default';
			if (result.notActivated)
				new StartupMessageCommand('notActivatedStartup').execute();
				
			if (_finishedNotification)
			{
				var msg1:CitizenMembershipEndMessage=new CitizenMembershipEndMessage('membershipFinishedCaption', 'membershipFinishedText');
				Global.inbox.addMessage(msg1);
				msg1.show();
			}
			else if (_finishingNotification)
			{
				var msg2:CitizenMembershipEndMessage=new CitizenMembershipEndMessage('membershipFinishingCaption', 'membershipFinishingText');
				Global.inbox.addMessage(msg2);
				msg2.show();
			}

			if (!Global.startupInfo.isBot)
			{
				_body=result.body;
				_color=result.color;
				_stuffs.setList(result.stuffs);
			}
			else
			{
				new StuffServiceNT(onBotClothes).getStuffTypes('kostjumy');
			}

			_readyEvent.sendEvent();
		}

		public function get isFriendsFull():Boolean
		{
			var maxFriends:int=Friends.REGULAR_LIMIT;

			if (Global.superUser || isModerator)
				maxFriends=Friends.SUPER_LIMIT;
			else if (_isCitizen)
				maxFriends=Friends.CITIZEN_LIMIT;
			else if (_isAgent)
				maxFriends=Friends.AGENT_LIMIT;

			return _friends.length >= maxFriends;
		}
		
		public function get backPackLimit():int
		{
			return (_isCitizen)
				? Stuffs.BACKPACK_CITIZEN_SIZE
				: Stuffs.BACKPACK_REGULAR_SIZE;
		}
		
		public function get actionsTime():Object
		{
			return _actionsTime;
		}

		public function get readyEvent():EventSender { return _readyEvent; }
		public function get removeModifiearEvent():EventSender { return _removeModifiearEvent; }
		public function get playerCardChangeEvent():EventSender { return _playerCardChangeEvent; }		
		public function get addModifierEvent():EventSender { return _addModifierEvent; }
		public function get citizenChangeEvent():EventSender { return _citizenChangeEvent; }
		public function get drawEnabledChangeEvent():EventSender { return _drawEnabledChangeEvent; }
		public function get moneyChangeEvent():EventSender { return _moneyChangeEvent; }
		public function get toolChangeEvent():EventSender { return _toolChangeEvent; }
		public function get instrumentChangeEvent():EventSender { return _instrumentChangeEvent; }
		public function get magicItemChangeEvent():EventSender { return _magicItemChangeEvent; }
		public function get magicStuffItemRainChangeEvent():EventSender { return _magicStuffItemRainChangeEvent; }
		public function get charViewChangeEvent():EventSender { return _charViewChangeEvent; }		
		public function get robotChangeEvent():EventSender { return _robotChangeEvent; }		

		public function get created():Date { return _created; }
		public function get charId():String { return _charId; }
		public function get userId():Number { return _userId; }
		public function get age():Number { return _age; }
		public function get stuffs():Stuffs { return _stuffs; }
		public function get friends():Friends { return _friends; }
		public function get ignores():Ignores { return _ignores; }
		public function get isGuest():Boolean { return _isGuest; }
		public function get isNotActivated():Boolean { return _isNotActivated; }
		public function get isParent():Boolean { return _isParent; }
		public function get isAgent():Boolean { return _isAgent; }
		public function get isCitizen():Boolean { return _isCitizen; }
		public function get isModerator():Boolean { return _isModerator; }
		public function get email():String { return _email; }
		public function get moodId():String { return _moodId; }
		public function get helpEnabled():Boolean { return _helpEnabled; }
		public function get firstLogin():Boolean { return _firstLogin; }
		public function get robotTeam():RobotTeam { return _robotTeam; }
		
		public function get playerCard():StuffItemLightTO { return _playerCard; }
		public function set playerCard(value:StuffItemLightTO):void
		{
			 _playerCard = value;
			 
			 if (_playerCard)
			 	new CharService().savePlayerCard(_playerCard.id);
			 else
			 	new CharService().savePlayerCard(-1);
			 
			 _playerCardChangeEvent.sendEvent();
		}
		
		public function get tool():String { return _tool; }
		public function set age(value:Number):void { _age=value; }
		public function set tool(value:String):void
		{
			_tool=value;
			_toolChangeEvent.sendEvent();
		}

		public function get instrument():String { return _instrument; }
		public function set instrument(value:String):void
		{
			_instrument=value;
			_instrumentChangeEvent.sendEvent();
		}
		
		public function get magicItem():String { return _magicItem; }
		public function set magicItem(value:String):void
		{
			 _magicItem = value;
			 _magicItemChangeEvent.sendEvent();
		}
		public function get magicStuffItemRain():String { return _magicStuffItemRain; }
		public function set magicStuffItemRain(value:String):void
		{
			 _magicStuffItemRain = value;
			 _magicStuffItemRainChangeEvent.sendEvent();
		}
		public function get magicStuffItemRainCount():int { return _magicStuffItemRainCount; }
		public function set magicStuffItemRainCount(value:int):void
		{
			 _magicStuffItemRainCount = value;
		}

		public function get money():Number { return _money; }
		public function set money(value:Number):void
		{
			_money=value;
			moneyChangeEvent.sendEvent();
		}

		public function get baned():Boolean { return _baned; }
		public function set baned(baned:Boolean):void
		{
			_baned = baned;
		}

		public function set citizen(value:Boolean):void
		{
			_isCitizen=value;
			_citizenChangeEvent.sendEvent();
		}

		public function get finishedNotification():Boolean { return _finishedNotification; }
		public function set finishedNotification(value:Boolean):void
		{
			_finishedNotification=value;
		}

		public function get finishingNotification():Boolean { return _finishingNotification; }
		public function set finishingNotification(value:Boolean):void
		{
			_finishingNotification=value;
		}

		public function get citizenTryCount():int { return _citizenTryCount; }
		public function set citizenTryCount(value:int):void
		{
			_citizenTryCount=value;
		}

		public function get citizenExpirationDate():Date { return _citizenExpirationDate; }
		public function set citizenExpirationDate(value:Date):void
		{
			_citizenExpirationDate=value;
		}

		public function get body():String { return _body; }
		public function set body(value:String):void
		{
			_body=value;
			_charViewChangeEvent.sendEvent();
		}

		public function get clothes():Array { return _stuffs.getUsedClothes(); }
		public function set clothes(value:Array):void
		{
			_stuffs.setUsedClothes(value);
			_charViewChangeEvent.sendEvent();
		}
		public function applyClothes(value:Array):void
		{
			_stuffs.addUsedClothes(value);
			_charViewChangeEvent.sendEvent();
		}
		
		public function get color():int { return _color; }
		public function set color(value:int):void
		{
			_color=value;
			_charViewChangeEvent.sendEvent();
		}

		public function get drawEnabled():Boolean { return _drawEnabled; }
		public function set drawEnabled(value:Boolean):void
		{
			_drawEnabled=value;
			_drawEnabledChangeEvent.sendEvent();
		}
		
		public function get hasRobot():Boolean { return Boolean(_robot); }
		
		public function get robot():Robot { return _robot; }
		public function set robot(value:Robot):void
		{
			 _robot = value;
			 _robotChangeEvent.sendEvent();
		}

		public function getCharState():Object
		{
			var state:Object={id:_charId, body:_body, color:_color, clothes:_stuffs.getUsedClothes(), tool:_tool, userId:_userId}
			return state;
		}

		public function get isInitialised():Boolean
		{
			return _charId != null;
		}

		public function get canHaveTextChat():Boolean
		{
			return !_baned
			&& !_isGuest
			&& !_serverChatDisabled
			&& (_isCitizen || !_nonCitizenChatDisabled)
			&& _chatEnabledByMod
			&& _chatEnabledByParent;
		}

		public function set serverChatDisabled(serverChatDisabled:Boolean):void
		{
			if (_serverChatDisabled != serverChatDisabled)
			{
				_serverChatDisabled=serverChatDisabled;

				Global.notifications.chatEnabled = canHaveTextChat;
			}
		}
		
		public function set chatEnabledByMod(chatEnabledByMod:Boolean):void
		{
			_chatEnabledByMod = chatEnabledByMod
		}

		public function set chatEnabledByParent(chatEnabledByParent:Boolean):void
		{
			_chatEnabledByParent = chatEnabledByParent
		}
		
		public function get serverChatDisabled():Boolean
		{
			return _serverChatDisabled;
		}

		public function get serverDrawDisabled():Boolean
		{
			return _serverDrawDisabled;
		}

		public function set serverDrawDisabled(serverDrawDisabled:Boolean):void
		{
			if (_serverDrawDisabled != serverDrawDisabled)
			{
				_serverDrawDisabled=serverDrawDisabled;
				_drawEnabledChangeEvent.sendEvent();
			}
		}

	}
}





