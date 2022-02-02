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

class TitleState extends MusicBeatState
{
	static var initialized:Bool = false;
	static var goBitch:Bool = false;

	var whiteScreen:FlxSprite;
	var credGroup:FlxGroup;
	var credTextShit:Alphabet;
	var textGroup:FlxGroup;
	var whereAreTheGorls:FlxGroup;
	var monika:FlxSprite;
	var sayori:FlxSprite;
	var yuri:FlxSprite;
	var natsuki:FlxSprite;
	var funnySplash:FlxSprite;
	var funnyText1:FlxText;
	var funnyText2:FlxText;
	var coolLogo:FlxSprite;
	var ghostMenu:Bool = false;
	var ghostSprite:String = '';
	var ghostBG:FlxSprite;
	var end:FlxSprite;

	var curWacky:Array<String> = [];

	//var coolBG:FlxBackdrop;
	//var sideMenu:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuStuff/menu_side'));

	var wackyImage:FlxSprite;

	override public function create():Void
	{

		PlayerSettings.init();

		goBitch = FlxG.save.data.firstrun;

		curWacky = FlxG.random.getObject(getIntroTextShit());

		// DEBUG BULLSHIT

		super.create();

		NGio.noLogin(APIStuff.API);

		#if ng
		var ng:NGio = new NGio(APIStuff.API, APIStuff.EncKey);
		trace('NEWGROUNDS LOL');
		#end
		
		FlxG.save.bind('FNF_X_DDLC', 'jjgamer');

		Highscore.load();

		//add(coolBG = new FlxBackdrop(Paths.image('menuStuff/menu_bg')));
		//coolBG.velocity.set(-40, -40);

		if (FlxG.save.data.weekUnlocked != null)
		{
			// FIX LATER!!!
			// WEEK UNLOCK PROGRESSION!!
			// StoryMenuState.weekUnlocked = FlxG.save.data.weekUnlocked;

			if (StoryMenuState.weekUnlocked.length < 4)
				StoryMenuState.weekUnlocked.insert(0, true);

			// QUICK PATCH OOPS!
			if (!StoryMenuState.weekUnlocked[0])
				StoryMenuState.weekUnlocked[0] = true;
		}

		#if FREEPLAY
		FlxG.switchState(new FreeplayState());
		#elseif CHARTING
		FlxG.switchState(new ChartingState());
		#else
			startIntro();
		#end

	}

	var gfDance:FlxSprite;
	var danceLeft:Bool = false;
	var titleText:FlxSprite;

	function startIntro()
	{
		if (!initialized)
		{
			var diamond:FlxGraphic = FlxGraphic.fromClass(GraphicTransTileDiamond);
			diamond.persist = true;
			diamond.destroyOnNoUse = false;

			FlxTransitionableState.defaultTransIn = new TransitionData(FADE, FlxColor.BLACK, 1, new FlxPoint(0, -1), {asset: diamond, width: 32, height: 32},
				new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.4));
			FlxTransitionableState.defaultTransOut = new TransitionData(FADE, FlxColor.BLACK, 0.7, new FlxPoint(0, 1),
				{asset: diamond, width: 32, height: 32}, new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.4));

			transIn = FlxTransitionableState.defaultTransIn;
			transOut = FlxTransitionableState.defaultTransOut;

			if (FlxG.random.bool(10))
				{
					ghostMenu = true;
				}

			//ACTIVATE FOR START WARNING/ACT 1 & 2 TESTING
			//FlxTransitionableState.skipNextTransIn = true;
			//FlxTransitionableState.skipNextTransOut = true;
			//FlxG.switchState(new ActSelectorState());

			// HAD TO MODIFY SOME BACKEND SHIT
			// IF THIS PR IS HERE IF ITS ACCEPTED UR GOOD TO GO
			// https://github.com/HaxeFlixel/flixel-addons/pull/348

