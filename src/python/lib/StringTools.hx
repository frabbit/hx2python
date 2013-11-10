
package python.lib;

import python.lib.Types.Bytes;

class StringTools {

	public static function format (s:String, args:Array<Dynamic>):String 
	{
		return untyped __python_varargs__(__field__(s, "format"), args);
	}

	public static function encode(s:String, encoding:String="utf-8", errors:String="strict"):Bytes {
		return untyped __field__(s, "encode")(encoding, errors);
	}

	public static inline function contains(s:String, e:String):Bool {
		return untyped __python_in__(e,s);
	}

	public static inline function strip(s:String, ?chars:String):String 
	{
		return untyped __field__(s, "strip")(chars);
	}


}