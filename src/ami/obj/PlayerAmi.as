package ami.obj
{
	import ami.worlds.GameWorld;
	
	import flash.geom.Point;
	
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	
	public class PlayerAmi extends Thing
	{
		//Graphics.
		public var sprAmi:Spritemap = new Spritemap(Assets.IMGAMITILES, 24, 24)
		
		//Physic Capabilities.
		public var move:Number = .5; //Movement power.
		public var jump:Number = 6; //Jump power.
		public var ts:Number = 1;
		
		//Special Capabilities.
		public var brainPower:Number = 100;
		public var tsGlobalFactor:Number = .00001;
		public var slowmo:Boolean = false;
		
		//Game variables
		public var caught:Boolean = false;
		public var done:Boolean = true;
		
		//States.
		public var ml:Boolean = false;
		public var mr:Boolean = false;
		public var jp:Boolean = false;
		
		public function PlayerAmi(x:int, y:int)
		{
			super(x, y); //Initialize object at x,y position.
			
			//Physical Properties.
			massGrav = .4;
			maxS = new Point(4,8);
			maxF = new Point (.5, .5);
			
			setHitbox(12,24,-6,0);
			
			//Define Animations.
			sprAmi.add("stand", [0]);
			sprAmi.add("standSlow", [0]);
			sprAmi.add("mR", [1, 2, 3, 2, 1], 10, true);
			sprAmi.add("mRS", [1, 2, 3, 2], 5, true);
			sprAmi.add("jpR", [4], 1, false);
			
			//Set Animations.
			graphic = sprAmi;
			sprAmi.play("stand");

			//Set Input.
			Input.define("hello", Key.A);
			
			Input.define("Jump", Key.W, Key.UP);
			Input.define("slowmo", Key.SPACE, Key.X, Key.C);
			Input.define("moveLeft", Key.A, Key.LEFT);
			Input.define("moveRight", Key.D, Key.RIGHT);

		}
		
		override public function update():void
		{
			checkCollision();
			checkControls();
			
			if (caught) {sprAmi.alpha -= 1; return;}
			
			updateTimeControl();

			//Jump.
			if (Input.pressed("Jump"))
			{
				if (collide("Solid", x, y+1))
				{//If player is on the ground:
					s.y -= jump;
				}
			}
			
			//Collision with cieling.
			if (collide("Solid", x, y-1)){
				s.y = 0;
			}
			
			a.x = 0;
			
			//If its moving (left/right) and the speed is within limits.
			if (ml && s.x > -maxS.x) { a.x = -move; sprAmi.flipped = true;}
			if (mr && s.x < maxS.x)  { a.x = +move; sprAmi.flipped = false;}
			
			//If there is no x movement or the speed is greater than the max speed:
			if (!ml && !mr || Math.abs(s.x) > maxS.x) { friction(true, false); }
			
			//Apply time speed.
			s.x *= ts;
			s.y *= ts;
			
			gravity();
			motion();	
		}
		
		public function updateTimeControl():void{ //Time Control operations.
			
			if (Input.check("slowmo"))
			{ //Wanting to activate brainpower.
				
				if(brainPower > 0)
				{ //If there still is brainpower. Should change to make activate threshold 20?
					
					slowmo = true;
					brainPower -= .3;
					Global.ts = tsGlobalFactor;
					ts = 1;
					//trace(brainPower.toString()); 
					
				}else
				{ //No more brainpower.
					brainPower = 0;
					slowmo = false;
	
					Global.ts = 1;
					ts = 1;
				}
			}else
			{ //Not wanting to activate brainpower.
				
				slowmo = false;
				
				if(brainPower < 100){
					
					brainPower += .1;
					Global.ts = 1;
					ts = 1;
				}
			}
		}
		
		public function checkControls():void
		{
			//Control Check.
			ml = Input.check("moveLeft");
			mr = Input.check("moveRight");
			jp = Input.pressed("Jump");
			
			if (jp){
				sprAmi.play("jpR");
			} else if (ml || mr){
				sprAmi.play("mR");
			} else {
				sprAmi.play("stand");
			}
		}

		public function checkCollision():void
		{
			if (collide(Global.Enemy, x + 1, y) as Enemy)
			{
				catchPlayer();
			}
			if (collide(Global.Enemy, x - 1, y) as Enemy)
			{
				catchPlayer();
			}
			if (collide(Global.Goal, x, y) as Goal)
			{
				amiWins();
			}
		}
		
		public function catchPlayer():void
		{
			caught = true;
			Global.reLevel = true;
		}
		
		public function amiWins():void
		{
			done = true;
			Global.nextLevel = true;
		}
	}
}