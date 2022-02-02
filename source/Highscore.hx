package;

import flixel.FlxG;

class Highscore
{
	#if (haxe >= "4.0.0")
	public static var songScores:Map<String, Int> = new Map();
	#else
	public static var songScores:Map<String, Int> = new Map<String, Int>();
	#end


	public static function saveScore(song:String, score:Int = 0, ?diff:Int = 0, ?act2:Bool = false):Void
	{
		var daSong:String = formatSong(song, diff, act2);

		if (songScores.exists(daSong))
		{
			if (songScores.get(daSong) < score)
				setScore(daSong, score);
		}
		else
			setScore(daSong, score);
	}

	public static function saveWeekScore(week:Int = 1, score:Int = 0, ?diff:Int = 0, ?act2:Bool = false):Void
	{
		var daWeek:String = formatSong('week' + week, diff, act2);

		if (songScores.exists(daWeek))
		{
			if (songScores.get(daWeek) < score)
				setScore(daWeek, score);
		}
		else
			setScore(daWeek, score);
	}

	/**
	 * YOU SHOULD FORMAT SONG WITH formatSong() BEFORE TOSSING IN SONG VARIABLE
	 */
	static function setScore(song:String, score:Int):Void
	{
		// Reminder that I don't need to format this song, it should come formatted!
		songScores.set(song, score);
		FlxG.save.data.songScores = songScores;
		FlxG.save.flush();
	}

	public static function formatSong(song:String, diff:Int, act2:Bool):String
	{
		var daSong:String = song;

		if (diff == 0)
			daSong += '-easy';
		else if (diff == 2)
			daSong += '-hard';

		if (act2)
			daSong += '-2';
		else
			daSong += '-1';

		return daSong;
	}

	public static function getScore(song:String, diff:Int, act2:Bool):Int
	{
		if (!songScores.exists(formatSong(song, diff, act2)))
			setScore(formatSong(song, diff, act2), 0);

		return songScores.get(formatSong(song, diff, act2));
	}

	public static function getWeekScore(week:Int, diff:Int, act2:Bool):Int
	{
		if (!songScores.exists(formatSong('week' + week, diff, act2)))
			setScore(formatSong('week' + week, diff, act2), 0);

		return songScores.get(formatSong('week' + week, diff, act2));
	}

	public static function load():Void
	{
		if (FlxG.save.data.songScores != null)
		{
			songScores = FlxG.save.data.songScores;
		}
	}
}
