package framework.background
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	
	import framework.core.Framework;
	import framework.display.Image;

	public class BackGround extends Image
	{
		private var _backGroundBitmapData : BitmapData;
		private var _sliceNum : Number;
		private var _frame : Number;
		
		private var _step : Number = 0;
		private var _drawPoint : Number = 0;
		
		public function BackGround(sliceNum : Number, frame: Number,step:Number, backGroudBitmapData : BitmapData)
		{
			super(0,0,backGroudBitmapData);
			
			_backGroundBitmapData = backGroudBitmapData;
			_sliceNum = sliceNum;
			_frame = frame;
			_step = step;
			
			createBackGround();
		}
		
		private function createBackGround():void
		{
			// TODO Auto Generated method stub
			var tempbitmapdata : BitmapData = new BitmapData(_backGroundBitmapData.width, _backGroundBitmapData.height/_sliceNum);
			var tempRegion : Rectangle = new Rectangle(0,_backGroundBitmapData.height/_sliceNum,_backGroundBitmapData.width,_backGroundBitmapData.height/_sliceNum)
			tempbitmapdata.copyPixels(_backGroundBitmapData,tempRegion,new Point(0,0));
			
			this.bitmapData = tempbitmapdata;
			this.width = Framework.viewport.width;
			this.height = Framework.viewport.height;
		}
		
		public override function render():void
		{
			super.render();	
			var curTimerBackGround : int = getTimer();
			
			if(curTimerBackGround - this.prevTime > 1000/_frame)
			{
				var tempbitmapdata : BitmapData = new BitmapData(_backGroundBitmapData.width, _backGroundBitmapData.height/_sliceNum);
				if((_backGroundBitmapData.height*(_sliceNum-1)/_sliceNum)-_drawPoint == 0)
				{
					_drawPoint = 0;
				}
				
				var tempRegion : Rectangle = new Rectangle(0, (
					_backGroundBitmapData.height*(_sliceNum-1)/_sliceNum)-(_drawPoint+=_step), _backGroundBitmapData.width, _backGroundBitmapData.height/_sliceNum);
				tempbitmapdata.copyPixels(_backGroundBitmapData,tempRegion,new Point(0,0));
				
				this.bitmapData = tempbitmapdata;
				this.width = Framework.viewport.width;
				this.height = Framework.viewport.height;
				this.prevTime = getTimer();	
			}
			
			
			
		}
		
	}
}