package com.kavalok.guitarIdol
{
	import com.kavalok.gameplay.controls.FlashViewBase;
	import com.kavalok.guitarIdol.interfaces.ITickDependent;

	public class TicksView extends FlashViewBase implements ITickDependent
	{
		private static const TICKS_IN_STEP : int = GameStage.TICKS_COUNT * GameStage.BIG_TICKS_COUNT;
		private var _content : McTickLines;
		private var _startPosition : Number;
		private var _offset : Number;
		private var _tick : Number;
		
		public function TicksView(content:McTickLines)
		{
			_content = content;
			_startPosition = _content.lines.y;
			_offset = _content.lines.firstTickLine.y;
			super(content);
		}
		
		public function updatePosition(tick : Number) : void
		{
			var position : Number = tick % TICKS_IN_STEP / TICKS_IN_STEP;
//			position += tick - int(tick);
			_content.lines.y = _startPosition + position * _offset;
		}
	}
}