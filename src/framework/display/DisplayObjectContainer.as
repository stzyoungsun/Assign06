package framework.display
{
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
		
		/**
		 * 자신에게 등록된 Object들을 rendering하는 메서드
		 */
		public override function render():void
		{
			var numChildren:int = _children.length;
			
			// loop 문을 이용해 Vector를 순회하면서 render 메서드를 호출
			for(var i:int = 0; i < numChildren; i++)
			{
				var child:DisplayObject = _children[i];
				child.render();
			}
		}
	}
}