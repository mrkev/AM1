package
{
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Key;
	
	public class Global
	{
		
		
		public static var 	
			Solid:String = "Solid",
			Enemy:String = "Enemy",
			Death:String = "Lethal", //unimplemented
			Goal:String = "Goal",
			
			ts:Number = 1,
			sprRate:int = 10,
			sprRateSlow:int = 5,
			
			darkColor:Number = 0x222222,
			
			musicOn:Boolean = true,
			soundOn:Boolean = true,
			
			paused:Boolean = false,
			
			tries:int = 1,
			
			lvl:int = 0,
			nextLevel:Boolean = false,
			prevLevel:Boolean = false, //unimplemented.
			reLevel:Boolean = false,
		
			iSnd:Sfx = new Sfx(Assets.SNDINTRO),
			gSnd:Sfx = new Sfx(Assets.SNDGAME);

			
		public static const gridSize:int = 24,
			levelWidth:int = 1536,
			levelHeight:int = 768;


	}
}