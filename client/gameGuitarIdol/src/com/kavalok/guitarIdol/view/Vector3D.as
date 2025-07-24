package com.kavalok.guitarIdol.view
{
	public class Vector3D
	{
		public var x:Number;
		public var y:Number;
		public var z:Number;
		
		public function Vector3D(x:Number = 0, y:Number = 0, z:Number = 0)
		{
			this.x = x;
			this.y = y;
			this.z = z;
		}
		
		public function clone():Vector3D
		{
			return new Vector3D(x, y, z);
		}
		
		public function setMembers(x:Number, y:Number, z:Number):void
		{
			this.x = x;
			this.y = y;
			this.z = z;
		}
		
		public function addVector(v:Vector3D):void
		{
			x += v.x;
			y += v.y;
			z += v.z;
		}
		
		public function subVector(v:Vector3D):void
		{
			x -= v.x;
			y -= v.y;
			z -= v.z;
		}
		
		public function getMulScalar(i:Number):Vector3D
		{
			return new Vector3D(x*i, y*i, z*i);
		}
		
		public function mulScalar(value:Number):void
		{
			x *= value;
			y *= value;
			z *= value;
		}
		
		public function get magnitude():Number
		{
			return Math.sqrt(x*x + y*y + z*z);
		}
		
		public function get magnitude2():Number
		{
			return x*x + y*y + z*z;
		}
		
		public function copyTo(v:Vector3D):void
		{
			v.x = x;
			v.y = y;
			v.z = z;
		}
		
		public function copyVector(v:Vector3D):void
		{
			x = v.x;
			y = v.y;
			z = v.z;
		}
		
		public function vectorProjectionOnto(v:Vector3D):Vector3D
		{
			var result:Vector3D = v.getUnitVector();
			result.mulScalar(scalarProjectionOnto(v));
			return result;
		}
		
		public function scalarProjectionOnto(v:Vector3D):Number
		{
			return (x*v.x + y*v.y + z*v.z)/v.magnitude;
		}
		
		public function getUnitVector():Vector3D
		{
			var len:Number = magnitude;
			var result:Vector3D = clone();
			
			if (len)
			{
				result.x /= len;
				result.y /= len;
				result.z /= len;
			}
			
			return result;
		}
		
		public function toString():String
		{
			return '[Vector3D: x=' + x + ', y=' + y + ',z=' + z + ']';
		}
		
	}
	
}
