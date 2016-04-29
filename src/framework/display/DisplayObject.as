package framework.display
{
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class DisplayObject extends EventDispatcher
	{
		private var _x:Number;
		private var _y:Number;
		private var _rotation:Number;
		private var _parent:DisplayObjectContainer;
		private var _width : Number;
		private var _height : Number;
		private var _visible:Boolean;
		
		private var _curFrame : Number = 0;
		private var _prevTime : Number = 0;
		
		private var _curbulletCount : Number = 0;
		
		protected var _objectType : String = ObjectType.NONE;
		
		public function DisplayObject()
		{
			_x = _y = _rotation = 0.0;
			_visible = true;
		}
		
		public virtual function render():void
		{
			// Abstract Method
		}
		
		public virtual function nextFrame() : void
		{
			// Abstract Method
		}
		

		public virtual function shooting() : void
		{
			// Abstract Method
		}
		
		public virtual function bulletFrame() : void
		{
			// Abstract Method
		}
		
		public virtual function AutoMoving() : void
		{
			
		}
		public function dispatchTouchEvent(type:String):void
		{
			dispatchEvent(new MouseEvent(type));
		}
		
		public function hitTest(localPoint:Point):DisplayObject
		{
			if (!_visible)
			{
				return null;
			}
			
			if (bounds.containsPoint(localPoint))
			{
				return this;
			}
			
			return null;
		}
		
		public function dispose():void
		{
			//해제가 필요한 부분 입력
			
		}
		
		public function get height():Number{ return _height; }
		public function set height(value:Number):void{ _height = value; }
		
		public function get width():Number{ return _width; }
		public function set width(value:Number):void{ _width = value; }
		
		public function get x():Number { return _x; }
		public function set x(x:Number):void { _x = x; }
		
		public function get y():Number { return _y; }
		public function set y(y:Number):void { _y = y; }
		
		public function get rotation():Number { return _rotation; }
		public function set rotation(rotation:Number):void { _rotation = rotation; }
		
		public function get visible():Boolean { return _visible; }
		public function set visible(visible:Boolean):void { _visible = visible; }
		
		public function get curFrame():Number{return _curFrame;}
		public function set curFrame(value:Number):void{_curFrame = value;}
		
		public function get curbulletCount():Number{return _curbulletCount;}
		public function set curbulletCount(value:Number):void {_curbulletCount = value;}
		
		public function get prevTime():Number{return _prevTime;}
		public function set prevTime(value:Number):void{_prevTime = value;}
		
		public function get bounds():Rectangle { return null; }
		
		public function get objectType() : String {return _objectType;};
	}
}