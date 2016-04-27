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
<<<<<<< HEAD
	
	import framework.Rendering.Painter;
	import framework.core.Framework;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
=======
	import flash.geom.Point;
>>>>>>> origin/develop

	public class Quad extends DisplayObject
	{
		private var _context:Context3D;
		private static const tempMatrix3D:Matrix3D = new Matrix3D();
		private static const Z_AXIS:Vector3D = Vector3D.Z_AXIS;
		private var fragConsts:Vector.<Number> = new <Number>[1, 1, 1, 1];
		private var _bitmapData:BitmapData;
<<<<<<< HEAD
		private var _painter : Painter;
		private var mProjectionMatrix:Matrix3D = new Matrix3D();
		
		public var textureWidth:uint;
		public var textureHeight:uint;
		private static const tempRect:Rectangle = new Rectangle();
		private static const tempPoint:Point = new Point();
		private var _texture:Texture;
		
		private var _drawx : Number;
		private var _drawy : Number;
		private var _drawWidth : Number;
		private var _drawHeight : Number;
		
		public function Quad(x:Number = 0, y:Number =0, color:uint = 0xffffff)
=======
		private static const tempRect:Rectangle = new Rectangle();
		private static const tempPoint:Point = new Point();
		
		public function Quad(x:Number, y:Number, color:uint)
>>>>>>> origin/develop
		{
			_painter = Framework.painter;
			_context = _painter.context;
			
			bitmapDataControl(_bitmapData);
			
			this.x = x;
			this.y = y;
<<<<<<< HEAD
=======
			scaleX = 0.1;
			scaleY = 0.1;
			
			_bitmapData = (new TEXTURE()).bitmapData as BitmapData;
>>>>>>> origin/develop
		}
		
		public function  bitmapDataControl(bmd:BitmapData): void
		{
			var width:uint = bmd.width;
			var height:uint = bmd.height;
			
			if(_texture == null)
			{
<<<<<<< HEAD
				if (createTexture(_bitmapData.width, _bitmapData.height))
				{
					// If the new texture doesn't match the BitmapData's dimensions
					if (width != textureWidth || height != textureHeight)
					{
						// Create a BitmapData with the required dimensions
						var powOfTwoBMD:BitmapData = new BitmapData(
							textureWidth,
							textureHeight,
							bmd.transparent
						);
						
						// Copy the given BitmapData to the newly-created BitmapData
						tempRect.width = width;
						tempRect.height = height;
						powOfTwoBMD.copyPixels(bmd, tempRect, tempPoint);
						
						// Upload the newly-created BitmapData instead
						bmd = powOfTwoBMD;
						
						// Scale the UV to the sub-texture
						fragConsts[0] = textureWidth / width;
						fragConsts[1] = textureHeight / height;
					}
					else
					{
						// Reset UV scaling
						fragConsts[0] = 1;
						fragConsts[1] = 1;
					}
				}
			}
			_texture.uploadFromBitmapData(bmd);
		}
		
		protected function createTexture(width:uint, height:uint): Boolean
		{
			width = nextPowerOfTwo(width);
			height = nextPowerOfTwo(height);
			
			if (!_texture || textureWidth != width || textureHeight != height)
			{
				_texture = _context.createTexture(width,height,Context3DTextureFormat.BGRA,false);
				textureWidth = width;
				textureHeight = height;
				this.width = width;
				this.heigth = height;
=======
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
>>>>>>> origin/develop
				
				return true;
			}
			return false;
		}
		
		public function controlBitmap() : void
		{
			_drawx = (this.x-Framework.viewport.width/2+_bitmapData.width)/(Framework.viewport.width/2);
			_drawy = -(this.y-Framework.viewport.height/2+_bitmapData.height)/(Framework.viewport.height/2);
			
			_drawWidth = (this.width)/Framework.viewport.width;
			_drawHeight = (this.heigth)/Framework.viewport.height;
		}
		
		public override function render():void
		{
			controlBitmap();
			
			var  mModelViewMatrix : Matrix3D = new Matrix3D();
			tempMatrix3D.identity();
			tempMatrix3D.appendRotation(-rotation, Z_AXIS);
			tempMatrix3D.appendScale(_drawWidth, _drawHeight, 1);
			tempMatrix3D.appendTranslation(_drawx, _drawy, 0);
			
			_context.setProgram(_painter.program);
			_context.setTextureAt(0, _texture);
			_context.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, tempMatrix3D, true);
			_context.setProgramConstantsFromVector(Context3DProgramType.VERTEX, 4, fragConsts);
			_context.setVertexBufferAt(0, _painter.vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_3);
			_context.setVertexBufferAt(1, _painter.vertexBuffer, 3, Context3DVertexBufferFormat.FLOAT_2);
			_context.drawTriangles(_painter.indexBuffer);
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
		
<<<<<<< HEAD
		public function get texture():Texture { return _texture; }
		public function set bitmapData(value:BitmapData):void { _bitmapData = value; }
=======
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
>>>>>>> origin/develop
	}
}