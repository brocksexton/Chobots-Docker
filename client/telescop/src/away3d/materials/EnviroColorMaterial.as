package away3d.materials
{
	import away3d.core.*;
	import away3d.core.base.*;
	import away3d.core.draw.*;
	import away3d.core.utils.*;
	import away3d.materials.shaders.*;
	
	import flash.display.*;
	import flash.geom.*;
	
	/**
	 * Color material with environment shading.
	 */
	public class EnviroColorMaterial extends EnviroShader implements ITriangleMaterial
	{
    	use namespace arcane;
		
		private var _color:uint;
		private var _red:Number;
		private var _green:Number;
		private var _blue:Number;
		private var _colorMap:BitmapData;
		
        private function setColorTranform():void
        {
            _colorTransform = new ColorTransform(_red*_reflectiveness, _green*_reflectiveness, _blue*_reflectiveness, 1, (1-_reflectiveness)*_red*255, (1-_reflectiveness)*_green*255, (1-_reflectiveness)*_blue*255, 0);
            _colorMap = _bitmap.clone();
            _colorMap.colorTransform(_colorMap.rect, _colorTransform);
        }
        
        /**
        * Defines the color of the material.
        */
        public function get color():uint
        {
            return _color;
        }
        
		public function set color(val:uint):void
        {
            _color = val;
            _red = ((_color & 0xFF0000) >> 16)/255;
            _green = ((_color & 0x00FF00) >> 8)/255;
            _blue = (_color & 0x0000FF)/255;
            setColorTranform();
        }
        
		/**
		 * @inheritDoc
		 */
        public override function set reflectiveness(val:Number):void
        {
            _reflectiveness = val;
            setColorTranform();
        }
		
		/**
		 * Creates a new <code>EnviroColorMaterial</code> object.
		 * 
		 * @param	color				A string, hex value or colorname representing the color of the material.
		 * @param	enviroMap			The bitmapData object to be used as the material's environment map.
		 * @param	init	[optional]	An initialisation object for specifying default instance properties.
		 */
		public function EnviroColorMaterial(color:*, enviroMap:BitmapData, init:Object = null)
		{            
			super(enviroMap, init);
			
            this.color = Cast.trycolor(color);
		}
    	
    	/**
    	 * Sends the material data coupled with data from the DrawTriangle primitive to the render session.
    	 */
		public function renderTriangle(tri:DrawTriangle):void
		{
			tri.source.session.renderTriangleBitmap(_colorMap, getMapping(tri.source as Mesh, tri.face), tri.v0, tri.v1, tri.v2, smooth, false);
			
			if (debug)
                tri.source.session.renderTriangleLine(0, 0x0000FF, 1, tri.v0, tri.v1, tri.v2);
		}
	}
}