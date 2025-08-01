package com.kavalok
{
	import com.kavalok.constants.StuffTypes;
	import com.kavalok.localization.Localiztion;
	import com.kavalok.utils.Strings;
	
	public class URLHelper
	{
		public static var RESOURCES_FOLDER_FORMAT : String = "resources/{0}/"
		public static var RESOURCES_PATH_FORMAT : String = RESOURCES_FOLDER_FORMAT + "{1}.swf"
		public static var MUSIC_PATH_FORMAT : String = "resources/music/{0}.mp3"
		public static var INSTRUMENT_PATH_FORMAT : String = "resources/instruments/{0}.mp3"
		public static var KAVALOK_CORE : String = "kavalok_core";
		public static var ROBOTS : String = "robots";
		
		private static var TYPES_FOLDERS : Object = getTypesFolders();
		
		private static function getTypesFolders() : Object
		{
			var result : Object = {};
			result[StuffTypes.BUGS] = "clothes";
			result[StuffTypes.CLOTHES] = "clothes";
			result[StuffTypes.STUFF] = "stuffs";
			result[StuffTypes.COCKTAIL] = "cocktails";
			result[StuffTypes.HOUSE] = "houses";
			result[StuffTypes.FURNITURE] = "furniture";
			result[StuffTypes.PETSTUFFS] = "petStuffs";
			result[StuffTypes.PLAYERCARD] = "playerCards";
			result[StuffTypes.ROBOT] = "robots";
			return result;
		}
		
		static public function instrumentMusicURL(musicName:String):String
		{
			return Strings.substitute(INSTRUMENT_PATH_FORMAT, musicName);
		}
		
		static public function get petModels() : String
		{
			return resourceURL("petModels", KAVALOK_CORE);
		}
		
		static public function getRobotModelURL(robotName:String) : String
		{
			return resourceURL(robotName + 'Model', ROBOTS);
		}
		
		static public function robotItemURL(fileName:String):String
		{
			return resourceURL(fileName, ROBOTS);
		}
		
		static public function petItemURL(fileName:String):String
		{
			return resourceURL(fileName, 'pets');
		}
		
		static public function petMessagesURL():String
		{
			return 'resources/localization/petMessages.'+Localiztion.locale+'.xml';
		}
		
		static public function get charModels() : String
		{
			return resourceURL("charModels", KAVALOK_CORE);
		}
		
		static public function stuffURL(id:String, type:String):String
		{
			if(type in TYPES_FOLDERS)
			{
				return resourceURL(id, TYPES_FOLDERS[type]);
			}

			trace ('Unknown stuff type!');
			return "";
		} 
		
		static public function charBodyURL(body:String):String
		{
			return resourceURL(body, 'charBody');
		}
		
		static public function charToolURL(tool:String):String
		{
			return resourceURL(tool, 'charTools');
		}
		
		static public function musicURL(musicName:String):String
		{
			return Strings.substitute(MUSIC_PATH_FORMAT, musicName);
		}
		
		static public function loaderURL(id:uint):String
		{
			return resourceURL("loader" + id, "loaders");
		}
		static public function resourceURL(id:String, folder:String):String
		{
			return Strings.substitute(RESOURCES_PATH_FORMAT, folder, id);
		}
		
		static public function locationUrl(locationId:String):String
		{
			return resourceURL(locationId, "locations");
		}
		static public function moduleFolder(moduleId:String):String
		{
			var folder : String = moduleId.substr(0, 1).toLowerCase() + moduleId.substr(1);
			return Strings.substitute(RESOURCES_FOLDER_FORMAT, folder);
		}
		static public function moduleUrl(moduleId:String):String
		{
			var oldLoc:Array =
			[
				'loc0', 'loc1', 'loc2', 'loc3', 'loc5',
				'locAccShop', 'locCafe', 'locHome', 'locMagicShop', 'locGames',
				'locAcademy', 'locAcademyRoom', "locKongregateSweetBattle",
				"locEco", "locPetsShop", "locEcoShop", "locMissions", "locHomeShop",
				"locPark", "locSecret", "locAgents", "locCitizen", "locCinema", "locMusic", "locRobots",
			];
			
			if (oldLoc.indexOf(moduleId) >= 0)
				return locationUrl(moduleId)
			else			
			{ 
				var id : String = moduleId.substr(0, 1).toLowerCase() + moduleId.substr(1);
				var folder : String = moduleId.substr(0, 1).toUpperCase() + moduleId.substr(1);
				return resourceURL(folder, id);
			}
		}
		
	}
}