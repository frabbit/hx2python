package ;


//import python.Lib;
//import python.lib.Types;

import Tools.*;

import python.lib.ArrayTools;


class Main
{

    @test
    public static function main()
    {
        NativeRegexDemo.main();

        IterDemo.main();


        //DateDemo.main();
        //FileSystemDemo.main();

        haxe.Log;
        log(":::::PyMetaDemo::::::");
        PyMetaDemo.main();
        log(":::::ReflectDemo::::::");
        ReflectDemo.main();
        TypeDemo.main();
        log(":::::TypeDemo::::::");
        TypeDemo.main();
        log(":::::StdDemo::::::");
        StdDemo.main();
        log(":::::PropertyDemo::::::");
        PropertyDemo.main();
        log(":::::VariousExpressionDemo::::::");
        VariousExpressions.main();
        log(":::::SerializeDemo::::::");
        SerializeDemo.main();
        log(":::::SimpleDemo::::::");
        SimpleDemo.main();
        log(":::::ReflectDemo::::::");
        ReflectDemo.main();
        log(":::::ArrayDemo::::::");
        ArrayDemo.main();
        log(":::::ControlFlowDemo::::::");
        ControlFlowDemo.main();
        //var x = false;

        //switch (x) {
        //	case true: return "foo";
        //	default:
        //}
        //return "";

        
        
    }
}

