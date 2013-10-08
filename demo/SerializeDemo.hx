
package ;

class A {
	public var x : Int = 10;

	public function new () {}
}

class SerializeDemo {

	public static function main () {
		var o = { age : 17, name : "jim", drinks: 3.5 };


		var s = haxe.Serializer.run(o);

		trace("after serialize: ");
		trace(s);
		var o2:{ age:Int, name:String, drinks:Float} = haxe.Unserializer.run(s);

		//trace(python.lib.Inspect.getmembers(o2,function (_) return true));
		trace("after unserialize: ");
		trace(o2.age);
		trace(o2.name);
		trace(o2.drinks);

		var s2 = haxe.Serializer.run(o2);

		trace("after serialized again: ");
		trace(s2);

		var cl = new A();

		var cl1 = haxe.Serializer.run(cl);

		var c2:A = haxe.Unserializer.run(cl1);

		trace(c2.x);

	}

}