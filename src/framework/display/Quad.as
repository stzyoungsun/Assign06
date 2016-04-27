package framework.display
{
	import flash.display.BitmapData;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.textures.Texture;
	import flash.geom.Matrix3D;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	import flash.geom.Point;

	public class Quad extends DisplayObject
	{
		[Embed(source="ani_play_button.png")]
		private static const TEXTURE:Class;
		
		private var _texture:Texture;
		private var _context:Context3D;
		private static const tempMatrix3D:Matrix3D = new Matrix3D();
		private static const Z_AXIS:Vector3D = Vector3D.Z_AXIS;
		private var fragConsts:Vector.<Number> = new <Number>[1, 1, 1, 1];
		private var _bitmapData:BitmapData;
		private static const tempRect:Rectangle = new Rectangle();
		private static const tempPoint:Point = new Point();
		
		public function Quad(x:Number, y:Number, color:uint)
		{
			this.x = x;
			this.y = y;
			scaleX = 0.1;
			scaleY = 0.1;
			
			_bitmapData = (new TEXTURE()).bitmapData as BitmapData;
		}
		
		public override function render(painter:Painter):void
		{
			_context = painter.context;
			
			if(_texture == null)
			{
				var textureWidth:int = nextPowerOfTwo(_bitmapData.width);
				var textureHeight:int = nextPowerOfTwo(_bitmapData.height);
				
				_texture = _context.createTexture(textureWidth, textureHeight, Context3DTextureFormat.BGRA, false);
				
				var powOfTwoBMD:BitmapData = new BitmapData(textureWidth, textureHeight, _bitmapData.transparent);
				
				tempRect.width = _bitmapData.width;
				tempRect.height = _bitmapData.height;
				
				powOfTwoBMD.copyPixels(_bitmapData, tempRect, tempPoint);
				
				_bitmapData = powOfTwoBMD;
				
				fragConsts[0] = textureWidth / _bitmapData.width;
				fragConsts[1] = textureHeight / _bitmapData.height;
				
				_texture.uploadFromBitmapData(_bitmapData);
			}
			
			tempMatrix3D.identity();
			tempMatrix3D.appendRotation(-rotation, Z_AXIS);
			tempMatrix3D.appendScale(scaleX, scaleY, 1);
			tempMatrix3D.appendTranslation(x, y, 0);
			
			_context.setProgram(painter.program);
			_context.setTextureAt(0, _texture);
			_context.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, tempMatrix3D, true);
			_context.setProgramConstantsFromVector(Context3DProgramType.VERTEX, 4, fragConsts);
			_context.setVertexBufferAt(0, painter.vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_3);
			_context.setVertexBufferAt(1, painter.vertexBuffer, 3, Context3DVertexBufferFormat.FLOAT_2);
			_context.drawTriangles(painter.indexBuffer);
		}
		
		public static function nextPowerOfTwo(v:uint): uint
		{
			v--;
			v |= v >> 1;
			v |= v >> 2;
			v |= v >> 4;
			v |= v >> 8;
			v |= v >> 16;
			v++;
			return v;
		}
	}
}