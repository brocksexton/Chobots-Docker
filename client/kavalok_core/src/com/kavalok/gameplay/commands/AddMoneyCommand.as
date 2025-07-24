package com.kavalok.gameplay.commands
{
	import com.kavalok.Global;
	import com.kavalok.gameplay.KavalokConstants;
	import com.kavalok.gameplay.McMoneyEffect;
	import com.kavalok.services.CompetitionService;
	import com.kavalok.services.MoneyService;
	
	public class AddMoneyCommand
	{
		
		public var citizenGetMore : Boolean = true;
		
		private var _money:int;
		private var _scores:int;
		private var _reason:String;
		private var _setCompetitionScore:Boolean;
		private var _completeHandler:Function;
		private var _effect:McMoneyEffect;
		
		
		
		public function AddMoneyCommand(money:int, reason : String, setCompetitionScore : Boolean = false
			, completeHandler:Function = null, citizenGetMore : Boolean = true)
		{
			this.citizenGetMore = citizenGetMore;
			_scores = money;
			_money = money;
			if(_money > 0 && Global.charManager.isCitizen && citizenGetMore)
			{
				_money *= KavalokConstants.CITIZEN_MONEY_MULTIPLIER;
			}
			_reason = reason;
			_setCompetitionScore = setCompetitionScore && _scores > 0;
			_completeHandler = completeHandler;
		}
		
		public function execute():void
		{
			if (Global.charManager.isGuest)
			{
				Global.charManager.money += _money;
			}
			else
			{
				new MoneyService(onResult).addMoney(_money, _reason);
				if(_setCompetitionScore)
					new CompetitionService().addResult(_reason, _scores);
			}
			new MoneyAnimCommand(_money).execute();
		}
		
		private function onResult(result:Object):void
		{
			if (_completeHandler != null)
				_completeHandler();
		}

	}
}