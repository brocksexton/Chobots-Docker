package com.kavalok.char.actions
{
	import com.kavalok.URLHelper;
	import com.kavalok.char.CharModels;
	import com.kavalok.location.commands.PlaySwfCommand;

	public class MagicAction extends CharActionBase
	{
		override public function execute():void
		{
			_char.stopMoving();
			_char.setModel(CharModels.MAGIC);
			
			if (_parameters && _parameters.name && _char.isUser)
			{
				var command:PlaySwfCommand = new PlaySwfCommand();
				command.url = animationURL;
				_location.sendCommand(command);
			}
		}
		
		public function get animationURL():String
		{
			 return URLHelper.resourceURL(_parameters.name, 'magic');
		}
	}
}