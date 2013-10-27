
package python.lib;

class ThreadLowLevel {

	static function __init__ ():Void 
	{
		python.Macros.importAs("_thread", "python.lib.ThreadLowLevel");
	}

}