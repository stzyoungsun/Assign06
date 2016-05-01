package framework.event
{
	public class Touch
	{
		// 터치의 상태
		private var _phase:String;
		
		// 터치의 현재 위치
		private var _globalX:Number;
		private var _globalY:Number;
		
		// 터치의 이전 위치
		private var _previousGlobalX:Number;
		private var _previousGlobalY:Number;
		
		public function Touch()
		{
			_phase = TouchPhase.HOVER;
		}
		
		public function get phase():String { return _phase; }
		public function set phase(value:String):void { _phase = value; }

		public function get globalX():Number { return _globalX; }
		public function set globalX(value:Number):void
		{
			// phase가 MOVED일 때만 _previousGlobalX와 globalX의 값이 차이나도록 설정
			// MOVED 이외의 상태일 때는 _globalX와 _previousGlobalX의 값이 동일
			previousGlobalX = (phase == TouchPhase.MOVED) ? _globalX : value;
			_globalX = value; 
		}
		
		public function get globalY():Number { return _globalY; }
		public function set globalY(value:Number):void
		{
			// set globalX와 같은 원리
			previousGlobalY = (phase == TouchPhase.MOVED) ? _globalY : value;
			_globalY = value;
		}
		
		public function get previousGlobalX():Number { return _previousGlobalX; }
		public function set previousGlobalX(value:Number):void { _previousGlobalX = value; }
		
		public function get previousGlobalY():Number { return _previousGlobalY; }
		public function set previousGlobalY(value:Number):void { _previousGlobalY = value; }
	}
}