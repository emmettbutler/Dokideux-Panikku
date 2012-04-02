package game {
	import com.adamatomic.flixel.*;

	public class Player extends FlxSprite
	{
		[Embed(source="data/player.png")] private var ImgPlayer:Class;
		[Embed(source="data/jump.mp3")] private var SndJump:Class;
		[Embed(source="data/land.mp3")] private var SndLand:Class;
		
		private var _jumpPower:int;
		public var _unease:int;
		public var _anxietyLevel:int;
		private var duck:Boolean;
		private var keylock:Boolean;
		
		public function Player(X:int,Y:int)
		{
			super(ImgPlayer,X,Y,true,true,11,22);
			
			var runSpeed:uint = 200;
			keylock = false;
			_unease = 10;
			width = 10;
			height = 22;
			drag.x = runSpeed*8;
			acceleration.y = 420;
			_jumpPower = 230;
			maxVelocity.x = runSpeed;
			maxVelocity.y = _jumpPower;
			
			//animations
			addAnimation("idle_0", [0]);
			addAnimation("run_0", [0, 1, 2, 3], 15);
			addAnimation("jump_0", [3]);
			addAnimation("duck_0", [4]);
			addAnimation("idle_1", [5]);
			addAnimation("run_1", [5, 6, 7, 8], 15);
			addAnimation("jump_1", [8]);
			addAnimation("duck_1", [9]);
			addAnimation("idle_2", [10]);
			addAnimation("run_2", [10, 11, 12, 13], 15);
			addAnimation("jump_2", [13]);
			addAnimation("duck_2", [14]);
			addAnimation("idle_3", [15]);
			addAnimation("run_3", [15, 16, 17, 18], 15);
			addAnimation("jump_3", [18]);
			addAnimation("duck_3", [19]);
			addAnimation("idle_4", [20, 21, 22], 10);
		}
		
		override public function update():void
		{
			_anxietyLevel = _unease/100;

			//MOVEMENT
			acceleration.x = 0;

			if(FlxG.kLeft) {
				duck = false;
				if(!keylock)
					_unease += 45;
				keylock = true;
				if(_unease < 400){
					facing = LEFT;
					acceleration.x -= drag.x;
				}
			}
			else if(FlxG.kRight) {
				duck = false;
				if(!keylock)
					_unease += 45;
				keylock = true;
				if(_unease < 400){
					acceleration.x += drag.x;
					facing = RIGHT;
				}
			}
			else if(FlxG.kDown) {
				duck = true;
				if(!keylock)
					_unease += 20;
				keylock = true;
			}
			if(FlxG.justPressed(FlxG.UP) && velocity.y == 0) {
				duck = false;
				if(_unease < 400){
					velocity.y = -_jumpPower;
					FlxG.play(SndJump);
				}
				if(!keylock)
					_unease += 20;
			}

			if(FlxG.justPressed(FlxG.UP) || FlxG.justPressed(FlxG.RIGHT) || FlxG.justPressed(FlxG.LEFT) || FlxG.justPressed(FlxG.DOWN)){
				keylock = false;
			}

			//ANIMATION
			if(velocity.y != 0 && _anxietyLevel != 4)
			{
				play("jump_"+_anxietyLevel);
			}
			else if(velocity.x == 0)
			{
				if (duck){
					play("duck_"+_anxietyLevel);
				}
				else {
					if(_anxietyLevel >= 4)
						play("idle_4");
					else
						play("idle_"+_anxietyLevel);
				}	
			}
			else
			{
				play("run_"+_anxietyLevel);
			}
				
			if(_unease >= 1)
				_unease--;

			//UPDATE POSITION AND ANIMATION
			super.update();
		}
		
		override public function hitCeiling():Boolean
		{
			if(velocity.y < 50)
				FlxG.play(SndLand);
			return super.hitCeiling();
		}
		
		override public function hitFloor():Boolean
		{
			if(velocity.y > 50)
				FlxG.play(SndLand);
			return super.hitFloor();
		}
	}
}