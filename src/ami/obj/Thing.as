package ami.obj
{
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	/*
	Describes a phisical "Thing" any object 
	that will be affected by phisical forces.
	Defines methods for motion, gravity 
	and colision with other "Things"
	and anything with type "object".
	*/

	public class Thing extends Entity
	{
		//Physics
		public var s:Point = new Point(0, 0); //Speed
		public var a:Point = new Point(0, 0); //Acceleration
		public var massGrav:Number = 0.2;
		public var maxF:Point = new Point(0.5, 0.5);
		public var maxS:Point = new Point(3, 8);
		
		public var object:String = Global.Solid;
		
		public function Thing(x:int = 0, y:int = 0)
		{
			super(x, y);
			type = object;
		}
		
		override public function update():void {
			motion();
			gravity();
		}
		
		public function gravity():void
		{
			//Apply gravity as an acceleration to y speed.
			s.y += massGrav;
		}
		
		//Motion. Moves the entity.
		//mx:Boolean = can move horizontally. 
		//my:Boolean = can move vertically.
		public function motion(mx:Boolean = true, my:Boolean = true):void
		{
					
			if (mx){
				if (!moveX(this, s.x)) { s.x = 0; } //Moves the Entity. If it hit something sets speed to 0.
				s.x += a.x;
			}
			
			if (my){
				if (!moveY(this, s.y)) { s.y = 0; }//Moves the Entity. If it hit something sets speed to 0.
				s.y += a.y;
			}
			
		}
		
		//Slows the entity down.
		//x:Boolean = should slow on x.
		//y:Boolean = should slow on y.
		public function friction(x:Boolean = true, y:Boolean = false):void
		{
			if (x)
			{
				//Reduce Speed.
				if(s.x > 0) {
					s.x -= maxF.x;
					if (s.x < 0) { s.x = 0 };
				}
				
				//If speed is negative, bring to 0.
				if (s.x < 0) {
					s.x += maxF.x;
					if (s.x > 0) { s.x = 0 };
				}
				
				
			}
			
			if (y){
				if(s.y > 0) {
					s.y -= maxF.y;
					if (s.y < 0) { s.y = 0};
				}
			}
			
		}
		
		public function maxSpeed(x:Boolean = true, y:Boolean = true):void
		{
			if (x) {
				if (Math.abs(s.x) > maxS.x)
				{
					s.x = maxS.x * FP.sign(s.x)
				}
			}
			
			if (y) {
				if (Math.abs(s.y) > maxS.y)
				{
					s.y = maxS.y * FP.sign(s.y)
				}
			}
		}
		
		//Moves the Entity 1px at a time in the X axis.
		//@return Boolean. true - didn't hit a solid. false - hit a solid.
		public function moveX(e:Entity, sx:Number):Boolean
		{
			
			//Check for each pixel
			for (var i:int = 0; i < Math.abs(sx); i++){
				var moved:Boolean;
				var objBelow:Boolean;
				
				// Check if there is something below.
				if(!e.collide(object, e.x, e.y + 1)){objBelow = false;}
				
				//Move one pixel if there is nothing.
				if (!e.collide(object, e.x + FP.sign(sx), e.y))
				{
					e.x += FP.sign(sx);
					moved = true;
				}
				
				//If right above a platform, place the Entity on it.
				if (objBelow && e.collide(object, e.x, e.y+1)){e.y += 1}
				
				if (!moved) {return false}
			}
			return true;
		}
		
		//Moves the Entity 1px at a time in the Y axis.
		//@return Boolean. true - didn't hit a solid. false - hit a solid.
		public function moveY(e:Entity, sy:Number):Boolean
		{
			
			//Check for each pixel
			for (var i:int = 0; i < Math.abs(sy); i++){
				
				//If there isn't anything in its way
				if (!e.collide(object, e.x, e.y + FP.sign(sy)))
				{
					e.y += FP.sign(sy);
				} else {
					//Hit something.
					return false;
				}

			}
			//Hit nothing!
			return true;
		}
		
	}
}