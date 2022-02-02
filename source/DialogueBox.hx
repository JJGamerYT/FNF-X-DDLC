package;

import sys.io.File;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUINumericStepper;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import haxe.io.Bytes;
import openfl.utils.Assets;
import lime.utils.Assets;
import flixel.addons.effects.chainable.FlxGlitchEffect;
import flixel.addons.effects.chainable.FlxEffectSprite;
#if sys
import sys.io.File;
import sys.FileSystem;
import flixel.addons.plugin.screengrab.FlxScreenGrab;
#end

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;
	var boxName:Port;

	var fileString:String = 'ha ha gf funkin dies.mp4';

	var curCharacter:String = '';
	var face:String = '';
	var chars:String = '';
	var pos:String = '';
	var effect:String = '';

	var dialogue:Alphabet;
	public var dialogueList:Array<String> = [];

	var dokiDialog:Bool = false;

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var bgTrans:FlxSprite;

	var console:FlxSprite;
	var consoleText:FlxTypeText;
	var consoleShown:Bool = false;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;

	var bg:FlxSprite;
	var glitchBG:FlxSprite;
	var end:FlxSprite;

	var bgFade:FlxSprite;

	var bgFadeOut:FlxSprite;

	var canSkip:Bool = true;
	var skipFastAndEatAss:Bool = false;
	var paused:Bool = false;

	//var jjPortUp:Bool = false;
	//var jjPortA:FlxSprite;
	//var jjPortB:FlxSprite;
	//var jjPortC:FlxSprite;

	var jPortUp:Bool = false;
	var jPortR:Bool = false;
	var jPort:Port;

	var bfPortUp:Bool = false;
	var bfPort:Port;

	var gfPortUp:Bool = false;
	var gfPort:Port;

	var mPortUp:Bool = false;
	var mPort:Port;

	var sPortUp:Bool = false;
	var sPort:Port;

	var yPortUp:Bool = false;
	var yPort:Port;
	
	var nPortUp:Bool = false;
	var nPort:Port;

	var portThing:Port;
	var callEffect:Bool = false;

	var handSelect:FlxSprite;

	var xTest:FlxUINumericStepper;
	var yTest:FlxUINumericStepper;
	var flip:FlxUICheckBox;
	var headFallTest:Bool = false;

	var gfStandIn:FlxSprite;
	var bfStandIn:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		xTest = new FlxUINumericStepper(10, 10, 1);
		xTest.value = 0;
		xTest.name = 'x_test';

		yTest = new FlxUINumericStepper(10, 30, 1);
		yTest.value = 0;
		yTest.name = 'y_test';

		flip = new FlxUICheckBox(10, 50, null, null, "Flip x", 100);
		flip.name = 'flip';

		bgTrans = new FlxSprite(-100, -50).makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);

		if (PlayState.SONG.song.toLowerCase() == 'spiders')
			{
				bgTrans.alpha = 1;
			}
		else
			{
				bgTrans.alpha = 0;
			}

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		//if (PlayState.SONG.song.toLowerCase() == 'spiders')
			//{
				//bgTrans.alpha = 1;
				//FlxTween.tween(bgTrans, {alpha: 0}, 1, {startDelay: 20,});
				//new FlxTimer().start(1, function(tmr:FlxTimer)
					//{
						//FlxG.sound.play(Paths.sound('dialogue/escape_sound'), 1);
					//});
			//}
		//else
			//{
				bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
				bgFade.scrollFactor.set();
				bgFade.alpha = 0;
				add(bgFade);

				new FlxTimer().start(0.83, function(tmr:FlxTimer)
					{
						bgFade.alpha += (1 / 5) * 0.7;
						if (bgFade.alpha > 0.7)
							bgFade.alpha = 0.7;
					}, 5);
			//}

		var box:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('game/dokiUI/textBox'));
		box.screenCenter(X);
		box.y = 480;
		
		var hasDialog = false;

		hasDialog = true;
		dokiDialog = true;
		box.antialiasing = true;
		
		/*switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);

			case 'cool-test':
				hasDialog = true;
				dokiDialog = true;
				box.frames = Paths.getSparrowAtlas('game/dokiUI/textBox');
				box.animation.addByPrefix('normalOpen', 'DDLC Box Open', 24, false);
				box.animation.addByIndices('normal', 'DDLC Box Open', [8], "", 24);
			
			case 'spiders' | 'bottles' | 'raccoon' | 'goodbye':
				hasDialog = true;
				dokiDialog = true;
				box.frames = Paths.getSparrowAtlas('game/dokiUI/textBox');
				box.animation.addByPrefix('normalOpen', 'DDLC Box Open', 24, false);
				box.animation.addByIndices('normal', 'DDLC Box Open', [8], "", 24);
				box.antialiasing = true;
		}*/

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;

		//cutsceneImage = new FlxSprite(0, 0);
		//cutsceneImage.visible = false;
		//add(cutsceneImage);	
		
		portraitLeft = new FlxSprite(-20, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitRight = new FlxSprite(0, 40);
		portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
		portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;

		//jjPortA = new FlxSprite(800, 85);
		//jjPortA.frames = Paths.getSparrowAtlas('game/dokiUI/portraits/JJGPort');
		//jjPortA.animation.addByPrefix('showA', 'Face A', 24, false);
		//jjPortA.animation.addByIndices('A', 'Face A', [7], "", 24);
		//add(jjPortA);
		//jjPortA.visible = false;

		//jjPortB = new FlxSprite(800, 85);
		//jjPortB.frames = Paths.getSparrowAtlas('game/dokiUI/portraits/JJGPort');
		//jjPortB.animation.addByPrefix('showB', 'Face B', 24, false);
		//jjPortB.animation.addByIndices('B', 'Face B', [7], "", 24);
		//add(jjPortB);
		//jjPortB.visible = false;

		//jjPortC = new FlxSprite(800, 85);
		//jjPortC.frames = Paths.getSparrowAtlas('game/dokiUI/portraits/JJGPort');
		//jjPortC.animation.addByPrefix('showC', 'Face C', 24, false);
		//jjPortC.animation.addByIndices('C', 'Face C', [7], "", 24);
		//add(jjPortC);
		//jjPortC.visible = false;

		//BG AND MUSIC
		bg = new FlxSprite(0, 0);
		if (PlayState.SONG.song.toLowerCase() == 'cool-test' || PlayState.SONG.song.toLowerCase() == 'spiders')
			{
				bg.loadGraphic(Paths.image('game/dokiUI/bg/class'), false);
			}
		else
			{
				bg.loadGraphic(Paths.image('game/dokiUI/bg/club'), false);
				if (PlayState.SONG.song.toLowerCase() == 'bottles')
					{
						FlxG.sound.playMusic(Paths.music('dialogue/ohio'), 0.7);
						FlxG.sound.music.looped = true;
						FlxG.sound.music.loopTime = 4499;
					}
				if (PlayState.SONG.song.toLowerCase() == 'raccoon')
					{
						FlxG.sound.playMusic(Paths.music('dialogue/too_much_piano'), 0.7);
						FlxG.sound.music.looped = true;
						FlxG.sound.music.loopTime = 10893;
					}
				if (PlayState.SONG.song.toLowerCase() == 'goodbye')
					{
						if (PlayState.reset == false)
							{
								FlxG.sound.playMusic(Paths.music('dialogue/azumanga_daijoubu'), 0.7);
								FlxG.sound.music.looped = true;
								FlxG.sound.music.loopTime = 9938;
							}
					}
			}
			
		add(bg);

		glitchBG = new FlxSprite(0, 0);
		glitchBG.loadGraphic(Paths.image('game/dokiUI/bg/clubG'), true, 1280, 720);
		glitchBG.animation.add('glitch', [0, 1], 24, true);
		glitchBG.alpha = 0;
		add(glitchBG);


		//if (PlayState.SONG.song.toLowerCase() == 'goodbye')
			//{
				//loadGraphic(Paths.image('game/dokiUI/bg/space'), false);
			//}

		//GF PORTS
		gfPort = new Port('gf');
		gfPort.x = 100;
		gfPort.y = 220;
		gfPort.alpha = 0;
		add(gfPort);
		
		//BF PORTS
		bfPort = new Port('bf');
		bfPort.x = 100;
		bfPort.y = 220;
		bfPort.alpha = 0;
		add(bfPort);

		//MONIKA PORTS
		mPort = new Port('monika');
		mPort.x = 100;
		mPort.y = 80;
		mPort.alpha = 0;
		add(mPort);

		//SAYORI PORTS
		sPort = new Port('sayori');
		sPort.x = 100;
		sPort.y = 100;
		sPort.alpha = 0;
		add(sPort);
		
		//YURI PORTS
		yPort = new Port('yuri');
		yPort.x = 100;
		yPort.y = 67;
		yPort.alpha = 0;
		add(yPort);

		//NATSUKI PORTS
		nPort = new Port('natsuki');
		nPort.x = 100;
		nPort.y = 130;
		nPort.alpha = 0;
		add(nPort);

		bfStandIn = new FlxSprite(85, 216);
		bfStandIn.frames = Paths.getSparrowAtlas('game/dokiUI/portraits/Local boyfriend watches his girlfriends head fall off');
		bfStandIn.animation.addByPrefix('oh damn', 'Local boyfriend watches his girlfriends head fall off', 24, true);
		bfStandIn.animation.play("oh damn");
		bfStandIn.visible = false;
		bfStandIn.flipX = true;
		add(bfStandIn);

		gfStandIn = new FlxSprite(657, 114);
		gfStandIn.frames = Paths.getSparrowAtlas('game/dokiUI/portraits/Her head falls the fuck off');
		gfStandIn.animation.addByPrefix('oh damn', 'Her Head Falls The Fuck Off', 24, true);
		gfStandIn.animation.play("oh damn");
		gfStandIn.visible = false;
		add(gfStandIn);

		bgFadeOut = new FlxSprite(-100, -50).makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);
		bgFadeOut.alpha = 0;
		add(bgFadeOut);

		boxName = new Port('names');
		boxName.x = 0;
		boxName.y = 40;
		boxName.alpha = 0;
		boxName.screenCenter(X);
		add(boxName);

		add(box);

		//box.animation.play('normalOpen');

		box.screenCenter(X);
		portraitLeft.screenCenter(X);

		console = new FlxSprite().makeGraphic(480, 180, 0xFF000000);
		console.alpha = 0.6;
		console.visible = false;
		add(console);

		consoleText = new FlxTypeText(10, 10, 440, "", 18);
		consoleText.setFormat(Paths.font("console.ttf"), 18, FlxColor.WHITE, LEFT);
		consoleText.visible = false;
		add(consoleText);

		dropText = new FlxText(142, 612, Std.int(FlxG.width * 0.75), "", 32);
		dropText.setFormat(Paths.font("doki.ttf"), 32, FlxColor.BLACK, LEFT);
		dropText.visible = false;
		add(dropText);
		
		swagDialogue = new FlxTypeText(140, 510, Std.int(FlxG.width * 0.75), "", 40);
		swagDialogue.setFormat(Paths.font("doki.ttf"), 32, FlxColor.WHITE, LEFT);
		swagDialogue.borderColor = 0xFF000000;
		swagDialogue.borderStyle = OUTLINE;
		swagDialogue.borderSize = 1.5;
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);

		add(bgTrans);

		end = new FlxSprite(0, 0).loadGraphic(Paths.image('game/dokiUI/bg/end'));
		end.alpha = 0;
		add(end);

	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
		{
			if (headFallTest)
				{
					bfStandIn.x = xTest.value;
					bfStandIn.y = yTest.value;
					bfStandIn.flipX = flip.checked;
					if (FlxG.keys.pressed.Z)
						{
							xTest.stepSize = 50;
							yTest.stepSize = 50;
						}
					else
						{
							xTest.stepSize = 1;
							yTest.stepSize = 1;
						}
				}
			// HARD CODING CUZ IM STUPDI
			if (PlayState.SONG.song.toLowerCase() == 'roses')
				portraitLeft.visible = false;
			if (PlayState.SONG.song.toLowerCase() == 'thorns')
			{
				portraitLeft.color = FlxColor.BLACK;
				swagDialogue.color = FlxColor.WHITE;
				dropText.color = FlxColor.BLACK;
			}
	
			dropText.text = swagDialogue.text;

			dialogueOpened = true;
	
			/*if (box.animation.curAnim != null)
			{
				if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
				{
					box.animation.play('normal');
					dialogueOpened = true;
				}
			}*/
	
			if (dialogueOpened && !dialogueStarted)
			{
				startDialogue();
				dialogueStarted = true;
			}
	
			//if (FlxG.keys.justPressed.SPACE && dialogueStarted == true && canSkip && !skipFastAndEatAss)
				//{
					//skipFastAndEatAss = true;

					//new FlxTimer().start(0.1, function(tmr:FlxTimer)
						//{
				
							//if (skipFastAndEatAss = false)
							//{
								//tmr.reset(0.1);
							//}
						//});
				//}

			/*if (FlxG.keys.justPressed.SPACE && dialogueStarted == true && canSkip)
				{
					isEnding = true;
	
					if (PlayState.SONG.song.toLowerCase() == 'spiders' || PlayState.SONG.song.toLowerCase() == 'bottles' || PlayState.SONG.song.toLowerCase() == 'raccoon' || PlayState.SONG.song.toLowerCase() == 'goodbye')
						FlxG.sound.music.fadeOut(2.2, 0);
						canSkip = false;

					new FlxTimer().start(0.5, function(tmr:FlxTimer)
					{
						boxName.visible = false;
						FlxTween.tween(bfPort, {alpha: 0}, 0.1);
						bfPortUp = false;
						FlxTween.tween(gfPort, {alpha: 0}, 0.1);
						gfPortUp = false;
						FlxTween.tween(mPort, {alpha: 0}, 0.1);
						mPortUp = false;
						FlxTween.tween(sPort, {alpha: 0}, 0.1);
						sPortUp = false;
						FlxTween.tween(yPort, {alpha: 0}, 0.1);
						yPortUp = false;
						FlxTween.tween(nPort, {alpha: 0}, 0.1);
						nPortUp = false;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}*/

			if (FlxG.keys.justPressed.ENTER && dialogueStarted == true && canSkip)
			{
				remove(dialogue);
				
	
				if (dialogueList[1] == null && dialogueList[0] != null)
				{
					if (!isEnding)
					{
						isEnding = true;
	
						if (PlayState.SONG.song.toLowerCase() == 'spiders' || PlayState.SONG.song.toLowerCase() == 'bottles' || PlayState.SONG.song.toLowerCase() == 'raccoon' || PlayState.SONG.song.toLowerCase() == 'goodbye')
							FlxG.sound.music.fadeOut(2.2, 0);
							canSkip = false;

						new FlxTimer().start(0.5, function(tmr:FlxTimer)
						{
							boxName.visible = false;
							FlxTween.tween(bfPort, {alpha: 0}, 0.1);
							bfPortUp = false;
							FlxTween.tween(gfPort, {alpha: 0}, 0.1);
							gfPortUp = false;
							FlxTween.tween(mPort, {alpha: 0}, 0.1);
							mPortUp = false;
							FlxTween.tween(sPort, {alpha: 0}, 0.1);
							sPortUp = false;
							FlxTween.tween(yPort, {alpha: 0}, 0.1);
							yPortUp = false;
							FlxTween.tween(nPort, {alpha: 0}, 0.1);
							nPortUp = false;
						}, 5);
	
						new FlxTimer().start(1.2, function(tmr:FlxTimer)
						{
							finishThing();
							kill();
						});
					}
				}
				else
				{
					dialogueList.remove(dialogueList[0]);
					startDialogue();
				}
			}
			
			super.update(elapsed);
		}

	var isEnding:Bool = false;

	public function startDialogue():Void
	{
		var skipDialogue = false;
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		//Listen, I know there are a lot of conditions and I could make it easyer on myself and make it more optimised, but I don't see you dialogue system doing the things this one can do, so sit down, and ignore the fact that there is way to much code.

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.03, true);

		callEffect = false;

		switch (curCharacter)
		{
			case 'bf':
				portThing = bfPort;
				boxName.playFrame('bf');
				boxName.alpha = 1;
			case 'gf':
				portThing = gfPort;
				boxName.playFrame('gf');
				boxName.alpha = 1;
			case 'm':
				portThing = mPort;
				boxName.playFrame('m');
				boxName.alpha = 1;
			case 's':
				portThing = sPort;
				boxName.playFrame('s');
				boxName.alpha = 1;
			case 'y':
				portThing = yPort;
				boxName.playFrame('y');
				boxName.alpha = 1;
			case 'n':
				portThing = nPort;
				boxName.playFrame('n');
				boxName.alpha = 1;
			default:
				callEffect = true;
		}

		if (!callEffect)
			{
				if (face != '')
					portThing.playFrame(face);
				if (chars != '')
					{
						if (portThing.shown)
							{
								FlxTween.tween(portThing, {x: ((1280 / (Std.parseInt(chars) + 1)) * Std.parseInt(pos) - (portThing.width / 2))}, 0.2, {ease: FlxEase.quadInOut, type: ONESHOT});
							}
						else
							{
								portThing.x = ((1280 / (Std.parseInt(chars) + 1)) * Std.parseInt(pos) - (portThing.width / 2));
								FlxTween.tween(portThing, {alpha: 1}, 0.2);
								portThing.shown = true;
							}
					}
				if (effect != '')
					{
						if (effect == 'hide')
							{
								FlxTween.tween(portThing, {alpha: 0}, 0.1);
								portThing.shown = false;
							}
						if (effect == 'hideinstant')
							{
								portThing.alpha = 0;
								portThing.shown = false;
							}
						if (effect == 'left')
							{
								portThing.flipX = true;
							}
		
						if (effect == 'right')
							{
								portThing.flipX = false;
							}
						
						if (effect == 'jump')
							{
								FlxTween.tween(portThing, {y: portThing.y - 30}, 0.15, {ease: FlxEase.quadOut, type: ONESHOT});
								FlxTween.tween(portThing, {y: 220}, 0.15, {ease: FlxEase.quadIn, type: ONESHOT, startDelay: 0.15});
							}
					}
				if (dialogueList[0] == '')
					{
						dialogueList.remove(dialogueList[0]);
						startDialogue();
					}
			}
		else
			{
				switch (curCharacter)
				{
					case 'playsound':
						FlxG.sound.play(Paths.sound('dialogue/'+face), 1);
						dialogueList.remove(dialogueList[0]);
						startDialogue();
					case 'playmusic':
						FlxG.sound.music.loadEmbedded(Paths.music('dialogue/'+face));
						FlxG.sound.music.play();
						dialogueList.remove(dialogueList[0]);
						startDialogue();
					case 'musicfadeout':
						if (FlxG.sound.music != null)
							FlxG.sound.music.fadeOut(1, 0);
						dialogueList.remove(dialogueList[0]);
						startDialogue();
					case 'bg':
						bg.loadGraphic(Paths.image('game/dokiUI/bg/'+face), false);
						dialogueList.remove(dialogueList[0]);
						startDialogue();
					case 'fade':
						switch (face)
						{
							case 'in':
								boxName.alpha = 0;
								FlxTween.tween(bgTrans, {alpha: 0}, 1);
								new FlxTimer().start((1.5), function(tmr:FlxTimer)
									{
										dialogueList.remove(dialogueList[0]);
										startDialogue();
										boxName.alpha = 1;
										canSkip = true;
									});
							default:
								canSkip = false;
								boxName.alpha = 0;
								FlxTween.tween(bgTrans, {alpha: 1}, 1, {startDelay: 0.5,});
								dialogueList.remove(dialogueList[0]);
								startDialogue();
						}
					case 'fadesudden':
						bgTrans.alpha = 1;
						canSkip = false;
						boxName.alpha = 0;
						dialogueList.remove(dialogueList[0]);
						startDialogue();
					case 'wait':
						canSkip = false;
						boxName.alpha = 0;
						new FlxTimer().start(Std.parseInt(face), function(tmr:FlxTimer)
							{
								dialogueList.remove(dialogueList[0]);
								startDialogue();
								canSkip = true;
								boxName.alpha = 1;
							});
					case 'crashthefumpinggame':
						//#if FEATURE_FILESYSTEM
						//Sys.exit(0);
						//#else
						//File.copy():"""
						dialogueList.remove(dialogueList[0]);
						startDialogue();
						//#end
					case 'start':
					canSkip = false;
					boxName.alpha = 0;
					bgTrans.alpha = 1;
					FlxTween.tween(bgTrans, {alpha: 0}, 1, {startDelay: 20,});
					new FlxTimer().start(1, function(tmr:FlxTimer)
						{
							FlxG.sound.play(Paths.sound('dialogue/escape_sound'), 1);
						});
					new FlxTimer().start(22, function(tmr:FlxTimer)
						{
							dialogueList.remove(dialogueList[0]);
							startDialogue();
							canSkip = true;
							boxName.alpha = 1;
							FlxG.sound.playMusic(Paths.music('dialogue/where_she_took_them'));
						});
					case 'herheadfallsoff':
						boxName.alpha = 0;
						bfPort.alpha = 0;
						gfPort.alpha = 0;
						bfPort.shown = false;
						gfPort.shown = false;
						bfStandIn.visible = true;
						gfStandIn.visible = true;
						bfStandIn.animation.play('oh damn', true);
						gfStandIn.animation.play('oh damn', true);
						new FlxTimer().start(1.2, function(tmr:FlxTimer)
							{
								FlxG.sound.music.stop();
								FlxG.sound.play(Paths.sound('dialogue/gf_actualy_dies'), 1);
							});
						new FlxTimer().start(4.5, function(tmr:FlxTimer)
							{
								remove(bfStandIn);
								remove(gfStandIn);
							});
						new FlxTimer().start(2.4, function(tmr:FlxTimer)
							{
								dialogueList.remove(dialogueList[0]);
								startDialogue();
							});

						//headFallTest = true;
						//gfPort.alpha = 0;
						//gfPort.shown = false;
						//bfStandIn.alpha = 0.5;
						//gfStandIn.visible = true;
						//FlxG.mouse.visible = true;
						//add(xTest);
						//add(yTest);
						//add(flip);
					//case 'screentear':
						//var glitchEffect:FlxGlitchEffect = new FlxGlitchEffect(10, 2, 0.05, HORIZONTAL);
						//var glitchSprite:FlxEffectSprite = new FlxEffectSprite(PlayState.doof, [glitchEffect]);
					//case 'radfile':
						//I litteraly hate you all. You know who you are and what you did to me.
						//makeFuniFile(face);
					//case 'rotate':
						//FlxTween.tween(FlxG.camera.screen, {angle: 10}, 1);
					//case 'resetcam':
						//FlxG.camera.screen.angle = 0;
				}
			}
		}
	
	public function makeFuniFile(fileName:String):Void
		{
			//First, we have to use limes Assets to get the txt version of the .png out of the embeded folder...
			//Then we copy some random ass file from the non-embeded game directory so the game has a file to edit because haxe is dumb sometimes
			File.copy('assets/shared/images/bad.png', 'assets/'+fileName+'.png');
			//FINALY WE WRITE THE STING TO THE PNG FILE TO CHANGE IT TO WHAT WE WANT
			File.saveContent('assets/'+fileName+'.png', Assets.getText('assets/embeded/images/'+fileName+'.txt'));
		}

	public function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		face = splitName[2];
		chars = splitName[3];
		pos = splitName[4];
		effect = splitName[5];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + splitName[2].length + splitName[3].length + splitName[4].length + splitName[5].length + 6).trim();
	}
}
