
package ;

import Tools.highlight;

import Types;

class SerializeDemo {

	public static function main () {

		highlight(serializeEnum, "serializeEnum");
		highlight(serializeClass, "serializeClass");
		highlight(serializeStructure, "serializeStructure");

	}

	

	static function serializeStructure () 
	{
		var o = { age : 17, name : "jim", drinks: 3.5 };

		var s = haxe.Serializer.run(o);

		
		trace(s);
		var o2:{ age:Int, name:String, drinks:Float} = haxe.Unserializer.run(s);

		//trace(python.lib.Inspect.getmembers(o2,function (_) return true));
		
		trace(o2.age);
		trace(o2.name);
		trace(o2.drinks);

		var s2 = haxe.Serializer.run(o2);

		
		trace(s2);
	}

	static function serializeEnum () 
	{
		var x = Euro;

		var s = haxe.Serializer.run(x);
		trace(s);
		var u = haxe.Unserializer.run(s);
		var s2 = haxe.Unserializer.run(s);

		trace(s);
		trace(s2);

		trace(x);
		trace(u);

		var x = bits.EnumDemo.One;

		var s = haxe.Serializer.run(x);
		trace(s);
		var u = haxe.Unserializer.run(s);
		var s2 = haxe.Unserializer.run(s);		

		trace(s);
		trace(s2);

		trace(x);
		trace(u);

	}

	static function serializeClass () 
	{
		var cl = new ClassA();

		var cl1 = haxe.Serializer.run(cl);

		var c2:ClassA = haxe.Unserializer.run(cl1);

		trace(c2.x);
	}

}