
package ;

#if python
import python.Lib;
import python.lib.Types;
#end

enum Color {
    RED;
    BLACK;
    RGB(r:Int, g:Int, b:Int);
    Alpha(a:Int, c:Color);
}

private class Sum {
    public static var jup = "hi";
}

class Sub {
    var q : Int;
    public function new (z:Int) {
        this.q = z;
    }

    public function walk () {
        trace("walk " + this.q);
    }
}

interface Hui {}
interface HuiBu {}
class Child extends Sub implements Hui {
    public function new () {
        super(77);
    }

    override public function walk () 
    {
        super.walk();
        trace("hey");
    }
}

class Whatever {
    public function new () {}
    public var hello(get, null):Int;

    function get_hello ():Int return 1;
}

class VariousExpressions
{

    static var HELLO = "hey";

	var test:String;
	var other = "hey";
    var self = "heyself";

    static var zy = 900;



    public static function main()
    {
        trace(new Whatever().hello);
        var x = 65;

        var z = 3 + x;
        trace("String.fromCharcode(" + Std.string(z) + ") = " + String.fromCharCode(z));
        trace("hello world".length);
        trace(Sum.jup);
        var umlaut = "UMLAUTE: äöüÄÖÜß";
        var gurki = 511111;
        #if python
        var t22 = Tup2.create(1, "tupleB");
        trace(t22._2);
        var t22 = Tup3.create(1, "tupleB", { x : function () { gurki = 121212121; return gurki;}});
        trace(t22._3.x());
        #end


        var mySub = new Sub(177);

        trace(Reflect.hasField(mySub, "walk"));
        mySub.walk();
        var child = new Child();
        child.walk();

        trace(Std.is(child, Hui));
        trace(Std.is(child, HuiBu));

        
        #if python
        trace(Std.string(untyped __python__("type")(umlaut)));
        Lib.print("hey");
        Lib.println(["hey", "heyho"]);
        #end
        
        
        try {
            trace([1,2].concat([3,4]).toString());
           
        } catch (e:String) {
            trace("catch String");
            // trace(Std.string([1,2,3][1]));
            // trace(Std.string([1,2,3].copy()));
        } 
        try {
            trace([1,2].concat([3,4]).toString());
            trace(Std.string([1,2,3][1]));
            trace(Std.string([1,2,3].copy()));
        } catch (e:String) {
            trace("catch String");
        } catch (x:Main) {
            trace("catch class");
        } catch (x:Color) {
            trace("catch enum");
        } 
        try {
            trace([1,2].concat([3,4]).toString());
            trace(Std.string([1,2,3][1]));
            trace(Std.string([1,2,3].copy()));
        } catch (e:String) {
            trace("catch String");
        } catch (x:Dynamic) {
            trace("catch class");
        } catch (x:Color) {
            trace("catch enum");
        } 

        var def = 500;

        // new StringDemo();
        // new ControlFlowDemo();
        // new StdDemo();
        // new ArrayDemo();
        {
            var a = "hi";
            a;
        }
        {
            var a = 1;
            a;
        }

        var u = 5;
        trace(u);
        {
            var u = 10;
            trace(u);
        }

        trace(zy);
        trace(u);

        var z = { var q = 5; var z = { var d = 0; d + q + 1; }; z+2;}

        var z2 = { var q = 99; function () return q; }


        if ({ var x = 0; x > 0;}) trace("hello");

        var b:Bool = false;
        if (b) trace("hello");

        z = 1;
        var z = if ({z = if (b) 2 else 3; z > 2;} ) {
            function () return z + 1;
        } else {
            function () return z + 2;
        }
        z();


        var x = try {
            throw null;
            1;
        } catch (e:String) {
            17;
        } catch (e:Dynamic) {
            15;
        }

        
        trace("x from tryCatch:" + x);

        var x = ((function () return { x : 5})().x = 10);

        trace("new X : " + x);

        var z = {
            x : 5,
            y : 10,
            z : function (x) {
                return x * 3;
            }
        }

        var z11 = (z.x > 10) ? 1 : (z.x < 0) ? 2 : 17;
        trace("z11:" + z11);
        z.x += 10;
        trace("z.z(2): " + z.z(2));
        trace("z:" + z.x);

        var x = true;
        while (x) {

            x = false;
            

            var z = 5;
            if (z == 5) {
                trace(z);
                break;    
            }
            
            1;

        }

        try {
            throw "s";
        } catch (e:Dynamic) {
            trace("except dynamic");
        } catch (s:String) {
            trace("except string");
        }

        do {
            x = false;
        } while (x);

        var c = RGB(10,11,23);

        var t = switch (c) {
            case RED: trace("it's red"); c;
            case RGB(20,_,_): trace("has 20 red"); c;
            case RGB(10,_,_): trace("has 10 red"); c;
            case RGB(_,_,_): trace("other rgb"); c;
            case BLACK: trace("it's black"); c;
            case Alpha(_, BLACK): c;
            case Alpha(_, RGB(10,_,_)): c;
            case Alpha(_, _): c;

        }
        $type(t);
        //trace("the t: " + haxe.EnumTools.EnumValueTools.getName(t));
        if (x) throw "whatever";

        var ix = 1;
        
        switch (ix) {
            case 1: trace("it's 1");
            case x: {
                trace("not 1"); 
                trace("not 1"); 
            }

        }

        trace(Std.string({ var z = 0; try { throw "whatever"; "juhu";} catch(s:String) s; }));

        switch ([ix, c]) {
            case [1, RED]: trace("it's 1 red");
            case _: trace("not 1 red"); 

        }
        for (i in 0...10) {
            trace(i);
        }

        for (i in [0,1,2]) {
            trace(i);
        }

        function hey () { return 17 + 6.1;};

        trace("----------------");
        var zy = 1;
        var f = function () {
            trace(zy);
            zy += 2;
            function zwei () {
                trace(zy);
                zy += 7;
                trace(zy);
            }
            zwei();

            trace(zy);
        };

        f();
        trace(zy);
        trace("----------------");

        trace(hey());
    }

    // public static function doSomething(z:Int)
    // {
    //     return if (z == 0) {
    //         var y = z * 2;
    //         y;

    //     } else {
    //         var a = z * 3;
    //         a;
    //     }
    //     // new StringDemo();
    //     // new ControlFlowDemo();
    //     // new StdDemo();
    //     // new ArrayDemo();
    // }

    // public function new (test:String)
    // {
    // 	this.test = test;

    //     var z = true;
    //     if (z) {
    //         trace(1);
    //     } else {
    //         trace(2);
    //     }

    //     var y = if (z) {
    //         1;
    //     } else {
    //         2;
    //     }


    //     var hey = 1;

    //     var foo = hey++;

    //     trace(foo);


    //     foo += 5;
    //     foo -= 5;

    //     var z = if (foo == 10) function () return 1 else function () return 2;
    // }
}

