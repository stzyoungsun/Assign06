package framework.display
{
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.VertexBuffer3D;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import framework.Rendering.Painter;
	import framework.core.Framework;

	/**
	 * DisplayObject를 상속받은 클래스로 화면에 사각형을 그려주는 클래스 
	 * @author jihwan.ryu youngsun.yoo
	 */
	public class Quad extends DisplayObject
	{
		protected var _vertexBuffer:VertexBuffer3D;
		protected var _indexBuffer:IndexBuffer3D;
		protected var _vertexData:Vector.<Number>;
		protected var _numDataPerVertex:Number;
		private var _color:uint;
		
		/**
		 * 생성자 - x, y, width, height를 설정 후 Buffer 데이터를 생성하는 메서드 호출
		 * @param x - x좌표 값
		 * @param y - y좌표 값
		 * @param width - 너비
		 * @param height - 높이
		 * @param color - Quad에 입힐 색상
		 */
		public function Quad(x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0, color:uint = 0xffffff)
		{
			_color = color;
			
			this.x = x;
			this.y = y;
			
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
			
			this.width = width;
			this.height = height;
		}
		
		/**
		 * Vertex 버퍼에 업로드할 데이터를 생성하는 메서드
		 */
		protected function createBufferData():void
		{
			// Color 설정
			var red:uint 	= (_color >> 16) & 0xff / 255.0;
			var green:uint 	= (_color >> 8) 	& 0xff / 255.0;
			var blue:uint 	= (_color) 		& 0xff / 255.0;
			var alpha:uint 	= 1.0;
			
			// raw 데이터 설정
			_vertexData = new <Number>
			[
			//  X,	Y,	Z,	R,	 G,		B		A
				0,	0,	0,	red, green,	blue,	alpha,
				0,	0,	0,	red, green,	blue,	alpha,
				0,	0,	0,	red, green,	blue,	alpha,
				0,	0,	0,	red, green,	blue,	alpha
			];
			
			// 버텍스 당 데이터 갯수
			_numDataPerVertex = 7;
			
			// 버퍼 데이터 설정
			_vertexBuffer = Framework.painter.context.createVertexBuffer(4, _numDataPerVertex);
			_indexBuffer = Framework.painter.context.createIndexBuffer(6);
		}
		
		/**
		 * 렌더링 버퍼에 Vertex, Index 버퍼 데이터를 입력하여 화면에 출력하도록 하는 메서드. 쉐이더 프로그램에서 사용될 변수와 상수 데이터를 적용한다.
		 */
		public override function render():void
		{
			var painter:Painter = Framework.painter;
			var context:Context3D = painter.context;
			
			// Vertex, Index 버퍼에 데이터 업로드
			_vertexBuffer.uploadFromVector(_vertexData, 0, 4);
			_indexBuffer.uploadFromVector(Vector.<uint>([0, 1, 2, 1, 3, 2]), 0, 6);
			
			painter.setDefaultBlendFactors(true);
			
			// 쉐이더 프로그램 설정
			context.setProgram(painter.quadProgram);
			// Vertex 프로그램에서 사용될 변수를 위해 버퍼 등록
			context.setVertexBufferAt(0, _vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_3);	// va0
			context.setVertexBufferAt(1, _vertexBuffer, 3, Context3DVertexBufferFormat.FLOAT_4);	// va1
			// Vertex, Fragment 프로그램에서 사용될 상수 설정
			context.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, painter.mvpMatrix3D, true);	// vc0
			context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, new <Number>[1.0, 1.0, 1.0, 1.0], 1);	// fc0

			// Index Buffer의 설정에 따라서 삼각형을 그리기
			context.drawTriangles(_indexBuffer, 0, 2);
			
			// 버퍼 비우기
			context.setVertexBufferAt(0, null);
			context.setVertexBufferAt(1, null);
		}
		
		public function get vertexData():Vector.<Number> { return _vertexData; }
		
		public override function get bounds():Rectangle
		{
			var rectangle:Rectangle = new Rectangle();
			rectangle.setTo(x - pivotX * scaleX, y - pivotY * scaleY, _vertexData[_numDataPerVertex * 3] * scaleX, _vertexData[_numDataPerVertex * 3 + 1] * scaleY);
			
			if(scaleX < 0) { rectangle.width *= -1; rectangle.x -= rectangle.width; }
			if(scaleY < 0) { rectangle.height *= -1; rectangle.y -= rectangle.height; }
			
			return rectangle;
		}
	}
}