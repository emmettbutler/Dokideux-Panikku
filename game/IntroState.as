package game
{
	import com.adamatomic.flixel.*
	import game.PlayStateTiles
	 
	public class IntroState extends FlxState
	{
		[Embed(source="data/title_BG.png")] private var ImgTitleBG:Class;
		[Embed(source="data/titleObj.png")] private var ImgTitleObj:Class;
		[Embed(source="data/playBtn.png")] private var ImgPlayBtn:Class;
		[Embed(source="data/cursor.png")] private var ImgCursor:Class;
		[Embed(source="data/sounds/title.mp3")] private var SndTitle:Class;
		[Embed(source="data/sounds/title2.mp3")] private var SndTitle2 :Class;

		private var t:FlxSprite; 
	 
		override public function IntroState():void
		{
			var bg:FlxSprite = new FlxSprite(ImgTitleBG, 0, 0);
			bg.scrollFactor.x=0;
			bg.scrollFactor.y=0;
			bg.x=0;
			bg.y=0;
			this.add(bg);

			t = new FlxSprite(ImgTitleObj, 30, 73, true, true, 260, 70);
			t.scrollFactor.x=0;
			t.scrollFactor.y=0;
			t.addAnimation("flash", [0, 1], 8);
			this.add(t);
			t.play("flash");

			var bs:FlxSprite = new FlxSprite(ImgPlayBtn, 30, 73);
			bs.scrollFactor.x=0;
			bs.scrollFactor.y=0;
			this.add(bs);

			var b:FlxButton = new FlxButton(47, 174, bs, onPressed);
			b.scrollFactor.x=0;
			b.scrollFactor.y=0;
			this.add(b);

			var s:int = Math.random()*2;
			if(s == 1)
				FlxG.play(SndTitle);
			else
				FlxG.play(SndTitle2);

			FlxG.setCursor(ImgCursor);
		}
		 
		override public function update():void
		{
			t.play("flash");
			super.update();
		}

		public function onPressed():void{
			FlxG.switchState(PlayStateTiles);
		}
	}
 
}