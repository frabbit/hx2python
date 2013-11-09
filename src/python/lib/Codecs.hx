
package python.lib;

import python.lib.Types.FileObject;


extern class Codecs {

	public static function open(filename:String, mode:String, ?encoding:String, ?errors:String, ?buffering:Bool):FileObject;

	static function __init__ ():Void {
		Macros.importAs("codecs", "python.lib.Codecs");
	}
}