package haxe.ds;

import python.lib.Types.Dict;

class IntMap<T> implements Map.IMap<Int, T> {
	private var h : Dict<Int, T>;

	public function new() : Void {
		h = untyped __python__("{}");
	}

	public function set( key : Int, value : T ) : Void {
		untyped h[key] = value;
	}

	public function get( key : Int ) : Null<T> {
		return untyped h[key];
	}

	public function exists( key : Int ) : Bool {
		return untyped h[key] != null;
	}

	public function remove( key : Int ) : Bool {
		

		if( untyped h[key] == null ) return false;
		untyped __python__("del h[key]");
		return true;
	}

	public function keys() : Iterator<Int> {
		var a = [];
		
		untyped __python__("for key in self.h:");
		untyped __python__("	a.append(self.h[key])");
		
		return a.iterator();
	}

	public function iterator() : Iterator<T> {
		var iter = keys();
		var ref = h;
		return {
			hasNext : function() { return iter.hasNext(); },
			next : function() { var i = iter.next(); return untyped ref[i]; }
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