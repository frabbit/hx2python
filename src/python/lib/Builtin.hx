
package python.lib;


import python.lib.Types;




@:native("__builtin__")
extern class Builtin {

	static function __init__ ():Void {
		python.Macros.importAs("builtins", "__builtin__");
	}

	@:overload(function (f:Int):Int {})
	public static function abs(x:Float):Float;
	public static function all(i:Iterable<Bool>):Bool;
	public static function any(i:Iterable<Bool>):Bool;

	public static function bool(x:Dynamic):Bool;

	public static function issubclass(x:Class<Dynamic>, from:Class<Dynamic>):Bool;
	public static function callable(x:Dynamic):Bool;

	public static function isinstance(obj:Dynamic, cl:Class<Dynamic>):Bool;

	public static function hasattr(obj:Dynamic, attr:String):Bool;
	public static function getattr(obj:Dynamic, attr:String):Dynamic;
	@:overload(function (f:Set<Dynamic>):Int {})
	@:overload(function (f:List<Dynamic>):Int {})
	@:overload(function (f:Array<Dynamic>):Int {})
	@:overload(function (f:Dict<Dynamic, Dynamic>):Int {})
	public static function len(x:String):Int;

	//public static function divmod():Void;
	//public static function input():Void;
	//public static function open():Void;
	//public static function staticmethod():Void;
	//public static function enumerate():Void;
	//public static function int():Void;
	//public static function ord():Void;
	public static inline function str(o:Dynamic):String {
		return untyped __python__("__builtin__.str")(o);
	}
	//public static function eval():Void;
	
	//public static function pow():Void;
	//public static function sum():Void;
	//public static function basestring():Void;
	//public static function execfile():Void;
	
	public static inline function print(o:Dynamic):Void {
		untyped __python__("__builtin__.print")(o);
	}
	
	//public static function super():Void;
	//public static function bin():Void;
	//public static function file():Void;
	//public static function iter():Void;
	//public static function property():Void;
	//public static function tuple():Void;

	
	//public static function filter():Void;
	
	//public static function range():Void;
	//public static function type():Void;
	//public static function bytearray():Void;
	//public static function float():Void;
	//public static function list():Void;
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
	//public static function max():Void;
	//public static function reversed():Void;
	//public static function zip():Void;
	//public static function compile():Void;
	
	//public static function memoryview():Void;
	//public static function round():Void;
	//public static function __import__():Void;
	//public static function complex():Void;
	//public static function hash():Void;
	//public static function min():Void;
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
	//public static function id():Void;
	//public static function oct():Void;
	//public static function sorted():Void;
	//public static function intern():Void;

}