
package python.lib;


@:native("_hx_random")
extern class Random {

	public static function random ():Float;

	static function __init__ ():Void {
		Macros.importAs("random", "_hx_random");
	}

}