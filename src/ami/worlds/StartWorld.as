package ami.worlds
{
	import ami.control.txtButton;
	
	import flash.display.StageDisplayState;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class StartWorld extends World
	{
		//HUD Buttons.
		protected var fsBtn:txtButton;
		protected var pauseButton:txtButton;
		
		//Title.
		public var amiBtn:txtButton;
		
		//Sound.
		
		public function StartWorld()
		{
			removeAll();
			FP.screen.color = Global.darkColor;
			Global.gSnd.stop();
			Global.iSnd.loop();

			fsBtn = new txtButton (goFull, null, "Fullscreen", 15, 10);
			add(fsBtn);
			
			//Load 
			amiBtn = new txtButton(playIntro, null, "AM1", 0, 0, 256);
			amiBtn.x = (FP.width/2) - (amiBtn.width/2);
			amiBtn.y = (FP.height/2) - (amiBtn.height/2);
			add(amiBtn);
			
			var e:Entity = new Entity;
			e.graphic = new Text("K3v1N + EDu2rd0");
			e.x = (FP.screen.width/2) - (amiBtn.width/2);
			e.y = (FP.screen.height/2) + (amiBtn.height/2) - 30;
			add(e);
			

		}
		
		private function playIntro():void
		{
			FP.world = new IntroWorld();
		}
		
		private function goFull():void
		{
			var xscale:Number = FP.stage.fullScreenWidth / FP.width;
			var yscale:Number = FP.stage.fullScreenHeight / FP.height;

			//Assuming you want to keep the aspect ratio and the screen is horizontal.
			if (FP.stage.displayState == StageDisplayState.NORMAL)
			{//Go Fullscreen
				if (true)
				{//Keep Aspect Ratio
					if(FP.stage.fullScreenWidth/FP.stage.width< FP.stage.fullScreenHeight/FP.stage.height)
					{//Use xscale
						trace("Scaling on X")
						FP.screen.scale = xscale;
						FP.screen.y = FP.stage.fullScreenHeight/2 - FP.halfHeight * xscale;
					} else
					{//Use yscale
						trace("Scaling on Y" + yscale)
						FP.screen.scale = yscale;
						FP.screen.x = (FP.stage.fullScreenWidth/2 - (FP.halfWidth * yscale));
					}
				}else{
					FP.screen.scaleX = xscale;
					FP.screen.scaleY = yscale;
				}
				FP.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
				
				trace (FP.stage.x + " " + FP.stage.width);

			}else
			{//Go Normal
				FP.stage.displayState = StageDisplayState.NORMAL;
				FP.screen.scale = 1;
			}
		}
	}
}