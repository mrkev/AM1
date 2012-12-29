package 
{
	public class Assets
	{
		//--Images--//
		
		//Intro Images
		[Embed(source = "assets/img/intro/pt1/1.png")]
		public static const IMGINTRO1:Class;
		[Embed(source = "assets/img/intro/pt1/2.png")]
		public static const IMGINTRO2:Class;
		[Embed(source = "assets/img/intro/pt1/3.png")]
		public static const IMGINTRO3:Class;
		[Embed(source = "assets/img/intro/pt1/4.png")]
		public static const IMGINTRO4:Class;
		[Embed(source = "assets/img/intro/pt1/5.png")]
		public static const IMGINTRO5:Class;
		
		public static const ARRIMGSINTRO:Array = [IMGINTRO1, IMGINTRO2, IMGINTRO3, IMGINTRO4, IMGINTRO5];
		
		//Level Images
		[Embed(source = "assets/img/testTilemap.png")]
		public static const IMGTILESET:Class;
		
		[Embed(source = "assets/img/fondos.png")]
		public static const IMGTILEBACK:Class;
		
		//Ami Images
		[Embed(source = "assets/img/amiRun.png")]
		public static const IMGAMIRUN:Class;
		
		[Embed(source = "assets/img/amiTilemap.png")]
		public static const IMGAMITILES:Class;
		
		//Enemy Images
		[Embed(source = "assets/img/malo.png")]
		public static const IMGMALOTILES:Class;
		
		//Objects Images
		[Embed(source = "assets/img/goal.png")]
		public static const IMGGOAL:Class;
		
		//Test Images
		[Embed(source = "assets/img/swordguy.png")]
		public static const IMGSWORDGUY:Class;
		
		[Embed(source = "assets/img/wall.png")] 
		public static const IMGWALL:Class;
		
		
		
		//--Levels--//
		[Embed(source = "assets/lvl/EASY LEVEL 1.oel", mimeType = "application/octet-stream")] 
		public static const LVL1:Class;
		[Embed(source = "assets/lvl/EASY LEVEL 2.oel", mimeType = "application/octet-stream")] 
		public static const LVL0:Class;
		[Embed(source = "assets/lvl/NewLevel.oel", mimeType = "application/octet-stream")] 
		public static const LVL2:Class;
		[Embed(source = "assets/lvl/LEVEL 2.oel", mimeType = "application/octet-stream")] 
		public static const LVL3:Class;
		
		
		public static const ARRLVLS:Array = new Array(LVL0, LVL1, LVL2, LVL3);


		
		//--Sounds--//
		[Embed(source = "assets/snd/kick.mp3")]
		public static const SNDKICK:Class;
		
		[Embed(source = "assets/snd/Intro1.mp3")]
		public static const SNDINTRO:Class;
		
		[Embed(source = "assets/snd/Game1.mp3")]
		public static const SNDGAME:Class;
		
	}
}