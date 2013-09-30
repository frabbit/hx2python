package ;

import js.Browser;

class BrowserDemo
{
    public function new()
    {
        trace('Browser.document = ${Browser.document}');
        trace('Browser.window = ${Browser.window}');
        trace('Browser.location = ${Browser.location}');
        trace('Browser.location = ${Browser.navigator}');

        trace('Browser.getLocalStorage() = ${Browser.getLocalStorage()}');
        trace('Browser.getSessionStorage() = ${Browser.getSessionStorage()}');
        trace('Browser.createXMLHttpRequest() = ${Browser.createXMLHttpRequest()}');
    }
}
