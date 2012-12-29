package ami.obj
{
	import flash.geom.Rectangle;
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	public class Solid extends Entity
	{
				
		public function Solid(x:int, y:int, w:int = 24, h:int = 24)
		{
			graphic = new Image(new BitmapData(w, h, true, 0xEEFFFFFF));
			this.x = x;
			this.y = y;
			
			this.setHitbox(w,h);
			type = Global.Solid;
			
			active = false; visible = false;
			
		}
	}
}