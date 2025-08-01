package away3d.core.base
{
    import away3d.containers.*;
    import away3d.core.*;
    import away3d.core.draw.*;
    import away3d.core.light.*;
    import away3d.core.math.*;
    import away3d.core.project.*;
    import away3d.core.render.*;
    import away3d.core.traverse.*;
    import away3d.core.utils.*;
    import away3d.events.*;
    import away3d.loaders.utils.*;
    import away3d.primitives.*;
    
    import flash.display.*;
    import flash.events.EventDispatcher;
    
	/**
	 * Dispatched when the local transform matrix of the 3d object changes.
	 * 
	 * @eventType away3d.events.Object3DEvent
	 * @see	#transform
	 */
	[Event(name="transformChanged",type="away3d.events.Object3DEvent")]
	
	/**
	 * Dispatched when the scene transform matrix of the 3d object changes.
	 * 
	 * @eventType away3d.events.Object3DEvent
	 * @see	#sceneTransform
	 */
	[Event(name="scenetransformChanged",type="away3d.events.Object3DEvent")]
	
	/**
	 * Dispatched when the parent scene of the 3d object changes.
	 * 
	 * @eventType away3d.events.Object3DEvent
	 * @see	#scene
	 */
	[Event(name="sceneChanged",type="away3d.events.Object3DEvent")]
	
	/**
	 * Dispatched when the render session property of the 3d object changes.
	 * 
	 * @eventType away3d.events.Object3DEvent
	 * @see	#session
	 */
	[Event(name="sessionChanged",type="away3d.events.Object3DEvent")]
	
	/**
	 * Dispatched when the render session property of the 3d object updates its contents.
	 * 
	 * @eventType away3d.events.Object3DEvent
	 * @see	#session
	 */
	[Event(name="sessionUpdated",type="away3d.events.Object3DEvent")]
	
	/**
	 * Dispatched when the bounding dimensions of the 3d object changes.
	 * 
	 * @eventType away3d.events.Object3DEvent
	 * @see	#minX
	 * @see	#maxX
	 * @see	#minY
	 * @see	#maxY
	 * @see	#minZ
	 * @see	#maxZ
	 */
	[Event(name="dimensionsChanged",type="away3d.events.Object3DEvent")]
    
	/**
	 * Dispatched when a user moves the cursor while it is over the 3d object.
	 * 
	 * @eventType away3d.events.MouseEvent3D
	 */
	[Event(name="mouseMove",type="away3d.events.MouseEvent3D")]
    
	/**
	 * Dispatched when a user presses the left hand mouse button while the cursor is over the 3d object.
	 * 
	 * @eventType away3d.events.MouseEvent3D
	 */
	[Event(name="mouseDown",type="away3d.events.MouseEvent3D")]
    
	/**
	 * Dispatched when a user releases the left hand mouse button while the cursor is over the 3d object.
	 * 
	 * @eventType away3d.events.MouseEvent3D
	 */
	[Event(name="mouseUp",type="away3d.events.MouseEvent3D")]
    
	/**
	 * Dispatched when a user moves the cursor over the 3d object.
	 * 
	 * @eventType away3d.events.MouseEvent3D
	 */
	[Event(name="mouseOver",type="away3d.events.MouseEvent3D")]
    
	/**
	 * Dispatched when a user moves the cursor away from the 3d object.
	 * 
	 * @eventType away3d.events.MouseEvent3D
	 */
	[Event(name="mouseOut",type="away3d.events.MouseEvent3D")]
	
    /**
     * Base class for all 3d objects.
     */
    public class Object3D extends EventDispatcher implements IClonable
    {
        use namespace arcane;
        /** @private */
        arcane var _mouseEnabled:Boolean = true;
		/** @private */
        arcane var _transformDirty:Boolean;
        /** @private */
        arcane var _transform:Matrix3D = new Matrix3D();
        /** @private */
        arcane var _sceneTransformDirty:Boolean;
        /** @private */
        arcane var _sceneTransform:Matrix3D = new Matrix3D();
        /** @private */
        arcane var _localTransformDirty:Boolean;
        /** @private */
        arcane var _dimensionsDirty:Boolean = false;
        /** @private */
        arcane var _boundingRadius:Number = 0;
        /** @private */
        arcane var _maxX:Number = 0;
        /** @private */
        arcane var _minX:Number = 0;
        /** @private */
        arcane var _maxY:Number = 0;
        /** @private */
        arcane var _minY:Number = 0;
        /** @private */
        arcane var _maxZ:Number = 0;
        /** @private */
        arcane var _minZ:Number = 0;
        /** @private */
        public function get parentradius():Number
        {
            //if (_transformDirty)   ???
            //    updateTransform();
			_parentradius.sub(position, _parentPivot);
            
            return _parentradius.modulo + boundingRadius*(_scaleX + _scaleY + _scaleZ)/3;
        }
        /** @private */
        public function get parentmaxX():Number
        {
            return boundingRadius + _transform.tx;
        }
		/** @private */
        public function get parentminX():Number
        {
            return -boundingRadius + _transform.tx;
        }
		/** @private */
        public function get parentmaxY():Number
        {
            return boundingRadius + _transform.ty;
        }
		/** @private */
        public function get parentminY():Number
        {
            return -boundingRadius + _transform.ty;
        }
		/** @private */
        public function get parentmaxZ():Number
        {
            return boundingRadius + _transform.tz;
        }
		/** @private */
        public function get parentminZ():Number
        {
            return -boundingRadius + _transform.tz;
        }
        /** @private */
        arcane function notifyParentUpdate():void
        {
        	if (_ownCanvas && _parent)
        		_parent._sessionDirty = true;
        	
            if (!hasEventListener(Object3DEvent.PARENT_UPDATED))
                return;
			
            if (!_parentupdated)
                _parentupdated = new Object3DEvent(Object3DEvent.PARENT_UPDATED, this);
            
            dispatchEvent(_parentupdated);
        }
        /** @private */
        arcane function notifyTransformChange():void
        {
        	_localTransformDirty = false;
        	
            if (!hasEventListener(Object3DEvent.TRANSFORM_CHANGED))
                return;
			
            if (!_transformchanged)
                _transformchanged = new Object3DEvent(Object3DEvent.TRANSFORM_CHANGED, this);
            
            dispatchEvent(_transformchanged);
        }
        /** @private */
        arcane function notifySceneTransformChange():void
        {
        	_sceneTransformDirty = false;
        	
        	_objectDirty = true;
        	
            if (!hasEventListener(Object3DEvent.SCENETRANSFORM_CHANGED))
                return;
			
            if (!_scenetransformchanged)
                _scenetransformchanged = new Object3DEvent(Object3DEvent.SCENETRANSFORM_CHANGED, this);
            
            dispatchEvent(_scenetransformchanged);
        }
        /** @private */
        arcane function notifySceneChange():void
        {
        	_sceneTransformDirty = true;
        	
            if (!hasEventListener(Object3DEvent.SCENE_CHANGED))
                return;
			
            if (!_scenechanged)
                _scenechanged = new Object3DEvent(Object3DEvent.SCENE_CHANGED, this);
            
            dispatchEvent(_scenechanged);
        }
         /** @private */
        arcane function notifySessionChange():void
        {
        	changeSession();
        	
            if (!hasEventListener(Object3DEvent.SESSION_CHANGED))
                return;
			
            if (!_sessionchanged)
                _sessionchanged = new Object3DEvent(Object3DEvent.SESSION_CHANGED, this);
            
            dispatchEvent(_sessionchanged);
        }
        /** @private */
        arcane function notifySessionUpdate():void
        {
        	if (_scene)
        		_scene.updatedSessions[_session] = _session;
        	
            if (!hasEventListener(Object3DEvent.SESSION_UPDATED))
                return;
			
            if (!_sessionupdated)
                _sessionupdated = new Object3DEvent(Object3DEvent.SESSION_UPDATED, this);
            
            dispatchEvent(_sessionupdated);
        }
        /** @private */
        arcane function notifyDimensionsChange():void
        {
            _dimensionsDirty = true;
            
            if (_dispatchedDimensionsChange || !hasEventListener(Object3DEvent.DIMENSIONS_CHANGED))
                return;
                
            if (!_dimensionschanged)
                _dimensionschanged = new Object3DEvent(Object3DEvent.DIMENSIONS_CHANGED, this);
                
            dispatchEvent(_dimensionschanged);
            
            _dispatchedDimensionsChange = true;
        }
        /** @private */
		arcane function dispatchMouseEvent(event:MouseEvent3D):Boolean
        {
            if (!hasEventListener(event.type))
                return false;

            dispatchEvent(event);

            return true;
        }
		/** @private */
		arcane function setParentPivot(val:Number3D):void
		{
			_parentPivot = val;
		}
		
        private static var toDEGREES:Number = 180 / Math.PI;
        private static var toRADIANS:Number = Math.PI / 180;
		
        private var _rotationDirty:Boolean;
        arcane var _sessionDirty:Boolean;
        arcane var _objectDirty:Boolean;
        arcane var _rotationX:Number = 0;
        arcane var _rotationY:Number = 0;
        arcane var _rotationZ:Number = 0;
        arcane var _scaleX:Number = 1;
        arcane var _scaleY:Number = 1;
        arcane var _scaleZ:Number = 1;
        arcane var _pivotPoint:Number3D = new Number3D();
        private var _scenePivotPoint:Number3D = new Number3D();
        private var _parentPivot:Number3D;
        private var _parentradius:Number3D = new Number3D();
        arcane var _scene:Scene3D;
        private var _oldscene:Scene3D;
        private var _parent:ObjectContainer3D;
		private var _quaternion:Quaternion = new Quaternion();
		private var _rot:Number3D = new Number3D();
		private var _sca:Number3D = new Number3D();
        private var _pivotZero:Boolean;
		private var _vector:Number3D = new Number3D();
		private var _m:Matrix3D = new Matrix3D();
    	private var _xAxis:Number3D = new Number3D();
    	private var _yAxis:Number3D = new Number3D();
    	private var _zAxis:Number3D = new Number3D();
    	private var _parentupdated:Object3DEvent;      
        private var _transformchanged:Object3DEvent;
        private var _scenetransformchanged:Object3DEvent;
        private var _scenechanged:Object3DEvent;
        private var _sessionchanged:Object3DEvent;
        private var _sessionupdated:Object3DEvent;
        private var _dimensionschanged:Object3DEvent;
        private var _dispatchedDimensionsChange:Boolean;
		arcane var _session:AbstractRenderSession;
		private var _ownSession:AbstractRenderSession;
		private var _ownCanvas:Boolean;
		private var _filters:Array;
		private var _alpha:Number;
		private var _blendMode:String;
		private var _renderer:IPrimitiveConsumer;
		private var _ownLights:Boolean;
		private var _lightsDirty:Boolean;
		private var _lightarray:ILightConsumer;
		private var _debugBoundingSphere:WireSphere;
		private var _debugBoundingBox:WireCube;
		private var _projector:IPrimitiveProvider;
		private var _visible:Boolean;
		
		private function onSessionUpdate(event:SessionEvent):void
		{
			if (event.target is BitmapRenderSession)
				_scene.updatedSessions[event.target] = event.target;
		}
		
        private function updateSceneTransform():void
        {
            _sceneTransform.multiply(_parent.sceneTransform, transform);
            
            if (!_pivotZero) {
            	_scenePivotPoint.rotate(_pivotPoint, _sceneTransform);
				_sceneTransform.tx -= _scenePivotPoint.x;
				_sceneTransform.ty -= _scenePivotPoint.y;
				_sceneTransform.tz -= _scenePivotPoint.z;
            }
            
            //calulate the inverse transform of the scene (used for lights and bones)
            inverseSceneTransform.inverse(_sceneTransform);
            
            notifySceneTransformChange();
        }
		
        private function updateRotation():void
        {
            _rot.matrix2euler(_transform, _scaleX, _scaleY, _scaleZ);
            _rotationX = _rot.x;
            _rotationY = _rot.y;
            _rotationZ = _rot.z;
    
            _rotationDirty = false;
        }
		
		private function onParentUpdate(event:Object3DEvent):void
		{
			_sessionDirty = true;
			
			dispatchEvent(event);
		}
		
        private function onParentSessionChange(event:Object3DEvent):void
        {
    		if (_ownSession && event.object.parent)
    			event.object.parent.session.removeChildSession(_ownSession);
    		
        	if (_ownSession && _parent.session)
        		_parent.session.addChildSession(_ownSession);
        		
            if (!_ownSession && _session != _parent.session) {
            	changeSession();
            	dispatchEvent(event);
            }
        }
        
        private function onParentSceneChange(event:Object3DEvent):void
        {
            if (_scene == _parent.scene)
                return;
            
            _scene = _parent.scene;
            
            notifySceneChange();
        }
		
        private function onParentTransformChange(event:Object3DEvent):void
        {
            _sceneTransformDirty = true;
        }
        
        private function updateLights():void
        {
        	if (!_ownLights)
        		_lightarray = parent.lightarray;
        	else
        		_lightarray = new LightArray();
        	
        	_lightsDirty = false;
        }
        
        private function changeSession():void
        {
			if (_ownSession)
        		_session = _ownSession;
        	else if (_parent)
        		_session = _parent.session;
        	else
        		_session = null;
        		
        	_sessionDirty = true;
        }
        
        protected var viewTransform:Matrix3D;
        
        /**
         * Instance of the Init object used to hold and parse default property values
         * specified by the initialiser object in the 3d object constructor.
         */
		protected var ini:Init;
        
        protected function updateTransform():void
        {
            if (_rotationDirty) 
                updateRotation();
            
            _quaternion.euler2quaternion(-_rotationY, -_rotationZ, _rotationX); // Swapped
            _transform.quaternion2matrix(_quaternion);
            
            _transform.scale(_transform, _scaleX, _scaleY, _scaleZ);
			
            _transformDirty = false;
            _sceneTransformDirty = true;
            _localTransformDirty = true;
        }
        
        protected function updateDimensions():void
        {
        	_dimensionsDirty = false;
        	
            _dispatchedDimensionsChange = false;
        	
        	if (debugbb)
            {
            	if (!_debugBoundingBox)
					_debugBoundingBox = new WireCube({material:"#333333"});
				
                if (boundingRadius) {
                	_debugBoundingBox.visible = true;
                	_debugBoundingBox.v000.setValue(_minX, _minY, _minZ);
                	_debugBoundingBox.v100.setValue(_maxX, _minY, _minZ);
                	_debugBoundingBox.v010.setValue(_minX, _maxY, _minZ);
                	_debugBoundingBox.v110.setValue(_maxX, _maxY, _minZ);
                	_debugBoundingBox.v001.setValue(_minX, _minY, _maxZ);
                	_debugBoundingBox.v101.setValue(_maxX, _minY, _maxZ);
                	_debugBoundingBox.v011.setValue(_minX, _maxY, _maxZ);
                	_debugBoundingBox.v111.setValue(_maxX, _maxY, _maxZ);
                } else {
                	debugBoundingBox.visible = false;
                }
            }
            
            if (debugbs)
            {
            	if (!_debugBoundingSphere)
					_debugBoundingSphere = new WireSphere({material:"#cyan", segmentsW:16, segmentsH:12});
				
                if (boundingRadius) {
                	_debugBoundingSphere.visible = true;
					_debugBoundingSphere.radius = _boundingRadius;
					_debugBoundingSphere.updateObject();
					_debugBoundingSphere.applyPosition(-_pivotPoint.x, -_pivotPoint.y, -_pivotPoint.z);
            	} else {
            		debugBoundingSphere.visible = false;
            	}
            }
        }
        
		/**
		 * Elements use their furthest point from the camera when z-sorting
		 */
        public var pushback:Boolean;
		
		/**
		 * Elements use their nearest point to the camera when z-sorting
		 */
        public var pushfront:Boolean;
        
    	/**
    	 * Returns the inverse of sceneTransform.
    	 * 
    	 * @see #sceneTransform
    	 */
        public var inverseSceneTransform:Matrix3D = new Matrix3D();
		
    	/**
    	 * An optional name string for the 3d object.
    	 * 
    	 * Can be used to access specific 3d object in a scene by calling the <code>getChildByName</code> method on the parent <code>ObjectContainer3D</code>.
    	 * 
    	 * @see away3d.containers.ObjectContainer3D#getChildByName()
    	 */
        public var name:String;
        
    	/**
    	 * An optional untyped object that can contain used-defined properties
    	 */
        public var extra:Object;
		
    	/**
    	 * Defines whether mouse events are received on the 3d object
    	 */
        public var mouseEnabled:Boolean = true;
        
    	/**
    	 * Defines whether a hand cursor is displayed when the mouse rolls over the 3d object.
    	 */
        public var useHandCursor:Boolean = false;
        
        /**
        * Reference container for all materials used in the container. Populated in <code>Collada</code> and <code>Max3DS</code> importers.
        * 
        * @see away3d.loaders.Collada
        * @see away3d.loaders.Max3DS
        */
    	public var materialLibrary:MaterialLibrary;

        /**
        * Reference container for all animations used in the container. Populated in <code>Collada</code> and <code>Max3DS</code> importers.
        * 
        * @see away3d.loaders.Collada
        * @see away3d.loaders.Max3DS
        */
    	public var animationLibrary:AnimationLibrary;

        /**
        * Reference container for all geometries used in the container. Populated in <code>Collada</code> and <code>Max3DS</code> importers.
        * 
        * @see away3d.loaders.Collada
        * @see away3d.loaders.Max3DS
        */
    	public var geometryLibrary:GeometryLibrary;
		
        /**
        * Indicates whether a debug bounding box should be rendered around the 3d object.
        */
        public var debugbb:Boolean;
		
        /**
        * Indicates whether a debug bounding sphere should be rendered around the 3d object.
        */
        public var debugbs:Boolean;
		
		public var center:Vertex = new Vertex();
		
		public function get debugBoundingBox():WireCube
		{	
            if (_dimensionsDirty || !_debugBoundingBox)
            	updateDimensions();
            
			return _debugBoundingBox;
		}
		
		public function get debugBoundingSphere():WireSphere
		{
            if (_dimensionsDirty || !_debugBoundingSphere)
            	updateDimensions();
            
            return _debugBoundingSphere;
		}
		
    	/**
    	 * The render session used by the 3d object
    	 */
        public function get session():AbstractRenderSession
        {
        	return _session;
        }
        
    	/**
    	 * Returns the bounding radius of the 3d object
    	 */
        public function get boundingRadius():Number
        {
            if (_dimensionsDirty)
            	updateDimensions();
           
           return _boundingRadius;
        }
        
    	/**
    	 * Returns the maximum x value of the 3d object
    	 * 
    	 * @see	#x
    	 */
        public function get maxX():Number
        {
            if (_dimensionsDirty)
            	updateDimensions();
           
           return _maxX;
        }
        
    	/**
    	 * Returns the minimum x value of the 3d object
    	 * 
    	 * @see	#x
    	 */
        public function get minX():Number
        {
            if (_dimensionsDirty)
            	updateDimensions();
           
           return _minX;
        }
        
    	/**
    	 * Returns the maximum y value of the 3d object
    	 * 
    	 * @see	#y
    	 */
        public function get maxY():Number
        {
            if (_dimensionsDirty)
            	updateDimensions();
           
           return _maxY;
        }
        
    	/**
    	 * Returns the minimum y value of the 3d object
    	 * 
    	 * @see	#y
    	 */
        public function get minY():Number
        {
            if (_dimensionsDirty)
            	updateDimensions();
           
           return _minY;
        }
        
    	/**
    	 * Returns the maximum z value of the 3d object
    	 * 
    	 * @see	#z
    	 */
        public function get maxZ():Number
        {
            if (_dimensionsDirty)
            	updateDimensions();
           
           return _maxZ;
        }
        
    	/**
    	 * Returns the minimum z value of the 3d object
    	 * 
    	 * @see	#z
    	 */
        public function get minZ():Number
        {
            if (_dimensionsDirty)
            	updateDimensions();
           
           return _minZ;
        }
				
		/**
		* Boundary width of the 3d object
		* 
		*@return	The width of the object
		*/
		public function get objectWidth():Number
		{
            if (_dimensionsDirty)
            	updateDimensions();
           
			return _maxX - _minX;
		}
		
		/**
		* Boundary height of the 3d object
		* 
		*@return	The height of the mesh
		*/
		public function get objectHeight():Number
		{
            if (_dimensionsDirty)
            	updateDimensions();
           
			return _maxY - _minY;
		}
		
		/**
		* Boundary depth of the 3d object
		* 
		*@return	The depth of the mesh
		*/
		public function get objectDepth():Number
		{
            if (_dimensionsDirty)
            	updateDimensions();
           
			return  _maxZ - _minZ;
		}
        
    	/**
    	 * Defines whether the 3d object is visible in the scene
    	 */
        public function get visible():Boolean
        {
            return _visible;
        }
    
        public function set visible(val:Boolean):void
        {
        	if (_visible == val)
        		return;
        	
        	_visible = val;
        	
        	_sessionDirty = true;
        	
        	notifyParentUpdate();
        }
        
    	/**
    	 * Defines whether the contents of the 3d object are rendered using it's own render session
    	 */
        public function get ownCanvas():Boolean
        {
            return _ownCanvas;
        }
    
        public function set ownCanvas(val:Boolean):void
        {
        	if (_ownCanvas == val)
        		return;
        	
        	if (val)
        		ownSession = new SpriteRenderSession();
        	else if (this is Scene3D)
        		throw new Error("Scene cannot have ownCanvas set to false");
        	else
        		ownSession = null;
        }
        
    	/**
    	 * An optional renderer object that can be used to render the contents of the object.
    	 * 
    	 * Requires <code>ownCanvas</code> to be set to true.
    	 * 
    	 * @see #ownCanvas
    	 */
        public function get renderer():IPrimitiveConsumer
        {
            return _renderer;
        }
    
        public function set renderer(val:IPrimitiveConsumer):void
        {
        	if (_renderer == val)
        		return;
        	
        	_renderer = val;
        	
        	if (_ownSession)
        		_ownSession.renderer = _renderer;
        }
        
    	/**
    	 * An optional array of filters that can be applied to the 3d object.
    	 * 
    	 * Requires <code>ownCanvas</code> to be set to true.
    	 * 
    	 * @see #ownCanvas
    	 */
        public function get filters():Array
        {
            return _filters;
        }
    
        public function set filters(val:Array):void
        {
        	if (_filters == val)
        		return;
        	
        	_filters = val;
        	
        	if (_ownSession)
        		_ownSession.filters = _filters;
        }
        
    	/**
    	 * An optional alpha value that can be applied to the 3d object.
    	 * 
    	 * Requires <code>ownCanvas</code> to be set to true.
    	 * 
    	 * @see #ownCanvas
    	 */
        public function get alpha():Number
        {
            return _alpha;
        }
    
        public function set alpha(val:Number):void
        {
        	if (_alpha == val)
        		return;
        	
        	_alpha = val;
        	
        	if (_ownSession)
        		_ownSession.alpha = _alpha;
        }
        
    	/**
    	 * An optional blend mode that can be applied to the 3d object.
    	 * 
    	 * Requires <code>ownCanvas</code> to be set to true.
    	 * 
    	 * @see #ownCanvas
    	 */
        public function get blendMode():String
        {
            return _blendMode;
        }
    
        public function set blendMode(val:String):void
        {
        	if (_blendMode == val)
        		return;
        	
        	_blendMode = val;
        	
        	if (_ownSession)
        		_ownSession.blendMode = _blendMode;
        }
        
    	/**
    	 * Defines a unique render session for the 3d object.
    	 */
        public function get ownSession():AbstractRenderSession
        {
            return _ownSession;
        }
    
        public function set ownSession(val:AbstractRenderSession):void
        {
        	if (_ownSession == val)
        		return;
        	
        	if (_ownSession) {
		    	//remove old session from parent session
        		if (_parent && _parent.session)
        			_parent.session.removeChildSession(_ownSession);
        			
	        	//reset old session children
        		_ownSession.clearChildSessions();
        		_ownSession.renderer = null;
        		_ownSession.internalRemoveOwnSession(this);
        		_ownSession.removeOnSessionUpdate(onSessionUpdate);
        	} else if (_parent && _parent.session) {
        		_parent.session.internalRemoveOwnSession(this);
        	}
        	
        	//set new session
        	_ownSession = val;
        	
        	if (_ownSession) {
	        	//add new session to parent session
	        	if (_parent && _parent.session)
	        		_parent.session.addChildSession(_ownSession);
	        	
		    	//reset new session children and session properties
        		_ownSession.clearChildSessions();
        		_ownSession.renderer = _renderer;
	        	_ownSession.filters = _filters;
	    		_ownSession.alpha = _alpha;
	    		_ownSession.blendMode = _blendMode;
	    		_ownSession.internalAddOwnSession(this);
	    		_ownSession.addOnSessionUpdate(onSessionUpdate);
        	} else if (this is Scene3D) {
        		throw new Error("Scene cannot have ownSession set to null");
        	} else if (_parent && _parent.session) {
        		_parent.session.internalAddOwnSession(this);
        	}
        	
        	
        	//update ownCanvas property
        	if (_ownSession)
        		_ownCanvas = true;
        	else
        		_ownCanvas = false;
        	
        	notifySessionChange();
        }
        
        public function get projector():IPrimitiveProvider
        {
        	return _projector;
        }
        
        public function set projector(val:IPrimitiveProvider):void
        {
        	if (_projector == val)
        		return;
        	
        	if (_projector)
        		_projector.source = null;
        	
        	_projector = val;
        	
        	if (_projector)
        		_projector.source = this;
        }
        
    	/**
    	 * Defines the x coordinate of the 3d object relative to the local coordinates of the parent <code>ObjectContainer3D</code>.
    	 */
        public function get x():Number
        {
            return _transform.tx;
        }
    
        public function set x(value:Number):void
        {
            if (isNaN(value))
                throw new Error("isNaN(x)");
			
			if (_transform.tx == value)
				return;
			
            if (value == Infinity)
                Debug.warning("x == Infinity");

            if (value == -Infinity)
                Debug.warning("x == -Infinity");

            _transform.tx = value;

            _sceneTransformDirty = true;
			_localTransformDirty = true;
        }
		
    	/**
    	 * Defines the y coordinate of the 3d object relative to the local coordinates of the parent <code>ObjectContainer3D</code>.
    	 */
        public function get y():Number
        {
            return _transform.ty;
        }
    
        public function set y(value:Number):void
        {
            if (isNaN(value))
                throw new Error("isNaN(y)");
			
			if (_transform.ty == value)
				return;
			
            if (value == Infinity)
                Debug.warning("y == Infinity");

            if (value == -Infinity)
                Debug.warning("y == -Infinity");

            _transform.ty = value;

            _sceneTransformDirty = true;
			_localTransformDirty = true;
        }
		
    	/**
    	 * Defines the z coordinate of the 3d object relative to the local coordinates of the parent <code>ObjectContainer3D</code>.
    	 */
        public function get z():Number
        {
            return _transform.tz;
        }
    	
        public function set z(value:Number):void
        {
            if (isNaN(value))
                throw new Error("isNaN(z)");
			
			if (_transform.tz == value)
				return;
			
            if (value == Infinity)
                Debug.warning("z == Infinity");

            if (value == -Infinity)
                Debug.warning("z == -Infinity");

            _transform.tz = value;

            _sceneTransformDirty = true;
			_localTransformDirty = true;
        }
		
    	/**
    	 * Defines the euler angle of rotation of the 3d object around the x-axis, relative to the local coordinates of the parent <code>ObjectContainer3D</code>.
    	 */
        public function get rotationX():Number
        {
            if (_rotationDirty) 
                updateRotation();
    
            return -_rotationX*toDEGREES;
        }
    
        public function set rotationX(rot:Number):void
        {
        	if (_rotationX == -rot*toRADIANS)
        		return;
        	
            _rotationX = -rot*toRADIANS;
            _transformDirty = true;
        }
		
    	/**
    	 * Defines the euler angle of rotation of the 3d object around the y-axis, relative to the local coordinates of the parent <code>ObjectContainer3D</code>.
    	 */
        public function get rotationY():Number
        {
            if (_rotationDirty) 
                updateRotation();
    
            return -_rotationY*toDEGREES;
        }
    
        public function set rotationY(rot:Number):void
        {
        	if (_rotationY == -rot*toRADIANS)
        		return;
        	
            _rotationY = -rot*toRADIANS;
            _transformDirty = true;
        }
		
    	/**
    	 * Defines the euler angle of rotation of the 3d object around the z-axis, relative to the local coordinates of the parent <code>ObjectContainer3D</code>.
    	 */
        public function get rotationZ():Number
        {
            if (_rotationDirty) 
                updateRotation();
    
            return -_rotationZ*toDEGREES;
        }
    
        public function set rotationZ(rot:Number):void
        {
        	if (_rotationZ == -rot*toRADIANS)
        		return;
        	
            _rotationZ = -rot*toRADIANS;
            _transformDirty = true;
        }
		
    	/**
    	 * Defines the scale of the 3d object along the x-axis, relative to local coordinates.
    	 */
        public function get scaleX():Number
        {
            return _scaleX;
        }
    
        public function set scaleX(scale:Number):void
        {
        	if (_scaleX == scale)
        		return;
        	
            _scaleX = scale;
            _transformDirty = true;
            _dimensionsDirty = true;
        }
		
    	/**
    	 * Defines the scale of the 3d object along the y-axis, relative to local coordinates.
    	 */
        public function get scaleY():Number
        {
            return _scaleY;
        }
    
        public function set scaleY(scale:Number):void
        {
        	if (_scaleY == scale)
        		return;
        	
            _scaleY = scale;
            _transformDirty = true;
            _dimensionsDirty = true;
        }
		
    	/**
    	 * Defines the scale of the 3d object along the z-axis, relative to local coordinates.
    	 */
        public function get scaleZ():Number
        {
            return _scaleZ;
        }
    
        public function set scaleZ(scale:Number):void
        {
        	if (_scaleZ == scale)
        		return;
        	
            _scaleZ = scale;
            _transformDirty = true;
            _dimensionsDirty = true;
        }
        
    	/**
    	 * Defines the position of the 3d object, relative to the local coordinates of the parent <code>ObjectContainer3D</code>.
    	 */
        public function get position():Number3D
        {
            return transform.position;
        }
		
        public function set position(value:Number3D):void
        {
            _transform.tx = value.x;
            _transform.ty = value.y;
            _transform.tz = value.z;

            _sceneTransformDirty = true;
			_localTransformDirty = true;
        }
        
    	/**
    	 * Defines the transformation of the 3d object, relative to the local coordinates of the parent <code>ObjectContainer3D</code>.
    	 */
        public function get transform():Matrix3D
        {
            if (_transformDirty) 
                updateTransform();

            return _transform;
        }

        public function set transform(value:Matrix3D):void
        {
            if (value.toString() == _transform.toString())
                return;

            _transform.clone(value);

            _transformDirty = false;
            _rotationDirty = true;
            _sceneTransformDirty = true;
            _localTransformDirty = true;
            
            _sca.matrix2scale(_transform);
        	
    		if (_scaleX != _sca.x || _scaleY != _sca.y || _scaleZ != _sca.z) {
    			_scaleX = _sca.x;
    			_scaleY = _sca.y;
    			_scaleZ = _sca.z;
    			_dimensionsDirty = true;
    		}
        }
		
    	/**
    	 * Defines the parent of the 3d object.
    	 */
        public function get parent():ObjectContainer3D
        {
            return _parent;
        }
		
        public function set parent(value:ObjectContainer3D):void
        {
        	if (this is Scene3D)
        		 throw new Error("Scene cannot be parented");
			
            if (value == _parent)
                return;
			
            _oldscene = _scene;
			
            if (_parent != null) {
            	_parent.removeOnParentUpdate(onParentUpdate);
            	_parent.removeOnSessionChange(onParentSessionChange);
                _parent.removeOnSceneChange(onParentSceneChange);
                _parent.removeOnSceneTransformChange(onParentTransformChange);
                
                _parent.internalRemoveChild(this);
                
                if (_ownSession && _parent.session)
					_parent.session.removeChildSession(_ownSession);
            }
			
            _parent = value;
            _scene = _parent ? _parent.scene : null;
			
            if (_parent != null) {
            	_parent.internalAddChild(this);
            	
            	_parent.addOnParentUpdate(onParentUpdate);
                _parent.addOnSessionChange(onParentSessionChange);
                _parent.addOnSceneChange(onParentSceneChange);
                _parent.addOnSceneTransformChange(onParentTransformChange);
                
                if (_ownSession && _parent.session)
					_parent.session.addChildSession(_ownSession);
            }
			
            if (_scene != _oldscene)
                notifySceneChange();
            
			if (!_ownSession && (!_parent || _session != _parent.session))
				notifySessionChange();
			
            _sceneTransformDirty = true;
            _localTransformDirty = true;
        }
        
    	/**
    	 * Returns the transformation of the 3d object, relative to the global coordinates of the <code>Scene3D</code> object.
    	 */
        public function get sceneTransform():Matrix3D
        {
        	//for camera transforms
            if (_scene == null || _scene == this) {
            	if (_transformDirty)
            		 _sceneTransformDirty = true;
				
            	if (_sceneTransformDirty)
            		notifySceneTransformChange();
            	
                return transform;
            }
			
            if (_transformDirty) 
                updateTransform();
			
            if (_sceneTransformDirty) 
                updateSceneTransform();
			
			if (_localTransformDirty)
				notifyTransformChange();
        	
            return _sceneTransform;
        }
        
    	/**
    	 * Defines whether the children of the container are rendered using it's own lights.
    	 */
    	public function get ownLights():Boolean
    	{
    		return _ownLights;
    	}
    	
    	public function set ownLights(val:Boolean):void
    	{
    		_ownLights = val;
    		
    		_lightsDirty = true;
    	}
    	
    	/**
    	 * returns the array of lights contained inside the container.
    	 */
    	public function get lightarray():ILightConsumer
    	{
    		if (_lightsDirty)
    			updateLights();
    		
    		return _lightarray;
    	}
    	
    	/**
    	 * Returns the position of the 3d object, relative to the global coordinates of the <code>Scene3D</code> object.
    	 */
        public function get scenePosition():Number3D
        {
            return sceneTransform.position;
        }
		
    	/**
    	 * Returns the parent scene of the 3d object
    	 */
        public function get scene():Scene3D
        {
            return _scene;
        }
        
        public function get pivotPoint():Number3D
        {
        	return _pivotPoint;
        }
        
        public function get scenePivotPoint():Number3D
        {
        	return _scenePivotPoint;
        }
        
    	/**
    	 * @private
    	 */
        public function Object3D(init:Object = null):void
        {
        	
            ini = Init.parse(init);

            name = ini.getString("name", name);
            ownSession = ini.getObject("ownSession", AbstractRenderSession) as AbstractRenderSession;
            ownCanvas = ini.getBoolean("ownCanvas", ownCanvas);
            ownLights = ini.getBoolean("ownLights", false);
            visible = ini.getBoolean("visible", true);
            mouseEnabled = ini.getBoolean("mouseEnabled", mouseEnabled);
            useHandCursor = ini.getBoolean("useHandCursor", useHandCursor);
            renderer = ini.getObject("renderer", IPrimitiveConsumer) as IPrimitiveConsumer;
            filters = ini.getArray("filters");
            alpha = ini.getNumber("alpha", 1);
            blendMode = ini.getString("blendMode", BlendMode.NORMAL);
            debugbb = ini.getBoolean("debugbb", false);
            debugbs = ini.getBoolean("debugbs", false);
            pushback = ini.getBoolean("pushback", false);
            pushfront = ini.getBoolean("pushfront", false);
            x = ini.getNumber("x", 0);
            y = ini.getNumber("y", 0);
            z = ini.getNumber("z", 0);        
            rotationX = ini.getNumber("rotationX", 0);
            rotationY = ini.getNumber("rotationY", 0);
            rotationZ = ini.getNumber("rotationZ", 0);
            
            extra = ini.getObject("extra");
			
        	if (this is Scene3D)
        		_scene = this as Scene3D;
        	else
            	parent = ini.getObject3D("parent") as ObjectContainer3D;
			
            /*
            var scaling:Number = init.getNumber("scale", 1);

            scaleX(init.getNumber("scaleX", 1) * scaling);
            scaleY(init.getNumber("scaleY", 1) * scaling);
            scaleZ(init.getNumber("scaleZ", 1) * scaling);
            */
        }
		
		public function updateObject():void
		{
			if (_objectDirty) {
				_scene.updatedObjects[this] = this;
				_objectDirty = false;
				_sessionDirty = true;
			}
		}
		
		public function updateSession():void
		{
			if (_sessionDirty) {
	        	notifySessionUpdate();
	        	_sessionDirty = false;
	  		}
		}
		
    	/**
    	 * Scales the contents of the 3d object.
    	 * 
    	 * @param	scale	The scaling value
    	 */
        public function scale(scale:Number):void
        {
        	_scaleX = _scaleY = _scaleZ = scale;
        	_transformDirty = true;
        	_dimensionsDirty = true;
        }
        
    	/**
    	 * Calulates the absolute distance between the local 3d object position and the position of the given 3d object
    	 * 
    	 * @param	obj		The 3d object to use for calulating the distance
    	 * @return			The scalar distance between objects
    	 * 
    	 * @see	#position
    	 */
        public function distanceTo(obj:Object3D):Number
        {
            var m1:Matrix3D = _scene == this ? transform : sceneTransform;
            var m2:Matrix3D = obj.scene == obj ? obj.transform : obj.sceneTransform;

            var dx:Number = m1.tx - m2.tx;
            var dy:Number = m1.ty - m2.ty;
            var dz:Number = m1.tz - m2.tz;
    
            return Math.sqrt(dx*dx + dy*dy + dz*dz);
        }
    	
    	/**
    	 * Used when traversing the scenegraph
    	 * 
    	 * @param	tranverser		The traverser object
    	 * 
    	 * @see	away3d.core.traverse.BlockerTraverser
    	 * @see	away3d.core.traverse.PrimitiveTraverser
    	 * @see	away3d.core.traverse.ProjectionTraverser
    	 * @see	away3d.core.traverse.TickTraverser
    	 */
        public function traverse(traverser:Traverser):void
        {
        	
            if (traverser.match(this))
            {
            	
                traverser.enter(this);
				traverser.apply(this);
                traverser.leave(this);
               
            }
        }
        
        /**
         * Moves the 3d object forwards along it's local z axis
         * 
         * @param	distance	The length of the movement
         */
        public function moveForward(distance:Number):void 
        { 
            translate(Number3D.FORWARD, distance); 
        }
        
        /**
         * Moves the 3d object backwards along it's local z axis
         * 
         * @param	distance	The length of the movement
         */
        public function moveBackward(distance:Number):void 
        { 
            translate(Number3D.BACKWARD, distance); 
        }
        
        /**
         * Moves the 3d object backwards along it's local x axis
         * 
         * @param	distance	The length of the movement
         */
        public function moveLeft(distance:Number):void 
        { 
            translate(Number3D.LEFT, distance); 
        }
        
        /**
         * Moves the 3d object forwards along it's local x axis
         * 
         * @param	distance	The length of the movement
         */
        public function moveRight(distance:Number):void 
        { 
            translate(Number3D.RIGHT, distance); 
        }
        
        /**
         * Moves the 3d object forwards along it's local y axis
         * 
         * @param	distance	The length of the movement
         */
        public function moveUp(distance:Number):void 
        { 
            translate(Number3D.UP, distance); 
        }
        
        /**
         * Moves the 3d object backwards along it's local y axis
         * 
         * @param	distance	The length of the movement
         */
        public function moveDown(distance:Number):void 
        { 
            translate(Number3D.DOWN, distance); 
        }
        
        /**
         * Moves the 3d object directly to a point in space
         * 
		 * @param	dx		The amount of movement along the local x axis.
		 * @param	dy		The amount of movement along the local y axis.
		 * @param	dz		The amount of movement along the local z axis.
         */
        public function moveTo(dx:Number, dy:Number, dz:Number):void
        {
        	if (_transform.tx == dx && _transform.ty == dy && _transform.tz == dz)
        		return;
        	
            _transform.tx = dx;
            _transform.ty = dy;
            _transform.tz = dz;
            
            _localTransformDirty = true;
            _sceneTransformDirty = true;
        }
		
		/**
		 * Moves the local point around which the object rotates.
		 * 
		 * @param	dx		The amount of movement along the local x axis.
		 * @param	dy		The amount of movement along the local y axis.
		 * @param	dz		The amount of movement along the local z axis.
		 */
        public function movePivot(dx:Number, dy:Number, dz:Number):void
        {
        	_pivotPoint.x = dx;
        	_pivotPoint.y = dy;
        	_pivotPoint.z = dz;
        	
        	_pivotZero = (!dx && !dy && !dz);
        	_sceneTransformDirty = true;
        	_dimensionsDirty = true;
        }
        
		/**
		 * Moves the 3d object along a vector by a defined length
		 * 
		 * @param	axis		The vector defining the axis of movement
		 * @param	distance	The length of the movement
		 */
        public function translate(axis:Number3D, distance:Number):void
        {
            _vector.rotate(axis, transform);
    
            x += distance * _vector.x;
            y += distance * _vector.y;
            z += distance * _vector.z;
        }
        
        /**
         * Rotates the 3d object around it's local x-axis
         * 
         * @param	angle		The amount of rotation in degrees
         */
        public function pitch(angle:Number):void
        {
            rotate(Number3D.RIGHT, angle);
        }
        
        /**
         * Rotates the 3d object around it's local y-axis
         * 
         * @param	angle		The amount of rotation in degrees
         */
        public function yaw(angle:Number):void
        {
            rotate(Number3D.UP, angle);
        }
        
        /**
         * Rotates the 3d object around it's local z-axis
         * 
         * @param	angle		The amount of rotation in degrees
         */
        public function roll(angle:Number):void
        {
            rotate(Number3D.FORWARD, angle);
        }
		
		/**
		 * Rotates the 3d object around an axis by a defined angle
		 * 
		 * @param	axis		The vector defining the axis of rotation
		 * @param	angle		The amount of rotation in degrees
		 */
        public function rotate(axis:Number3D, angle:Number):void
        {
        	if (_transformDirty)
        		updateTransform();
        	
            _vector.rotate(axis, _transform);
            _m.rotationMatrix(_vector.x, _vector.y, _vector.z, angle * toRADIANS);
    		_m.tx = _transform.tx;
    		_m.ty = _transform.ty;
    		_m.tz = _transform.tz;
    		_transform.multiply3x3(_m, _transform);
    
            _rotationDirty = true;
            _sceneTransformDirty = true;
            _localTransformDirty = true;
        }

		
		/**
		 * Rotates the 3d object around to face a point defined relative to the local coordinates of the parent <code>ObjectContainer3D</code>.
		 * 
		 * @param	target		The vector defining the point to be looked at
		 * @param	upAxis		An optional vector used to define the desired up orientation of the 3d object after rotation has occurred
		 */
        public function lookAt(target:Number3D, upAxis:Number3D = null):void
        {
            _zAxis.sub(target, position);
            _zAxis.normalize();
    
            if (_zAxis.modulo > 0.1 && (_zAxis.x != _transform.sxz || _zAxis.y != _transform.syz || _zAxis.z != _transform.szz))
            {
                _xAxis.cross(_zAxis, upAxis || Number3D.UP);
                _xAxis.normalize();
    
                _yAxis.cross(_zAxis, _xAxis);
                _yAxis.normalize();
    
                _transform.sxx = _xAxis.x;
                _transform.syx = _xAxis.y;
                _transform.szx = _xAxis.z;
    
                _transform.sxy = -_yAxis.x;
                _transform.syy = -_yAxis.y;
                _transform.szy = -_yAxis.z;
    
                _transform.sxz = _zAxis.x;
                _transform.syz = _zAxis.y;
                _transform.szz = _zAxis.z;
    
                _transformDirty = false;
                _rotationDirty = true;
                _sceneTransformDirty = true;
                _localTransformDirty = true;
                // TODO: Implement scale
            }
            else
            {
                //throw new Error("lookAt Error");
            }
        }
		
		/**
		 * Used to trace the values of a 3d object.
		 * 
		 * @return A string representation of the 3d object.
		 */
        public override function toString():String
        {
            return (name ? name : "$") + ': x:' + Math.round(x) + ' y:' + Math.round(y) + ' z:' + Math.round(z);
        }
		
		/**
		 * Called by the <code>TickTraverser</code>.
		 * 
		 * Can be overridden to provide updates to the 3d object based on individual render calls from the renderer.
		 * 
		 * @param	time		The absolute time at the start of the render cycle
		 * 
		 * @see away3d.core.traverse.TickTraverser
		 */
        public function tick(time:int):void
        {
        }
		
		/**
		 * Duplicates the 3d object's properties to another <code>Object3D</code> object
		 * 
		 * @param	object	[optional]	The new object instance into which all properties are copied
		 * @return						The new object instance with duplicated properties applied
		 */
        public function clone(object:Object3D = null):Object3D
        {
            var object3D:Object3D = object || new Object3D();
            object3D.transform = transform;
            object3D.name = name;
            object3D.ownCanvas = _ownCanvas;
            object3D.renderer = _renderer;
            object3D.filters = _filters;
            object3D.alpha = _alpha;
            object3D.visible = visible;
            object3D.mouseEnabled = mouseEnabled;
            object3D.useHandCursor = useHandCursor;
            object3D.pushback = pushback;
            object3D.pushfront = pushfront;
            object3D.pivotPoint.clone(pivotPoint);
            object3D.projector = _projector.clone();
            object3D.extra = (extra is IClonable) ? (extra as IClonable).clone() : extra;
            
            return object3D;
        }
		
		/**
		 * Default method for adding a parentupdated event listener
		 * 
		 * @param	listener		The listener function
		 */
        public function addOnParentUpdate(listener:Function):void
        {
            addEventListener(Object3DEvent.PARENT_UPDATED, listener, false, 0, true);
        }
		
		/**
		 * Default method for removing a parentupdated event listener
		 * 
		 * @param	listener		The listener function
		 */
        public function removeOnParentUpdate(listener:Function):void
        {
            removeEventListener(Object3DEvent.PARENT_UPDATED, listener, false);
        }
        
		/**
		 * Default method for adding a transformchanged event listener
		 * 
		 * @param	listener		The listener function
		 */
        public function addOnTransformChange(listener:Function):void
        {
            addEventListener(Object3DEvent.TRANSFORM_CHANGED, listener, false, 0, true);
        }
		
		/**
		 * Default method for removing a transformchanged event listener
		 * 
		 * @param	listener		The listener function
		 */
        public function removeOnTransformChange(listener:Function):void
        {
            removeEventListener(Object3DEvent.TRANSFORM_CHANGED, listener, false);
        }
		
		/**
		 * Default method for adding a scenetransformchanged event listener
		 * 
		 * @param	listener		The listener function
		 */
		public function addOnSceneTransformChange(listener:Function):void
        {
            addEventListener(Object3DEvent.SCENETRANSFORM_CHANGED, listener, false, 0, true);
        }
		
		/**
		 * Default method for removing a scenetransformchanged event listener
		 * 
		 * @param	listener		The listener function
		 */
        public function removeOnSceneTransformChange(listener:Function):void
        {
            removeEventListener(Object3DEvent.SCENETRANSFORM_CHANGED, listener, false);
        }
		
		/**
		 * Default method for adding a scenechanged event listener
		 * 
		 * @param	listener		The listener function
		 */
        public function addOnSceneChange(listener:Function):void
        {
            addEventListener(Object3DEvent.SCENE_CHANGED, listener, false, 0, true);
        }
		
		/**
		 * Default method for removing a scenechanged event listener
		 * 
		 * @param	listener		The listener function
		 */
        public function removeOnSceneChange(listener:Function):void
        {
            removeEventListener(Object3DEvent.SCENE_CHANGED, listener, false);
        }
		
		/**
		 * Default method for adding a sessionchanged event listener
		 * 
		 * @param	listener		The listener function
		 */
        public function addOnSessionChange(listener:Function):void
        {
            addEventListener(Object3DEvent.SESSION_CHANGED, listener, false, 0, true);
        }
		
		/**
		 * Default method for removing a sessionchanged event listener
		 * 
		 * @param	listener		The listener function
		 */
        public function removeOnSessionChange(listener:Function):void
        {
            removeEventListener(Object3DEvent.SESSION_CHANGED, listener, false);
        }
        
		/**
		 * Default method for adding a dimensionschanged event listener
		 * 
		 * @param	listener		The listener function
		 */
        public function addOnDimensionsChange(listener:Function):void
        {
            addEventListener(Object3DEvent.DIMENSIONS_CHANGED, listener, false, 0, true);
        }
		
		/**
		 * Default method for removing a dimensionschanged event listener
		 * 
		 * @param	listener		The listener function
		 */
        public function removeOnDimensionsChange(listener:Function):void
        {
            removeEventListener(Object3DEvent.DIMENSIONS_CHANGED, listener, false);
        }
		
		/**
		 * Default method for adding a mouseMove3D event listener
		 * 
		 * @param	listener		The listener function
		 */
        public function addOnMouseMove(listener:Function):void
        {
            addEventListener(MouseEvent3D.MOUSE_MOVE, listener, false, 0, false);
        }
		
		/**
		 * Default method for removing a mouseMove3D event listener
		 * 
		 * @param	listener		The listener function
		 */
        public function removeOnMouseMove(listener:Function):void
        {
            removeEventListener(MouseEvent3D.MOUSE_MOVE, listener, false);
        }
		
		/**
		 * Default method for adding a mouseDown3D event listener
		 * 
		 * @param	listener		The listener function
		 */
        public function addOnMouseDown(listener:Function):void
        {
            addEventListener(MouseEvent3D.MOUSE_DOWN, listener, false, 0, false);
        }
		
		/**
		 * Default method for removing a mouseDown3D event listener
		 * 
		 * @param	listener		The listener function
		 */
        public function removeOnMouseDown(listener:Function):void
        {
            removeEventListener(MouseEvent3D.MOUSE_DOWN, listener, false);
        }
		
		/**
		 * Default method for adding a mouseUp3D event listener
		 * 
		 * @param	listener		The listener function
		 */
        public function addOnMouseUp(listener:Function):void
        {
            addEventListener(MouseEvent3D.MOUSE_UP, listener, false, 0, false);
        }
		
		/**
		 * Default method for removing a mouseUp3D event listener
		 * 
		 * @param	listener		The listener function
		 */
        public function removeOnMouseUp(listener:Function):void
        {
            removeEventListener(MouseEvent3D.MOUSE_UP, listener, false);
        }
		
		/**
		 * Default method for adding a mouseOver3D event listener
		 * 
		 * @param	listener		The listener function
		 */
        public function addOnMouseOver(listener:Function):void
        {
            addEventListener(MouseEvent3D.MOUSE_OVER, listener, false, 0, false);
        }
		
		/**
		 * Default method for removing a mouseOver3D event listener
		 * 
		 * @param	listener		The listener function
		 */
        public function removeOnMouseOver(listener:Function):void
        {
            removeEventListener(MouseEvent3D.MOUSE_OVER, listener, false);
        }
		
		/**
		 * Default method for adding a mouseOut3D event listener
		 * 
		 * @param	listener		The listener function
		 */
        public function addOnMouseOut(listener:Function):void
        {
            addEventListener(MouseEvent3D.MOUSE_OUT, listener, false, 0, false);
        }
		
		/**
		 * Default method for removing a mouseOut3D event listener
		 * 
		 * @param	listener		The listener function
		 */
        public function removeOnMouseOut(listener:Function):void
        {
            removeEventListener(MouseEvent3D.MOUSE_OUT, listener, false);
        }
    }
}
