package framework.display
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	
	import framework.gameobject.Collision;
	
	public class DisplayObjectContainer extends DisplayObject
	{
		private var _children:Vector.<DisplayObject>;
		
		/**
		 * 생성자
		 */
		public function DisplayObjectContainer()
		{
			_children = new <DisplayObject>[];
		}
		
		public function get children():Vector.<DisplayObject>
		{
			return _children;
		}

		public function set children(value:Vector.<DisplayObject>):void
		{
			_children = value;
		}

		/**
		 * child를 자식으로 등록하는 메서드.
		 * @param child - 자식으로 추가하려는 DisplayObject 객체
		 * @return 추가된 Object (child)
		 */
		public function addChild(child:DisplayObject):DisplayObject
		{
			return addChildAt(child, _children.length);
		}
		
		/**
		 * child를 자식으로 등록하고, 특정 인덱스에 위치 시키는 메서드
		 * @param child - 자식으로 추가하려는 DisplayObject 객체
		 * @param index - 위치시키려는 인덱스
		 * @return 추가된 Object (child)
		 */
		public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			var numChildren:int = _children.length;
			
			// index가 _children의 범위에 포함될 때 해당 index로 입력
			if (index >= 0 && index <= numChildren)
			{
				_children.insertAt(index, child);				
				return child;
			}
			// 범위를 벗어나면 Error throw
			else
			{
				throw new Error("Invalid child index");
			}
		}
		
		public function removeChild(child:DisplayObject, dispose:Boolean=false):void
		{
			var childIndex:int = getChildIndex(child);
			if (childIndex != -1) removeChildAt(childIndex, dispose);
		}
		
		public function removeChildAt(index:int, dispose:Boolean=false):void
		{
			if (index >= 0 && index < _children.length)
			{
				var child:DisplayObject = _children[index];
				_children.splice(index, 1);
				if (dispose) child.dispose();
			}
			else
			{
				throw new RangeError("Invalid child index");
			}
		}
		
		public function getChildIndex(child:DisplayObject):int
		{
			return _children.indexOf(child);
		}
		
		/**
		 * 자신에게 등록된 Object들을 rendering하는 메서드
		 */
		public override function render():void
		{
			// loop 문을 이용해 Vector를 순회하면서 render 메서드를 호출
			for(var i:int = 0 ; i <_children.length; ++i)
			{
				var child:DisplayObject = _children[i];
				
				if(child.objectType == ObjectType.PLAYER_BULLET)
					bulletCollision(i);
				
				child.render();
			}
		}
		
		public function bulletCollision(curChildNum : Number):void
		{
			for(var i:int = 0 ; i <_children.length; ++i)
			{
				var child:DisplayObject = _children[i];
				
				if(child.objectType == ObjectType.ENEMY)
				{
					if(Collision.bulletToObject(_children[curChildNum],child))
						trace("충돌");  //충돌 시 이벤트 처리
				}	
			}
		}
		
		public  function recursiveSearch() : DisplayObject
		{
			var numChildren:int = _children.length;
			
			// loop 문을 이용해 Vector를 순회하면서 render 메서드를 호출
			for(var i:int = 0 ; i <numChildren; ++i)
			{
				var child:DisplayObject = _children[i];
				
				if(child.objectType == ObjectType.PLAYER)
					return child;
			}
			return null;
		}
		public override function get bounds():Rectangle
		{
			var numChildren:int = _children.length;
			
			if (numChildren == 1)
			{
				return _children[0].getBounds();
			}
			else
			{
				var minX:Number = Number.MAX_VALUE, maxX:Number = -Number.MAX_VALUE;
				var minY:Number = Number.MAX_VALUE, maxY:Number = -Number.MAX_VALUE;
				for each (var child:DisplayObject in _children)
				{
					var childBounds:Rectangle = child.bounds;
					minX = Math.min(minX, childBounds.x);
					maxX = Math.max(maxX, childBounds.x + childBounds.width);
					minY = Math.min(minY, childBounds.y);
					maxY = Math.max(maxY, childBounds.y + childBounds.height);                    
				}
				return new Rectangle(minX, minY, maxX-minX, maxY-minY);
			}
		}
		
		public override function hitTest(localPoint:Point):DisplayObject
		{
			if (!visible) return null;
			
			var target:DisplayObject = null;
			var localX:Number = localPoint.x;
			var localY:Number = localPoint.y;
			var numChildren:int = _children.length;
			
			for(var i:int = 0 ; i <numChildren; ++i)
			{
				var child:DisplayObject = _children[i];
				target = child.hitTest(localPoint);
				
				if (target)
				{
					return target;
				}
			}
			return null;
		}
		
		public override function dispose():void
		{
			var numChildren:int = _children.length;
			
			// loop 문을 이용해 Vector를 순회하면서 render 메서드를 호출
			for(var i:int = 0 ; i <numChildren; ++i)
			{
				var child:DisplayObject = _children[i];
				child.dispose();
			}
			_children = null;
			super.dispose();
		}
	}
}