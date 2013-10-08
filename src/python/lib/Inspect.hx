
package python.lib;

import python.Macros;

@:native("_hx_inspect")
extern class Inspect {

	static function __init__ ():Void 
	{
		python.Macros.importAs("sys", "python.lib.Inspect");
	}

	static function getmembers (value:Dynamic, filter:Dynamic->Bool):Bool;
	static function ismethod (value:Dynamic):Bool;
	static function isclass (value:Dynamic):Bool;

	static function isfunction(value:Dynamic):Bool;

	
	static function __init__ ():Void {
		Macros.importAs("inspect", "_hx_inspect");
	}
}