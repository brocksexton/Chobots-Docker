package com.kavalok.constants
{
	import com.kavalok.utils.Arrays;
	import com.kavalok.utils.Maths;
	
	public class Locations
	{
		public static function isLocation(id : String) : Boolean
		{
			if (id)
				return id.indexOf('loc') == 0;
			else
				return false;
		}
		public static const LOC_0 : String = "loc0";
		public static const LOC_1 : String = "loc1";
		public static const LOC_2 : String = "loc2";
		public static const LOC_3 : String = "loc3";
		public static const LOC_5 : String = "loc5";
		public static const LOC_ROPE : String = "locationRope";
		public static const LOC_CAFE : String = "locCafe";
		public static const LOC_GRAPHITY : String = "locGraphity";
		public static const LOC_GRAPHITY_A : String = "locGraphityA";
		public static const LOC_PARK : String = "locPark";
		public static const LOC_MUSIC : String = "locMusic";
		
		public static const LOC_ACC_SHOP : String = "locAccShop";
		public static const LOC_ECO_SHOP : String = "locEcoShop";
		public static const LOC_ECO : String = "locEco";
		public static const LOC_MAGIC_SHOP : String = "locMagicShop";
		public static const LOC_ACADEMY : String = "locAcademy";
		public static const LOC_ACADEMY_ROOM : String = "locAcademyRoom";
		public static const LOC_GAMES : String = "locGames";
		public static const LOC_ROBOTS : String = "locRobots";
		
		public static const GAME_WORMS : String = "gameSweetBattle";
		public static const GAME_MONEY : String = "gameMoney";
		public static const GAME_GARBAGE_COLLECTOR : String = "gameGarbageCollector";
		
		public static const MISSION_FARM : String = "missionFarm";
		
		public static const LOC_MISSIONS : String = "locMissions";
		
		
		public static function getRandomLocation() : String
		{
			return Arrays.randomItem(list);
		}
		
		public static function get list():Array
		{
			var result:Array =
			[ 
				LOC_0, 
				LOC_1, 
				LOC_2, 
				LOC_3, 
				LOC_5, 
				LOC_ROPE, 
				LOC_CAFE, 
				LOC_PARK, 
				LOC_ACC_SHOP, 
				LOC_ECO_SHOP, 
				LOC_ECO, 
				LOC_MAGIC_SHOP, 
				LOC_ACADEMY, 
				LOC_ACADEMY_ROOM, 
				LOC_GAMES,
				LOC_GRAPHITY,
				LOC_GRAPHITY_A,
				LOC_MISSIONS,
				LOC_ROBOTS,
			];
			
			return result;
		}
	}
}