﻿package away3d.animators.skin
{
	import away3d.containers.*;
	import away3d.core.*;
	import away3d.core.base.*;
	import away3d.core.math.*;
	
    public class SkinController
    {
    	public var name:String;
		public var joint:ObjectContainer3D;
        public var bindMatrix:Matrix3D;
        public var sceneTransform:Matrix3D = new Matrix3D();
        public var inverseTransform:Matrix3D;
        public var updated:Boolean;
        
        public function update():void
        {
        	if (!joint.scene.updatedObjects[joint]) {
        		updated = false;
        		return;
        	} else {
        		updated = true;
        	}
        	
        	sceneTransform.multiply(joint.sceneTransform, bindMatrix);
        	sceneTransform.multiply(inverseTransform, sceneTransform);
        }
        
    }
}
