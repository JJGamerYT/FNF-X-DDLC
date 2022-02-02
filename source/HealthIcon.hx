package;

import flixel.FlxSprite;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		loadGraphic(Paths.image('iconGrid'), true, 150, 150);

		antialiasing = true;
		animation.add('bf', [0, 1], 0, false, isPlayer);
		animation.add('monika', [2, 3], 0, false, isPlayer);
		animation.add('monika-goodbye', [4, 5], 0, false, isPlayer);
		animation.add('sayori', [6, 7], 0, false, isPlayer);
		animation.add('sayori-act2', [6, 8], 0, false, isPlayer);
		animation.add('yuri', [9, 10], 0, false, isPlayer);
		animation.add('yuri-act2', [11, 12], 0, false, isPlayer);
		animation.add('natsuki', [13, 14], 0, false, isPlayer);
		animation.add('natsuki-act2', [15, 16], 0, false, isPlayer);
		animation.add('To whom it should concern, I still hate you. Love, JJGamer', [17, 18], 0, false, isPlayer);
		animation.add('gf', [16], 0, false, isPlayer);
		animation.play(char);
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
