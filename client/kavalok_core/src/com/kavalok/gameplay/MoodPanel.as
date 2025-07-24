package com.kavalok.gameplay
{
	import com.kavalok.Global;
	import com.kavalok.constants.ResourceBundles;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getQualifiedClassName;
	
	import com.kavalok.events.EventSender;
	import com.kavalok.utils.Timers;
	
	public class MoodPanel
	{
		private var _content:McMoodPanel;
		private var _visible:Boolean;
		private var _moodEvent:EventSender = new EventSender();
		
		public function MoodPanel()
		{
			_content = new McMoodPanel();
			_content.x = 125;
			_content.y = 345;
			
			for (var i:int = 0; i< _content.numChildren; i++)
			{
				var mc:MovieClip = _content.getChildAt(i) as MovieClip;
				
				if (mc)
				{
					mc.buttonMode = true;
					mc.addEventListener(MouseEvent.MOUSE_OVER, onOver);
					mc.addEventListener(MouseEvent.MOUSE_OUT, onOut);
					mc.addEventListener(MouseEvent.CLICK, onClick);
					ToolTips.registerObject(mc, getQualifiedClassName(mc), ResourceBundles.KAVALOK);
				}
			}
		}
		
		public function get visible():Boolean
		{
			return _visible;
		}
		
		public function show():void
		{
			_visible = true;
			Global.root.addChild(_content);
			
			Timers.callAfter(setMouseListeners);
			
			Global.locationManager.locationDestroy.addListener(onLocationChange);
		}
		
		private function setMouseListeners():void
		{
			Global.stage.addEventListener(MouseEvent.CLICK, onOutsideClick);
		}
		
		public function hide():void
		{
			_visible = false;
			Global.root.removeChild(_content);
			Global.locationManager.locationDestroy.removeListener(onLocationChange);			
			Global.stage.removeEventListener(MouseEvent.CLICK, onOutsideClick);
		}
		
		private function onOutsideClick(e:Event):void
		{
			var x:int = Global.stage.mouseX;
			var y:int = Global.stage.mouseY;
			
			if (!_content.hitTestPoint(x, y, true))
				hide();
		}
		
		private function onLocationChange():void
		{
			hide();
		}
		
		private function onOver(e:MouseEvent):void
		{
			var mc:MovieClip = MovieClip(e.currentTarget); 
			mc.scaleX = mc.scaleY = 1.1;
		}
		
		private function onOut(e:MouseEvent):void
		{
			var mc:MovieClip = MovieClip(e.currentTarget); 
			mc.scaleX = mc.scaleY = 1;
		}
		
		private function onClick(e:MouseEvent):void
		{
			var mc:MovieClip = MovieClip(e.currentTarget);
			var moodId:String = getQualifiedClassName(mc);
			
			_moodEvent.sendEvent(moodId);
			
			hide();
		}
		
		public function get moodEvent():EventSender { return _moodEvent; }
		
	}
}