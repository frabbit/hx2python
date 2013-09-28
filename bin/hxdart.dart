import 'dart:math';
main()=>Main.main();
class ArrayDemo
{
	
	ArrayDemo(  ) {
		print("ArrayDemo");
		new List();
		var a1 = [1, 2, 3];
		print(a1.toString());
		a1.add(4);
		print(a1.toString());
	}
	
}

class ControlFlowDemo
{
	
	ControlFlowDemo(  ) {
		this.NAMED_FUNCTION();
		var jimmy = 22;
		print("\n\n-------------CONDITIONAL---------------\n");
		if((ControlFlowDemo.STATIC_VAR == "staticVar")) print("STATIC_VAR == \"staticVar\" is true");  else {
			print("STATIC_VAR == \"staticVar\" is false");
			print("STATIC_VAR == \"staticVar\" is false");
		};
		print("\n\n-------------SWITCH---------------\n");
		jimmy = 33;
		switch (jimmy) {
			case 1:print("jimmy is 1"); break;
			case 3:print("jimmy is 3"); break;
			case 88:print("jimmy is 88"); break;
			case 33:print("jimmy is 33"); break;
			default: print("default: don\'t konw how old jimmy is");
		};
		print("\n\n-------------WHILE---------------\n");
		var count = 0;
		while((count++ < 3)) print("count = " + count.toString());
		print("\n\n-------------FOR---------------\n");
		{
			var _g = 0;
			while((_g < 3)) {
				var i = _g++;
				print("i = " + i.toString());
			};
		};
		print("-------------FOR OVER ITERTOR---------------");
		var it = [1, 2, 3, 4];
		{
			var _g = 0;
			while((_g < it.length)) {
				var i = it[_g];
				++_g;
				print(i.toString());
			};
		};
		print("\n\n-------------TRY CATCH: SUCCESS---------------\n");
		var str = "string";
		var x = "anotherString";
		var noError = ( a, b ) {
			return a + b;
		};
		try {
			noError(str, x);
			print("no error");
		} catch(e ) {
			print("error = " + e.toString());
		};
		print("\n\n-------------TRY CATCH: ERROR---------------\n");
		var str1 = "string";
		var x1 = 0;
		var causeError = ( a, b ) {
			return a + b;
		};
		try {
			causeError(str1, x1);
			print("no error");
		} catch(e ) {
			print("error = " + e.toString());
		};
	}
	static var STATIC_VAR = "staticVar";
	NAMED_FUNCTION(  ) {
	}
	
	
}

class Main
{
	static main (  ) {
		new StringDemo();
		new ControlFlowDemo();
		new StdDemo();
		new ArrayDemo();
	}
	
}

class Std
{
	static int ( x ) {
		return x.toInt();
	}
	static parseInt ( x ) {
		return int.parse(x);
	}
	
}

class StdDemo
{
	
	StdDemo(  ) {
		print("\n\n-------------Std.is---------------\n");
		var isIt = ("someString" is String);
		print("Std.is(\'someString\', String\') = " + isIt.toString());
		print("Std.is(12, String\') = " + (12 is String).toString());
		var baseClass = new bits_BaseClass();
		var aClass = new bits_AClass();
		var bClass = new bits_BClass();
		print("Std.is(baseClass, BaseClass) = " + (baseClass is bits_BaseClass).toString());
		print("Std.is(aClass, BaseClass) = " + (aClass is bits_BaseClass).toString());
		print("Std.is(bClass, InterfaceDemo) = " + (bClass is bits_InterfaceDemo).toString());
		print("Std.is(baseClass, String) = " + (baseClass is String).toString());
		print("\n\n-------------Std.int----4.12345-----------\n");
		var float = 4.12345;
		print("4.12345 Std.int(float) = " + float.toInt().toString());
		print("\n\n-------------Std.int----some string-----------\n");
		var dynamicString = "someString";
		try {
			Std.int(dynamicString);
		} catch(e ) {
			print("Std.int(dynamicString) error = " + e.toString());
		};
		print("\n\n-------------Std.parseInt----\'123\'-----------\n");
		var stringInt = "123";
		print("123 : Std.parseInt(stringInt) = " + int.parse("123").toString());
		print("\n-------------Std.parseInt----\'12.345\'-----------\n");
		var stringFloat = "12.345";
		try {
			int.parse(stringFloat);
		} catch(e ) {
			print("12.345 : Std.parseInt(stringFloat) error = " + e.toString());
		};
		print("\n-------------Std.parseInt----\'abc\'-----------\n");
		var abc = "abc";
		try {
			int.parse(abc);
		} catch(e ) {
			print("abc : Std.parseInt(abc) error = " + e.toString());
		};
		print("\n-------------Std.parseInt----dybamicBool-----------\n");
		var dybamicBool = true;
		try {
			Std.parseInt(dybamicBool);
		} catch(e ) {
			print("dybamicBool : Std.parseInt(dybamicBool) error = " + e.toString());
		};
		print("\n\n-------------Std.parseFloat----\'12.345\'-----------\n");
		var stringFloat1 = "12.345";
		print("12.345 : Std.parseInt(stringFloat) = " + double.parse(stringFloat1).toString());
		print("\n\n-------------Std.random----30-----------\n");
		var rand = dart_Lib.random(30);
		print("Std.random(30) = " + dart_Lib.random(30).toString());
	}
	
}

class StringDemo
{
	
	StringDemo(  ) {
		var someString = "someString";
		var inferredString = "inferredString";
		var nullString = null;
		print("\n\n-------------String-----------\n");
		print("someString.charAt(2) = " + someString[2].toString());
		assert(someString[2] == "m");
		var charCode = someString.codeUnitAt(5);
		print("someString.charCodeAt(5) = " + charCode.toString());
		print("inferredString.substr(3, 3) = " + inferredString.substring(3, 6).toString());
		print("inferredString.substr(3) = " + inferredString.substring(3, inferredString.length - 3).toString());
		print("inferredString.substring(3, 7) = " + inferredString.substring(3, 7).toString());
		print("inferredString.substring(6) = " + inferredString.substring(6, null).toString());
		print("String.fromCharChode   NOT IMPLEMENTED YET !!!!! ");
	}
	
}

class bits_BaseClass
{
	
	bits_BaseClass(  ) {
		print("BaseClass::new");
		if((bits_BaseClass._instances == null)) bits_BaseClass._instances = 0;  ;
		bits_BaseClass._instances++;
		this._count = 0;
		bits_BaseClass.UninitialisedStaticVar = 1.234;
	}
	static var UninitialisedStaticVar;
	static var _instances;
	var _count;
	
}

class bits_AClass extends bits_BaseClass
{
	
	bits_AClass(  ) {
		;
	}
	
}

abstract class bits_InterfaceDemo
{
	
}

class bits_BClass extends bits_AClass implements bits_InterfaceDemo
{
	
	bits_BClass(  ) {
		;
		print("BClass::new");
		this.apiVar = true;
	}
	var apiVar;
	
}

class dart_Lib
{
	static random ( max ) {
		var r = new Random();
		return r.nextInt(max);
	}
	
}

