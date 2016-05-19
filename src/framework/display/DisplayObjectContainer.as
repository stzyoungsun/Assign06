package framework.display
{
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import framework.Rendering.Painter;
	import framework.core.Framework;
	import framework.gameobject.Collision;
	
	public class DisplayObjectContainer extends DisplayObject
	{
		private var _children:Vector.<DisplayObject>;
		
		private static var _sMatrix:Matrix = new Matrix();
		private static var _sPoint:Point = new Point();
		
		/**
		 * 생성자
		 */
		public function DisplayObjectContainer()
		{
			super();
			
			_children = new <DisplayObject>[];
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
				child.setParent(this);
				return child;
			}
			// 범위를 벗어나면 Error throw
			else
			{
				throw new Error("Invalid child index");
			}
		}
		
		/**
		 * _children Vector 객체에서 특정 DisplayObject를 제거하는 메서드. 실제 제거 작업은 removeChildAt 메서드에서 이뤄짐
		 * @param child - 지우려고하는 DisplayObject 객체
		 * @param dispose - Child에 할당된 자원을 해제할 것인지 여부를 결정하는 변수
		 */
		public function removeChild(child:DisplayObject, dispose:Boolean=false):void
		{
			// get index
			var childIndex:int = getChildIndex(child);
			// 자식을 찾지 못한 경우 throw Error
			if(childIndex == -1)	throw new Error("Can not find object in Vector");
			// removeChildAt 호출
			else	removeChildAt(childIndex, dispose);
			
		}
		
		/**
		 * _children Vector 객체에서 index에 위치하는 DisplayObject 객체를 제거하는 메서드
		 * @param index - 지우려는 DisplayObject 대상이 위치한 index
		 * @param dispose - Child에 할당된 자원을 해제할 것인지 여부를 결정하는 변수
		 */
		public function removeChildAt(index:int, dispose:Boolean = false):void
		{
			if (index >= 0 && index < _children.length)
			{
				var child:DisplayObject = _children[index];
				// Vector에서 제거
				_children.splice(index, 1);
				// 자원 해제
				if (dispose) child.dispose();
			}
			else
			{
				throw new RangeError("Invalid child index");
			}
		}
		
		public function removeChildren(start:Number = 0, end:Number = -1, dispose:Boolean = false):void
		{
			var numChildren:int = _children.length;
			
			if(end < 0) end = numChildren;
			
			// loop 문을 이용해 Vector를 순회하면서 dispose 메서드를 호출
			for(var i:int = end - 1; i >= start; i--)
			{
				removeChildAt(i, dispose);
			}
		}
		
		/**
		 * child의 index를 반환하는 메서드 
		 * @param child - index를 얻으려하는 DisplayObject
		 * @return child의 index 값. 찾지 못하면 -1 반환
		 */
		public function getChildIndex(child:DisplayObject):int
		{
			return _children.indexOf(child);
		}
		
		/**
		 * _children Vector에 존재하는 DisplayObject들의 render 메서드를 호출. 매 프레임마다 호출됨
		 */
		public override function render():void
		{
			var painter:Painter = Framework.painter;
			//Scene이 체인지된 경우 더 이상 렌더링하지 않고 return
			if(_children == null) return;
			// loop 문을 이용해 Vector를 순회하면서 render 메서드를 호출
			for(var i:int = 0 ; i <_children.length; ++i)
			{
				var child:DisplayObject = _children[i];
				
				if(child.visible)
				{
					// 충돌 검사
					objectCollision(i);
					
					// 현재 Modelview matrix를 push
					painter.pushMatrix();
					// 자식 객체의 변환 행렬 연산
					painter.transformMatrix(child);
					// 자식의 render 호출
					child.render();
					// push했던 Modelview matrix를 pop
					painter.popMatrix();
					if(_children == null) return;
				}
			}
		}
		
		public function objectCollision(curChildNum : Number):void
		{
			switch(_children[curChildNum].objectType)
			{
				case ObjectType.ENEMY_GENERAL:
				{
					for(var i:int = 0 ; i <_children.length; ++i)
					{
						var child:DisplayObject = _children[i];
						
						switch(child.objectType)
						{
							case ObjectType.PLAYER_BULLET_MOVING:
							{
								if(Collision.ObjectToObject(child,_children[curChildNum]))
								{
									child.objectType = ObjectType.PLAYER_BULLET_COLLISION;
									_children[curChildNum].objectType = ObjectType.ENEMY_COLLISION
								}
								break;
							}
								
							case ObjectType.PLAYER_GENERAL:
							{
								if(Collision.ObjectToObject(child,_children[curChildNum]))
								{
									child.objectType = ObjectType.PLAYER_COLLISION;
									_children[curChildNum].objectType = ObjectType.ITEM_IDLE;
								}
								break;
							}
						}
					}
					break;
				}
					
				case ObjectType.PLAYER_GENERAL:
				{
					for(i = 0 ; i <_children.length; ++i)
					{
						child = _children[i];
						switch(child.objectType)
						{
							case ObjectType.ENEMY_BULLET_MOVING:
							{
								if(Collision.ObjectToObject(child,_children[curChildNum]))
								{
									child.objectType = ObjectType.ENEMY_BULLET_COLLISION;
									_children[curChildNum].objectType = ObjectType.PLAYER_COLLISION;
								}
								break;
							}
								
							case ObjectType.ITEM_COIN:
							{
								if(Collision.ObjectToObject(child,_children[curChildNum]))
								{
									child.objectType = ObjectType.ITEM_COIN_COLLISON;
								}
								break;
							}
								
							case ObjectType.ITEM_HEART:
							{
								if(Collision.ObjectToObject(child,_children[curChildNum]))
								{
									child.objectType = ObjectType.ITEM_HERAT_COLLISON;
								}
								break;
							}
								
							case ObjectType.ITEM_POWER:
							{
								if(Collision.ObjectToObject(child,_children[curChildNum]))
								{
									child.objectType = ObjectType.ITEM_POWER_COLLISON;
								}
								break;
							}
							
						   case ObjectType.OBSTACLE_MOVING:
						   {
							   if(Collision.ObjectToObject(child,_children[curChildNum]))
							   {
								   child.objectType = ObjectType.OBSTACLE_COLLISON;
								   _children[curChildNum].objectType = ObjectType.PLAYER_COLLISION;
							   }
							   break;
						   }
						}
					}
					break;
				}
					
				case ObjectType.BOSS_GENERAL:
				{
					if(this.visible == true)
					{
						for(i = 0 ; i <_children.length; ++i)
						{
							child = _children[i];
							switch(child.objectType)
							{
								case  ObjectType.PLAYER_BULLET_MOVING:
								{
									if(child.objectType == ObjectType.PLAYER_BULLET_MOVING)
									{
										if(Collision.ObjectToObject(child,_children[curChildNum]))
										{
											child.objectType = ObjectType.PLAYER_BULLET_COLLISION;
											_children[curChildNum].objectType = ObjectType.BOSS_COLLISION;
										}
									}
									break;
								}
							}
						
						}
					}
					break;
				}
			}
		}
		
		/**
		 * DisplayObjectContainer의 범위 정보를 가진 Rectangle 객체를 반환하는 메서드
		 * @return 해당 객체의 범위 정보를 가진 Rectangle 객체
		 */
		public override function get bounds():Rectangle
		{
			var numChildren:int = _children.length;
			
			// 자식이 없으면 기본 Rectangle 객체를 생성해서 반환
			if(numChildren == 0)
			{
				return new Rectangle();
			}
			// 자식이 하나면 그 자식의 bounds를 반환
			else if (numChildren == 1)
			{
				return _children[0].bounds;
			}
			// 자식이 여러개라면 최소 X, 최소 Y, 최대 X, 최대 Y 값을 각각 구해서 새로운 Rectangle 객체 생성 후 반환
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
		
		/**
		 * localPoint에 존재하는 자식 객체를 반환하는 메서드 
		 * @param localPoint - 특정 위치 정보를 담은 Point 객체
		 * @return 해당 위치에 자식이 존재하면 자식을 반환, 존재하지 않으면 null 반환
		 */
		public override function hitTest(localPoint:Point):DisplayObject
		{
			if (!visible || _children == null) return null;
			var target:DisplayObject = null;
			// localPoint의 좌표값
			var localX:Number = localPoint.x;
			var localY:Number = localPoint.y;
			var numChildren:int = _children.length;
			
			for(var i:int = numChildren - 1; i >= 0; i--)
			{
				var child:DisplayObject = _children[i];
				
				_sMatrix.copyFrom(child.transformationMatrix);
				_sMatrix.invert();
				
				_sPoint.x = _sMatrix.a * localX + _sMatrix.c * localY + _sMatrix.tx;
				_sPoint.y = _sMatrix.d * localY + _sMatrix.b * localX + _sMatrix.ty;
				
				// child의 hitTest 메서드 호출 후 결과가 null이 아니면 반환
				target = child.hitTest(_sPoint);
				if (target) return target;
			}
			
			if(bounds.contains(localX, localY))
			{
				return this;
			}
			
			return null;
		}
		
		/**
		 * 자신의 자원을 해제하고 자신에게 등록된 자식들의 자원도 해제하는 메서드 
		 */
		public override function dispose():void
		{
			// 자기 자신의 자원 해제
			super.dispose();
			if(_children == null) return;
			
			removeChildren(0, _children.length, true);
			
			_children = null;
		}
		
		public function get children():Vector.<DisplayObject> { return _children; }
		public function set children(value:Vector.<DisplayObject>):void { _children = value; }
		
		public override function get width():Number { return bounds.width; }
		public override function get height():Number { return bounds.height; }
	}
}