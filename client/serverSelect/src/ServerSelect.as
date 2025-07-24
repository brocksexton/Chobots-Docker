package {
	import com.kavalok.Global;
	import com.kavalok.gameplay.MousePointer;
	import com.kavalok.modules.LocationModule;
	import com.kavalok.services.AdminService;
	import com.kavalok.services.ServerService;
	import com.kavalok.utils.Arrays;
	import com.kavalok.utils.GraphUtils;
	import com.kavalok.utils.ResourceScanner;
	import com.kavalok.utils.comparing.PropertyCompareRequirement;
	
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	

	public class ServerSelect extends LocationModule
	{
		private static const CITIZENS_LIMIT : int = 50;
		
		private var _background : Background;
		private var _servers : Array;
		private var _limit : int;
		
		public function ServerSelect()
		{
		}
		
		override public function initialize():void
		{
			_background = new Background();
			addChild(_background);
			new ResourceScanner().apply(this);
			for(var i : uint = 0; i < _background.numChildren; i++)
			{
				var child : DisplayObject = _background.getChildAt(i);
				if(child is SimpleButton)
				{
					child.visible = false;
				}
			}
			Global.isLocked = true;
			new AdminService(onGetLimit).getServerLimit();
			
		}
		
		
		private function onGetLimit(result : int) : void
		{
			_limit = result;
			new ServerService(onGetServers).getServers();
		}
		private function onGetServers(result : Array) : void
		{
			Global.isLocked = false;
			_servers = result;
			readyEvent.sendEvent();
			MousePointer.resetIcon();
			for each(var server : Object in result)
			{
				var button : SimpleButton = _background[server.name];
				button.visible = true;
				var serverAvailable:Boolean = server.load < _limit || Global.superUser;
				GraphUtils.setBtnEnabled(button, serverAvailable);
				button.addEventListener(MouseEvent.CLICK, onServerClick);
				
				var states : Array = [button.upState, button.downState, button.overState];
				for each(var state : Sprite in states)
				{
					var bar : ProgressBar = ProgressBar(GraphUtils.findInstance(state, ProgressBar));
					bar.progress.height = bar.height * server.load / _limit;
				}
			}
		}
		
		private function onServerClick(event : MouseEvent) :void
		{
			var button : SimpleButton = SimpleButton(event.currentTarget);
			var server : Object = Arrays.firstByRequirement(_servers, new PropertyCompareRequirement("name", button.name));
			parameters.info.server = server.name;
			destroyEvent.sendEvent(this);
		} 
		
	}
}
