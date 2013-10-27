
package python.lib;

typedef WrappedString = String;

extern class Codecs {

	public static function open(filename:String, mode:String, ?encoding:String, ?errors:String, ?buffering:Bool):WrappedString;

	static function __init__ ():Void {
		Macros.importAs("codecs", "python.lib.Codecs");
	}
}