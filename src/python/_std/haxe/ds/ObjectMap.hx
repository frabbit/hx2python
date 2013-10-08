package haxe.ds;

import python.lib.Builtin;

class ObjectMap<K:{},V> implements Map.IMap<K, V> {
	
	static var count = 0;
	
	static inline function assignId(obj: { } ):Int {
		return untyped obj._hx_id__ = ++count;
	}
	
	static inline function getId(obj: { } ):Int {
		return untyped obj._hx_id__;
	}
	
	var h : { };

	
	public function new() : Void {
		h = { };
		untyped h._hx_keys__ = { };
	}
	
	public function set(key:K, value:V):Void untyped {
		var id = key._hx_id__ != null ? key._hx_id__ : assignId(key);
		h[id] = value;
		h._hx_keys__[id] = key;
	}
	
	public inline function get(key:K):Null<V> untyped {
		return untyped h[getId(key)];
	}
	
	public inline function exists(key:K):Bool {
		//return Builtin.hasattr(h, getId(key));
		return throw "not implemented";
	}
	
	public function remove( key : K ) : Bool {
		
		//var id = getId(key);
		//if ( !Builtin.hasattr(h, id) ) return false;
		//untyped  __python__("del h[id]");
		//untyped  __python__("del h._hx_keys__[id]");
		//return true;
		return throw "not implemented";
	}
	
	public function keys() : Iterator<K> {
		//var a = [];
		//
		//untyped __python__("for key in self.h._hx_keys__:");
		//untyped __python__("	a.append(self.h._hx_keys__[key])");
		//
		//return a.iterator();
		return throw "not implemented";
	}
	
	public function iterator() : Iterator<V> {
		//var iter = keys();
		//var ref = h;
		//return {
		//	hasNext : function() { return iter.hasNext(); },
		//	next : function() { var i = iter.next(); return ref[getId(i)]; }
		//};
		return throw "not implemented";
	}
	
	public function toString() : String {
		var s = new StringBuf();
		s.add("{");
		var it = keys();
		for( i in it ) {
			s.add(Std.string(i));
			s.add(" => ");
			s.add(Std.string(get(i)));
			if( it.hasNext() )
				s.add(", ");
		}
		s.add("}");
		return s.toString();
	}
}