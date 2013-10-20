import python.lib.Builtin;

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
enum ValueType {
	TNull;
	TInt;
	TFloat;
	TBool;
	TObject;
	TFunction;
	TClass( c : Class<Dynamic> );
	TEnum( e : Enum<Dynamic> );
	TUnknown;
}

@:coreApi class Type {

	public static function getClass<T>( o : T ) : Class<T> untyped {
		return throw "getClass not implemented";
	}

	public static function getEnum( o : EnumValue ) : Enum<Dynamic> untyped {
		if( o == null )
			return null;
		return untyped o.__class__;
	}

	public static function getSuperClass( c : Class<Dynamic> ) : Class<Dynamic> untyped {
		if( o == null )
			return null;
		var res = null;
		try {
			res = untyped __python_array_get(o.__bases__,0);
		} catch (e:Dynamic) {}
		return res;
	}


	public static function getClassName( c : Class<Dynamic> ) : String 
	{
		var res = null;
		trace(c);
		try {
			var s :String = untyped c.__name__;
			
			res = s.split("_").join(".");
			
			trace(res);
		} catch (e:Dynamic) {
			trace(e);
		}
		return res;
	}

	public static function getEnumName( e : Enum<Dynamic> ) : String {
		return untyped e._hx_class_name;
	}

	public static function resolveClass( name : String ) : Class<Dynamic> untyped {
		var cl : Class<Dynamic> = _hx_classes[name];
        // ensure that this is a class
        if( cl == null || !python.Boot.isClass(cl) )
                return null;
        return cl;

		//return throw "resolveClass not implemented";
	}

	public static function resolveEnum( name : String ) : Enum<Dynamic> untyped {
		return resolveClass(name);
	}

	public static function createInstance<T>( cl : Class<T>, args : Array<Dynamic> ) : T untyped 
	{
		var l = args.length;
		switch( l ) 
		{
			case 0:
				return __new__(cl);
			case 1:
				return __new__(cl,args[0]);
			case 2:
				return __new__(cl,args[0],args[1]);
			case 3:
				return __new__(cl,args[0],args[1],args[2]);
			case 4:
				return __new__(cl,args[0],args[1],args[2],args[3]);
			case 5:
				return __new__(cl,args[0],args[1],args[2],args[3],args[4]);
			case 6:
				return __new__(cl,args[0],args[1],args[2],args[3],args[4],args[5]);
			case 7:
				return __new__(cl,args[0],args[1],args[2],args[3],args[4],args[5],args[6]);
			case 8:
				return __new__(cl,args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7]);
			default:
				throw "Too many arguments";
		}
		return null;
	}

	public static function createEmptyInstance<T>( cl : Class<T> ) : T {
		return untyped cl.__new__(cl);
	}

	public static function createEnum<T>( e : Enum<T>, constr : String, ?params : Array<Dynamic> ) : T 
	{
		var f = Reflect.field(e,constr);
		if( f == null ) throw "No such constructor "+constr;
		if( Reflect.isFunction(f) ) {
			if( params == null ) throw "Constructor "+constr+" need parameters";
			return Reflect.callMethod(e,f,params);
		}
		if( params != null && params.length != 0 )
			throw "Constructor "+constr+" does not need parameters";
		return f;
	}

	public static function createEnumIndex<T>( e : Enum<T>, index : Int, ?params : Array<Dynamic> ) : T {
		var c : String = (untyped e.__constructs__)[index];
		if( c == null ) throw index+" is not a valid enum constructor index";
		return createEnum(e,c,params);
	}

	public static function getInstanceFields( c : Class<Dynamic> ) : Array<String> {
		// dict((name, getattr(f, name)) for name in dir(c) if not name.startswith('__'))
		return throw "getInstanceFields not implemented";
	}

	public static function getClassFields( c : Class<Dynamic> ) : Array<String> {
		return throw "getClassFields not implemented";
	}

	public static function getEnumConstructs( e : Enum<Dynamic> ) : Array<String> {
		return throw "getEnumConstructs not implemented";
	}

	/*
	enum ValueType {
	TNull;
	TInt;
	TFloat;
	TBool;
	TObject;
	TFunction;
	TClass( c : Class<Dynamic> );
	TEnum( e : Enum<Dynamic> );
	TUnknown;
}*/

	public static function typeof( v : Dynamic ) : ValueType {
		if (v == null) {
			return TNull;
		} else if (Builtin.isinstance(v, untyped __python__("bool") )) {
			return TBool;
		} else if (Builtin.isinstance(v, untyped __python__("int"))) {
			return TInt;
		} else if (Builtin.isinstance(v, untyped __python__("float"))) {
			return TFloat;
		} else if (Builtin.hasattr(v, "__class__")) {
			if (Builtin.isinstance(v, untyped __python__("AnonObject"))) {
				return TObject;
			}
			if (Builtin.isinstance(v, untyped __python__("Enum"))) {
				return TEnum(untyped v.__class__);	
			}
			return TClass(untyped v.__class__);
		} else if (Builtin.callable(v)) {
			return TFunction;
		} else {
			return TUnknown;
		}
	}

	public static function enumEq<T>( a : T, b : T ) : Bool {
		return throw "enumEq not implemented";
	}

	public inline static function enumConstructor( e : EnumValue ) : String {
		return throw "enumConstructor not implemented";
	}

	public inline static function enumParameters( e : EnumValue ) : Array<Dynamic> {
		return throw "enumParameters not implemented";
	}

	public inline static function enumIndex( e : EnumValue ) : Int {
		return throw "enumIndex not implemented";
	}

	public static function allEnums<T>( e : Enum<T> ) : Array<T> {
		return throw "allEnums not implemented";
	}

}
