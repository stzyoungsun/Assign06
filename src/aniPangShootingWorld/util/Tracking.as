package aniPangShootingWorld.util
{
	import flash.geom.Point;
	
	import framework.core.Framework;

	public class Tracking
	{
		
		
		public function Tracking() { throw new Error("Abstract Class"); }
		
		private static const  GRAVITY_NUM : Number  = 9.8665;
		private static const  ANGLE :Number = 30;
	
		
		public static function minuscurveTraking(objectWidth : Number, objectHeight : Number, trackingVector : Vector.<Point>) : void
		{
			//Note @유영선 도착 점
			var destPos : Point = new Point(Framework.viewport.width - objectWidth, 0);
			 //Note @유영선 시작점 
			var startPos : Point = new Point(0,0);
			 //Note @유영선 x축 방향의 속도
			var speedX : Number;
			 //Note @유영선 Y축 방향의 속도
			var speedY : Number;
			 //Note @유영선 도착점 까지 도달 시간
			var destArriveTime : Number;
			 //Note @유영선 최고점의 높이
			 var mountheight : Number;
			 //Note @유영선  도착점 높이
			var destHeight : Number;
			 //Note @유영선 y축 방향의 중력 가속도
			var gravity : Number;
			 //Note @유영선 진행 시간
			var timer : Number = 0;
			 //Note @유영선 최고점 높이
			var maxHeight : Number = Framework.viewport.height/2 - objectHeight/2
			 //Note @유영선 최고점 도달 시간
			var mHTimer : Number = (Framework.viewport.width - objectWidth)/60;
			 
			destHeight = destPos.y - startPos.y;
			mountheight = maxHeight - startPos.y;
			 
			gravity = 2*mountheight / (mHTimer * mHTimer);
			 
			speedY = Math.sqrt(2*gravity*mountheight);
			
			destArriveTime = (2*speedY + Math.sqrt(-2*speedY*-2*speedY-4*gravity*2*destHeight))/(2*gravity);
			speedX = -(startPos.x - destPos.x)/destArriveTime;
			
			var x : Number;
			var y : Number;
			
			while(timer < destArriveTime)
			{
				x = startPos.x + speedX*timer;
				y = startPos.y + speedY*timer - 0.5*gravity*timer*timer;
				trackingVector.push(new Point(x,y));
				timer += 1/60;
			}
			
			while(timer > 0)
			{
				x = startPos.x + speedX*timer;
				y  = startPos.y + speedY*timer - 0.5*gravity*timer*timer;
				trackingVector.push(new Point(x,y));
				
				timer -= 1/60;
			}
		}
		
	}
}