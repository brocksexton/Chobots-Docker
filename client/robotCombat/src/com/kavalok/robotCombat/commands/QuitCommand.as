package com.kavalok.robotCombat.commands
{
	public class QuitCommand extends ModuleCommandBase
	{
		public function QuitCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			combat.client.disconnect();
			RobotCombat.instance.closeModule();
		}
		
	}
}