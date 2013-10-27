
package python.lib;


extern class FuncTools {

	public static function cmp_to_key<A>(f:A->A->Int):Dynamic;

	static function __init__ ():Void {
		Macros.importAs("functools", "python.lib.FuncTools");
	}

}