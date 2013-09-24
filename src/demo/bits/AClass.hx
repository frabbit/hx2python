package demo.bits;

class AClass extends BaseClass
{


    public function methodInAClass()
    {
        trace("AClass::methodInAClass");
    }

    override function getString()
    {
        return super.getString() + " Overridden in AClass";
       // return "AClsss::getString - override with no super call";
    }
}
