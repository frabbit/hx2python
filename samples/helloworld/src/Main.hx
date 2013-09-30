package ;

using dart.Html;
@:library("dart:html")  //HACK(av) temporarily required to ensure dart library is imported when only inlined methods have been used
class Main
{
    public static function main()
    {
        var sampleText = "#sample_text_id".query();
        sampleText.text = "Click me!";
        sampleText.onClick.listen(reverseText);
    }

    @:top_level
    static function reverseText(e)
    {
        var text = "#sample_text_id".query().text;
        var buffer = new StringBuf();
        var i = text.length;
        while(i-- > 0)            //haxe for loops can't decrement
        {
            buffer.add(text.charAt(i));
        }
        "#sample_text_id".query().text = buffer.toString();
    }
}

