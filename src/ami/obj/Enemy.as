package ami.obj
{
	import ami.worlds.GameWorld;
	
	import flash.geom.Point;
	
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	
	public class Enemy extends Thing
	{
		public var sprMalo:Spritemap = new Spritemap(Assets.IMGMALOTILES, 24, 24);
		public var move:Number = .2; //Movement power.
		public var jump:Number = 4; //Jump power.
		
		public var alert:Boolean = false;
		
		public function Enemy(x:int = 0, y:int = 0){
			
			sprMalo.add("s", [1], 1, false);
			sprMalo.add("ml", [1, 2, 3, 2], Global.sprRate, true);
			sprMalo.add("mr", [6, 5, 4, 5], Global.sprRate, true);
			sprMalo.add("mlS", [1, 2, 3, 2], Global.sprRateSlow, true);
			sprMalo.add("mrS", [6, 5, 4, 5], Global.sprRateSlow, true);
			
			super(x, y); //Initialize object at x,y position.
			massGrav = .4;
			maxS = new Point(4,8);
			maxF = new Point (.5, .5);
			
			graphic = sprMalo;
			type = Global.Enemy;
			setHitbox(12, 24, -6, 0);

		}
		
		
		override public function update():void
		{
			if (!alert)
			{
				checkCollision();
			} else{
				var ml:Boolean = x > GameWorld.player.x;
				var mr:Boolean = x < GameWorld.player.x;
			}
			
			if (ml && s.x > -maxS.x) { //If move left
				a.x = -move; 
				if (Global.ts < 1){
					sprMalo.play("mlS");
				}else{
					sprMalo.play("ml");

				}	
			}
			if (mr && s.x < maxS.x)  { //If move right
				a.x = +move;
				if (Global.ts < 1){
					sprMalo.play("mrS")
				}else{
					sprMalo.play("mr");
				}
			}
			
			//If there is no x movement or the speed is greater than the max speed:
			if (!ml && !mr || Math.abs(s.x) > maxS.x) { friction(true, false);}
			
			s.x *= Global.ts;
			s.y *= Global.ts;
			gravity();
			motion();
			
			checkCollision();
		}
		
		public function checkCollision():void
		{
			if (collide(Global.Solid, x - 60, y) as PlayerAmi)
			{
				alert = true;
			}
		}
	}
}