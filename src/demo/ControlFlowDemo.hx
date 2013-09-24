package demo;
class ControlFlowDemo
{
    public static var STATIC_VAR = "staticVar";

    public function new()
    {
        NAMED_FUNCTION();

        var jimmy = 22;

        trace("\n\n-------------CONDITIONAL---------------\n");

        if(STATIC_VAR == "staticVar")
        {
//            trace('STATIC_VAR == "staticVar" is true');
            trace('STATIC_VAR == "staticVar" is true');
        }
        else
        {
            trace('STATIC_VAR == "staticVar" is false');
            trace('STATIC_VAR == "staticVar" is false');
        }

        trace("\n\n-------------SWITCH---------------\n");

        jimmy = 33;

        switch(jimmy)
        {
            case 1: trace("jimmy is 1");
            case 3: trace("jimmy is 3");
            case 88: trace("jimmy is 88");
            case 33: trace("jimmy is 33");
            default:trace("default: don't konw how old jimmy is");
        }

//        trace("-------------SWITCH RETURNING VALUE---------------");
//
//        jimmy = 88;
//
//        trace(switch(jimmy)
//              {
//                  case 1: "jimmy is 1";
//                  case 3: "jimmy is 3";
//                  case 88: "jimmy is 88";
//                  case 33: "jimmy is 33";
//                  default:"default: don't konw how old jimmy is";
//              });

        trace("\n\n-------------WHILE---------------\n");

        var count = 0;
        while(count ++ < 3)
        {
            trace("count = " + Std.string(count));      //*currently need to convert to string before concating via + operator
        }

        trace("\n\n-------------FOR---------------\n");

        for(i in 0 ... 3)
        {
            trace("i = " + Std.string(i));
        }

        trace("-------------FOR OVER ITERTOR---------------");

        var it = [1, 2, 3, 4];

        for(i in it)
        {
            trace(i);
        }

        trace("\n\n-------------TRY CATCH: SUCCESS---------------\n");

        var str = "string";
        var x = "anotherString";
        function noError(a :Dynamic, b : Dynamic ) return a + b;

        try
        {
            noError(str, x);
            trace("no error");
        }
        catch(e:Dynamic)
        {
            trace("error = " + Std.string(e));
        }

        trace("\n\n-------------TRY CATCH: ERROR---------------\n");

        var str = "string";
        var x = 0;
        function causeError(a :Dynamic, b : Dynamic ) return a + b;

        try
        {
            causeError(str, x);
            trace("no error");
        }
        catch(e:Dynamic)
        {
            trace("error = " + Std.string(e));
        }
    }

    function NAMED_FUNCTION()
    {

    }
}
