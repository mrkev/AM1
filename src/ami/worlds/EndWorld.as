package ami.worlds
{
	import ami.control.txtButton;
	
	import mx.charts.chartClasses.StackedSeries;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Text;

	public class EndWorld extends World
	{
		public var scss:txtButton;
		public function EndWorld()
		{
			FP.screen.color = Global.darkColor;
			
			scss = new txtButton(done, null, "Sucess", 0, 0, 256);
			scss.x = FP.screen.width/2 - scss.width / 2;
			scss.y = FP.screen.height/2 - scss.height/2 - 30;
			add(scss);
			
			var tt:String;
			if (Global.tries > 1){
				tt = " tries"
			} else {
				tt = " try"
			}
			
			var e:Entity = new Entity;
			var t:Text = new Text("It only took " + Global.tries + tt);
			e.graphic = t;
			e.x = (FP.screen.width/2) - (t.width/2);
			e.y = (FP.screen.height/2) + (t.height/2);
			add(e);
		}
		
		public function done():void
		{
			FP.world = new StartWorld();
		}
	}
}