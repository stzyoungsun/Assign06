package framework.display
{
	import flash.display.BitmapData;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.textures.Texture;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	
	import framework.core.Framework;
	

	public class Quad extends DisplayObject
	{
	
		private var _texture:Texture;
		private var _context:Context3D;
		private static const tempMatrix3D:Matrix3D = new Matrix3D();
		private static const Z_AXIS:Vector3D = Vector3D.Z_AXIS;
		private var fragConsts:Vector.<Number> = new <Number>[1, 1, 1, 1];
		private var _bitmapData:BitmapData;
		private var _painter : Painter;
		public function Quad(x:int, y:int, color:uint = 0xffffff)
		{
			this.x = x;
			this.y = y;	
			_painter = Framework.painter;
			_context = _painter.context;
			if(_texture == null)
			{
				_texture = _context.createTexture(64, 64, Context3DTextureFormat.BGRA, false);
				
				_texture.uploadFromBitmapData(_bitmapData);
			}
		}
		
		public override function render():void
		{
			
			tempMatrix3D.identity();
			tempMatrix3D.appendRotation(-rotation, Z_AXIS);
			tempMatrix3D.appendScale(scaleX, scaleY, 1);
			tempMatrix3D.appendTranslation(x, y, 0);
			
			_context.setProgram(_painter.program);
			_context.setTextureAt(0, _texture);
			_context.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, tempMatrix3D, true);
			_context.setProgramConstantsFromVector(Context3DProgramType.VERTEX, 4, fragConsts);
			_context.setVertexBufferAt(0, _painter.vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_3);
			_context.setVertexBufferAt(1, _painter.vertexBuffer, 3, Context3DVertexBufferFormat.FLOAT_2);
			_context.drawTriangles(_painter.indexBuffer);
		}
		
		public function get texture():Texture { return _texture; }
		public function set bitmapData(value:BitmapData):void { _bitmapData = value; }
	}
}