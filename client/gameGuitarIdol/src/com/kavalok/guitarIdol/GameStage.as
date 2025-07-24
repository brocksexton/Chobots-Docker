package com.kavalok.guitarIdol
{
	import com.kavalok.gameplay.controls.FlashViewBase;
	import com.kavalok.guitarIdol.data.SongInfo;
	import com.kavalok.guitarIdol.interfaces.ITickDependent;
	import com.kavalok.guitarIdol.view.Vector3D;
	import com.kavalok.guitarIdol.view.ViewPort;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.ui.Keyboard;

	public class GameStage extends FlashViewBase
	{
		public static const BIG_TICKS_COUNT : Number = 4;
		public static const BACKGROUND_SOUND_VOLUME : Number = 0.5;
		public static const TICKS_COUNT : Number = 4;

		private var _viewPort:ViewPort;
		private var _tickDependents : Array = [];
		private var _ticksView : TicksView;
		private var _nipplesView : NipplesView;
		private var _keyboardController : KeyboardController;
		
		private var _content : McGameStage = new McGameStage();

		private var _songInfo : SongInfo;

		private var _sounds : Array;
		private var _mainChannel : SoundChannel;
		private var _mainSound : Sound;
		private var _channels : Array = [];

		
		private var _tick : Number = 0;
		private var _startTime : Date;
		private var _startOffset : Number;
		private var _muteTick : Number;
		private var _muteCount : int = 0;
		private var _bpm : Number;
		private var _started : Boolean;

		static public const VIEW_DISTANCE:Number = 42;
		public var roadRect:Rectangle = new Rectangle(-0.75, 1, 5, VIEW_DISTANCE);
		
		public function GameStage(stage : Stage)
		{
			super(_content);
			_ticksView = new TicksView(_content.tickLines);
			_keyboardController = new KeyboardController(_content.buttons, stage);
			_nipplesView = new NipplesView(_content.nipples, this, _keyboardController);
			_tickDependents.push(_ticksView);
			_tickDependents.push(_nipplesView);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);

			_content.editField.visible = false;

			_viewPort = new ViewPort(GameGuitarIdol.WIDTH, GameGuitarIdol.HEIGHT, VIEW_DISTANCE);
			_viewPort.calibrateY(
				roadRect.y, _content.aBottom.y,
				roadRect.y + roadRect.height, _content.aUp.y);
			_viewPort.calibrateX(
				roadRect.x + roadRect.width, roadRect.y,
				_content.fBottom.x);
			
//			_viewPort.calibrateY(
//				roadRect.y, _content.mcBottomLeft.y,
//				roadRect.y + roadRect.height, _content.mcTopLeft.y);
//			_viewPort.calibrateX(
//				roadRect.x + roadRect.width, roadRect.y,
//				_content.mcBottomRight.x);

		}
		
		public function get viewPort() : ViewPort
		{
			return _viewPort;
		}

		public function set song(value : XML) : void
		{
			_content.editField.text = value.toString();
		}
		
		public function unmute() : void
		{
			_muteCount--;
			if(_muteCount == 0)
			{
				_muteTick = _tick;
				_mainChannel.soundTransform = new SoundTransform(1);
			}
		}
		public function mute(lastTick : int) : void
		{
			if(_muteTick == lastTick)
			{
				_muteCount++;
			}
			else
			{
				_muteCount = 1;
			}
			_muteTick = lastTick;
			_mainChannel.soundTransform = new SoundTransform(0);
		}
		
		private function onKeyDown(event : KeyboardEvent) : void
		{
			if(event.keyCode == Keyboard.F4)
			{
				if(_started)
				{
					stop();
				}
				else
				{
					start(new SongInfo(new XML(_content.editField.text)));
				}
				_content.infoField.visible = !_started; 
				_content.editField.visible = false;
			}
			else if(event.keyCode == Keyboard.F5)
			{
				_content.editField.visible = true;
			}
		}
		private function tryUnmute(tick : Number) : void
		{
			if(!isNaN(_muteTick) && tick > _muteTick)
			{
				_muteTick = NaN;
				_mainChannel.soundTransform = new SoundTransform(1);
			}
		}
		private function stop() : void
		{
			_started = false;
			_content.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			for each(var channel : SoundChannel in _channels)
			{
				channel.stop();
			}	
		}
		private function start(songInfo : SongInfo) : void
		{
			_songInfo = songInfo;
			if(_songInfo.loaded)
				doStart();
			else
				_songInfo.loadedEvent.addListener(doStart);
		}
		
		private function doStart() : void
		{
			_tick = Number(_content.tickField.text);
			_muteTick = NaN;
			_muteCount = 0;
			_started = true;
			_bpm = _songInfo.bpm;
			_nipplesView.nipplesConfig = _songInfo.items; 
			_startTime = new Date();
			_mainSound = _songInfo.sounds.shift(); 
			_sounds = _songInfo.sounds;
			_channels = [];
			_startOffset = _tick / _bpm / TICKS_COUNT * 1000 * 60;
			_mainChannel = _mainSound.play(_startOffset);
			for each(var sound : Sound in _sounds)
			{
				_channels.push(sound.play(_startOffset, 0, new SoundTransform(BACKGROUND_SOUND_VOLUME)));
			}
				
			_sounds.push(_mainSound);
			_channels.push(_mainChannel);
			_content.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(event : Event) : void
		{
			var time : Date = new Date();
			var period : Number = time.time - _startTime.time + _startOffset;
			var tick : Number = period * _bpm * TICKS_COUNT / 1000 / 60 ;
			for each(var dependent : ITickDependent in _tickDependents)
				dependent.updatePosition(tick);

			_tick = tick;
			_content.tickField.text = int(tick).toString()
			tryUnmute(tick);
		}
		
	}
}