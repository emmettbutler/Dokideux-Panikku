package game {
	import com.adamatomic.flixel.*;

	public class Player extends FlxSprite
	{
		[Embed(source="data/player.png")] private var ImgPlayer:Class;
		[Embed(source="data/sounds/anxious_1.mp3")] private var SndAnx1:Class;
		[Embed(source="data/sounds/anxious_2.mp3")] private var SndAnx2:Class;
		[Embed(source="data/sounds/anxious_3.mp3")] private var SndAnx3:Class;
		[Embed(source="data/sounds/anxious_4.mp3")] private var SndAnx4:Class;
		[Embed(source="data/sounds/anxious_5.mp3")] private var SndAnx5:Class;
		[Embed(source="data/sounds/anxious_6.mp3")] private var SndAnx6:Class;
		[Embed(source="data/sounds/anxious_7.mp3")] private var SndAnx7:Class;
		[Embed(source="data/sounds/anxious_8.mp3")] private var SndAnx8:Class;
		[Embed(source="data/sounds/anxious_9.mp3")] private var SndAnx9:Class;
		[Embed(source="data/sounds/anxious_10.mp3")] private var SndAnx10:Class;
		[Embed(source="data/sounds/anxious_11.mp3")] private var SndAnx11:Class;
		[Embed(source="data/sounds/freakout_1.mp3")] private var SndFreak1:Class;
		[Embed(source="data/sounds/freakout_2.mp3")] private var SndFreak2:Class;
		[Embed(source="data/sounds/jump.mp3")] private var SndJump:Class;
		[Embed(source="data/sounds/keypress.mp3")] private var SndKey:Class;
		[Embed(source="data/sounds/die.mp3")] private var SndDie:Class;
		
		private var _jumpPower:int;
		public var _unease:int;
		public var _anxietyLevel:int;
		public var _freakLock:Boolean;
		private var duck:Boolean;
		private var keylock:Boolean;
		private var playSnd:int;
		private var anxiousSound:int;
		
		public function Player(X:int,Y:int)
		{
			super(ImgPlayer,X,Y,true,true,11,22);
			
			var runSpeed:uint = 200;
			keylock = false;
			_unease = 10;
			width = 10;
			height = 20;
			offset.y = 2;
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
			addAnimation("die_0", [23, 24, 25, 26, 27], 15);
			addAnimation("idle_1", [5]);
			addAnimation("run_1", [5, 6, 7, 8], 15);
			addAnimation("jump_1", [8]);
			addAnimation("duck_1", [9]);
			addAnimation("die_1", [28, 29, 30, 31, 32], 15);
			addAnimation("idle_2", [10]);
			addAnimation("run_2", [10, 11, 12, 13], 15);
			addAnimation("jump_2", [13]);
			addAnimation("duck_2", [14]);
			addAnimation("die_2", [33, 34, 35, 36, 37], 15);
			addAnimation("idle_3", [15]);
			addAnimation("run_3", [15, 16, 17, 18], 15);
			addAnimation("jump_3", [18]);
			addAnimation("duck_3", [19]);
			addAnimation("die_3", [38, 39, 40, 41, 42], 15);
			addAnimation("idle_4", [20, 21, 22], 10);
		}
		
		override public function update():void
		{
			_anxietyLevel = _unease/100;

			//MOVEMENT
			acceleration.x = 0;

			if(FlxG.kLeft) {
				duck = false;
				height = 20;
				offset.y = 2;
				if(!keylock){
					_unease += 45;
					FlxG.play(SndKey);
				}
				keylock = true;
				if(_unease < 400){
					facing = LEFT;
					acceleration.x -= drag.x;
				}
			}
			else if(FlxG.kRight) {
				duck = false;
				height = 20;
				offset.y = 2;
				if(!keylock){
					_unease += 45;
					FlxG.play(SndKey);
				}
				keylock = true;
				if(_unease < 400){
					acceleration.x += drag.x;
					facing = RIGHT;
				}
			}
			else if(FlxG.kDown) {
				duck = true;
				if(!keylock){
					FlxG.play(SndKey);
					_unease += 20;
				}
				keylock = true;
			}
			if(FlxG.justPressed(FlxG.UP) && velocity.y == 0) {
				duck = false;
				height = 20;
				offset.y = 2;
				if(_unease < 400){
					velocity.y = -_jumpPower;
					FlxG.play(SndJump);
				}
				if(!keylock){
					FlxG.play(SndKey);
					_unease += 20;
				}
			}

			if(FlxG.justPressed(FlxG.UP) || FlxG.justPressed(FlxG.RIGHT) || FlxG.justPressed(FlxG.LEFT) || FlxG.justPressed(FlxG.DOWN)){
				keylock = false;
			}

			anxiousSound = Math.random()*11;
			playSnd = Math.random()*2;
			if((_unease == 100 || _unease == 200 || _unease == 300) && playSnd == 1){
				switch(anxiousSound){
					case 1: FlxG.play(SndAnx1); break;
					case 2: FlxG.play(SndAnx2); break;
					case 3: FlxG.play(SndAnx3); break;
					case 4: FlxG.play(SndAnx4); break;
					case 5: FlxG.play(SndAnx5); break;
					case 6: FlxG.play(SndAnx6); break;
					case 7: FlxG.play(SndAnx7); break;
					case 8: FlxG.play(SndAnx8); break;
					case 9: FlxG.play(SndAnx9); break;
					case 10: FlxG.play(SndAnx10); break;
					case 11: FlxG.play(SndAnx11); break;
				}
			}

			if(_anxietyLevel < 4){
				_freakLock = false;
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
					height = 11;
					offset.y = 12;
				}
				else {
					if(_anxietyLevel >= 4 && !_freakLock){
						_freakLock = true;
						play("idle_4");
						var s:int = Math.random()*2;
						if(s == 1)
							FlxG.play(SndFreak1);
						else
							FlxG.play(SndFreak2);
					}
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
			return super.hitCeiling();
		}
		
		override public function hitFloor():Boolean
		{
			return super.hitFloor();
		}

		override public function kill():void{
			FlxG.play(SndDie);
			play("die_"+_anxietyLevel);
			super.kill();
		}
	}
}