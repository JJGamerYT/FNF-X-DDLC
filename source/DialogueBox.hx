package;

//import sys.io.File;
import flixel.group.FlxGroup;
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
import flixel.system.FlxSound;
#if sys
import sys.io.File;
import sys.FileSystem;
import flixel.addons.plugin.screengrab.FlxScreenGrab;
#end

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;
	var boxName:FlxSprite;

	var fileString:String = 'ha ha gf funkin dies.mp4';

	var curCharacter:String = '';
	var face:String = '';
	var chars:String = '';
	var pos:String = '';
	var effect:String = '';

	var dialogue:Alphabet;
	public var dialogueList:Array<String> = [];
	public var skipDialogueList:Array<String> = [];

	var skipCheck:Bool = false;
	var inSkipDialogue:Bool = false;

	var dokiDialog:Bool = false;

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var bgTrans:FlxSprite;

	var console:FlxSprite;
	var consoleText:FlxTypeText;
	var consoleShown:Bool = false;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var bg:FlxSprite;
	var end:FlxSprite;
	var vignette:FlxSprite;

	var musicPlaying:String = '';
	var musicTime:Float;

	var bgFade:FlxSprite;

	var bgFadeOut:FlxSprite;

	var canSkip:Bool = true;
	var skipFastAndEatAss:Bool = false;
	var textSpeed:Float = 0.03;
	var paused:Bool = false;

	private var sounds:FlxSound;
	private var music:FlxSound;

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

	var layerBG:FlxSpriteGroup;
	var layerPorts:FlxSpriteGroup;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>, ?bg:String)
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

		if (PlayState.SONG.song.toLowerCase() == 'goodbye')
			skipDialogueList = CoolUtil.coolTextFile(Paths.txt('goodbye/skip'));

		bgTrans = new FlxSprite(-100, -50).makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);

		if (PlayState.SONG.song.toLowerCase() == 'spiders')
			{
				bgTrans.alpha = 0;
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
			//}

		var box:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('game/textBox'));
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

		//BG AND MUSIC
		this.bg = new FlxSprite(0, 0);
		this.bg.loadGraphic(Paths.image('game/dokiUI/bg/' + bg), false);
		/*if (PlayState.SONG.song.toLowerCase() == 'cool-test' || PlayState.SONG.song.toLowerCase() == 'spiders')
			{
				this.bg.loadGraphic(Paths.image('game/dokiUI/bg/class'), false);
			}
		else
			{
				this.bg.loadGraphic(Paths.image('game/dokiUI/bg/club'), false);
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
			}*/
		
		layerBG = new FlxSpriteGroup();
		layerBG.add(this.bg);
		add(layerBG);

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
		mPort.y = 70;
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
		bfStandIn.animation.addByPrefix('oh damn', 'Local boyfriend watches his girlfriends head fall off', 12, true);
		bfStandIn.animation.play("oh damn");
		bfStandIn.visible = false;
		bfStandIn.flipX = true;
		add(bfStandIn);

		gfStandIn = new FlxSprite(657, 114);
		gfStandIn.frames = Paths.getSparrowAtlas('game/dokiUI/portraits/Her head falls the fuck off');
		gfStandIn.animation.addByPrefix('oh damn', 'Her Head Falls The Fuck Off', 12, true);
		gfStandIn.animation.play("oh damn");
		gfStandIn.visible = false;
		add(gfStandIn);

		layerPorts = new FlxSpriteGroup();

		layerPorts.add(gfPort);
		layerPorts.add(bfPort);
		layerPorts.add(mPort);
		layerPorts.add(sPort);
		layerPorts.add(yPort);
		layerPorts.add(nPort);
		layerPorts.add(bfStandIn);
		layerPorts.add(gfStandIn);

		add(layerPorts);

		bgFadeOut = new FlxSprite(-100, -50).makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);
		bgFadeOut.alpha = 0;
		add(bgFadeOut);

		boxName = new FlxSprite(140, 435);
		boxName.loadGraphic(Paths.image('game/dokiUI/boxNames'), true, 153, 86);
		boxName.animation.add('bf', [0], 0, false);
		boxName.animation.add('gf', [1], 0, false);
		boxName.animation.add('m', [2], 0, false);
		boxName.animation.add('s', [3], 0, false);
		boxName.animation.add('y', [4], 0, false);
		boxName.animation.add('n', [5], 0, false);
		boxName.animation.play("bf");
		boxName.alpha = 0;
		add(boxName);

		// HEIGHT:153 WIDTH:86

		add(box);

		//box.animation.play('normalOpen');

		box.screenCenter(X);

		console = new FlxSprite().makeGraphic(480, 180, 0xFF000000);
		console.alpha = 0.6;
		console.visible = false;
		add(console);

		consoleText = new FlxTypeText(10, 10, 440, "", 16);
		consoleText.setFormat(Paths.font("console.ttf"), 16, FlxColor.WHITE, LEFT);
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

		vignette = new FlxSprite(0, 0).loadGraphic(Paths.image('game/dokiUI/bg/vignette'));
		vignette.setGraphicSize(Std.int(FlxG.width));
		vignette.alpha = 0;
		add(vignette);

		//sounds = new FlxSound();
		//music = new FlxSound();

		//FlxG.sound.list.add(sounds);
		//FlxG.sound.list.add(music);

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

			if (FlxG.keys.justPressed.SPACE && dialogueStarted == true && !inSkipDialogue)
				{
					if (skipCheck)
						{
							dialogueList = skipDialogueList;
							inSkipDialogue = true;
							startDialogue();
						}
					else
						{
							if (!canSkip && skipFastAndEatAss)
								skipFastAndEatAss = false;
							else if (canSkip)
								skipFastAndEatAss = !skipFastAndEatAss;
						}
				}

			if (skipFastAndEatAss && canSkip)
				{
					swagDialogue.completeCallback = resetDialogue;
					textSpeed = 0.01;
				}
			else
				{
					swagDialogue.completeCallback = null;
					textSpeed = 0.03;
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

			if ((FlxG.keys.justPressed.ENTER || skipFastAndEatAss) && dialogueStarted == true && canSkip)
			{
				remove(dialogue);
				
	
				if (dialogueList[1] == null && dialogueList[0] != null)
				{
					if (!isEnding)
					{
						isEnding = true;
	
						//if (PlayState.SONG.song.toLowerCase() == 'spiders' || PlayState.SONG.song.toLowerCase() == 'bottles' || PlayState.SONG.song.toLowerCase() == 'raccoon' || PlayState.SONG.song.toLowerCase() == 'goodbye')
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

	function resetDialogue()
		{
			dialogueList.remove(dialogueList[0]);
			startDialogue();
		}

	public function startDialogue():Void
	{
		var skipDialogue = false;
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);


		//Ok, let me pose a quick question, how is it that all other dialogue systems in fnf either get nowhere close to what I got here, or kinda do what I got here, but completely fail to condence it down and make it optimised?
		//Like, I don't mean to flex on ya'll, but FIVE FIELDS to fill out, along with not having to have all the ports in different xml files. Tweening. That's what makes this swag.


		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(textSpeed, true);

		callEffect = false;

		switch (curCharacter)
		{
			case 'bf':
				portThing = bfPort;
				boxName.animation.play('bf');
				boxName.alpha = 1;
			case 'gf':
				portThing = gfPort;
				boxName.animation.play('gf');
				boxName.alpha = 1;
			case 'm':
				portThing = mPort;
				boxName.animation.play('m');
				boxName.alpha = 1;
			case 's':
				portThing = sPort;
				boxName.animation.play('s');
				boxName.alpha = 1;
			case 'y':
				portThing = yPort;
				boxName.animation.play('y');
				boxName.alpha = 1;
			case 'n':
				portThing = nPort;
				boxName.animation.play('n');
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
						if (effect == 'glitch')
							{
								var glitchEffect:FlxGlitchEffect = new FlxGlitchEffect(10, 2, 0.05, HORIZONTAL);
								var glitchSprite:FlxEffectSprite = new FlxEffectSprite(portThing, [glitchEffect]);
								glitchSprite.x = portThing.x;
								glitchSprite.y = portThing.y;
								if (curCharacter == 'gf')
									{
										add(glitchSprite);
										new FlxTimer().start(0.5, function(tmr:FlxTimer)
											{
												remove(glitchSprite);
											});
									}
								else
									{
										layerPorts.add(glitchSprite);
										new FlxTimer().start(0.5, function(tmr:FlxTimer)
											{
												layerPorts.remove(glitchSprite);
											});
									}
							}
					}
				if (dialogueList[0] == '')
					{
						resetDialogue();
					}
			}
		else
			{
				switch (curCharacter)
				{
					case 'playsound':
						FlxG.sound.play(Paths.sound('dialogue/'+face), 1);
						resetDialogue();
					case 'playmusic':
						musicPlaying = face;
						musicTime = Std.parseFloat(chars);
						FlxG.sound.music.loadEmbedded(Paths.music('dialogue/'+face));
						FlxG.sound.music.looped = true;
						if (chars != null)
							FlxG.sound.music.loopTime = Std.parseFloat(chars);
						FlxG.sound.music.play();
						resetDialogue();
					case 'musicfadeout':
						if (FlxG.sound.music != null)
							FlxG.sound.music.fadeOut(1, 0);
						resetDialogue();
					case 'muteall':
						FlxG.sound.music.volume = 0;
						resetDialogue();
					case 'bg':
						bg.loadGraphic(Paths.image('game/dokiUI/bg/'+face), false);
						resetDialogue();
					case 'edited':
						swagDialogue.setFormat(Paths.font("edited.otf"), 32, FlxColor.WHITE, LEFT);
						swagDialogue.borderColor = 0xFF000000;
						swagDialogue.borderStyle = OUTLINE;
						swagDialogue.borderSize = 5;
						resetDialogue();
					case 'normal':
						swagDialogue.setFormat(Paths.font("doki.ttf"), 32, FlxColor.WHITE, LEFT);
						swagDialogue.borderColor = 0xFF000000;
						swagDialogue.borderStyle = OUTLINE;
						swagDialogue.borderSize = 1.5;
						resetDialogue();
					case 'fade':
						switch (face)
						{
							case 'in':
								boxName.alpha = 0;
								FlxTween.tween(bgTrans, {alpha: 0}, 1);
								new FlxTimer().start((1.5), function(tmr:FlxTimer)
									{
										resetDialogue();
										boxName.alpha = 1;
										canSkip = true;
									});
							default:
								canSkip = false;
								boxName.alpha = 0;
								FlxTween.tween(bgTrans, {alpha: 1}, 1, {startDelay: 0.5,});
								resetDialogue();
						}
					case 'fadesudden':
						bgTrans.alpha = 1;
						canSkip = false;
						boxName.alpha = 0;
						console.visible = false;
						consoleText.visible = false;
						resetDialogue();
					case 'fadesuddenin':
						bgTrans.alpha = 0;
						canSkip = true;
						boxName.alpha = 1;
						console.visible = false;
						consoleText.visible = false;
						resetDialogue();
					case 'wait':
							{
								canSkip = false;
								boxName.alpha = 0;
								new FlxTimer().start(Std.parseFloat(face), function(tmr:FlxTimer)
									{
										resetDialogue();
										canSkip = true;
										boxName.alpha = 1;
									});
							}
					case 'monikaskipcheck':
						skipFastAndEatAss = false;
						skipCheck = true;
						resetDialogue();
					case 'console':
						console.visible = true;
						consoleText.visible = true;
						boxName.alpha = 0;
						canSkip = false;
						new FlxTimer().start(1, function(tmr:FlxTimer)
							{
								consoleText.resetText(face);
								consoleText.start(0.03, true);
								resetDialogue();
							});
					case 'hideconsole':
						console.visible = false;
						consoleText.visible = false;
						resetDialogue();
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
							resetDialogue();
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
						resetDialogue();
						new FlxTimer().start(1.2, function(tmr:FlxTimer)
							{
								FlxG.sound.music.stop();
								FlxG.sound.play(Paths.sound('dialogue/gf_actualy_dies'), 1);
							});
						new FlxTimer().start(2, function(tmr:FlxTimer)
							{
								remove(bfStandIn);
								remove(gfStandIn);
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

					case 'gfheadglitch':
						resetDialogue();
						new FlxTimer().start(0.6, function(tmr:FlxTimer)
							{
								canSkip = false;
								FlxG.sound.music.stop();
								FlxG.sound.music.loadEmbedded(Paths.sound('dialogue/gf_head_glitch'));
								FlxG.sound.music.looped = true;
								FlxG.sound.music.loopTime = 4618;
								FlxG.sound.music.play();
								gfPort.x = (1280 / (4 + 1)) * 3 - (gfPort.width / 2);
								gfPort.flipX = true;
								gfPort.alpha = 1;
								gfPort.playFrame('G');
								bfPort.playFrame('G');
								vignette.alpha = 0.5;
								new FlxTimer().start(0.75, function(tmr:FlxTimer)
									{
										canSkip = true;
										gfPort.alpha = 0;
										vignette.alpha = 0;
										FlxG.sound.music.stop();
										FlxG.sound.music.looped = true;
										FlxG.sound.music.loopTime = musicTime;
										FlxG.sound.music.loadEmbedded(Paths.music('dialogue/' + musicPlaying));
										FlxG.sound.music.play();
										resetDialogue();
									});
							});
					case 'beginact2':
						//Setin' up the stuff for the next act
						FlxG.save.data.act2 = true;
						FlxG.save.data.overallMisses = PlayStateChangeables.overallMisses;
						FlxG.save.data.shitRatings = PlayStateChangeables.shitRatings;
						if (PlayState.storyDifficulty == 2)
							FlxG.save.data.act1OnHard = true;
						var spSong:Int = FlxG.random.int(0, 2);
						switch (spSong)
							{
								case 0:
									FlxG.save.data.spSong = 'spiders';
								case 1:
									FlxG.save.data.spSong = 'bottles';
								case 2:
									FlxG.save.data.spSong = 'raccoon';
							}
						FlxTransitionableState.skipNextTransIn = true;
						FlxTransitionableState.skipNextTransOut = true;
						FlxG.switchState(new FuniError());
					case 'screentear':
						canSkip = false;
						var glitchEffect:FlxGlitchEffect = new FlxGlitchEffect(10, 2, 0.05, HORIZONTAL);
						var glitchSprite:FlxEffectSprite = new FlxEffectSprite(bg, [glitchEffect]);
						layerBG.add(glitchSprite);
							new FlxTimer().start(0.5, function(tmr:FlxTimer)
								{
									layerBG.remove(glitchSprite);
									resetDialogue();
									canSkip = true;
								});
					case 'fadeover':
						FlxTween.tween(bgFadeOut, {alpha: 1}, 1);
						resetDialogue();
					case 'end':
						canSkip = false;
						FlxTween.tween(end, {alpha: 1}, 1);
						new FlxTimer().start(3, function(tmr:FlxTimer)
							{
								FlxTween.tween(end, {alpha: 0}, 1);
								new FlxTimer().start(3, function(tmr:FlxTimer)
									{
										finishThing();
										kill();
									});
							});


				}
			}
		}

	public function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		//dialogueList[0] = StringTools.replace(dialogueList[0].substr(splitName[1].length + splitName[2].length + splitName[3].length + splitName[4].length + splitName[5].length + 6).trim(), '{Your IP address here}', Sys.environment()["USERNAME"]);
		face = splitName[2];
		chars = splitName[3];
		pos = splitName[4];
		effect = splitName[5];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + splitName[2].length + splitName[3].length + splitName[4].length + splitName[5].length + 6).trim();
	}
}
