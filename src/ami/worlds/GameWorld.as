package ami.worlds
{

	import ami.control.GameCamera;
	import ami.control.OveralyIndicator;
	import ami.control.txtButton;
	import ami.obj.Enemy;
	import ami.obj.Goal;
	import ami.obj.PlayerAmi;
	import ami.obj.Solid;
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Tilemap;

	public class GameWorld extends World
	{
		public static var tileset:Tilemap;
		public static var tilesetBack:Tilemap;
		//Game Logic
		public static var finished:Boolean = false;
		public static var restart:Boolean = false;
		public static var goNext:Boolean = false;
		public static var goPrev:Boolean = false;
		
		//Levels
		public static var levels:Array = new Array(Assets.LVL0);
		
		//Characters
		public static var player:PlayerAmi;
				
		//The Camera/BPI
		public static var bpi:OveralyIndicator;
		public static var cam:GameCamera = new GameCamera;

		
		//The HUD
		public static var pBtn:txtButton;
		public static var pb:txtButton;
		
		public function GameWorld()
		{
			Global.iSnd.stop();
			Global.gSnd.loop();
			FP.screen.color = 0x000000;
			
			Global.lvl = 0; //Set level to 0.
			nextLevel(); //Load next level (0 + 1 = 1)
			
			
		}
		
		
		
		public function pause():void
		{
			if (Global.paused){
				Global.paused = false;
			} else {
				Global.paused = true;
			}
		}
		
		override public function update():void
		{
			pBtn.x = pb.x = FP.camera.x + 15;
			//pb.y = FP.camera.y + 5;
			pBtn.y = FP.camera.y + 10;
			if (!Global.paused) {super.update();}
			
			if (Global.reLevel) {
				restartLevel();
			}
			
			if (Global.nextLevel) {
				nextLevel();
			}
			
			bpi.setInvPercent(player.brainPower);
		}
		
		public function loadLevel():void{
			//restart game progress variables
			finished = goNext = restart = goPrev = false;
			
			//Blank variables to build the level
			var o:XML;
			var e:Entity;
			
			//Load tilesets
			add(new Entity(0, 0, tilesetBack = new Tilemap(Assets.IMGTILEBACK, 1536, 768, 24, 24)));
			add(new Entity(0, 0, tileset = new Tilemap(Assets.IMGTILESET, 1536, 768, 24, 24)));
			
			//Load level file into XML object
			var file:ByteArray = new Assets.ARRLVLS[Global.lvl-1];
			var str:String = file.readUTFBytes( file.length);
			var xml:XML = new XML(str);
			
			//Add foreground tiles.
			for each (o in xml.tilesAbove[0].tile) 
			{
				loadTilestoMap(tileset, o.@x, o.@y, 5, o.@tx, o.@ty)

			}
			
			//Add tile colliders.
			if(xml.floors[0] != null){
				for each (o in xml.floors[0].rect)
				{
					add(new Solid(o.@x, o.@y, o.@w, o.@h));
				}
			}
			
			//Add background tiles.
			if(xml.tilesBack[0] != null){
				for each (o in xml.tilesBack[0].tile)
				{
					loadTilestoMap(tilesetBack, o.@x, o.@y, 5, o.@tx, o.@ty)
				}
				
				for each (o in xml.tilesBack[0].rect)
				{
					trace("a rect");
					var tmCol:int = 5;
					var kind:int = ((o.@ty/Global.gridSize) * tmCol) + (o.@tx/Global.gridSize)
					
					tilesetBack.setRect(o.@x, o.@y, o.@w/Global.gridSize , o.@h/Global.gridSize, kind)
				}
			}
			
			//Add Things.
			if(xml.things[0] != null){
				
				//Add Player.
				for each (o in xml.things[0].player) {
					GameWorld.player = new PlayerAmi(o.@x, o.@y);
					add(player);
					
					//Set Camera to player.
					add(cam);
					cam.setView(player, new Rectangle(0,0,Global.levelWidth,Global.levelHeight), 10);
				}
				
				//Add Enemies.
				for each (o in xml.things[0].enemy) {
					add(new Enemy(o.@x, o.@y));
				}
				
				for each (o in xml.things[0].goal) {
					add(new Goal(o.@x, o.@y));
				}
			}
			
			
			//Add Reset button
			pBtn = new txtButton(reset, null, "reset", 5, 20);
			add(pBtn);
			pb = new txtButton(pause, null, "pause", 5, 20);
			//add(pb);
			
			//Add Brain Power Indicator
			bpi = new OveralyIndicator(0,0,true);
			add(bpi);
		}
		
		public function loadTilestoMap(ts:Tilemap, px:int, py:int, tmCol:int, tx:int, ty:int):void
		{
			var kind:int = ((ty/Global.gridSize) * tmCol) + (tx/Global.gridSize);
			
			ts.setTile(px/Global.gridSize, py/Global.gridSize, kind)
		}
		
		public function restartLevel():void
		{
			removeAll();

			Global.tries += 1;
			Global.reLevel = false;
			
			loadLevel();
			
		}
		
		public function nextLevel():void
		{
			trace("Next Level");
			
			removeAll(); //Clear everything.
			
			if (Global.lvl < Assets.ARRLVLS.length)
			{		
				Global.lvl += 1; //Increase Level.
			}else{
				FP.world = new EndWorld();
			}
			Global.nextLevel = false;
			
			loadLevel();
			
		}
		
		public function reset():void
		{
			removeAll();
			FP.world = new StartWorld();
		}
	}
}