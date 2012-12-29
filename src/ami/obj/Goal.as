package ami.obj
{	
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;

	public class Goal extends Entity
	{
		public function Goal(x:int=0, y:int=0)
		{
			super(x, y, new Image(Assets.IMGGOAL));
			setHitbox(24, 48)
			type = Global.Goal;
		}
	}
}