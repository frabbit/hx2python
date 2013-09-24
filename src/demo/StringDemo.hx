package demo;

import dart.Lib;

class StringDemo
{
    public function new()
    {
        var someString:String = 'someString';
        var inferredString = "inferredString";
        var nullString:String = null;

        trace("\n\n-------------String-----------\n");

        trace("someString.charAt(2) = " + someString.charAt(2));

        Lib.assert(someString.charAt(2) == 'm');

        var charCode = someString.charCodeAt(5);

        trace("someString.charCodeAt(5) = " + Std.string(charCode));

        trace("inferredString.substr(3, 3) = " + inferredString.substr(3, 3));

        trace("inferredString.substr(3) = " + inferredString.substr(3));

        trace("inferredString.substring(3, 7) = " + inferredString.substring(3, 7));

        trace("inferredString.substring(6) = " + inferredString.substring(6));

        trace("String.fromCharChode   NOT IMPLEMENTED YET !!!!! ");
    }
}
