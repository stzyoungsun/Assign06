package framework.event
{
    public final class TouchPhase
    {
        public function TouchPhase() { throw new Error("Abstract Class"); }
		
        public static const HOVER:String = "hover";
        public static const BEGAN:String = "began";
        public static const MOVED:String = "moved";
        public static const ENDED:String = "ended";
    }
}