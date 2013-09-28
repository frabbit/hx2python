package ;
class ArrayDemo
{
    public function new()
    {
        trace("ArrayDemo");

        new Array();

        var a1 = [1, 2, 3];

        trace(a1);

        a1.push(4);

        trace(a1);
    }
}
