
package python;

class Boot {

	static inline function isClass(o:Dynamic) : Bool {
        return untyped __define_feature__("python.Boot.isClass", o._hx_class);
    }

	@:ifFeature("has_enum")
	private static function __string_rec(o:Dynamic,s:String):String {
		
		

		if (s == null) s = "";
		if( o == null ) return "null";
		
		if( s.length >= 5 ) return "<...>"; // too much deep recursion
		
		var builtin = python.lib.Builtin;
		var inspect = python.lib.Inspect;

		if (builtin.isinstance(o, String)) return o;

		if (builtin.isinstance(o, untyped __python__("bool"))) {
			if (untyped o) return "true" else return "false";
		}
		if (builtin.isinstance(o, untyped __python__("int"))) {
			return builtin.str(o);
		}
		if (builtin.isinstance(o, untyped __python__("float"))) {
			return builtin.str(o);
		}
		

		if (inspect.isfunction(o) || inspect.ismethod(o)) return "<function>";
		
		
		
		
		if (builtin.isinstance(o, Array)) 
		{
			var o1:Array<Dynamic> = o;
			var l = o1.length;
			
			var st = "[";
			s += "\t";
			for( i in 0...l ) {
				var prefix = "";
				if (i > 0) {
					prefix = ",";
				}
				st += prefix + __string_rec(o1[i],s);
			}
			st += "]";
			return st;
		}

		if (builtin.hasattr(o, "toString")) {
			return o.toString();
		}
		
		if (builtin.hasattr(o, "__class__")) 
		{

			if (builtin.isinstance(o, untyped __python__("_Hx_AnonObject"))) 
			{
				var toStr = null;
				try 
				{
					var fields = Reflect.fields(o);
					var fieldsStr = [for (f in fields) '$f : ${__string_rec(Reflect.field(o,f), s+"\t")}'];
					
					toStr = "{ " + fieldsStr.join(", ") + " }";
				} 
				catch (e:Dynamic) {
					trace(e);
				}

				if (toStr == null) 
				{
					return "{ ... }";	
				} 
				else 
				{
					return toStr;	
				}
				
			}
			if (builtin.isinstance(o, untyped __python__("_Hx_Enum"))) {
				
				

				var l = builtin.len(o.params);
				var hasParams = l > 0;
				if (hasParams) {
					var paramsStr = "";
					for (i in 0...l) {
						var prefix = "";
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


			if (builtin.hasattr(o, "_hx_class_name") && o.__class__.__name__ != "type") {

				var fields = Type.getInstanceFields(o);
				var fieldsStr = [for (f in fields) '$f : ${__string_rec(Reflect.field(o,f), s+"\t")}'];
					
				var toStr = o._hx_class_name + "( " + fieldsStr.join(", ") + " )";
				return toStr;
			}

			if (builtin.hasattr(o, "_hx_class_name") && o.__class__.__name__ == "type") {

				var fields = Type.getClassFields(o);
				var fieldsStr = [for (f in fields) '$f : ${__string_rec(Reflect.field(o,f), s+"\t")}'];
					
				var toStr = "#" + o._hx_class_name + "( " + fieldsStr.join(", ") + " )";
				return toStr;
			}
			if (o == String) {
				return "#String";
			}
			
			//if (builtin.hasattr(o, "_hx_name")) {
			//	return "#" + untyped o._hx_name;
			//}

			if (builtin.hasattr(o, "__repr__")) {
				return untyped o.__repr__();
			}

			if (builtin.hasattr(o, "__str__")) {
				return untyped o.__str__();
			}

			if (builtin.hasattr(o, "__name__")) {
				return untyped o.__name__;
			}
			return "???";

			
			



		} else {
			try {
				python.lib.Inspect.getmembers(o, function (_) return true);
				return python.lib.Builtin.str(o);
			} catch (e:Dynamic) {
				return "???";
			}
		}
	
	
			
		
	}

}