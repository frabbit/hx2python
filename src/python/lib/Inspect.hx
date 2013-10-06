
package python.lib;

extern class Inspect {

	static function __init__ ():Void 
	{
		python.Macros.importAs("sys", "python.lib.Inspect");
	}

	static function ismethod (value:Dynamic):Bool {

	}

	

}