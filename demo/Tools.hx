
package ;

class Tools {

	public static function highlight (f:Void->Void, name : String) {
		log("------------------------------------------start " + name + "\n");
		f();
		log("------------------------------------------end " + name + "\n");
	}

	public static function log (f:Dynamic) {
		trace(Std.string(f));
	}

}