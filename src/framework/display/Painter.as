package framework.display
{
	import flash.display3D.Context3D;

	public class Painter
	{
		private var _context:Context3D;
		
		public function Painter(context:Context3D)
		{
			_context = context;
		}
		
		public function get context():Context3D { return _context; }
	}
}