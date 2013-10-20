
package python.lib;

extern class Time {

	public static function time ():Int;

	static function __init__ ():Void 
	{
		python.Macros.importAs("time", "python.lib.Time");
	}
}