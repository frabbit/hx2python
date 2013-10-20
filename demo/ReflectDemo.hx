
package ;

import Types;

@:keep class MyClass {
	public var foo : Int = 1;

	static var bar : Int = 10;
	public function new () {}
}

class ReflectDemo {

	public static function main () {
		var o = { age : 17, name : "hey" };

		trace(Reflect.fields(o));

		Reflect.setField(o, "age", 22);

		trace(o.age);

		Reflect.setField(o, "name", "jimmy");

		//trace(Reflect.fields(o));

		trace(Reflect.field(o, "name"));

		trace(Reflect.field(o, "name_x"));
		
		trace(Reflect.getProperty(o, "name"));
		
		var tmp = 1;
		if (!(Reflect.getProperty(o, "name") == null)) {
			trace("hey");
		} else if (o.age > 10) {
			trace(tmp);
		} else {
			trace("whatever");
		}

		var a = new MyClass();

		trace(Reflect.fields(a));
		

	}

}