package python;

class Lib
{
	/*
    public static inline function assert(value:Dynamic)
    {
        untyped __assert__(value);
    }

    public static function random(max:Int)
    {
       var r = new dart.math.Random(); //TODO(av) benchmark / test caching Random instance as static
       return r.nextInt(max);
    }
    */

    public static function print(v:Dynamic)
    {
       python.lib.Sys.stdout.write(Std.string(v));
       python.lib.Sys.stdout.flush();
    }

    public static function println(v:Array<Dynamic>)
    {
       for (e in v) {
            
            untyped __python__("print")(Std.string(e));
       }
       
    }

    
    
}
