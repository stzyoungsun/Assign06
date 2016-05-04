package framework.display
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import avmplus.getQualifiedClassName;
	
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
		private var _eventDictionary:Dictionary;
		
		protected var _prevTime:Number;
		protected var _objectType : String = ObjectType.NONE;
		
		/**
		 * 생성자 - 객체를 생성자를 통해 직접 만들 수는 없고 상속해서 사용 가능
		 */
		public function DisplayObject()
		{
			if (getQualifiedClassName(this) == "framework.display::DisplayObject")
				throw new Error("This class is Abstract. Use this class extends to your custom class.");
				
			_x = _y = _rotation = _pivotX = _pivotY = 0.0;
			_scaleX = _scaleY = 1.0;
			_visible = true;
			_eventDictionary = new Dictionary();
		}

		/**
		 * Vertex 데이터와 Index 데이터를 각각의 버퍼에 올려서 화면에 출력하도록 하는 메서드<br/>
		 * 이 메서드는 가상(추상) 메서드이며 DisplayObject를 상속받은 클래스에서 오버라이딩해서 사용해야한다
		 */
		public virtual function render():void
		{
			// Abstract Method
		}
		
		/**
		 * localPoint가 해당 객체의 범위안에 들어있는지 검사하는 메서드
		 * @param localPoint - 검사하려는 위치가 담긴 Point 객체
		 * @return 포함되어 있으면 객체 자신을 반환, 없으면 null 반환
		 */
		public function hitTest(localPoint:Point):DisplayObject
		{
			if (!_visible)
			{
				return null;
			}
			
			var bounds:Rectangle = new Rectangle(x - pivotX, y - pivotY, width, height);
			
			// 포함되어있는지 검사
			if (bounds.containsPoint(localPoint))
			{
				return this;
			}
			
			return null;
		}
		
		/**
		 * 이벤트를 발생시키는 메서드 
		 * @param event - 발생시키려는 Event 객체
		 * @return flash.events.Event.dispatchEvent 메서드 호출
		 */
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
		
		/**
		 * flash.events.Eventdispatcher 클래스의 addEventListener를 오버라이딩한 메서드
		 * 이벤트를 등록 후 해당 객체에 등록되는 리스너를 Dictionary 객체에 입력한다
		 */
		public override function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			// super 호출해서 이벤트 등록
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
			
			// _eventDictionary에 처음 입력되는 type의 경우 listener를 바로 추가
			if(_eventDictionary[type] == null)
			{
				_eventDictionary[type] = listener;
			}
			// 이전에 추가된 type이 존재할 경우 - Vector 객체로 관리
			else
			{
				// type에 해당하는 value가 Vector인 경우
				if(_eventDictionary[type] is Vector.<Function>)
				{
					// Vector에 listener 푸시
					_eventDictionary[type].push(listener);
				}
				// 그렇지 않은 경우 Vector 객체 생성
				else
				{
					var vector:Vector.<Function> = new Vector.<Function>();
					// dictionary에 입력된 listener push
					vector.push(_eventDictionary[type]);
					// 새로 입력되는 listener push
					vector.push(listener);
					// vector를 value로 설정
					_eventDictionary[type] = vector;
				}
			}
		}
		
		/**
		 * 해당 객체에 생성된 자원을 제거하는 메서드
		 */
		public function dispose():void
		{
			_prevTime = 0;
			// Dictionary에 존재하는 모든 리스너를 제거
			for(var event:String in _eventDictionary)
			{
				// Dictionary의 value가 Vector일 경우 Vector에 존재하는 모든 요소를 제거
				if(_eventDictionary[event] is Vector.<Function>)
				{
					var vector:Vector.<Function> = _eventDictionary[event];
					while(vector.length != 0)
					{
						removeEventListener(event, vector.pop());
					}
				}
				// Vector가 아닌 Function 형일 경우 바로 제거
				else
				{
					removeEventListener(event, _eventDictionary[event]);
				}
			}
			// Dictionary 객체에 null 입력
			_eventDictionary = null;
		}
		
		/**
		 * flash.events.Eventdispatcher 클래스의 removeEventListener 오버라이딩한 메서드
		 * 이벤트 제거 후 삭제될 리스너를 Dictionary 객체에서 제거한다
		 */
		public override function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			// super 호출로 이벤트 제거
			super.removeEventListener(type, listener, useCapture);
			
			// Dictionary에 입력된 value가 Vector일 경우 listener에 해당하는 값을 찾아 제거
			if(_eventDictionary[type] is Vector.<Function>)
			{
				var vector:Vector.<Function> = _eventDictionary[type];
				for(var i:int = 0; i < vector.length; i++)
				{
					if(listener == vector[i])
					{
						// 해당하는 값을 Vector에서 제거
						vector.removeAt(i);
						break;
					}
				}
				
				// Vector에 요소가 남아있지 않으면 Dictionary에서 제거
				if(vector.length == 0)
				{
					delete _eventDictionary[type];
				}
			}
			// Vector가 아닌 Function 형일 경우 바로 제거
			else
			{
				delete _eventDictionary[type];
			}
		}
		
		/**
		 * DisplayObject의 Pivot을 설정해주는 메서드. Framework.util.Align 클래스를 이용해 설정 가능
		 * @param horizontalAlign - 수평 정렬 (Align.LEFT, Align.RIGHT, Align.CENTER)
		 * @param verticalAlign - 수직 정렬 (Align.TOP, Align.BOTTOM, Align.CENTER)
		 */
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
		
		/**
		 * DisplayObject의 부모를 정하는 메서드. DisplayObjectContainer에서 addChild 이후 사용 
		 * @param parent - 부모로 설정하려는 DisplayObjectContainer 객체
		 */
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