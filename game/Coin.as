package game {
	import com.adamatomic.flixel.*;

	public class Coin extends FlxSprite
	{
		[Embed(source="data/none.png")] private var ImgCoin:Class;
		
		public function Coin(X:int,Y:int)
		{
			super(ImgCoin,X,Y,true,true);
		}

		override public function update():void{
			velocity.x = 80;
			super.update();
		}
	}
}