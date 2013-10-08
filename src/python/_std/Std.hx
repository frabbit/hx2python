package;

import python.lib.Builtin;
import python.lib.Inspect;
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

    public static function is( v : Dynamic, t : Dynamic ) : Bool {
        if (v == null) {
            return false;
        }
        else if (t == null) {
            return false;
        }
        else if (t == untyped __python__("Dynamic")) {
            return true;
        }
        else if (t == untyped __python__("Int") && Builtin.isinstance(v, __python__("int"))) {
            return true;
        }
        else if (t == untyped __python__("Float") && (Builtin.isinstance(v, __python__("(float,int)")) || Builtin.isinstance(v, __python__("int")))) {
            return true;
        }
        else if (t == String) {
            return Builtin.isinstance(v, String);
        }
        else if (Builtin.isinstance(v, t)) {
            return true;
        } 
        else if (Inspect.isclass(t)) {
            
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

    @:keep public static function string( s : Dynamic ) : String {
        if (is(s, Int)) {
            return untyped str(s);
        }
        if (is(s, String)) {
            return s;
        }
        try {
            return untyped s.toString();
        } catch (e:Dynamic) {
            try {
                return untyped s.__str__();
            } catch(e:Dynamic) {
                try {
                    return untyped str(s);
                } catch(e:Dynamic) {
                    return "##Cannot convert to String##";
                }
            }
        }
    }

   public static inline function int( x : Float ) : Int {
        return untyped x.toInt(); //x.toInt() prob not needed
    }

    public static inline function parseInt( x : String ) : Null<Int> {
        
        return untyped int(untyped float(x));
        
    }

    public static inline function parseFloat( x : String ) : Float {
        return untyped float(x);
    }


    public static inline function random( x : Int ) : Int {
        return 1;
        //return dart.Lib.random(x);
//        return untyped __cascade__(new dartt.math.Random(), nextInt(x));// //untyped x <= 0 ? 0 : Math.floor(Math.random()*x);        import 'dart:marth'; new Random()..nextInt(x);
    }
}
