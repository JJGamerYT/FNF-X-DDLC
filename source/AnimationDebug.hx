package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

/**
	*DEBUG MODE
 */
class AnimationDebug extends FlxState
{
	var bf:Boyfriend;
	var doki:Character;
	var deathMoni:Character;
	var char:Character;
	var textAnim:FlxText;
	var dumbTexts:FlxTypedGroup<FlxText>;
	var animList:Array<String> = [];
	var curAnim:Int = 0;
	var isdoki:Bool = true;
	var isMonika:Bool = false;
	var daAnim:String = 'monika';
	var camFollow:FlxObject;
	//var characters:Array<String> = CoolUtil.coolTextFile(Paths.txt('characterList'));

	public function new(daAnim:String = 'monika')
	{
		super();
		this.daAnim = daAnim;
	}

	override function create()
	{
		super.create();
		
		FlxG.sound.music.stop();

		var gridBG:FlxSprite = FlxGridOverlay.create(10, 10);
		gridBG.scrollFactor.set(0.5, 0.5);
		add(gridBG);

		if (daAnim == 'bf' || daAnim == 'bf-act2')
			isdoki = false;

		if (daAnim == 'monika')
			isMonika = true;

		if (isdoki)
		{
			doki = new Character(0, 0, daAnim);
			doki.screenCenter();
			doki.debugMode = true;
			add(doki);

			if (!isMonika)
				char = doki;
			
			doki.flipX = false;

			if (isMonika)
				{
					deathMoni = new Character(0, 0, 'monika-reload');
					deathMoni.screenCenter();
					deathMoni.debugMode = true;
					add(deathMoni);
					char = deathMoni;
					deathMoni.flipX = false;
				}
		}
		else
		{
			bf = new Boyfriend(0, 0, 'bf-act2');
			bf.screenCenter();
			bf.debugMode = true;
			add(bf);

			char = bf;
			bf.flipX = false;
		}

		dumbTexts = new FlxTypedGroup<FlxText>();
		add(dumbTexts);

		textAnim = new FlxText(300, 16);
		textAnim.size = 26;
		textAnim.scrollFactor.set();
		add(textAnim);

		genBoyOffsets();

		camFollow = new FlxObject(0, 0, 2, 2);
		camFollow.screenCenter();
		add(camFollow);

		FlxG.camera.follow(camFollow);

		/*act2SPSong = new FlxUIDropDownMenu(30, 30, FlxUIDropDownMenu.makeStrIdLabelArray(character, true), function(character:String)
			{
				remove(doki);
				doki = new Character(0, 0, character);
				doki.screenCenter();
				doki.debugMode = true;
				add(doki);
	
				//char = doki;
				doki.flipX = false;
			});*/
	}

	function genBoyOffsets(pushList:Bool = true):Void
	{
		var daLoop:Int = 0;

		for (anim => offsets in char.animOffsets)
		{
			var text:FlxText = new FlxText(10, 20 + (18 * daLoop), 0, anim + ": " + offsets, 15);
			text.scrollFactor.set();
			text.color = FlxColor.BLUE;
			dumbTexts.add(text);

			if (pushList)
				animList.push(anim);

			daLoop++;
		}
	}

	function updateTexts():Void
	{
		dumbTexts.forEach(function(text:FlxText)
		{
			text.kill();
			dumbTexts.remove(text, true);
		});
	}

	override function update(elapsed:Float)
	{
		textAnim.text = char.animation.curAnim.name;

		if (FlxG.keys.justPressed.E)
			FlxG.camera.zoom += 0.25;
		if (FlxG.keys.justPressed.Q)
			FlxG.camera.zoom -= 0.25;

		if (FlxG.keys.pressed.I || FlxG.keys.pressed.J || FlxG.keys.pressed.K || FlxG.keys.pressed.L)
		{
			if (FlxG.keys.pressed.I)
				camFollow.velocity.y = -90;
			else if (FlxG.keys.pressed.K)
				camFollow.velocity.y = 90;
			else
				camFollow.velocity.y = 0;

			if (FlxG.keys.pressed.J)
				camFollow.velocity.x = -90;
			else if (FlxG.keys.pressed.L)
				camFollow.velocity.x = 90;
			else
				camFollow.velocity.x = 0;
		}
		else
		{
			camFollow.velocity.set();
		}

		if (FlxG.keys.justPressed.W)
		{
			curAnim -= 1;
		}

		if (FlxG.keys.justPressed.S)
		{
			curAnim += 1;
		}

		if (curAnim < 0)
			curAnim = animList.length - 1;

		if (curAnim >= animList.length)
			curAnim = 0;

		if (FlxG.keys.justPressed.S || FlxG.keys.justPressed.W || FlxG.keys.justPressed.SPACE)
		{
			char.playAnim(animList[curAnim]);

			updateTexts();
			genBoyOffsets(false);
		}

		var upP = FlxG.keys.anyJustPressed([UP]);
		var rightP = FlxG.keys.anyJustPressed([RIGHT]);
		var downP = FlxG.keys.anyJustPressed([DOWN]);
		var leftP = FlxG.keys.anyJustPressed([LEFT]);

		var holdShift = FlxG.keys.pressed.SHIFT;
		var multiplier = 1;
		if (holdShift)
			multiplier = 10;

		if (upP || rightP || downP || leftP)
		{
			updateTexts();
			if (upP)
				char.animOffsets.get(animList[curAnim])[1] += 1 * multiplier;
			if (downP)
				char.animOffsets.get(animList[curAnim])[1] -= 1 * multiplier;
			if (leftP)
				char.animOffsets.get(animList[curAnim])[0] += 1 * multiplier;
			if (rightP)
				char.animOffsets.get(animList[curAnim])[0] -= 1 * multiplier;

			updateTexts();
			genBoyOffsets(false);
			char.playAnim(animList[curAnim]);
		}

		super.update(elapsed);
	}
}
