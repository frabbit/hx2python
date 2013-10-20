package bits;

@:keep class BClass extends AClass implements InterfaceDemo
{
    public static var WHOOT = "whoot";

    public var apiVar:Bool;

    public function new()
    {
        super();
        trace("BClass::new");

        apiVar = true;
    }

    public function methodInBClass()
    {
        trace("BClass::methodInBClass");
    }

    public function doSomething()
    {
        trace("BClass::doSomething()");
    }
}
