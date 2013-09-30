package ;
import js.html.XMLHttpRequest;
class HttpRequestDemo
{
    var request:XMLHttpRequest;

    public function new()
    {
        request = js.Browser.createXMLHttpRequest();

        request.open("GET", "response.txt");
        request.onabort = eventHandler;
        request.onerror = eventHandler;
        request.onreadystatechange = eventHandler;
        request.onload = eventHandler;
        request.onloadend = eventHandler;
        request.onloadstart = eventHandler;
        request.onprogress = eventHandler;

        request.send(null);
    }

    function eventHandler(e)
    {
        trace('${e.type} e = $e');
        trace('request.readyState ${request.readyState}');
        trace('request.response ${request.response}');
        trace('request.responseText ${request.responseText}');
        trace('request.responseType ${request.responseType}');
        trace('request.responseXML ${request.responseXML}');
    }
}
