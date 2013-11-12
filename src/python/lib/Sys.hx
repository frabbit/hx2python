
package python.lib;

import python.lib.io.RawIOBase;
import python.lib.io.TextIOBase;
import python.lib.Types;





extern class Sys {

	public static function exit (x:Int):Void;

	public static function getfilesystemencoding():String;

	public static var stdout(default, never):TextIOBase;

	
	static function __init__ ():Void 
	{
		python.Macros.importAs("sys", "python.lib.Sys");
	}
	
}
