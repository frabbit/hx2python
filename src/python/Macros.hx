
package python;

class Macros {

	macro public static function importModule (module:String):haxe.macro.Expr {
		return macro untyped __python__($v{"import " + module});
	}

	macro public static function importAs (module:String, className : String):haxe.macro.Expr {
        
        var n = className.split(".").join("_");

        var e = "import " + module + " as " + n;

	    return macro untyped __python__($v{e});
    }

    macro public static function importFromAs (from:String, module:String, className : String):haxe.macro.Expr {
        
        var n = className.split(".").join("_");

        var e = "from " + from + " import " + module + " as " + n;

	    return macro untyped __python__($v{e});
    }

}