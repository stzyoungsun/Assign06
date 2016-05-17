package framework.display
{
	import framework.Rendering.Painter;
	import framework.core.Framework;
	import framework.texture.FwTexture;
	
	/**
	 * Quad를 상속받은 클래스로 특정 비트맵을 텍스쳐로 입힌 후 화면에 그려지는 클래스
	 * @author jihwan.ryu youngsun.yoo
	 */
	public class Image extends Quad
	{
		private var _texture:FwTexture;
		
		/**
		 * 생성자 - x, y, bitmapData 인자를 통해 부모의 생성자를 호출 
		 * @param x - x좌표 값
		 * @param y - y좌표 값
		 * @param bitmapData - 텍스쳐로 생성하려는 비트맵 데이터
		 */
		public function Image(x:int, y:int, texture:FwTexture)
		{
			// width와 height는 BitmapData의 크기를 넣어준다
			super(x, y, texture.width, texture.height);
			_texture = texture;
		}
		
		/**
		 * Vertex 버퍼에 업로드할 데이터를 생성하는 메서드
		 */
		protected override function createBufferData():void
		{
			// raw 데이터 설정
			_vertexData = new <Number>
				[
				//	X,		Y,		Z,	U,	V
					0,		0,		0,	0,	0,
					width,	0,		0,	1,	0,
					0,		height,	0,	0,	1,
					width,	height,	0,	1,	1,
				]
			
			// 버텍스 당 데이터 갯수
			_numDataPerVertex = 5;
		}
		
		/**
		 * 렌더링 버퍼에 Vertex, Index 버퍼 데이터를 입력하여 화면에 출력하도록 하는 메서드. 쉐이더 프로그램에서 사용될 변수와 상수 데이터를 적용한다.
		 */
		public override function render():void
		{
			var painter:Painter = Framework.painter;
			painter.batch(this, _texture);
		}
		
		public override function dispose():void
		{
			super.dispose();
			
			_texture = null;
		}
		
		public function get texture():FwTexture { return _texture; }
		public function set texture(value:FwTexture):void
		{
			_texture = value;
		}
	}
}