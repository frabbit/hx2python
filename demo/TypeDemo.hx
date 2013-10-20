
package ;

import Tools.*;

import Types;


@:keep private class MyClass {
	public var foo : Int = 1;

	@:isVar public var foo2(get, null) : Int = 1;

	public function get_foo2() return foo2;

	static var bar : Int = 10;
	public function new () {}
}

class Foo {
	public var z : Int = 5;

}


class TypeDemo {

	public static function main () {

		

		highlight(createInstance, "createInstance");
		highlight(typeOfInt, "typeOfInt");
		highlight(typeOfBool, "typeOfBool");
		highlight(typeOfFloat, "typeOfFloat");
		highlight(typeOfString, "typeOfString");
		highlight(typeOfStructure, "typeOfStructure");
		highlight(typeOfEnum, "typeOfEnum");
		highlight(typeOfClass, "typeOfClass");

		highlight(getInstanceFields, "getInstanceFields");
		highlight(getClassFields, "getClassFields");

	}

	public static function getInstanceFields () {
		var a = new MyClass();

		trace(Type.getInstanceFields(Type.getClass(a)));	
	}
	public static function getClassFields () {
		var a = new MyClass();
		trace(Type.getClassFields(Type.getClass(a)));
	}
		

	public static function createInstance () 
	{
		var f:Foo = Type.createEmptyInstance(Foo);

		log(Std.is(f, Foo));
		
		var f2 = Type.createInstance(Foo,[]);

		log(f2.z);
	}

	public static function typeOfInt ()  {
		log(Type.typeof(1));
	}

	public static function typeOfBool ()  {
		log(Type.typeof(true));
	}

	public static function typeOfFloat () 
	{
		log(Type.typeof(1.1));
	}
	public static function typeOfString () 
	{
		log(Type.typeof("foo"));
	}
	public static function typeOfStructure () 
	{	
		log(Type.typeof({ x : "hey", y : 17}));
	}
	public static function typeOfEnum () 
	{
		log(Type.typeof(Dollar));
	}
	public static function typeOfClass () 
	{
		log(Type.typeof(new ClassA()));
	}

}