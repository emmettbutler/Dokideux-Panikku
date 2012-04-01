package game{
	
	import com.adamatomic.flixel.*;

	public class flyBoy extends FlxSprite{

		[Embed(source="data/flyBoy.png")] protected var imgEnemy:Class;

		protected var runSpeed:uint = 90;
		protected var posCounter:uint = 0;

		public function flyBoy(x:uint, y:uint):void{
			super(imgEnemy,x,y,true,true,18,18);
			drag.x = runSpeed*8;
			maxVelocity.x = runSpeed;

			addAnimation("run", [0, 1, 2], 15);
		}

		override public function update():void{
			posCounter++;
			velocity.x = Math.cos(posCounter / 50) * 50;
			if(velocity.x < 0)
				facing = RIGHT;
			if(velocity.x > 0)
				facing = LEFT;
			play("run");
			super.update();
		}
	}
}
