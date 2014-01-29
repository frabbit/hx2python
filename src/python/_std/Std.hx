package;

import python.lib.Builtin;
import python.lib.Inspect;
import python.Boot;
/*
 * Copyright (C)2005-2012 Haxe Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */
//import flash.Boot;

@:keepInit
@:coreApi /*extern*/ class Std {

    public static inline function instance<T:{}, S:T>( value : T, c : Class<S> ) : S {
        try {
            return Builtin.isinstance(value,c) ? cast value : null;
        } catch (e:Dynamic) {
            return null;
        }


    }
    public static function is( v : Dynamic, t : Dynamic ) : Bool {

        if (v == null && t == null) {
            return false;
        }
        if (t == null) {

            return false;
        }
        if (t == (untyped __python__("Dynamic"))) {
            return true;
        }
        var isBool = Builtin.isinstance(v, (untyped __python__("bool")));

        if (t == (untyped __python__("Bool")) && isBool) {
            return true;
        }
        if (!isBool && t != (untyped __python__("Bool")) && t ==  (untyped __python__("Int")) && Builtin.isinstance(v, (untyped __python__("int")) )) {
            return true;
        }
        var vIsFloat = Builtin.isinstance(v, (untyped __python__("float")));

        if (!isBool && vIsFloat && t == (untyped __python__("Int")) && Math.isFinite(v) && v == Std.int(v)) {
            return true;
        }

        if (!isBool &&  t == (untyped __python__("Float")) && ( Builtin.isinstance(v, (untyped __python__("(float,int)"))))) {
            return true;
        }

        if ( t == (untyped __python__("str"))) {
            return Builtin.isinstance(v, String);
        }
        if (t == Enum && Inspect.isclass(v) && Builtin.hasattr(v, "_hx_constructs")) return true;

        if (t == Enum) return false;

        if (t == Date && Builtin.isinstance(v, Date)) return true;

        if (t == Date) return false;

        if (Builtin.isinstance(v, Date)) return false;

        if (t == Class && !Builtin.isinstance(v, untyped Enum) && Inspect.isclass(v) && Builtin.hasattr(v, "_hx_class_name") && !Builtin.hasattr(v, "_hx_constructs")) return true;

        if (t == Class) return false; // && !Builtin.isinstance(v, untyped Enum) && Builtin.hasattr(v, "__class__") && untyped Builtin.hasattr(v.__class__, "_hx_class_name") && !untyped Builtin.hasattr(v.__class__, "_hx_constructs")) return true;



        if (try Builtin.isinstance(v, t) catch (e:Dynamic) false) {
            return true;
        }
        if (Inspect.isclass(t)) {

            function loop (intf)
            {
                var f:Array<Dynamic> = Reflect.field(intf, "_hx_interfaces");
                if (f != null) {
                    for (i in f) {
                        if ( i == t) {
                            return true;
                        } else {
                            var l = loop(i);
                            if (l) {
                                return true;
                            }
                        }
                    }
                    return false;
                } else {
                    return false;
                }
            }
            return loop(untyped v.__class__);


        } else {
            return false;
        }
        //return untyped __is__(v , t);  //TODO(av) macro to check t is a Type and not null as dart only perfomrs "is" at compile time despite having a runtime Type
    }

//    public static inline function instance<T>( v : {}, c : Class<T> ) : T {
//        return untyped __as__(v, c);
//    }

    @:access(python.Boot)
    @:keep
    public static function string( s : Dynamic ) : String
    {

        return python.Boot.__string_rec(s, "");
    }

    public static inline function int( x : Float ) : Int
    {
        try {
            return (untyped __python__("int"))(x);
        } catch (e:Dynamic) {
            return null;
        }
    }

    public static function parseInt( x : String ) : Null<Int> {
        if (x == null) return null;
        try {
            return (untyped __python__("int"))(x);
        } catch (e:Dynamic) {
            try {
                var prefix = x.substr(0,2).toLowerCase();

                if (prefix == "0x") {
                    return (untyped __python__("int"))(x,16);
                }
                throw "fail";
            } catch (e:Dynamic) {


                var r = int(parseFloat(x));

                if (r == null) {
                    var r1 = shortenPossibleNumber(x);
                    if (r1 != x) {
                        return parseInt(r1);
                    } else {
                        return null;
                    }
                }
                return r;
            }
        }


    }

    static function shortenPossibleNumber (x:String):String
    {
        var r = "";
        for (i in 0...x.length) {
            var c = x.charAt(i);
            switch (c.charCodeAt(0)) {
                case "0".code
                | "1".code
                | "2".code
                | "3".code
                | "4".code
                | "5".code
                | "6".code
                | "7".code
                | "8".code
                | "9".code
                | ".".code : r += c;
                case _ : break;
            }
        }
        return r;
    }

    public static function parseFloat( x : String ) : Float
    {
        try {
            return untyped __python__("float")(x);
        } catch (e:Dynamic) {

            if (x != null) {
                var r1 = shortenPossibleNumber(x);
                if (r1 != x) {
                    return parseFloat(r1);
                }
            }
            return Math.NaN;

        }

    }


    public static inline function random( x : Int ) : Int {
        if (x <= 0) {
            return 0;
        } else {
            return int(Math.random()*x);
        }

        //return dart.Lib.random(x);
//        return untyped __cascade__(new dartt.math.Random(), nextInt(x));// //untyped x <= 0 ? 0 : Math.floor(Math.random()*x);        import 'dart:marth'; new Random()..nextInt(x);
    }
}
