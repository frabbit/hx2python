
package python;

@:native("List")
extern class NativeList<T> implements ArrayAccess<T> {

	public var length (get_length, null):Int;

	private inline function get_length ():Int return untyped len(this);

	public function append (x:T):Void {}

	
	
}