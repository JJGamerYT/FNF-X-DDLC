package;

import flixel.math.FlxPoint;
import flixel.input.FlxPointer;
import flixel.ui.FlxButton;
import openfl.ui.Mouse;
import flixel.tweens.FlxTween;
import flixel.addons.text.FlxTypeText;
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.FlxSprite;
//import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;

class InfoBoxS extends MusicBeatState
{
	var coolBox:FlxSprite;
	var coolBoxBorder:FlxSprite;
	var curDifficulty:Int = 1;
	var infoText:FlxText;
	var diffText:FlxText;
	var okBoomer:FlxText;
	var okBoomerHigh:FlxText;
	var overlay:FlxSprite;
	var isSecretPoem:Bool = false;
	
	public function new(info:String = "info.text", isModeSelect:Bool = false, isSecretPoem:Bool = false, boxWidth:Int = 400, boxHeight:Int = 150)
	{
		super();
		FlxG.mouse.visible = true;
		this.isSecretPoem = isSecretPoem;
		overlay = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
		overlay.scrollFactor.set();
		overlay.alpha = 0.5;
		add(overlay);
		coolBox = new FlxSprite().makeGraphic(boxWidth, boxHeight, 0xFFFFE6F4);
		coolBox.screenCenter();
		coolBox.scrollFactor.set();
		coolBoxBorder = new FlxSprite().makeGraphic(boxWidth += 10, boxHeight += 10, 0xFFFFBDE1);
		coolBoxBorder.screenCenter();
		coolBoxBorder.scrollFactor.set();
		infoText = new FlxText(0, 0, (boxWidth - 20), info);
		infoText.setFormat(Paths.font("doki.ttf"), 25, FlxColor.BLACK, CENTER);
		infoText.screenCenter();
		infoText.scrollFactor.set();
		infoText.y -= ((coolBox.height / 2) - 40);
		add(coolBoxBorder);
		add(coolBox);
		add(infoText);
		if (isModeSelect)
			{
				diffText = new FlxText(0, 0, 0, "Normal");
				diffText.setFormat(Paths.font("dokiUI.ttf"), 25, FlxColor.BLACK, CENTER);
				diffText.borderColor = 0xFF000000;
				diffText.borderStyle = OUTLINE;
				diffText.borderSize = 1.5;
				diffText.screenCenter();
				diffText.y += ((boxHeight / 2) - 40);
				diffText.scrollFactor.set();
				changeDifficulty();
				add(diffText);
			}
		else
			{
				okBoomer = new FlxText(0, 0, 0, "OK");
				okBoomer.setFormat(Paths.font("dokiUI.ttf"), 25, FlxColor.WHITE, CENTER);
				okBoomer.borderColor = 0xFFBB5599;
				okBoomer.borderStyle = OUTLINE;
				okBoomer.borderSize = 2;
				okBoomer.screenCenter();
				okBoomer.y += ((coolBox.height / 2) - 40);
				okBoomer.scrollFactor.set();
				add(okBoomer);

				okBoomerHigh = new FlxText(0, 0, 0, "OK");
				okBoomerHigh.setFormat(Paths.font("dokiUI.ttf"), 25, FlxColor.WHITE, CENTER);
				okBoomerHigh.borderColor = 0xFFFFFFFF;
				okBoomerHigh.borderStyle = OUTLINE;
				okBoomerHigh.borderSize = 2;
				okBoomerHigh.x = okBoomer.x;
				okBoomerHigh.y = okBoomer.y;
				okBoomerHigh.scrollFactor.set();
				okBoomerHigh.alpha = 0;
				add(okBoomerHigh);
			}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.LEFT)
			changeDifficulty(-1);
		if (FlxG.keys.justPressed.RIGHT)
			changeDifficulty(1);
		if (FlxG.keys.justPressed.ESCAPE)
			close();

		if (FlxG.mouse.overlaps(okBoomer) && FlxG.mouse.justPressed)
			{
				if (isSecretPoem)
					openSubState(new PoemScreen(true));
				FlxG.mouse.visible = false;
				kill();
			}
		
		if (FlxG.mouse.overlaps(okBoomer))
			{
				okBoomerHigh.alpha = 0.4;
			}
		else
			{
				okBoomerHigh.alpha = 0;
			}
	}

	function changeDifficulty(change:Int = 0):Void
		{
			curDifficulty += change;
	
			if (curDifficulty < 0)
				curDifficulty = 2;
			if (curDifficulty > 2)
				curDifficulty = 0;

			switch (curDifficulty)
			{
				case 0:
					diffText.text = "Easy";
					diffText.color = FlxColor.LIME;
				case 1:
					diffText.text = "Normal";
					diffText.color = FlxColor.YELLOW;
				case 2:
					diffText.text = "Hard";
					diffText.color = FlxColor.RED;
			}
			diffText.screenCenter(X);

			FlxG.sound.play(Paths.sound('scrollMenu'));
		}
}
