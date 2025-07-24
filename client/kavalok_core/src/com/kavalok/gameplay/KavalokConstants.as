package com.kavalok.gameplay
{
	import com.kavalok.constants.Locations;
	
	import flash.geom.Rectangle;
	
	public class KavalokConstants
	{
		public static var LOCALIZATION_URL_FORMAT : String = "resources/localization/{0}.{1}.xml";

		public static const LOCATION_PREFIX : String = "loc";
		public static const LOCATION_LIMIT : int = 75;
		
		static public const STARTUP_LOCS:Array = [Locations.LOC_0, Locations.LOC_3, Locations.LOC_PARK];
		
		public static const CITIZEN_MONEY_MULTIPLIER : Number = 2;
		public static const MONEY_CHAR : String = "";
		public static const SCREEN_WIDTH : Number = 900;
		public static const SCREEN_HEIGHT : Number = 510;
		static public const LOGIN_PATTERN : RegExp = /[a-zA-Z0-9]+/g;
		static public const LOGIN_CHARS : String = "a-zA-Z0-9";
		static public const PET_CHARS : String = "a-zA-Z0-9";

		public static const MODAL_SHADOW_COLOR : Number = 0;
		public static const MODAL_SHADOW_ALPHA : Number = 0.5;
		
		public static const SCREEN_RECT : Rectangle = new Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);

		public static const MY_MESSAGE_FORMAT : String = "<font color='#4785C4'><b>{0}:</b></font> {1}";
		public static const OTHERS_MESSAGE_FORMAT : String = "<font color='#DD5E14'><b>{0}:</b></font> {1}";
		public static const MAX_CHAT_CHARS : uint = 100;
		public static const MAX_CHAT_WORD : uint = 30;

		public static const LOGIN_LENGTH : uint = 16;
		public static const PASSWORD_LENGTH : uint = 64;
		public static const MAX_TEXT_LENGTH : uint = 150;
		
		static public const EMAIL_EXP:RegExp = /[a-zA-Z0-9._%-]+@[a-zA-Z0-9-.]+\.[a-zA-Z]{2,255}/;
		static public const LOCALE_DE:String = "deDE";
		static public const LOCALES:Array = ["enUS", "uaUA", "ruRU", LOCALE_DE, "enIN"];
		static public const TIPS_COUNT:int = 41;
		
		static public const DEFAULT_FONT:String = "Tahoma";
		
		static public const WIDGET_CHAR:String = "widgetChar";

		static public const MODIFIER_PREFIX:String = 'modifier_';

	}
}