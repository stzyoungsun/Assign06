package framework.background
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	
	import framework.core.Framework;
	import framework.display.Image;
	import framework.texture.FwTexture;

	public class BackGround extends Image
	{
		private var _backGroudTexture:FwTexture;
		private var _sliceNum:Number;
		private var _frame:Number;
		private var _step:Number;
		private var _drawPoint:Number;
		private var _prevTime:Number;
		
		public function BackGround(sliceNum:Number, frame:Number,step:Number, backGroudTexture:FwTexture)
		{
			super(0, 0, backGroudTexture);
			
			_backGroudTexture = backGroudTexture;
			_sliceNum = sliceNum;
			_frame = frame;
			_step = step;
			_drawPoint = 0;
			_prevTime = 0;
			
			createBackGround();
		}
		
		private function createBackGround():void
		{
//			tempbitmapdata.copyPixels(_backGroundBitmapData, tempRegion, new Point(0,0));
			var tempbitmapdata : BitmapData = new BitmapData(_backGroudTexture.width, _backGroudTexture.height/_sliceNum);
			var tempRegion : Rectangle = new Rectangle(0,_backGroudTexture.height/_sliceNum,_backGroudTexture.width,_backGroudTexture.height/_sliceNum)
			// TODO @jihwan.ryu 텍스쳐 UV 좌표 수정으로 배경을 움직이도록 해야함
			
			texture = FwTexture.fromBitmapData(tempbitmapdata);
			width = Framework.viewport.width;
			height = Framework.viewport.height;
		}
		
		public override function render():void
		{
			super.render();	
			var curTimerBackGround : int = getTimer();
			
			if(curTimerBackGround - _prevTime > 1000/_frame)
			{
				var tempbitmapdata : BitmapData = new BitmapData(_backGroudTexture.width, _backGroudTexture.height/_sliceNum);
				if((_backGroudTexture.height*(_sliceNum-1)/_sliceNum)-_drawPoint <= 0)
				{
					_drawPoint = 0;
				}
				
				var tempRegion : Rectangle = new Rectangle(
					0,
					(_backGroudTexture.height * (_sliceNum-1) / _sliceNum) - (_drawPoint += _step),
					_backGroudTexture.width,
					_backGroudTexture.height / _sliceNum
				);
				
//				tempbitmapdata.copyPixels(_backGroundBitmapData, tempRegion, new Point(0,0));
				
				texture = FwTexture.fromBitmapData(tempbitmapdata);
				width = Framework.viewport.width;
				height = Framework.viewport.height;
				_prevTime = 0;
			}
		}
		
		public override function dispose():void
		{
			super.dispose();
			_backGroudTexture = null;
		}
		
		public function set step(value:Number):void { _step = value; }
	}
}