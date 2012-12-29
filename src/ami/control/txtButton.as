package ami.control
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;

	public class txtButton extends Entity
	{
		protected var sMap:Spritemap;
		protected var text:Text

		
		protected var mClicked:Boolean = false;
		protected var mOver:Boolean = false;
		
		protected var toCall:Function;
		protected var arg:*;
		
		public function txtButton(callback:Function, argument:*, txt:String = "", x:int = 0, y:int = 0, size:int = 16)
		{
			text = new Text(txt);
			text.alpha = .8;
			text.size = size;
			graphic = text;
			setHitbox(text.width, text.height);
			
			toCall = callback;
			arg = argument;
			
			super(x, y);
		}
		override public function update():void
		{
			if (!world)
			{
				return;
			}
			
			mClicked = false;
			mOver = false;
			
			if (collidePoint(x - world.camera.x, y - world.camera.y, Input.mouseX, Input.mouseY))
			{
				if (Input.mouseReleased)
				{
					mouseRel();
				} else if (Input.mouseDown)
				{
					mouseDown();
				} else {
					mouseOver();
				}
			}
			super.update();
		}
		
		override public function render():void
		{
			
			if (mClicked) { 
				//Draw Clicked State
				text.alpha = .9;
			} else if (mOver) {
				//Draw Over State
				text.alpha = 1;
			} else {
				//Draw Normal State
				text.alpha = .8;
			}
			
			super.render();
		}
		
		public function setSpriteMap(asset:*, w:int, h:int):void
		{
			sMap = new Spritemap(asset, w, h);
			
			//more missing.
		}
		
		private function mouseRel():void {
			if(toCall != null){
				
				if (!arg){
					toCall();
				}else{
					toCall(arg);
				}
			}
			
		}
		
		private function mouseDown():void { mClicked = true;}
		private function mouseOver():void {	mOver = true;}
		
	}
}