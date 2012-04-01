package game {
	import com.adamatomic.flixel.*;

	public class BorderSide extends FlxSprite
	{
		[Embed(source="data/border_height.png")] private var ImgBorder:Class;
		
		public function BorderSide(X:int,Y:int)
		{
			super(ImgBorder,X,Y,true,true,12,240);
			scrollFactor.x = scrollFactor.y = 0;
		}
	}
}