package com.kavalok.gameplay.chat
{
	public class BubbleStyles
	{
		static public const DEFAULT:String			= 'D';
		static public const CITIZEN:String			= 'C';
		static public const MODERATOR:String		= 'M';
		static public const AGENT:String			= 'A';
		static public const CITIZEN_AGENT:String	= 'CA';
		static public const PROMOTION:String		= 'P';
		
		static private var _styles:Object;
		
		static public function getStyle(styleName:String):BubbleStyle
		{
			if (!_styles)
				initializeStyles();
				
			return _styles[styleName];
		}
		
		static private function initializeStyles():void
		{
			_styles = {};
			_styles[DEFAULT] = new BubbleStyle(12, 1, 120);
			_styles[CITIZEN] = new BubbleStyle(15, 2, 150);
			_styles[MODERATOR] = new BubbleStyle(15, 3, 150);
			_styles[AGENT] = new BubbleStyle(12, 4, 120);
			_styles[CITIZEN_AGENT] = new BubbleStyle(15, 4, 120);
			_styles[PROMOTION] = new BubbleStyle(16, 5, 120);
		}
		
		static public function get defaultStyle():BubbleStyle
		{
			return getStyle(DEFAULT);
		}

	}
}