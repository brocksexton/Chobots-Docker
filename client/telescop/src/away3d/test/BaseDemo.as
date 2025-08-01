package 
{
	import away3d.cameras.*;
	import away3d.containers.*;
	import away3d.core.render.*;
	import away3d.core.utils.*;
	import away3d.test.Button;
	import away3d.test.Panel;
	import away3d.test.Slide;
	
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.ui.Keyboard;
	import flash.utils.*;

    /**
    * Base class for Away3D demos 
    */ 
    public class BaseDemo extends Sprite
    {
        protected var camera:HoverCamera3D;

        private var slide:Slide;
        private var slides:Array = new Array();
        private var slideindex:Number = 0;

        protected var centergroup:Sprite;
        protected var startlabel:TextField;

        protected var titlegroup:Sprite;
        protected var statsgroup:Sprite;
        protected var infogroup:Sprite;
        protected var lefttopgroup:Sprite;

        private var copylabel:TextField;
        private var fpslabel:TextField;
        private var cpulabel:TextField;
        private var trilabel:TextField;
        private var messagelabel:TextField;
        private var titlelabel:TextField;

        private var nextbutton:Button;
        private var prevbutton:Button;

        private var dirty:Boolean = true;

        private var lastrender:int = 0;
		
        private var stageWidth:Number = 1;
        private var stageHeight:Number = 1;

        private var active:Boolean = false;
        private var animation:Boolean = true;
        private var scroll:Boolean = true;
        private var time:int;

        protected var view:View3D;

        public function BaseDemo(title:String="huj", infogroupheight:Number = 410)
        {
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            //stage.showDefaultContextMenu = false;
            stage.stageFocusRect = false;

            camera = new HoverCamera3D({zoom:3, focus:200, distance:800});
            camera.tiltangle = 10;
            camera.targettiltangle = 40;

            camera.panangle = 0;
            camera.targetpanangle = 230;

            camera.mintiltangle = 0;

            view = new View3D({camera:camera, stats:true});
            addChild(view);
            
            lefttopgroup = new Sprite();
            addChild(lefttopgroup);

            statsgroup = new Sprite();
            lefttopgroup.addChild(statsgroup);

            statsgroup.addChild(new Panel(5, 5, 400, 70, 0.8));

            fpslabel = new TextField();
            fpslabel.x = 10;
            fpslabel.y = 10;
            fpslabel.defaultTextFormat = new TextFormat("Arial", 16, 0x000000);
            fpslabel.text = "";
            fpslabel.background = true;
            fpslabel.height = 20;
            fpslabel.width = 200;
            fpslabel.backgroundColor = 0xCC0000;
            statsgroup.addChild(fpslabel);

            cpulabel = new TextField();
            cpulabel.x = fpslabel.x;
            cpulabel.y = fpslabel.y + fpslabel.height;
            cpulabel.defaultTextFormat = fpslabel.defaultTextFormat;
            cpulabel.text = "";
            cpulabel.background = true;
            cpulabel.height = 20;
            cpulabel.width = 200;
            cpulabel.backgroundColor = 0x0000CC;
            statsgroup.addChild(cpulabel);
    
            trilabel = new TextField();
            trilabel.x = cpulabel.x;
            trilabel.y = cpulabel.y + cpulabel.height;
            trilabel.defaultTextFormat = new TextFormat("Arial", 10, 0x000000);
            trilabel.text = "";
            trilabel.height = 22;
            trilabel.width = 380;
            statsgroup.addChild(trilabel);

            infogroup = new Sprite();
            lefttopgroup.addChild(infogroup);
            infogroup.y = statsgroup.height + 4;

            infogroup.addChild(new Panel(5, 5, 250, infogroupheight, 0.8));

            messagelabel = new TextField();
            messagelabel.autoSize = TextFieldAutoSize.LEFT;
            messagelabel.wordWrap = true;
            messagelabel.x = 10;
            messagelabel.y = 10;
            messagelabel.defaultTextFormat = trilabel.defaultTextFormat;
            messagelabel.text = "";
            messagelabel.width = 240;
            messagelabel.multiline = true;
            infogroup.addChild(messagelabel);

            prevbutton = new Button("Prev", 46);
            prevbutton.x = 80;
            prevbutton.y = infogroup.height - 52;
            infogroup.addChild(prevbutton);

            nextbutton = new Button("Next", 46);
            nextbutton.x = prevbutton.x + prevbutton.width + 4;
            nextbutton.y = prevbutton.y;
            infogroup.addChild(nextbutton);

            copylabel = new TextField();
            copylabel.autoSize = TextFieldAutoSize.CENTER;
            copylabel.x = 124;
            copylabel.y = infogroup.height - 30;
            copylabel.defaultTextFormat = new TextFormat("Arial", 10, 0x000000, true);
            copylabel.htmlText = "<p align='center'>Alexander Zadorozhny (c) 2007<br>\n<a href='http://away.kiev.ua/'>http://away.kiev.ua/</a></p>";
            infogroup.addChild(copylabel);

            titlegroup = new Sprite();
            lefttopgroup.addChild(titlegroup);
            titlegroup.x = statsgroup.width + 4;

            titlegroup.addChild(new Panel(5, 5, 360, 36, 0.8));

            titlelabel = new TextField();
            titlelabel.autoSize = TextFieldAutoSize.CENTER;
            titlelabel.x = 180;
            titlelabel.y = 10;
            titlelabel.defaultTextFormat = new TextFormat("Arial", 18, 0x000000, true);
            titlelabel.htmlText = title;
            titlegroup.addChild(titlelabel);

            centergroup = new Sprite();
            addChild(centergroup);
            centergroup.x = stage.stageWidth / 2;
            centergroup.y = stage.stageHeight / 2;

            centergroup.addChild(new Panel(-80, -20, 160, 40, 0.8));

            startlabel = new TextField();
            startlabel.autoSize = TextFieldAutoSize.CENTER;
            startlabel.x = 0;
            startlabel.y = -18;
            startlabel.defaultTextFormat = new TextFormat("Arial", 24, 0x000000, true);
            startlabel.htmlText = "Start demo";
            centergroup.addChild(startlabel);

            stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
            stage.addEventListener(Event.RESIZE, onResize);
            stage.addEventListener(Event.ACTIVATE, onActivate);
            stage.addEventListener(Event.DEACTIVATE, onDeactivate);
            stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
            stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
            prevbutton.addEventListener(MouseEvent.CLICK, onPrev);
            nextbutton.addEventListener(MouseEvent.CLICK, onNext);

            this.onResize(null);

            Debug.active = true;
       }

        protected function addSlide(title:String, text:String, scene:Scene3D, renderer:IRenderer, session:AbstractRenderSession):void
        {
            slides.push(new Slide(title, text, scene, renderer, session));
        }

        private function changeSlide():void
        {
            slide = slides[slideindex];
            dirty = true;
            messagelabel.htmlText = "<font size='16' face='arial'>"
                            +"<p align='center'><b>"+slide.title+"</b></p>"
                            +"<p align='left'>"+slide.desc+"</p>"
                            +"</font>";
            nextbutton.visible = slideindex < slides.length-1;
            prevbutton.visible = slideindex > 0;

            view.clear();
            view.scene = slide.scene;
            view.renderer = slide.renderer;
            view.session = slide.session;
        }

        private function onNext(event:MouseEvent):void
        {
            slideindex = Math.min(slides.length-1, slideindex+1);
            changeSlide();
        }

        private function onPrev(event:MouseEvent):void
        {
            slideindex = Math.max(0, slideindex-1);
            changeSlide();
        }

        private function onEnterFrame(event:Event):void
        {
            if (slide == null)
                changeSlide();

            if (!active)
                return;

            dirty = true; // !!

            if (scroll)
            {
                if (view.mouseX > stage.stageWidth*0.40)
                    camera.targetpanangle -= 3;
                if (view.mouseX < -stage.stageWidth*0.40)
                    camera.targetpanangle += 3;

                if (view.mouseY > stage.stageHeight*0.40)
                    camera.targettiltangle -= 2;
                if (view.mouseY < -stage.stageHeight*0.40)
                    camera.targettiltangle += 2;
            }

            if (camera.hover())
                dirty = true;

            if (!dirty)
            {
                fpslabel.width = 0;
                cpulabel.width = 0;
                return;
            }

            var start:int = getTimer();

            if (animation)
                time = getTimer();

            slide.scene.updateTime(time);
            
            view.render();
            
            var now:int = getTimer();
            var performance:int = now - lastrender;
            lastrender = now;

            if (performance < 1000)
            {
                fpslabel.text = "" + int(1000 / (performance+0.001)) + " fps " + performance + " ms";
                fpslabel.width = 4 * performance;
            }

            var think:int = now - start;
            if (think < 1000)
            {
                cpulabel.width = 4 * think;
            }

            trilabel.text = slide.renderer.toString();

            dirty = false;
        }

        private function onResize(event:Event):void 
        {
            view.x = stage.stageWidth / 2;
            view.y = stage.stageHeight / 2;

            stageWidth = stage.stageWidth;
            stageHeight = stage.stageHeight;

            dirty = true;
        }

        private function onActivate(event:Event):void 
        {
            onResize(null);
            active = true;
            centergroup.visible = false;
        }

        private function onDeactivate(event:Event):void 
        {
            active = false;
            fpslabel.width = 0;
            cpulabel.width = 0;
        }

        private function onKeyDown(event:KeyboardEvent):void
        {
            switch (event.keyCode)
            {
                case Keyboard.SPACE:
                    onNext(null);
                    break;
                case Keyboard.BACKSPACE:
                    onPrev(null);
                    break;
                case Keyboard.CONTROL:
                    lefttopgroup.visible = !lefttopgroup.visible;
                    break;
                case "F".charCodeAt():
                    break;
                    if (stage.displayState == StageDisplayState.FULL_SCREEN)
                        stage.displayState = StageDisplayState.NORMAL;
                    else
                        stage.displayState = StageDisplayState.FULL_SCREEN;
                    break;
                case "X".charCodeAt():
                    Debug.active = !Debug.active;
                    if (Debug.active)
                        Debug.clear();
                    break;
                case "S".charCodeAt():
                    setScroll(!scroll);
                    break;
                case "Z".charCodeAt():
                    animation = !animation;
                    setScroll(animation);
                    break;
                case Keyboard.NUMPAD_ADD:
                    adjustzoom(3);
                    break;
                case Keyboard.NUMPAD_SUBTRACT:
                    adjustzoom(-3);
                    break;
            }
        }

        private function setScroll(value:Boolean):void
        {
            scroll = value;
            if (!scroll)
            {
                camera.targetpanangle = camera.panangle;
                camera.targettiltangle = camera.tiltangle;
            }
        }

        private function onMouseWheel(event:MouseEvent):void
        {
            adjustzoom(event.delta);
        }

        private function adjustzoom(delta:int):void
        {
            camera.zoom = Math.min(25, Math.max(2, camera.zoom + delta / 3));
        }
    }
}
