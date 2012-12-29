package ami.control
{	
	import flash.display.BitmapData;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;

	public class OveralyIndicator extends Entity
	{
		public var indicator:Image;
		public function OveralyIndicator(x:int = 0, y:int = 0, fullscreen:Boolean = true)
		{
			var w:int = 0;
			var h:int = 0;
			if (fullscreen) { w = FP.width; h = FP.height; }
			
			indicator = new Image(new BitmapData(w, h, true, 0x777777aa));
			indicator.alpha = 0;
			graphic = indicator;
		}
		
		public function setInvPercent(n:Number):void {
			indicator.alpha = 1 - n/100;
			x = FP.camera.x;
			y = FP.camera.y;
		}
	}
}