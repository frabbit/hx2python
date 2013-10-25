
package python.lib;

extern class PPrint {

	
	public static function pprint (x:Dynamic):Void;

	static function __init__ ():Void {
		python.Macros.importAs("pprint", "python.lib.PPrint");
	}

}