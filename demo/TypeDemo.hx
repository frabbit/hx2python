
package ;

class Foo {
	public var z : Int = 5;

}

class TypeDemo {

	public static function main () {

		var f:Foo = Type.createEmptyInstance(Foo);

		trace(Std.is(f, Foo));
		
		var f2 = Type.createInstance(Foo,[]);

		trace(f2.z);

	}

}