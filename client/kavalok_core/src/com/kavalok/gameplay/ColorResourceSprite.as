package com.kavalok.gameplay
{
	import com.kavalok.utils.SpriteDecorator;
	
	import flash.display.Sprite;
	
	public class ColorResourceSprite extends ResourceSprite
	{
		private var _color : int;
		
		public function ColorResourceSprite(url:String, className:String, color : int = 0, autoLoad:Boolean=true, useView:Boolean=true)
		{
			super(url, className, autoLoad, useView);
			_color = color;
			readyEvent.addListener(onReady);
		}
		
		private function onReady(sprite : ColorResourceSprite) : void
		{
			if (_color >= 0)
				SpriteDecorator.decorateColor(Sprite(sprite.content), _color) 
		}
		
	}
}