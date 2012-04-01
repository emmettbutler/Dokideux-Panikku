package game{
	
	import com.adamatomic.flixel.*;

	public class Sprites extends FlxSprite{

		[Embed(source="data/spikes.png")] protected var imgEnemy:Class;

		public function Sprites(x:uint, y:uint):void{
			super(imgEnemy,x,y,true,true,18,18);
		}
	}
}
