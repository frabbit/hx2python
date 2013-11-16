package python;


import haxe.macro.Expr;

import haxe.macro.Context;



class Macros {

	@:noUsing macro public static function importModule (module:String):haxe.macro.Expr {
		return macro untyped __python__($v{"import " + module});
	}

	@:noUsing macro public static function importAs (module:String, className : String):haxe.macro.Expr {
        
        var n = className.split(".").join("_");

        var e = "import " + module + " as " + n;

	    return macro untyped __python__($v{e});
    }

    @:noUsing macro public static function pyFor (e:Expr, it:Expr, body:Expr):haxe.macro.Expr {
        return macro untyped __python_for__($e, $it, $body);
    }

    @:noUsing macro public static function importFromAs (from:String, module:String, className : String):haxe.macro.Expr {
        
        var n = className.split(".").join("_");

        var e = "from " + from + " import " + module + " as " + n;

	    return macro untyped __python__($v{e});
    }

    #if !macro macro #end public static function callNamed (e:Expr, args:Expr):haxe.macro.Expr {
        var fArgs = switch (Context.typeof(e)) {
            case TFun(args, ret): args;
            case _ : haxe.macro.Context.error("e must be of type function", e.pos);
        }
        switch (args.expr) {
            case EObjectDecl(fields):
                for (f in fields) {
                    var found = false;
                    for (a in fArgs) {
                        found = a.name == f.field;
                        if (found) break;
                    }
                    if (!found) {
                        haxe.macro.Context.error("field " + f.field + " is not a valid argument (valid names " + [for (a in fArgs) a.name].join(",") + ")", args.pos);   
                    }
                }
                // TODO check at least if fields are valid (maybe if types match);
            case _ : haxe.macro.Context.error("args must be an ObjectDeclaration like { name : 1 }", args.pos);
        }
        return macro @:pos(e.pos) untyped __named__($e, $args);
    }


}