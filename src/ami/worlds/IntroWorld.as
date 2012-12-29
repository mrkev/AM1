package ami.worlds
{
	import ami.control.ComicPage;
	import ami.control.txtButton;
	
	import mx.charts.AreaChart;
	
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class IntroWorld extends World
	{
		public var p1:ComicPage;
		
		public function IntroWorld()
		{
			FP.screen.color = 0xFFFFFF;
				
			p1 = new ComicPage(Assets.ARRIMGSINTRO);
			add(p1);
			
			Input.define("prev", Key.A, Key.LEFT);
			Input.define("next", Key.D, Key.RIGHT);
		}
		
		override public function update():void
		{
			if (!p1.cdone)
			{//If comic not done.
				if (Input.mouseReleased){
					p1.next();
				}
				if(Input.pressed("next")){
					p1.next();
				}
				if(Input.pressed("prev")){
					//not implemented
				}
			}else{
				FP.world = new GameWorld();
			}
			
			
			super.update()
		}
	}
}