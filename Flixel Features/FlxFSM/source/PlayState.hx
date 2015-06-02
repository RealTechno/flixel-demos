package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;

class PlayState extends FlxState
{
	
	private var _map:FlxTilemap;
	private var _slime:Slime;
	private var _powerup:FlxSprite;
	
	private var _info:String = "LEFT & RIGHT to move, UP to jump\nDOWN (in the air) to ground-pound.\n\nCurrent State: {STATE}";
	private var _txtInfo:FlxText;
	
	override public function create():Void
	{
		bgColor = 0xff661166;
		super.create();
		
		
		_map = new FlxTilemap();
		_map.loadMapFromArray([
						1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
						1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
						1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
						1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
						1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
						1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
						1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
						1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
						1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
						1,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,1,
						1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
						1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,1,1,1,
						1,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,1,1,1,1,
						1,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,1,1,1,1,
						1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
				], 20, 15, "assets/tiles.png", 16, 16);
		
		
		add(_map);
		
		_slime = new Slime(192, 128);
		
		add(_slime);
		
		_powerup = new FlxSprite(48, 208, "assets/powerup.png");
		add(_powerup);
		
		
		_txtInfo = new FlxText(16, 16, -1, _info);
		add(_txtInfo);
	}
	
	
	override public function destroy():Void
	{
		super.destroy();
	}

	
	override public function update(elapsed:Float):Void
	{
		
		super.update(elapsed);
		
		FlxG.collide(_map, _slime);
		FlxG.overlap(_slime, _powerup, getPowerup);
		
		_txtInfo.text = StringTools.replace(_info, "{STATE}", Type.getClassName(_slime.fsm.stateClass));
	}
	
	private function getPowerup(S:Slime, P:FlxSprite):Void
	{		
		S.fsm.transitions.start(Slime.Idle);
		S.fsm.transitions.replace(Slime.Jump, Slime.SuperJump);
		
		P.kill();
		
	}
}