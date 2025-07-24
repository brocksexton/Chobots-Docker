package com.kavalok.guitarIdol.view
{
	import com.kavalok.guitarIdol.data.NippleInfo;
	
	import flash.display.Sprite;
	import flash.geom.Intersection;
	import flash.geom.Line;
	import flash.geom.Point;

	public class ViewPort
	{
		private var _focus:Vector3D = new Vector3D();
		private var _content:Sprite = new Sprite();
		private var _width:Number;
		private var _height:Number;
		private var _maxDistance:Number;
		
		public function ViewPort(width:Number, height:Number, maxDistance:Number)
		{
			_width = width;
			_height = height;
			_maxDistance = maxDistance;
		}
		
		public function calibrateY(
			worldY1:Number, viewY1:Number,
			worldY2:Number, viewY2:Number):void 
		{
			var line1:Line = new Line(
				new Point(worldY1, 0),
				new Point(0, _height - viewY1), false);
			var line2:Line = new Line(
				new Point(worldY2, 0),
				new Point(0, _height - viewY2), false);
			var intersection:Intersection = line1.intersectionLine(line2);
			var time:Number = intersection.currentTimes[0];
			var point:Point = line1.getPoint(time);
			
			_focus.y = point.x;
			_focus.z = point.y;
		}
		
		public function calibrateX(worldX:Number, worldY:Number, viewX:Number):void
		{
			var x1:Number = _focus.y / (worldY - _focus.y) * worldX;
			_focus.x = (viewX - 0.5 * _width) / x1;
		}
		
		public function refreshObject(item:NippleInfo):void
		{
			item.content.x = 0.5 * _width + _focus.y / (item.position.y - _focus.y) * item.position.x * _focus.x;
			item.content.y = _height - (item.position.y / (item.position.y - _focus.y) * _focus.z);
	
			var scale:Number = _focus.y / (_focus.y - item.position.y)
				- _focus.y / (_focus.y - _maxDistance); 
			
			item.content.scaleX = item.scale * scale;
			item.content.scaleY = item.scale * scale;
		}
		
		public function refreshObjects(items:Array):void
		{
			for each (var item:NippleInfo in items)
			{
				refreshObject(item);
			}
		}
		
		public function get content():Sprite { return _content; }
		
	}
}
