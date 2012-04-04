package game
{
	import com.adamatomic.flixel.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;

	public class PlayStateTiles extends FlxState
	{
		[Embed(source="data/sounds/relief.mp3")] private var SndRelief:Class;
		[Embed(source="data/flixel_logo.png")] private var ImgFlixelLogo:Class;
		[Embed(source="data/sounds/breathing.mp3")] private var SndBreath:Class;

		private var _map:MapBase;

		private var _player:Player;
		private var _coins:FlxArray = new FlxArray;
		private var _enemies:FlxArray = new FlxArray;
		private var _flyers:FlxArray = new FlxArray;
		private var _spikes:FlxArray = new FlxArray;
		private var _restart:Number;
		private var coin:Coin;
		private var deathTimer:int;
		private var _enemy:GroundEnemy;
		private var _bunnies:FlxArray = new FlxArray;
		private var _leftBorder:BorderSide;
		private var _rightBorder:BorderSide;
		
		
		protected function onMapAddCallback(spr:FlxSprite):void
		{
			if(spr is Player) {
				_player = spr as Player;
			}
			else if(spr is Coin)
				_coins.add(spr);
			else if(spr is GroundEnemy)
				_enemies.add(spr)
			else if(spr is flyBoy)
				_flyers.add(spr)
			else if(spr is Sprites)
				_spikes.add(spr)
			else if(spr is Bunny)
				_bunnies.add(spr);
		}
		
		function PlayStateTiles():void {
			super();
			
			deathTimer = 0;

			_map = new MapNewMap;
			//Add the background (a bit hacky but works)
			var bgColorSprite:FlxSprite = new FlxSprite(null, 0, 0, false, false, FlxG.width, FlxG.height, _map.bgColor);
			bgColorSprite.scrollFactor.x = 0;
			bgColorSprite.scrollFactor.y = 0;
			FlxG.state.add(bgColorSprite);

			//Create the map and add the layers to current the FlxState
			FlxG.state.add(_map.layerClouds);
			FlxG.state.add(_map.layerGAME);
			_map.addSpritesToLayerGAME(onMapAddCallback);
			_map.addSpritesToLayerClouds(onMapAddCallback);

			_leftBorder = new BorderSide(0, 0);
			this.add(_leftBorder);
			_rightBorder = new BorderSide(308, 0);
			this.add(_rightBorder);

			_player = new Player(20, 0);
			this.add(_player);

			//inivisble, followed by camera
			coin = new Coin(90, 0);
			_coins.add(coin);
			this.add(coin);

			FlxG.follow(coin,2.5);
			FlxG.followAdjust(0.5,0.0);
			FlxG.followBounds(_map.boundsMinX, _map.boundsMinY, _map.boundsMaxX, _map.boundsMaxY);

			var logo:FlxSprite = new FlxSprite(ImgFlixelLogo, 0, 0);
			logo.scrollFactor.x=0;
			logo.scrollFactor.y=0;
			logo.x=1;
			logo.y=FlxG.height-logo.height-1;
			this.add(logo);
			
			FlxG.flash(0xff131c1b);
			//FlxG.setMusic(SndBreath);
		}

		protected function overlapPlayerEnemy(enemy:GroundEnemy, player:Player):void
		{
			_player.play("die_"+_player._anxietyLevel);
			_player.kill()
			FlxG.switchState(PlayStateTiles);
		}

		protected function overlapPlayerFlyer(enemy:flyBoy, player:Player):void
		{
			_player.play("die_"+_player._anxietyLevel);
			_player.kill()
			FlxG.switchState(PlayStateTiles);
		}

		protected function overlapPlayerSpikes(spikes:Sprites, player:Player):void
		{
			_player.play("die_"+_player._anxietyLevel);
			_player.kill()
			FlxG.switchState(PlayStateTiles);
		}

		override public function update():void
		{
			_rightBorder.scale.x = _leftBorder.scale.x = _player._unease/25;
		
			if(_player.y > _map.boundsMaxY || _player.x < coin.x - 200){
				_player.kill()
				FlxG.switchState(PlayStateTiles);
			}

			if(_player.x == 4200){
				FlxG.play(SndRelief);
				FlxG.switchState(IntroState);
			}

			_map.layerGAME.collide(_player);
			for(var i:Number = 0; i != _bunnies.length; i++){
				_map.layerGAME.collide(_bunnies[i]);
			}
			for(i = 0; i != _enemies.length; i++){
				_map.layerGAME.collide(_enemies[i]);
			}

			/*if(_player._curFrame == 42 || _player._curFrame == 37 || _player._curFrame == 32 || _player._curFrame == 27){
				_player.kill()
				FlxG.switchState(PlayStateTiles);
			}*/

			FlxG.overlapArray(_enemies, _player, overlapPlayerEnemy);
			FlxG.overlapArray(_flyers, _player, overlapPlayerFlyer);
			FlxG.overlapArray(_spikes, _player, overlapPlayerSpikes);

			super.update();
		}
	}
}
