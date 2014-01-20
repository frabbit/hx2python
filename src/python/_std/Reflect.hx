import Map;
import haxe.ds.StringMap;
import python.internal.KeywordHandler;
import python.lib.Builtin;
import python.lib.Inspect;
import python.lib.Types;



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
@:coreApi class Reflect {

	public static function hasField( o : Dynamic, field : String ) : Bool 
	{
		var field = KeywordHandler.handleKeywords(field);
		//return untyped __js__('Object').prototype.hasOwnProperty.call(o, field);
		return Builtin.hasattr(o, field);
		
	}

	public static function field( o : Dynamic, field : String ) : Dynamic 
	{
		var field = KeywordHandler.handleKeywords(field);	
		return if (Builtin.hasattr(o, field)) Builtin.getattr(o, field) else null;
		
	}

	public inline static function setField( o : Dynamic, field : String, value : Dynamic ) : Void untyped 
	{
		var field = KeywordHandler.handleKeywords(field);
		return __define_feature__("Reflect.setField",Builtin.setattr(o,field,value));
	}

	public static function getProperty( o : Dynamic, field : String ) : Dynamic 
	{
		var field = KeywordHandler.handleKeywords(field);
		//var tmp;
		//return if( o == null ) __define_feature__("Reflect.getProperty",null) else if( o.__properties__ && (tmp=o.__properties__["get_"+field]) ) o[tmp]() else o[field];
		var tmp = null;
		if (o == null) {
			return null;
		} else {
			tmp = Reflect.field(o, "get_" + field);
			if (tmp != null && Builtin.callable(tmp)) {
				return tmp();
			} else {
				return Reflect.field(o, field);
			}
		}
		//return if (o == null) null else if ( (tmp=Reflect.field(o, "get_" + field)) != null && Builtin.callable(tmp)) tmp() else Reflect.field(o, field);
	}

	public static inline function setProperty( o : Dynamic, field : String, value : Dynamic ) : Void untyped {
		
		/*
		if (hasattr(o,"set_"+field)) {
			var tmp = getattr(o,"set_"+field);
			tmp(value);
		}
		else setattr(o,field, __define_feature__("Reflect.setProperty",value));
		*/
		var field = KeywordHandler.handleKeyword(field);
		return throw "not implemented";
	}

	public static function callMethod( o : Dynamic, func : Dynamic, args : Array<Dynamic> ) : Dynamic 
	{
		var args:VarArgs = args;
		return if (Builtin.callable(func)) func(untyped __python_varargs__(args)) else null;
	}

	public static function fields( o : Dynamic ) : Array<String> 
	{
		var a = [];
		if (o != null) 
		{
			if (Builtin.hasattr(o, "_hx_fields")) 
			{
				
				var fields:Array<String> = o._hx_fields;
				return fields.copy();
			}
			if (Builtin.isinstance(o, untyped __python__("_hx_c._hx_AnonObject"))) 
			{
				
				var d:Dict<String, Dynamic> = Builtin.getattr(o, "__dict__");
				var keys  = d.keys();
				var handler = python.internal.KeywordHandler.unhandleKeywords;
				untyped __python__("for k in keys:");
				untyped __python__("	a.append(handler(k))");
				
			} 
			else if (Builtin.hasattr(o, "__dict__")) 
			{
				var a = [];
				var d:Dict<String, Dynamic> = Builtin.getattr(o, "__dict__");
				var keys  = untyped d.keys();
				untyped __python__("for k in keys:");
				untyped __python__("	a.append(k)");

			}
		}
		return a;

	}

	public static function isFunction( f : Dynamic ) : Bool 
	{
		return Inspect.isfunction(f) || Inspect.ismethod(f);
	}

	public static function compare<T>( a : T, b : T ) : Int {
		return if (a == null) 1 else if (b == null) -1 else
		( a == b ) ? 0 : (((cast a) > (cast b)) ? 1 : -1);
		//return throw "not implemented";
	}

	public static function compareMethods( f1 : Dynamic, f2 : Dynamic ) : Bool {
		if( f1 == f2 )
			return true;
		if( !isFunction(f1) || !isFunction(f2) )
			return false;
		
		return throw "not implemented";
	}

	public static function isObject( v : Dynamic ) : Bool untyped {

		// if( v == null )
		// 	return false;
		// var t = __js__("typeof(v)");
		// return (t == "string" || (t == "object" && v.__enum__ == null)) || (t == "function" && (js.Boot.isClass(v) || js.Boot.isEnum(v)) != null);
		return throw "not implemented";
	}
	
	public static function isEnumValue( v : Dynamic ) : Bool {
		//return v != null && v.__enum__ != null;
		return throw "not implemented";
	}

	public static function deleteField( o : Dynamic, field : String ) : Bool untyped {
		if( !hasField(o,field) ) return false;
		untyped __python_del__(untyped __python_array_get__(o, field));
		return true;
	}

	public static function copy<T>( o : T ) : T {
		// var o2 : Dynamic = {};
		// for( f in Reflect.fields(o) )
		// 	Reflect.setField(o2,f,Reflect.field(o,f));
		// return o2;
		return throw "not implemented";
	}

	@:overload(function( f : Array<Dynamic> -> Void ) : Dynamic {})
	public static function makeVarArgs( f : Array<Dynamic> -> Dynamic ) : Dynamic {
		return throw "not implemented";
		
	}

}