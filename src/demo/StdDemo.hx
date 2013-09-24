package demo;
import demo.bits.InterfaceDemo;
import demo.bits.BClass;
import demo.bits.AClass;
import demo.bits.BaseClass;
class StdDemo
{
    public function new()
    {
        trace("\n\n-------------Std.is---------------\n");

//Int, Float and Bool failing at the moment

        var isIt = Std.is("someString", String);

        trace("Std.is('someString', String') = " + isIt);
        trace("Std.is(12, String') = " + Std.is(12, String));

        var baseClass = new BaseClass();
        var aClass = new AClass();
        var bClass = new BClass();

        trace("Std.is(baseClass, BaseClass) = " + Std.is(baseClass, BaseClass));
        trace("Std.is(aClass, BaseClass) = " + Std.is(aClass, BaseClass));
        trace("Std.is(bClass, InterfaceDemo) = " + Std.is(bClass, InterfaceDemo));
        trace("Std.is(baseClass, String) = " + Std.is(baseClass, String));

//        trace("\n\n-------------Std.instance : suceesful cast---------------\n");
//
//        trace("Std.instance(baseClass, BaseClass) = " + Std.instance(baseClass, BaseClass));
//        trace("Std.instance(bClass, SomeInterface) = " + Std.instance(bClass, InterfaceDemo));
//
//        trace("\n\n-------------Std.instance : suceesful cast---------------\n");
//
//        var classDynamic:Dynamic = new BClass();
//        try
//        {
//            Std.instance(classDynamic, InterfaceDemo).doSomething();
//        }
//        catch(error:Dynamic)
//        {
//            trace("Std.instance(baseClass, Main) = error = " + error);
//        }

        trace("\n\n-------------Std.int----4.12345-----------\n");
//        Std.int(0.xxxx) is inlined by haxe compiler   and compiler catches non floats. Dynamic types throw runtime error
        var float = 4.12345;
        trace("4.12345 Std.int(float) = " + Std.int(float));

        trace("\n\n-------------Std.int----some string-----------\n");

        var dynamicString:Dynamic = "someString";

        try
        {
            Std.int(dynamicString);
        }
        catch(e:Dynamic)
        {
            trace("Std.int(dynamicString) error = " + e);
        }

        trace("\n\n-------------Std.parseInt----'123'-----------\n");

        var stringInt = "123";
        trace("123 : Std.parseInt(stringInt) = " + Std.parseInt("123"));

        trace("\n-------------Std.parseInt----'12.345'-----------\n");

        var stringFloat = "12.345";

        try
        {
            Std.parseInt(stringFloat);
        }
        catch(e:Dynamic)
        {
            trace("12.345 : Std.parseInt(stringFloat) error = " + e);
        }

        trace("\n-------------Std.parseInt----'abc'-----------\n");

        var abc = "abc";

        try
        {
            Std.parseInt(abc);
        }
        catch(e:Dynamic)
        {
            trace("abc : Std.parseInt(abc) error = " + e);
        }

        trace("\n-------------Std.parseInt----dybamicBool-----------\n");

        var dybamicBool:Dynamic = true;

        try
        {
            Std.parseInt(dybamicBool);
        }
        catch(e:Dynamic)
        {
            trace("dybamicBool : Std.parseInt(dybamicBool) error = " + e);
        }


        trace("\n\n-------------Std.parseFloat----'12.345'-----------\n");

        var stringFloat = "12.345";
        trace("12.345 : Std.parseInt(stringFloat) = " + Std.parseFloat(stringFloat));


        trace("\n\n-------------Std.random----30-----------\n");

        var rand = Std.random(30);
        trace("Std.random(30) = " + Std.random(30));

    }
}
