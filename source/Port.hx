package;

import flixel.tweens.FlxEase;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;

class Port extends FlxSprite
{
	public var shown:Bool = false;

	public function new(char:String = 'bf')
	{
		super();

		antialiasing = true;

		switch (char)
			{
				case 'bf':
					loadGraphic(Paths.image('game/dokiUI/portraits/BFPort'), true, 338, 263);
					animation.add('A', [0], 0, false);
					animation.add('B', [1], 0, false);
					animation.add('C', [2], 0, false);
					animation.add('D', [3], 0, false);
					animation.add('E', [4], 0, false);
					animation.add('F', [5], 0, false);
					animation.add('G', [6], 0, false);
					animation.play("A");
				case 'gf':
					loadGraphic(Paths.image('game/dokiUI/portraits/GFPort'), true, 323, 295);
					animation.add('A', [0], 0, false);
					animation.add('B', [1], 0, false);
					animation.add('C', [2], 0, false);
					animation.add('D', [3], 0, false);
					animation.add('E', [4], 0, false);
					animation.add('F', [5], 0, false);
					animation.add('G', [6], 0, false);
					animation.play("A");	
				case 'monika':
					loadGraphic(Paths.image('game/dokiUI/portraits/MPort'), true, 324, 429);
					animation.add('A', [0], 0, false);
					animation.add('B', [1], 0, false);
					animation.add('C', [2], 0, false);
					animation.add('D', [3], 0, false);
					animation.add('E', [4], 0, false);
					animation.add('F', [5], 0, false);
					animation.add('G', [6], 0, false);
					animation.add('H', [7], 0, false);
					animation.add('I', [8], 0, false);
					animation.add('J', [9], 0, false);
					animation.add('K', [10], 0, false);
					animation.add('L', [11], 0, false);
					animation.add('M', [12], 0, false);
					animation.add('N', [13], 0, false);
					animation.add('O', [14], 0, false);
					animation.add('P', [15], 0, false);
					animation.add('Q', [16], 0, false);
					animation.add('R', [17], 0, false);
					animation.add('S', [18], 0, false);
					animation.play("A");		
				case 'sayori':
					loadGraphic(Paths.image('game/dokiUI/portraits/SPort'), true, 314, 400);
					animation.add('A', [0], 0, false);
					animation.add('B', [1], 0, false);
					animation.add('C', [2], 0, false);
					animation.add('D', [3], 0, false);
					animation.add('E', [4], 0, false);
					animation.add('F', [5], 0, false);
					animation.play("A");
				case 'yuri':
					loadGraphic(Paths.image('game/dokiUI/portraits/YPort'), true, 346, 419);
					animation.add('A', [0], 0, false);
					animation.add('B', [1], 0, false);
					animation.add('C', [2], 0, false);
					animation.add('D', [3], 0, false);
					animation.add('E', [4], 0, false);
					animation.add('F', [5], 0, false);
					animation.add('G', [6], 0, false);
					animation.add('H', [7], 0, false);
					animation.add('I', [8], 0, false);
					animation.add('J', [9], 0, false);
					animation.add('K', [10], 0, false);
					animation.play("A");
				case 'natsuki':
					loadGraphic(Paths.image('game/dokiUI/portraits/NPort'), true, 263, 359);
					animation.add('A', [0], 0, false);
					animation.add('B', [1], 0, false);
					animation.add('C', [2], 0, false);
					animation.add('D', [3], 0, false);
					animation.add('E', [4], 0, false);
					animation.add('F', [5], 0, false);
					animation.add('G', [6], 0, false);
					animation.add('H', [7], 0, false);
					animation.add('I', [8], 0, false);
					animation.add('J', [9], 0, false);
					animation.add('K', [10], 0, false);
					animation.play("A");
			}

		//antialiasing = true;
		//animation.play(char);
		scrollFactor.set();
	}

	public function playFrame(frame:String = "A")
		{
			animation.play(frame);
		}


	/*public function setPos(chars:String = "1", pos:String = "1")
		{
			if (shown)
				{
					FlxTween.tween({x: ((1280 / (Std.parseInt(chars) + 1)) * Std.parseInt(pos) - (width / 2))}, 0.2, {ease: FlxEase.quadInOut, type: ONESHOT});
				}
			else
				{
					x = ((1280 / (Std.parseInt(chars) + 1)) * Std.parseInt(pos) - (width / 2));
					FlxTween.tween({alpha: 1}, 0.2);
					shown = true;
				}
		}*/

	//override function update(elapsed:Float)
	//{
		//super.update(elapsed);

		//if (sprTracker != null)
			//setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	//}
}
