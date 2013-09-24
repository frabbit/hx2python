package dart;

class Lib
{
    public static inline function assert(value:Dynamic)
    {
        untyped __assert__(value);
    }

    public static function random(max:Int)
    {
       var r = new dart.math.Random(); //TODO(av) benchmark / test caching Random instance as static
       return r.nextInt(max);
    }
}
