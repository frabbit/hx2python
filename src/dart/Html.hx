package dart;

import dart.html.Element;
@:library("dart:html")
class Html
{
    public static inline function query(selector:String):Element return untyped __call_global__("query", selector);
    public static inline function queryAll(selector:String) return untyped __call_global__("queryAll", selector);
}

//class HtmlTools
//{
//    public static inline function query(any:Dynamic, selector:String):Element return Html.query(selector);
//    public static inline function queryAll(any:Dynamic, selector:String) return untyped __call_global__("queryAll", selector);
//}