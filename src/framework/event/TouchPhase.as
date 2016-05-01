package framework.event
{
    public final class TouchPhase
    {
        public function TouchPhase() { throw new Error("Abstract Class"); }
		
		// PC에서 마우스의 HOVER 상태
        public static const HOVER:String = "hover";
		// 터치가 시작되었을 때의 상태
        public static const BEGAN:String = "began";
		// 터치하면서 이동할 때의 상태
        public static const MOVED:String = "moved";
		// 터치가 종료될 때의 상태
        public static const ENDED:String = "ended";
    }
}