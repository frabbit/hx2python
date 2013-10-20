package ;
class ArrayDemo
{
    public static function main()
    {
        trace("ArrayDemo");

        new Array();

        var a1 = [1, 2, 3];



        trace(a1);

        a1.push(4);

        trace(a1);

        var a2 = [1, 2, 3];

        trace(a2.map(function (x) return 100+x));
    }
}
