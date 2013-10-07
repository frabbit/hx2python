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

    public static function toPythonIterable <T>(it:Iterable<T>):python.lib.Types.Iterable<T> 
    {
      return {
        __iter__ : function () {
          var it1 = it.iterator();
          return {
            next : function () {
              if (it1.hasNext()) {
                return it1.next();
              } else {
                throw new python.lib.Types.StopIteration();
              }
            }
          }
        }
      }
    }

    public static function toHaxeIterable <T>(it:python.lib.Types.Iterable<T>):Iterable<T> 
    {
      return {
        iterator : function () {
          var it1 = it.__iter__();
          var x:Null<T> = null;
          var checked = false;
          return {
            next : function () {
              return x;
            },
            hasNext : function () {
              if (!checked) {
                return x != null;
              }
              try {
                x = it1.next();
              } catch (s:python.lib.Types.StopIteration) {
                x = null;
              }
              checked = true;
              return x != null;
            }
          }
        }
      }
    }


    
}
