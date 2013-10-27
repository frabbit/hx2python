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

        var a = [2,1,3];
        a.sort(function (x,y) return x < y ? -1 : x > y ? 1 : 0);
        trace("sorted a : " + a);

        var x = [1,2,3,4];

        trace(x.slice(1, 2));
        trace(x);

        trace(x.splice(1, 2));
        trace(x);
    }
}
