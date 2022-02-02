package;

import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;

class FuniError extends MusicBeatState
    {
        var exception:FlxSprite;

        //Monika! What did you do to the mod?
        //Oh, nothing, nothing. At least nothing you need to worry about!
        //Yeah real funny. What did you do.
        //Just took care of that Boyfriend characters little companion.
        //... wait what

        //GF IS FUCKING DEAD HOLY SHI-

        public function new()
            {
                super();

                FlxG.sound.music.stop();

                exception = new FlxSprite(0, 0).loadGraphic(Paths.image('exception'));
                add(exception);

                FlxG.sound.playMusic(Paths.music('exception'));
            }
    }