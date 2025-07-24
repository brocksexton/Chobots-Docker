package com.kavalok.commands.location
{
	import com.kavalok.Global;
	import com.kavalok.events.EventSender;
	import com.kavalok.gameplay.KavalokConstants;
	import com.kavalok.gameplay.commands.CitizenWarningCommand;
	import com.kavalok.interfaces.ICommand;
	import com.kavalok.services.SOService;
	
	public class GotoLocationCommand implements ICommand
	{
		private var _locationId:String
		private var _parameters:Object;
		private var _server:String;
		
		private var _completeEvent:EventSender = new EventSender();
		
		public function GotoLocationCommand(locationId:String, parameters:Object = null, server:String = "")
		{
			_locationId = locationId;
			_parameters = parameters;
			_server = server;
		}
		
		public function execute():void
		{
			//loadLocation();
			if(_locationId=="locCitizen" && !Global.charManager.isCitizen){
				new CitizenWarningCommand('locationForCitizensOnly', Global.messages.locationForCitizensOnly).execute();
			}else if (Global.charManager.isCitizen || Global.charManager.isAgent
				|| Global.charManager.isModerator || Global.superUser || !_locationId)
			{
				loadLocation();
			}
			else
			{
				Global.isLocked = true;
				new SOService(onGetData).getNumConnectedChars(_locationId, _server);
			}
		}
		
		public function onGetData(result:int):void
		{
			Global.isLocked = false;
			if (result >= KavalokConstants.LOCATION_LIMIT)
				new CitizenWarningCommand('locationFull', Global.messages.locationFull).execute();
			else
				loadLocation();
		}
		
		private function loadLocation():void
		{
			if (_server.length > 0 && _server != Global.loginManager.server)
				Global.loginManager.changeServer(_server, _locationId, _parameters);
			else
				Global.moduleManager.loadModule(_locationId, _parameters);
				
			_completeEvent.sendEvent();
		}
		
		public function get completeEvent():EventSender { return _completeEvent; }

	}
}