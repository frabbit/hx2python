
package python.lib;

extern class StartupInfo {
	public var dwFlags : Int;

}

class Subprocess {

	public static function STARTUPINFO():StartupInfo {

	}

	//public static var STD_INPUT_HANDLE;
	//public static var STD_OUTPUT_HANDLE;
	//public static var STD_ERROR_HANDLE;
	//public static var SW_HIDE;
	//public static var STARTF_USESTDHANDLES;
	//public static var STARTF_USESHOWWINDOW;

	//public static var CREATE_NEW_CONSOLE;

	//public static var CREATE_NEW_PROCESS_GROUP;

	public static var PIPE:Dynamic;

	public static var STDOUT:Dynamic;	

	static function __init__ ():Void 
	{
		python.Macros.importAs("subprocess", "python.lib.Subprocess");
	}
}