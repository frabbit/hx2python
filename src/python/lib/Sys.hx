
package python.lib;

import python.lib.Types;





extern class Sys {

	public static function exit (x:Int):Void;

	public static var stdout(default, never):FileObject;

	
	static function __init__ ():Void 
	{
		python.Macros.importAs("sys", "python.lib.Sys");
	}
	
}
