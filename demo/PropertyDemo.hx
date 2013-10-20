
package ;

private class Foo {
	public function new () {}
	public var z(get, null) : Int = 5;

	public function get_z () return this.z;

}

interface A extends B {}
interface B {}
interface C extends A extends B {}
class Z implements A implements B implements C {
	public function new () {}

}

enum MyEnum {
	MyEnum1;
}

class PropertyDemo {

	public static function main () {
		Z;

		var x:Z = new Z();

		Std.is(x,A);
		var f = new Foo();
		

		trace(Std.is(1, Int));
		trace(Std.is(1, Float));
		trace(Std.is(1.1, Float));
		trace(Std.is(1.1, Int));

		var e1 = MyEnum1;
		trace(Std.is(e1, MyEnum));

		
		trace(f.z);


		trace(Std.is(x, A));
	}

}