			// var music:FlxSound = new FlxSound();
			// music.loadStream(Paths.music('freakyMenu'));
			// FlxG.sound.list.add(music);
			// music.play();
		}

		Conductor.changeBPM(120);
		persistentUpdate = true;

		/*if (!FlxG.save.data.firstrun)
			{
				FlxG.save.data.firstrun = true;
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				FlxG.switchState(new StartWarning());
			}*/

		if (ghostMenu)
			{
				ghostSprite = '_G';
				FlxG.sound.playMusic(Paths.music('ghostmenu'));
			}
		else
			{
				FlxG.sound.playMusic(Paths.music('Gettin Doki is a terible name so this song is called FNF X DDLC! cause the DDLC menu theme is called Doki Doki Literature Club! and thats the only good name there could be for that song'));
				FlxG.sound.music.looped = true;
				FlxG.sound.music.loopTime = 20000;
			}
		//My friend SkyMewtwo64 said I shoud call this file this. You're wellcome Sky. Hope you're happy.

		monika = new FlxSprite(790, 100).loadGraphic(Paths.image('menuStuff/menuArt/M' + ghostSprite), false);
		sayori = new FlxSprite(350, 100).loadGraphic(Paths.image('menuStuff/menuArt/S' + ghostSprite), false);
		yuri = new FlxSprite(540, 10).loadGraphic(Paths.image('menuStuff/menuArt/Y' + ghostSprite), false);
		natsuki = new FlxSprite(720, 40).loadGraphic(Paths.image('menuStuff/menuArt/N' + ghostSprite), false);
		monika.setGraphicSize(Std.int(monika.width * 0.9));
		sayori.setGraphicSize(Std.int(sayori.width * 0.8));
		yuri.setGraphicSize(Std.int(yuri.width * 0.7));
		natsuki.setGraphicSize(Std.int(natsuki.width * 0.7));
		monika.antialiasing = true;
		sayori.antialiasing = true;
		yuri.antialiasing = true;
		natsuki.antialiasing = true;
		monika.updateHitbox();
		sayori.updateHitbox();
		yuri.updateHitbox();
		natsuki.updateHitbox();

		//whereAreTheGorls = new FlxGroup();
		//add(whereAreTheGorls);

		if (ghostMenu)
			{
				ghostBG = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
				add(ghostBG);
			}
		else
			{
				var coolBG:FlxBackdrop;
				add(coolBG = new FlxBackdrop(Paths.image('menuStuff/menu_bg')));
				coolBG.velocity.set(-40, -40);
			}
		// bg.antialiasing = true;
		// bg.setGraphicSize(Std.int(bg.width * 0.6));
		// bg.updateHitbox();

		add(yuri);
		add(natsuki);
		add(sayori);
		add(monika);

		var sideMenu:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuStuff/menu_side'));
		sideMenu.screenCenter();

		if (!ghostMenu)
			{
				add(sideMenu);
			}

		// logoBl.screenCenter();
		// logoBl.color = FlxColor.BLACK;

		//gfDance = new FlxSprite(FlxG.width * 0.4, FlxG.height * 0.07);
		//gfDance.frames = Paths.getSparrowAtlas('gfDanceTitle');
		//gfDance.animation.addByIndices('danceLeft', 'gfDance', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
		//gfDance.animation.addByIndices('danceRight', 'gfDance', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
		//gfDance.antialiasing = true;
		//add(gfDance);

		titleText = new FlxSprite(100, FlxG.height * 0.8);
		titleText.frames = Paths.getSparrowAtlas('titleEnter');
		titleText.animation.addByPrefix('idle', "Press Enter to Begin", 24);
		titleText.animation.addByPrefix('press', "ENTER PRESSED", 24);
		titleText.antialiasing = true;
		titleText.animation.play('idle');
		titleText.updateHitbox();
		//titleText.screenCenter(X);
		
		if (!ghostMenu)
			{
				add(titleText);
			}

		// add(logo);

		// FlxTween.tween(logoBl, {y: logoBl.y + 50}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG});
		// FlxTween.tween(logo, {y: logoBl.y + 50}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG, startDelay: 0.1});

		credGroup = new FlxGroup();
		add(credGroup);
		textGroup = new FlxGroup();


		if (ghostMenu)
			{
				whiteScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
			}
		else
			{
				whiteScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
			}
			add(whiteScreen);
		

		coolLogo = new FlxSprite(80, -320).loadGraphic(Paths.image('menuStuff/menu_icon'));
		add(coolLogo);

		credTextShit = new Alphabet(0, 0, "ninjamuffin99\nPhantomArcade\nkawaisprite\nevilsk8er", true);
		credTextShit.screenCenter();

		funnyText1 = new FlxText(0, 0, (FlxG.width), "", 30);
		funnyText1.setFormat(Paths.font("doki.ttf"), 30, FlxColor.BLACK, CENTER);
		funnyText1.screenCenter(Y);
		funnyText1.y -= 20;
		funnyText1.alpha = 0;
		funnyText1.text = curWacky[0];
		add(funnyText1);

		funnyText2 = new FlxText(0, 0, (FlxG.width), "", 30);
		funnyText2.setFormat(Paths.font("doki.ttf"), 30, FlxColor.BLACK, CENTER);
		funnyText2.screenCenter(Y);
		funnyText2.y += 20;
		funnyText2.alpha = 0;
		funnyText2.text = curWacky[1];
		add(funnyText2);

		// credTextShit.alignment = CENTER;

		credTextShit.visible = false;

		end = new FlxSprite(0, 0).loadGraphic(Paths.image('menuStuff/end'));
		end.alpha = 0;
		if (ghostMenu)
			{
				add(end);
			}

		funnySplash = new FlxSprite().loadGraphic(Paths.image('menuStuff/splashJJ'));
		add(funnySplash);
		funnySplash.alpha = 0;
		funnySplash.screenCenter(Y);
		funnySplash.screenCenter(X);
		funnySplash.antialiasing = true;

		if (ghostMenu)
			{
				titleText.visible = false;
				coolLogo.visible = false;
				sideMenu.visible = false;
			}

		FlxTween.tween(credTextShit, {y: credTextShit.y + 20}, 2.9, {ease: FlxEase.quadInOut, type: PINGPONG});

		FlxG.mouse.visible = false;

		initialized = true;

		// credGroup.add(credTextShit);
	}

	function getIntroTextShit():Array<Array<String>>
	{
		var fullText:String = Assets.getText(Paths.txt('introText'));

		var firstArray:Array<String> = fullText.split('\n');
		var swagGoodArray:Array<Array<String>> = [];

		for (i in firstArray)
		{
			swagGoodArray.push(i.split('--'));
		}

		return swagGoodArray;
	}

	var transitioning:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;
		// FlxG.watch.addQuick('amp', FlxG.sound.music.amplitude);

		if (FlxG.keys.justPressed.F)
		{
			FlxG.fullscreen = !FlxG.fullscreen;
		}

		var pressedEnter:Bool = FlxG.keys.justPressed.ENTER;

		#if mobile
		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed)
			{
				pressedEnter = true;
			}
		}
		#end

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		if (gamepad != null)
		{
			if (gamepad.justPressed.START)
				pressedEnter = true;

			#if switch
			if (gamepad.justPressed.B)
				pressedEnter = true;
			#end
		}

		if (pressedEnter && !transitioning && skippedIntro && !ghostMenu)
		{
			#if !switch
			NGio.unlockMedal(60960);

			// If it's Friday according to da clock
			if (Date.now().getDay() == 5)
				NGio.unlockMedal(61034);
			#end

			titleText.animation.play('press');

			FlxG.camera.flash(FlxColor.WHITE, 1);
			FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);

			transitioning = true;
			// FlxG.sound.music.stop();

			new FlxTimer().start(2, function(tmr:FlxTimer)
			{
				// Check if version is outdated

				var version:String = "v" + Application.current.meta.get('version');

				//if (version.trim() != NGio.GAME_VER_NUMS.trim() && !OutdatedSubState.leftState)
				//{
					//FlxG.switchState(new OutdatedSubState());
					//trace('OLD VERSION!');
					//trace('old ver');
					//trace(version.trim());
					//trace('cur ver');
					//trace(NGio.GAME_VER_NUMS.trim());
				//}
				//else
				//{
					FlxG.switchState(new MainMenuState());
				//}
			});
			// FlxG.sound.play(Paths.music('titleShoot'), 0.7);
		}

		if (pressedEnter && !skippedIntro && !ghostMenu)
		{
			skipIntro();
		}

		super.update(elapsed);
	}

	//function createCoolText(textArray:Array<String>)
	//{
		//for (i in 0...textArray.length)
		//{
			//var coolText:FlxTypeText = new FlxTypeText(0, 0, FlxG.width, textArray[i], 20);
			//coolText.setFormat(Paths.font("doki.ttf"), 18, FlxColor.BLACK, CENTER);
			//coolText.screenCenter(X);
			//coolText.screenCenter(Y);
			//credGroup.add(money);
			//textGroup.add(money);
		//}
	//}

	//function addMoreText(text:String)
	//{
		//var coolText:FlxTypeText = new FlxTypeText(0, 0, FlxG.width, textArray[i], 20);
		//coolText.setFormat(Paths.font("doki.ttf"), 18, FlxColor.BLACK, CENTER);
		//coolText.screenCenter(X);
		//coolText.screenCenter(Y);
		//credGroup.add(coolText);
		//textGroup.add(coolText);
	//}

	//function deleteCoolText()
	//{
		//while (textGroup.members.length > 0)
		//{
			//credGroup.remove(textGroup.members[0], true);
			//textGroup.remove(textGroup.members[0], true);
		//}
	//}

	override function beatHit()
	{
		super.beatHit();

		//danceLeft = !danceLeft;

		//if (danceLeft)
			//gfDance.animation.play('danceRight');
		//else
			//gfDance.animation.play('danceLeft');

		FlxG.log.add(curBeat);

		if (!ghostMenu)
		{
			switch (curBeat)
			{
				case 4:
					FlxTween.tween(funnySplash, {alpha: 1}, 0.5);
				case 7:
					FlxTween.tween(funnySplash, {alpha: 0}, 0.5);
					//3
				case 8:
					FlxTween.tween(funnyText1, {alpha: 1}, 0.5);
					FlxTween.tween(funnyText2, {alpha: 1}, 0.5);
					//1
				case 12:
					FlxTween.tween(funnyText1, {alpha: 0}, 0.5);
					FlxTween.tween(funnyText2, {alpha: 0}, 0.5);
					//1
				case 14:
					funnyText1.text = "FNF";
					funnyText1.alpha = 1;
					//2
				case 15:
					funnyText2.text = "X DDLC!";
					funnyText2.alpha = 1;
					if (!skippedIntro)
						{
							FlxTween.tween(coolLogo, {y: coolLogo.y + 320}, 0.5, {ease: FlxEase.quadIn, type: ONESHOT});
						}
					//FlxTween.tween(coolLogo, {y: coolLogo.y - 100}, 1, {ease: FlxEase.quadInOut, type: PINGPONG, startDelay: 1});
				case 16:
					skipIntro();
			}
		}
		else
			{
				switch (curBeat)
					{
						case 7:
							FlxTween.tween(end, {alpha: 1}, 0.7);
						case 12:
							end.alpha = 0;
							skipIntro();
					}
			}
	}

	//function dropLogo():Void
		//{
			//FlxTween.tween(coolLogo, {y: coolLogo.y + 100}, 1, {ease: FlxEase.quadIn, type: PINGPONG, startDelay: 1});
		//}

	var skippedIntro:Bool = false;

	function skipIntro():Void
	{
		if (!skippedIntro)
		{
			remove(funnySplash);
			remove(funnyText1);
			remove(funnyText2);
			remove(whiteScreen);
			remove(end);

			coolLogo.y = 0;

			FlxG.camera.flash(FlxColor.WHITE, 1);
			remove(credGroup);
			skippedIntro = true;
		}
	}
}
