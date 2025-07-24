package com.kavalok.guitarIdol.view
{
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	
	public class Object3D
	{
		public var position:Vector3D = new Vector3D();
		public var velocity:Vector3D = new Vector3D();
		public var radius:Number;
		public var elastity:Number = 1;
		
		public var force:Vector3D = new Vector3D(); // not used yet
		public var mass:Number; // not used yet
		
		public var model:Sprite;
		public var deleted:Boolean = false;
		public var scale:Number = 1.2;
		public var rowNum:int = -1;
		
		public function Object3D(modelClass:Class, radius:Number = 0, mass:Number = 0)
		{
			if (modelClass)
				this.model = new modelClass();
			
			this.radius = radius;
			this.mass = (mass > 0) ? mass : 1;
		}
		
		public function distance2To(object:Object3D):Number
		{
			var dx:Number = position.x - object.position.x;
			var dy:Number = position.y - object.position.y;
			var dz:Number = position.z - object.position.z;
			
			return dx * dx + dy * dy + dz * dz;
		}
		
		public function distanceTo(object:Object3D):Number
		{
			return Math.sqrt(distance2To(object));
		}
		
		public function collide(item:Object3D):Boolean
		{
			var dx:Number = item.position.x - position.x;
			var dy:Number = item.position.y - position.y;
			var dz:Number = item.position.z - position.z;
			var d2:Number = dx * dx + dy * dy + dz * dz;
			
			var r2:Number = (radius + item.radius) * (radius + item.radius);
			
			return d2 < r2;
		}
		
		public function onMove():void
		{
		}
		
		public function onCollide(item:Object3D):void
		{
		}
		
	}
	
}
