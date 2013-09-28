package;
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

    public static inline function is( v : Dynamic, t : Dynamic ) : Bool {
        return untyped __is__(v , t);  //TODO(av) macro to check t is a Type and not null as dart only perfomrs "is" at compile time despite having a runtime Type
    }

//    public static inline function instance<T>( v : {}, c : Class<T> ) : T {
//        return untyped __as__(v, c);
//    }

    public static inline function string( s : Dynamic ) : String {
        return untyped s.toString();
    }

   public static inline function int( x : Float ) : Int {
        return untyped x.toInt(); //x.toInt() prob not needed
    }

    public static inline function parseInt( x : String ) : Null<Int> {
        return untyped __int_parse__(x);
    }

    public static inline function parseFloat( x : String ) : Float {
        return untyped __double_parse__(x);
    }

    public static inline function random( x : Int ) : Int {
        return dart.Lib.random(x);
//        return untyped __cascade__(new dartt.math.Random(), nextInt(x));// //untyped x <= 0 ? 0 : Math.floor(Math.random()*x);        import 'dart:marth'; new Random()..nextInt(x);
    }
}
