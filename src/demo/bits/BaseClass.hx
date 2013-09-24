package demo.bits;
class BaseClass
{
    public static inline var SOME_CONSTANT = "someConstant";  //final or inlined at compile time

    public static var UninitialisedStaticVar:Float;

    public var id:String;

    public var count(get, set):Int;
    var _count:Int;
    function get_count() return _count++;
    function set_count(v) return _count = v;

    public function new()
    {
        trace("BaseClass::new");

        #if !as3
        if(_instances == null)
        {
            _instances  = 0;
        }
        #end

        _instances ++;
        _count = 0;
        UninitialisedStaticVar = 1.234;
    }

    public function getString()
    {
        return "string from BaseClass::getString()";
    }

    public function acceptArgument(value:Bool)
    {
        trace("BaseClass::acceptArguments value = " + Std.string(value));
    }

    public static var instances(get, null):Int = 0;     //TODO(av) make sure this gets initialized

    static var _instances:Int;

    static function get_instances() return _instances;
}
