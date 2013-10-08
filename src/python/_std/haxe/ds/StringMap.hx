package haxe.ds;

import python.lib.Types.Dict;

class StringMap<T> implements Map.IMap<String, T> {
	private var h : Dict<String,T>;

	public function new() : Void {
		h = untyped __python__("{}");
	}

	public function set( key : String, value : T ) : Void {
		untyped h["$"+key] = value;
	}

	public function get( key : String ) : Null<T> {
		return untyped h.get("$"+key, null);
	}

	public function exists( key : String ) : Bool {
		return untyped h.get("$"+key, null) == null;
	}

	public function remove( key : String ) : Bool {
		key = "$"+key;

		if( untyped h.get("$"+key, null) == null ) return false;
		untyped __python__("del h[key]");
		return true;
	}

	public function keys() : Iterator<String> {
		
		var a = [];
		
		untyped __python__("for key in self.h:");
		untyped __python__("	a.append(self.h[key[1:]])");
		
		return a.iterator();
	}
	public function iterator() : Iterator<T> {
		var iter = keys();
		var ref = h;
		return {
			hasNext : function() { return iter.hasNext(); },
			next : function() { var i = iter.next(); return untyped ref["$" + i]; }
		};
	}
	
	public function toString() : String {
		var s = new StringBuf();
		s.add("{");
		var it = keys();
		for( i in it ) {
			s.add(i);
			s.add(" => ");
			s.add(Std.string(get(i)));
			if( it.hasNext() )
				s.add(", ");
		}
		s.add("}");
		return s.toString();
	}
}