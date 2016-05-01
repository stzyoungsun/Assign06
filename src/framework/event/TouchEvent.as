package framework.event
{
	import flash.events.TouchEvent;

	/**
	 * flash.events.TouchEvent를 상속받은 클래스. 터치 정보를 가진 Touch 객체를 인자로 가진다.
	 */
	public class TouchEvent extends flash.events.TouchEvent
	{
		private var _touch:Touch;
		
		public static const TOUCH:String = "touch";
		
		public function TouchEvent(touch:Touch, type:String, bubbles:Boolean = false)
		{
			super(type, bubbles);
			_touch = touch;
		}
		
		public function get touch():Touch { return _touch; }
	}
}