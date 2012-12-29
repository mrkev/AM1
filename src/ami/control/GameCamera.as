package ami.control
{
	import flash.geom.Rectangle;
	
	import mx.utils.NameUtil;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;

	public class GameCamera extends Entity
	{
		//For Following
		public static var toFollow:Entity;
		public static var viewRect:Rectangle;
		public static var s:Number;
		
		//For shaking
		public static var shakes:int = 0;
		public static var strength:int = 10;
		private static var originalX:Number;
		private static var originalY:Number;
		
		public function GameCamera()
		{
			super(x, y);
			trace ("initializing camera");
			x = FP.camera.x;
			y = FP.camera.y;
			
		}
		
		public function setView(eToFollow:Entity, within:Rectangle = null, speed:Number = 1):void
		{
			toFollow = eToFollow;
			viewRect = within;
			s = speed;
			
			trace("Setting view on: " + toFollow.name);
		}
		
		public function jitter(n:Number, s:Number):void
		{
			if (shakes == 0) {
				shakes = n;
				strength = s;
				originalX = FP.camera.x;
				originalY = FP.camera.y;
			}
		}
		
		override public function update():void
		{
			super.update();
			//Follow the Entity
			var distance:Number = FP.distance(
				toFollow.x - FP.screen.width/2,
				toFollow.y - FP.screen.height/2,
				FP.camera.x,
				FP.camera.y);
			var step:Number = distance / s;
			
			FP.stepTowards(this, 
				toFollow.x - FP.screen.width/2,
				toFollow.y - FP.screen.height/2,
				step);
			
			FP.camera.x = x;
			FP.camera.y = y;
			
			if(viewRect != null){
				if (FP.camera.x < viewRect.x) {FP.camera.x = viewRect.x;} //If camera is within bounds move it.
				if (FP.camera.y < viewRect.y) {FP.camera.y = viewRect.y;}
				
				var camMaxX:Number = FP.camera.x;
				var camMaxY:Number = FP.camera.y;
				
				var vMaxX:Number = viewRect.x + viewRect.width;
				var vMaxY:Number = viewRect.y + viewRect.height;
				
				if (camMaxX > vMaxX) { FP.camera.x = vMaxX - FP.screen.width; }
				if (camMaxY > vMaxY) { FP.camera.y = vMaxY - FP.screen.height; }

			}
			
			//Shake the Camera
			if (shakes > 0){
				shakes--;
				if (shakes == 0){
					FP.camera.x = originalX;
					FP.camera.y = originalY;
				}else{
					var moveX:Number = Math.random() * strength;
					if(Math.random() < .5){
						moveX = -moveX;
					}
					
					var moveY:Number = Math.random() * strength;
					if(Math.random() < .5){
						moveY = -moveY;
					}
					FP.camera.x = originalX + moveX;
					FP.camera.y = originalY + moveY;
				}
			}
			
		}
	}
}