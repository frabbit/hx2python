
package python;

class Boot {

	static inline function isClass(o:Dynamic) : Bool {
        return untyped __define_feature__("python.Boot.isClass", o._hx_class);
    }

	@:ifFeature("has_enum")
	private static function __string_rec(o,s:String) {
		untyped {
			
			if( o == null ) return "null";
			
			if( s.length >= 5 ) return "<...>"; // too much deep recursion
			
			var builtin = python.lib.Builtin;

			if (builtin.isinstance(o, String)) return o;

			if (builtin.isinstance(o, untyped __python__("bool"))) {
				if (o) return "true" else return "false";
			}
			if (builtin.isinstance(o, untyped __python__("int"))) {
				return builtin.str(o);
			}
			if (builtin.isinstance(o, untyped __python__("float"))) {
				return builtin.str(o);
			}
			

			if (builtin.callable(o) && !builtin.hasattr(o, "__class__")) return "<function>";
			
			
			
			if (builtin.isinstance(o, Array)) 
			{
			
				var l = o.length;
				
				var st = "[";
				s += "\t";
				for( i in 0...l ) {
					prefix = "";
					if (i > 0) {
						prefix = ",";
					}
					st += prefix + __string_rec(o[i],s);
				}
				st += "]";
				return st;
			}
			if (builtin.hasattr(o, "__class__")) 
			{

				if (builtin.isinstance(o, untyped __python__("AnonObject"))) 
				{
					var toStr = null;
					try 
					{
						toStr = untyped o.toString();
					} 
					catch (e:Dynamic) {}

					if (toStr == null) 
					{
						return "{ ... }";	
					} 
					else 
					{
						return toStr;	
					}
					
				}
				if (builtin.isinstance(o, untyped __python__("Enum"))) {
					

					var l = builtin.len(o.params);
					var hasParams = l > 0;
					if (hasParams) {
						var paramsStr = "";
						for (i in 0...l) {
							prefix = "";
							if (i > 0) {
								prefix = ",";
							}
							paramsStr += prefix + __string_rec(o.params[i],s);
						}
						return o.tag + "(" + paramsStr + ")";
					} else {
						return o.tag;
					}
					
					
				}


				if (builtin.hasattr(o, "_hx_class_name")) {
					
					return o._hx_class_name;
				}
				if (o == String) {
					return "String";
				}
				//builtin.print(builtin.str(python.lib.Inspect.getmembers(o, function (_) return true)));
				return o.__class__.__name__;



			} else {
				try {
					python.lib.Inspect.getmembers(o, function (_) return true);
					return python.lib.Builtin.str(o);
				} catch (e:Dynamic) {
					return "???";
				}
			}

			/*
			var t = __js__("typeof(o)");
			if( t == "function" && (isClass(o) || isEnum(o)) )
				t = "object";
			switch( t ) {
			case "object":
				if( __js__("o instanceof Array") ) {
					if( o.__enum__ ) {
						if( o.length == 2 )
							return o[0];
						var str = o[0]+"(";
						s += "\t";
						for( i in 2...o.length ) {
							if( i != 2 )
								str += "," + __string_rec(o[i],s);
							else
								str += __string_rec(o[i],s);
						}
						return str + ")";
					}
					var l = o.length;
					var i;
					var st = "[";
					s += "\t";
					for( i in 0...l )
						st += (if (i > 0) "," else "")+__string_rec(o[i],s);
					st += "]";
					return str;
				}
				var tostr;
				try {
					tostr = untyped o.toString;
				} catch( e : Dynamic ) {
					// strange error on IE
					return "???";
				}
				if( tostr != null && tostr != __js__("Object.toString") ) {
					var s2 = o.toString();
					if( s2 != "[object Object]")
						return s2;
				}
				var k : String = null;
				var st = "{\n";
				s += "\t";
				var hasp = (o.hasOwnProperty != null);
				__js__("for( var k in o ) { ");
					if( hasp && !o.hasOwnProperty(k) )
						__js__("continue");
					if( k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__" )
						__js__("continue");
					if( st.length != 2 )
						st += ", \n";
					st += s + k + " : "+__string_rec(o[k],s);
				__js__("}");
				s = s.substring(1);
				st += "\n" + s + "}";
				return st;
			default:
				return String(o);
			}
			*/
		}
	}

}