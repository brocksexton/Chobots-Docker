package com.kavalok.guitarIdol.data
{
	import com.kavalok.guitarIdol.view.Vector3D;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class NippleInfo
	{
		public var position:Vector3D = new Vector3D();

		public var buttonName : String;
		public var tick : int;
		public var long : Boolean;
		public var processed : Boolean;
		public var soundDuration : Number;
		public var content : Sprite;
		public var hit : Boolean = false;
		public var failed : Boolean = false;
		private var _tail : Sprite;
		private var _processedTail : Sprite;
		private var _clip : MovieClip;
		public var scale:Number = 1.3;
		
		public function NippleInfo(buttonName : String, tick : int, soundDuration : Number, long : Boolean = false)
		{
			this.buttonName = buttonName;
			this.tick = tick;
			this.soundDuration = soundDuration;
			this.long = long;
		}
		
		public function set scale1(value : Number) : void
		{
			_clip.scaleX = _clip.scaleY = value;
//			if(_tail)
//			{
//				_tail.scaleX = value;
//			}
				
		}
		public function setProcessedTail(sprite : Sprite) : void
		{
			if(_processedTail)
				content.removeChild(_processedTail);
			content.addChildAt(sprite, 2);
			_processedTail = sprite;
			
		}
		public function addTail(tail : Sprite) : void
		{
			content.addChildAt(tail, 0);
			_tail = tail;
		}
		public function fail() : void
		{
			_clip.gotoAndStop(3);
			failed = true;
		}
		public function success() : void
		{
			hit = true;
			_clip.gotoAndStop(2);
		}
		public function createObject() : void
		{
			content = new Sprite();
			switch (this.buttonName){
				case "a":
					_clip = new McNipple1();
					position.x = -5.7;
					break;
				case "s":
					_clip = new McNipple2();
					position.x = -2.55;
					break;
				case "d":
					_clip = new McNipple3();
					position.x = 0.4;
					break;
				case "f":
					_clip = new McNipple4();
					position.x = 3.6;
					break;
			}
			_clip.gotoAndStop(1);
			content.addChild(_clip);
			
		}

	}
}