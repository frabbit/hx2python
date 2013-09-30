import 'dart:html';
main()=>Main.main();
class BrowserDemo
{
	
	BrowserDemo(  ) {
		print("Browser.document = " + document.toString());
		print("Browser.window = " + window.toString());
		print("Browser.location = " + window.location.toString());
		print("Browser.location = " + window.navigator.toString());
		print("Browser.getLocalStorage() = " + Browser.getLocalStorage().toString());
		print("Browser.getSessionStorage() = " + Browser.getSessionStorage().toString());
		print("Browser.createXMLHttpRequest() = " + new HttpRequest().toString());
	}
	
}

class CanvasDemo
{
	
	CanvasDemo(  ) {
		var canvasElement = document.$dom_createElement("canvas");
		var context2d = canvasElement.getContext("2d");
		context2d.fillStyle = "#ff00ff";
		context2d.fillRect(0, 0, 100, 100);
		document.getElementById("content").append(canvasElement);
		var contextWebGL = _CanvasUtil.getContextWebGL(canvasElement, null);
	}
	
}

class HttpRequestDemo
{
	
	HttpRequestDemo(  ) {
		this.request = new HttpRequest();
		this.request.open("GET", "response.txt");
		this.request.onAbort.listen(this.eventHandler);
		this.request.onError.listen(this.eventHandler);
		this.request.onReadyStateChange.listen(this.eventHandler);
		this.request.onLoad.listen(this.eventHandler);
		this.request.onLoadEnd.listen(this.eventHandler);
		this.request.onLoadStart.listen(this.eventHandler);
		this.request.onProgress.listen(this.eventHandler);
		this.request.send(null);
	}
	eventHandler( e ) {
		print("" + e.type.toString() + " e = " + e.toString());
		print("request.readyState " + this.request.readyState.toString());
		print("request.response " + this.request.response.toString());
		print("request.responseText " + this.request.responseText.toString());
		print("request.responseType " + this.request.responseType.toString());
		print("request.responseXML " + this.request.responseXml.toString());
	}
	
	var request;
	
}

class Main
{
	static main (  ) {
		new HttpRequestDemo();
		new BrowserDemo();
		new CanvasDemo();
	}
	
}

class Browser
{
	static getLocalStorage (  ) {
		try {
			var s = window.localStorage;
			s.getItem("");
			return s;
		} catch(e ) {
			return null;
		};
	}
	static getSessionStorage (  ) {
		try {
			var s = window.sessionStorage;
			s.getItem("");
			return s;
		} catch(e ) {
			return null;
		};
	}
	
}

class _CanvasUtil
{
	static getContextWebGL ( canvas,attribs ) {
		{
			var _g = 0, _g1 = ["webgl", "experimental-webgl"];
			while((_g < _g1.length)) {
				var name = _g1[_g];
				++_g;
				var ctx = canvas.getContext(name, attribs);
				if((ctx != null)) return ctx;  ;
			};
		};
		return null;
	}
	
}

