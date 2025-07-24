package com.kavalok.guitarIdol
{
	import com.kavalok.events.EventSender;
	import com.kavalok.utils.GraphUtils;
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	
	public class KeyboardController
	{
		private var _buttons : McControlButtons;
		private var _mapping : Dictionary = new Dictionary(); 
		private var _keyDownEvent : EventSender = new EventSender(); 
		private var _keyUpEvent : EventSender = new EventSender(); 
		private var _downKeys : Object = {}; 
		public function KeyboardController(buttons : McControlButtons, stage : Stage)
		{
			_mapping[65] = "a";
			_mapping[83] = "s";
			_mapping[68] = "d";
			_mapping[70] = "f";

			_buttons = buttons;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			GraphUtils.stopAllChildren(_buttons, 1);
		}
		
		public function get keyDownEvent() : EventSender
		{
			return _keyDownEvent;
		}

		public function get keyUpEvent() : EventSender
		{
			return _keyUpEvent;
		}
		
		private function onKeyDown(event : KeyboardEvent) : void
		{
			if(event.keyCode in _downKeys)
				return;
			_downKeys[event.keyCode] = true;
			var name : String = stopButton(event, 2);
			if(name)
				keyDownEvent.sendEvent(name);
		}

		private function onKeyUp(event : KeyboardEvent) : void
		{
			delete _downKeys[event.keyCode];
			var name : String = stopButton(event, 1);
			if(name)
				keyUpEvent.sendEvent(name);
		}
		
		private function stopButton(event : KeyboardEvent, frame : int) : String
		{
			var name : String = _mapping[event.keyCode];
			if(name)
			{
				var button : MovieClip = _buttons[name];
				button.gotoAndStop(frame);
			}
			return name;
		}
		

	}
}