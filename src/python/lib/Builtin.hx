
package python.lib;


import python.lib.io.TextIOBase;
import python.lib.Types;




@:native("_hx_builtin")
extern class Builtin {

	

	@:overload(function (f:Int):Int {})
	public static function abs(x:Float):Float;
	public static function all(i:Iterable<Bool>):Bool;
	public static function any(i:Iterable<Bool>):Bool;

	public static function bool(x:Dynamic):Bool;

	public static function issubclass(x:Class<Dynamic>, from:Class<Dynamic>):Bool;
	public static function callable(x:Dynamic):Bool;


	

	@:overload(function (obj:Dynamic, f:Tuple<Dynamic>):Bool {})
	public static function isinstance(obj:Dynamic, cl:Class<Dynamic>):Bool;

	public static function hasattr(obj:Dynamic, attr:String):Bool;
	public static function getattr(obj:Dynamic, attr:String):Dynamic;
	
	@:overload(function (f:Set<Dynamic>):Int {})
	@:overload(function (f:StringBuf):Int {})
	@:overload(function (f:Array<Dynamic>):Int {})
	@:overload(function (f:Dict<Dynamic, Dynamic>):Int {})
	@:overload(function (f:Bytes):Int {})
	@:overload(function (f:DictView<Dynamic>):Int {})
	@:overload(function (f:Tuple<Dynamic>):Int {})
	public static function len(x:String):Int;

	public static function open(file:String, mode:String, ?encoding:String = null, ?errors : String, ?newline:String, ?closefd:Bool, ?opener:String->Int->FileDescriptor):TextIOBase;

	//public static function divmod():Void;
	//public static function input():Void;
	
	//public static function staticmethod():Void;
	//public static function enumerate():Void;

	public static function int(x:Dynamic):Int;
	//public static function ord():Void;
	public static inline function str(o:Dynamic):String {
		return untyped __field__(Builtin, "str")(o);
	}
	//public static function eval():Void;
	
	//public static function pow():Void;
	//public static function sum():Void;
	//public static function basestring():Void;
	//public static function execfile():Void;
	
	public static inline function print(o:Dynamic):Void {
		return untyped __field__(Builtin, "print")(o);
	}
	
	//public static function super():Void;
	//public static function bin():Void;
	//public static function file():Void;
	public static function iter<X>(d:DictView<X>):PyIterator<X>;
	//public static function property():Void;
	


	@:overload(function <X>():Tuple<X> {})
	public static function tuple<X>(a:Array<X>):Tuple<X>;

	
	
	
	//public static function range():Void;
	//public static function type():Void;
	//public static function bytearray():Void;
	//public static function float():Void;
	

	@:overload(function (f:String):Array<String> {})
	@:overload(function <G>(f:Tuple<G>):Array<G> {})
	public static function list<T>(i:PyIterable<T>):Array<T>;

	public static function filter<A>(f:A->Bool, i:Choice<Array<A>, PyIterable<A>>):PyIterator<A>;
	//public static function raw_input():Void;
	//public static function unichr():Void;
	
	//public static function format():Void;
	//public static function locals():Void;
	//public static function reduce():Void;
	//public static function unicode():Void;
	//public static function chr():Void;
	//public static function frozenset():Void;
	//public static function long():Void;
	//public static function reload():Void;
	//public static function vars():Void;
	//public static function classmethod():Void;
	
	public static function map<A,B>(fn:A->B, it:PyIterable<A>):PyIterator<B>;
	//public static function repr():Void;
	//public static function xrange():Void;
	//public static function cmp():Void;
	//public static function globals():Void;
	@:overload(function (a1:Float, a2:Float, ?a3:Float, ?a4:Float, ?a5:Float, ?a6:Float, ?a7:Float, ?a8:Float, ?a9:Float):Float {})
	public static function max(a1:Int, a2:Int, ?a3:Int, ?a4:Int, ?a5:Int, ?a6:Int, ?a7:Int, ?a8:Int, ?a9:Int):Int;
	//public static function reversed():Void;
	//public static function zip():Void;
	//public static function compile():Void;
	
	//public static function memoryview():Void;
	public static function round(f:Float):Int;
	//public static function __import__():Void;
	//public static function complex():Void;
	//public static function hash():Void;
	@:overload(function (a1:Float, a2:Float, ?a3:Float, ?a4:Float, ?a5:Float, ?a6:Float, ?a7:Float, ?a8:Float, ?a9:Float):Float {})
	public static function min(a1:Int, a2:Int, ?a3:Int, ?a4:Int, ?a5:Int, ?a6:Int, ?a7:Int, ?a8:Int, ?a9:Int):Int;
	//public static function set():Void;
	//public static function apply():Void;
	public static function delattr(o:Dynamic, attr:String):Void;
	//public static function help():Void;
	//public static function next():Void;
	public static function setattr(o:Dynamic, attr:String, val:Dynamic):Void;
	//public static function buffer():Void;
	//public static function dict():Void;
	//public static function hex():Void;
	//public static function object():Void;
	//public static function slice():Void;
	//public static function coerce():Void;
	//public static function dir():Void;
	public static function id(x:{}):Int;
	//public static function oct():Void;
	//public static function sorted():Void;
	//public static function intern():Void;
	static function __init__ ():Void {
		python.Macros.importAs("builtins", "python.lib.Builtin");
	}

}