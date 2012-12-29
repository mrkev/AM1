package
{
	import ami.worlds.EndWorld;
	import ami.worlds.StartWorld;
	
	import net.flashpunk.Engine;
	import net.flashpunk.FP;

	public class Main extends Engine
	{
		private const fps:int = 60;
		private var initd:Boolean = false;

		public function Main()
		{
			super(960, 540, fps, false);
			FP.world = new StartWorld();
			trace("starting this");
			initd = true;
		}
		override public function init():void
		{
			trace("FlashPunk has started sucessfully!");
			
			//FP.console.enable();
			
			super.init();
		}
	}
}