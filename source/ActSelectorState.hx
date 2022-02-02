package;

import flixel.addons.display.FlxBackdrop;
#if desktop
import Discord.DiscordClient;
import sys.thread.Thread;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.text.FlxText;
import flixel.addons.text.FlxTypeText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import io.newgrounds.NG;
import lime.app.Application;
import openfl.Assets;

using StringTools;

class ActSelectorState extends MusicBeatState
	{
		//ORIGINALY START WARNING BUT SHIT DIDN'T WORK SO NOW IT'S THIS
		//USED FOR DEBUG ACTIVATE IN TITLE STATE TO SELECT ACT AND DEBUG FEATURES 

		var box:FlxSprite;
		var bg1:FlxSprite;
		var bg2:FlxSprite;
		var whiteScreen:FlxSprite;

		var swagDialogue:FlxTypeText;

		var stupidTestThing:FlxText;

		var readBox:Bool = false;
		var boxDone:Bool = false;

		//var curCharacter:String = '';
		//var face:String = '';
		//var chars:String = '';
		//var pos:String = '';
		//var effect:String = '';

		//public var dialogueList:Array<String> = ["FNF X DDLC is a Doki Doki Literature Club and Friday Night Funkin' fan mod.", "Team JJGamer is in no way affiliated with Team Salvato.", "This mod is designed to be played only after the original DDLC and FNF have been completed, and contains spoilers for both within.", "The original DDLC and FNF can be found for free at http://ddlc.moe and https://ninja-muffin24.itch.io/funkin", "The content contained in FNF X DDLC is not suitable for children or those who are easily disturbed.", "Individuals suffering from anxiety or depression may not have a safe experience playing this game.", "By playing FNF X DDLC, you agree that you have completed Doki Doki Literature Club and Friday Night Funkin', accept any spoilers contained within, and are ready for some freaky fresh, heart pounding beats."];

		override function create()
			{
				super.create();
				
				FlxG.sound.music.stop();

				bg1 = new FlxSprite(0, 0).loadGraphic(Paths.image('menuStuff/opening_1'));
				bg2 = new FlxSprite(0, 0).loadGraphic(Paths.image('menuStuff/opening_2'));
				bg1.setGraphicSize(Std.int(FlxG.width));
				bg2.setGraphicSize(Std.int(FlxG.width));
				bg1.updateHitbox();
				bg2.updateHitbox();
				bg1.scrollFactor.set();
				bg2.scrollFactor.set();
				bg1.screenCenter();
				bg2.screenCenter();

				whiteScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
				//dialogueList = CoolUtil.coolTextFile('embeded/startwarning.txt');

				box = new FlxSprite(0, 0).loadGraphic(Paths.image('menuStuff/textBox'));
				box.screenCenter(X);
				box.y = 480;
				box.visible = false;

				//swagDialogue = new FlxTypeText(0, 0, 0, "FUCK JUST SHOW UP PLEASE", 40);
				//swagDialogue.setFormat(Paths.font("doki.ttf"), 32, FlxColor.BLACK, LEFT);
				//swagDialogue.borderColor = 0xFF000000;
				//swagDialogue.borderStyle = OUTLINE;
				//swagDialogue.borderSize = 1.5;

				//stupidTestThing = new FlxText(0, 0, 0, "FUCK JUST SHOW UP PLEASE", 40);

				add(bg2);
				add(bg1);
				add(box);
				add(whiteScreen);
				add(swagDialogue);
				//add(stupidTestThing);

				startWarning();
			}

		override function update(elapsed:Float)
			{
				if (readBox && FlxG.keys.justPressed.ENTER)
					{
						boxDone = true;
						//dialogueList.remove(dialogueList[0]);
						//swagDialogue.resetText(dialogueList[0]);
						//swagDialogue.start(0.03, true);
					}
				//if (dialogueList[0] == null)
				if (boxDone)
					{
						box.visible = false;
						readBox = false;
						endWarning();
					}
			}

		/*public function cleanDialog():Void
		{
			var splitName:Array<String> = dialogueList[0].split(":");
			curCharacter = splitName[1];
			face = splitName[2];
			chars = splitName[3];
			pos = splitName[4];
			effect = splitName[5];
			dialogueList[0] = dialogueList[0].substr(splitName[1].length + splitName[2].length + splitName[3].length + splitName[4].length + splitName[5].length + 6).trim();
		}*/

		function startWarning():Void
			{
				new FlxTimer().start(2, function(tmr:FlxTimer)
					{
						FlxTween.tween(whiteScreen, {alpha: 0}, 2);
					});
				new FlxTimer().start(4, function(tmr:FlxTimer)
					{
						warning();
					});
			}

		function warning():Void
			{
				box.visible = true;
				//dialogueList.remove(dialogueList[0]);
				//swagDialogue.resetText(dialogueList[0]);
				swagDialogue.resetText('This is test');
				swagDialogue.start(0.03, true);
				readBox = true;
			}

		function endWarning():Void
			{
				new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						FlxTween.tween(bg1, {alpha: 0}, 2);
					});
				new FlxTimer().start(6, function(tmr:FlxTimer)
					{
						FlxTween.tween(whiteScreen, {alpha: 1}, 0.5);
					});
				new FlxTimer().start(6.5, function(tmr:FlxTimer)
					{
						FlxTransitionableState.skipNextTransIn = true;
						FlxTransitionableState.skipNextTransOut = true;
						FlxG.switchState(new TitleState());
					});
			}
	}