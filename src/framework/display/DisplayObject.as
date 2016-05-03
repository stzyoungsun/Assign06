package framework.display
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import framework.util.Align;

	public class DisplayObject extends EventDispatcher
	{
		private var _x:Number;
		private var _y:Number;
		private var _width:Number;
		private var _height:Number;
		private var _scaleX:Number;
		private var _scaleY:Number;
		private var _pivotX:Number;
		private var _pivotY:Number;
		private var _rotation:Number;
		private var _visible:Boolean;
		private var _parent:DisplayObjectContainer;
		
		protected var _objectType : String = ObjectType.NONE;
		
		public function DisplayObject()
		{
			_x = _y = _rotation = _pivotX = _pivotY = 0.0;
			_scaleX = _scaleY = 1.0;
			_visible = true;
		}

	

		public virtual function render():void
		{
			// Abstract Method
		}
		
		public function hitTest(localPoint:Point):DisplayObject
		{
			if (!_visible)
			{
				return null;
			}
			
			var bounds:Rectangle = new Rectangle(x - pivotX, y - pivotY, width, height);
			
			if (bounds.containsPoint(localPoint))
			{
				return this;
			}
			
			return null;
		}
		
		public override function dispatchEvent(event:Event):Boolean
		{
			// 부모가 존재하고 bubbles 속성이 true면 부모의 dispatchEvent 호출
			if(_parent != null && event.bubbles)
			{
				_parent.dispatchEvent(event);
			}
			// super 호출 후 결과 반환
			return super.dispatchEvent(event);
		}
		
		public function alignPivot(horizontalAlign:String="center", verticalAlign:String="center"):void
		{
			// pivotX 설정 - 수평 정렬
			switch(horizontalAlign)
			{
				case Align.LEFT:
					_pivotX = 0;
					break;
				case Align.RIGHT:
					_pivotX = width;
					break;
				case Align.CENTER:
					_pivotX = width / 2.0;
					break;
				default:
					// 잘못된 값이 입력되면 에러 throw
					throw new ArgumentError("Invalid horizontal value. Use Align.LEFT, Align.RIGHT, Align.CENTER");
			}
			
			// pivotY 설정 - 수직 정렬
			switch(verticalAlign)
			{
				case Align.TOP:
					_pivotY = 0;
					break;
				case Align.BOTTOM:
					_pivotY = height;
					break;
				case Align.CENTER:
					_pivotY = height / 2.0;
					break;
				default:
					// 잘못된 값이 입력되면 에러 throw
					throw new ArgumentError("Invalid vertical value. Use Align.TOP, Align.BOTTOM, Align.CENTER");
			}
		}
		
		public function dispose():void
		{
			//해제가 필요한 부분 입력
		}
		
		internal function setParent(parent:DisplayObjectContainer):void
		{
			_parent = parent;
		}
		
		public function get x():Number { return _x; }
		public function set x(value:Number):void { _x = value; }
		
		public function get y():Number { return _y; }
		public function set y(value:Number):void { _y = value; }
		
		public function get scaleX():Number { return _scaleX; }
		public function set scaleX(value:Number):void { _scaleX = value; }
		
		public function get scaleY():Number { return _scaleY; }
		public function set scaleY(value:Number):void { _scaleY = value; }
		
		public function get pivotX():Number { return _pivotX; }
		public function set pivotX(value:Number):void { _pivotX = value; }
		
		public function get pivotY():Number { return _pivotY; }
		public function set pivotY(value:Number):void { _pivotY = value; }
		
		public function get rotation():Number { return _rotation; }
		public function set rotation(value:Number):void
		{
			while (value < -Math.PI) value += Math.PI * 2.0;
			while (value >  Math.PI) value -= Math.PI * 2.0;
			_rotation = value;
		}
		
		public function get width():Number { return _width; }
		public function set width(value:Number):void { _width = value; }
		
		public function get height():Number { return _height; }
		public function set height(value:Number):void { _height = value; }
		
		public function get visible():Boolean { return _visible; }
		public function set visible(value:Boolean):void { _visible = value; }
		
		public function get bounds():Rectangle { return null; }
		
		public function get objectType():String { return _objectType; }
		public function set objectType(value:String):void{_objectType = value;}
		
		public function get parent():DisplayObjectContainer { return _parent; }
	}
}