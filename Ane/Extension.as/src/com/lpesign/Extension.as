package com.lpesign
{
	import flash.display.BitmapData;
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	/**
	 * Air Native Extension 
	 */
	public class Extension extends EventDispatcher
	{
		private var context:ExtensionContext;
		private var _drawSprite : Function;
		
		public function Extension(drawSprite:Function = null)
		{
			_drawSprite = drawSprite;
			
			try
			{
				if(!context)
					context = ExtensionContext.createExtensionContext("com.lpesign.Extension", null);
				if(context)
					context.addEventListener(StatusEvent.STATUS,statusHandle);
			} 
			catch(e:Error) 
			{
				trace(e.message);
			}
		}
		
		public function statusHandle(event:StatusEvent):void{
			if((event.level as String) == "INPUT_ID")
			{
				dispatchEvent(new StatusEvent("INPUT_ID", false, false, event.code, event.level));
			}
			else if((event.level as String) == "eventCode")
			{
				_drawSprite(event.level as String);
			}
		}
		
		}
		
		public function toast(message:String):void{
			context.call("toast",message);
		}
		
		public function exitDialog(clickedFlag:Boolean):void{
			context.call("exitdialog",clickedFlag);
		}
				
		public function listDialog(arrPngName:Array) : void{
			context.call("listdialog",arrPngName);
		}
		
		public function spriteActivity(spriteSheet:BitmapData) : void{
			context.call("spritesheet",spriteSheet);
		}
		
		public function push(icon : BitmapData, title:String, message : String, time:int):void
		{
			context.call("push",icon, title,message,time);
		}
		
		public function inputID():void
		{
			context.call("input");
		}
	}
}