package com.kavalok.guitarIdol
{
	import com.kavalok.collections.ArrayList;
	import com.kavalok.gameplay.controls.FlashViewBase;
	import com.kavalok.guitarIdol.data.NippleInfo;
	import com.kavalok.guitarIdol.interfaces.ITickDependent;
	import com.kavalok.utils.GraphUtils;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.media.SoundTransform;

	public class NipplesView extends FlashViewBase implements ITickDependent
	{
		private static const TOP : String = "Up";
		private static const BOTTOM : String = "Bottom";
		
		private static const TAIL_WIDTH : Number = 1;
		private static const BOTTOM_DIFF : Number = 0.6;
		private static const MAX_DIFF : Number = 1.3;
		private static const MAX_VISIBLE_OFFSET : int = 2;
		private static const MIN_OFFSET : int = -40;
		private static const DISTANCE : int = 42;
		private static const SCALE : Number = 0.2556;
		
		private var _pressedKeys : ArrayList = new ArrayList();
		private var _content : McNipples;

		private var _myError : SoundErrorMy = new SoundErrorMy();

		private var _nipplesConfig : ArrayList;
		private var _visibleNipples : ArrayList = new ArrayList();
		private var _stage : GameStage;
		private var _lastTick : Number;
		
		public function NipplesView(content:McNipples, stage : GameStage, keyboardController : KeyboardController)
		{
			_content = content;
			_stage = stage;
			super(content);
			GraphUtils.setChildrenVisibility(_content, null, false);
			keyboardController.keyDownEvent.addListener(onKeyDown);
			keyboardController.keyUpEvent.addListener(onKeyUp);
		}
		
		public function set nipplesConfig(value : ArrayList) : void
		{
			_nipplesConfig = value;
			for each(var info : NippleInfo in _visibleNipples)
				_content.removeChild(info.content);
			_visibleNipples = new ArrayList();
		}
		
		private function onKeyUp(button : String) : void
		{
			_pressedKeys.removeItem(button);
		}
		
		private function onKeyDown(button : String) : void
		{
			_pressedKeys.addItem(button);
			var success : Boolean = false;
			for each(var info : NippleInfo in _visibleNipples)
			{
				if(info.hit)
					continue;
				var diff : Number = _lastTick - info.tick;
				if(Math.abs(diff) < MAX_DIFF && info.buttonName == button)
				{
					info.success();
					success = true;
					if(info.failed)
						_stage.unmute();
					break;
				}
			}
			if(!success)
				_myError.play(0,0, new SoundTransform(0.3));
		}
		
		public function updatePosition(tick : Number) : void
		{
			_lastTick = tick;
			addToVisible(tick);
			processVisible(tick);
		}
		
		private function addToVisible(tick : Number) : void
		{
			var newNipples : Array = [];
			var info : NippleInfo;
			for each(info in _nipplesConfig)
			{
				var offset : Number = tick - info.tick; 
				if(offset > MIN_OFFSET)
				{
					info.createObject();
					if(info.long)
					{
//						var tail : Sprite = createTail(info.soundDuration, info.buttonName);
//						info.addTail(tail);
					}
					_content.addChild(info.content);
					newNipples.push(info);
				}
				else
				{
					break;
				}
			}
			for each(info in newNipples)
			{
				_visibleNipples.push(info);
				_nipplesConfig.removeItem(info);
			}
		}
		
		private function createTail(duration : Number, button : String, color : Number = 0) : Sprite
		{
			var tail : Sprite = new Sprite();
			var topPoint : Point = getPoint(MIN_OFFSET - duration, button);
			var bottomPoint : Point = getPoint(MIN_OFFSET, button);
			var scaleTop : Number = getScale(MIN_OFFSET - duration);
			var scaleBottom : Number = getScale(MIN_OFFSET);
			var xDiff : Number = topPoint.x - bottomPoint.x; 
			var yDiff : Number = topPoint.y - bottomPoint.y; 
			tail.graphics.lineStyle(0, color);
			tail.graphics.beginFill(color, 1);
			tail.graphics.moveTo(-TAIL_WIDTH * scaleBottom, 0);
			tail.graphics.lineTo(-TAIL_WIDTH * scaleTop + xDiff, yDiff);
			tail.graphics.lineTo(TAIL_WIDTH * scaleTop + xDiff, yDiff);
			tail.graphics.lineTo(TAIL_WIDTH * scaleBottom, 0);
			tail.graphics.endFill();
			return tail;
		}
		private function processVisible(tick : Number) : void
		{
			for each(var info : NippleInfo in _visibleNipples)
			{
				var offset : Number = tick - info.tick;
				if((!info.long && offset > MAX_VISIBLE_OFFSET) || (offset - info.soundDuration > MAX_VISIBLE_OFFSET))
				{
					_visibleNipples.removeItem(info);
					_content.removeChild(info.content);
					continue;
				}
				info.position.y = -offset;
//				info.position.y = (DISTANCE+offset);
				//trace("info.position.y "+info.position.y);
		
//				var point : Point = getPoint(offset, info.buttonName);
//				info.content.y = point.y; 
//				info.content.x = point.x; 
//				var scale : Number = getScale(offset);
//				info.scale = scale;
				
				if(!info.hit && offset > 0 && !info.failed)
				{
					info.fail();
					_stage.mute(info.tick + info.soundDuration);
				}
				if(info.hit && info.long && !info.processed)
				{
					if(_pressedKeys.contains(info.buttonName))
					{
						var tail : Sprite = createTail(_lastTick - info.tick, info.buttonName, 0xffffff);
						info.setProcessedTail(tail);
					}
					else
					{
						info.processed = true;
						_stage.mute(info.tick + info.soundDuration);
					}
					 
				}
			}
			_stage.viewPort.refreshObjects(_visibleNipples);
			
		}
		
		private function getScale(offset : Number) : Number
		{ 
			return 1 + (1 - SCALE ) * offset / DISTANCE;
		}
		
		private function getPoint(offset : Number, button : String) : Point
		{
			var top : DisplayObject = _content[button + TOP];
			var bottom : DisplayObject = _content[button + BOTTOM];
			var y : Number = bottom.y + (bottom.y - top.y) * offset / DISTANCE; 
			var x : Number = bottom.x + (bottom.x - top.x) * offset / DISTANCE;
			return new Point(x, y); 
		}
		
		
	}
}