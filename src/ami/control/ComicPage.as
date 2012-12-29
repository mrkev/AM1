package ami.control
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;

	public class ComicPage extends Entity
	{
		private var points1:Array = [[30,30],[70,70]];
		
		public var nx:Number = 0;
		public var ny:Number = 0;
		
		public var cpage:int = 0;
		public var pages:int;
		
		public var parr:Array;
		public var cdone:Boolean = false;
		
		
		public function ComicPage(arr:Array)
		{
			pages = arr.length - 1;
			parr = arr;
			
			var img:Image = new Image(parr[cpage]);
			graphic = img;
			
			this.setHitbox(img.width, img.height);
		}
		
 		public function next():void
		{
			ny -= this.height / 3;
			
			if (ny < -2 * height/3){
				cpage += 1;
				
				if (cpage > pages){
					comicDone(); 
					return;
				} else {
					if (cpage == pages)
					{
						FP.screen.color = 0x000000; //Make background black for last image.
					}
					ny = 0;
					graphic = new Image(parr[cpage]);
				}
				
			
			}
		}
		
		public function comicDone():void
		{
			cdone = true;
		}
		
		override public function update():void
		{
			
			var dist:Number = FP.distance(x, y, nx, ny);
			var step:Number = dist / 10; //10 is our speed
			
			FP.stepTowards(this, nx, ny, step)
				
		}
	}
}