(function () { "use strict";
var BrowserDemo = function() {
	console.log("Browser.document = " + Std.string(js.Browser.document));
	console.log("Browser.window = " + Std.string(js.Browser.window));
	console.log("Browser.location = " + Std.string(js.Browser.location));
	console.log("Browser.location = " + Std.string(js.Browser.navigator));
	console.log("Browser.getLocalStorage() = " + Std.string(js.Browser.getLocalStorage()));
	console.log("Browser.getSessionStorage() = " + Std.string(js.Browser.getSessionStorage()));
	console.log("Browser.createXMLHttpRequest() = " + Std.string(js.Browser.createXMLHttpRequest()));
};
BrowserDemo.__name__ = true;
var CanvasDemo = function() {
	var canvasElement = js.Browser.document.createElement("canvas");
	var context2d = canvasElement.getContext("2d");
	context2d.fillStyle = "#ff00ff";
	context2d.fillRect(0,0,100,100);
	js.Browser.document.getElementById("content").appendChild(canvasElement);
	var contextWebGL = js.html._CanvasElement.CanvasUtil.getContextWebGL(canvasElement,null);
};
CanvasDemo.__name__ = true;
var HttpRequestDemo = function() {
	this.request = js.Browser.createXMLHttpRequest();
	this.request.open("GET","response.txt");
	this.request.onabort = $bind(this,this.eventHandler);
	this.request.onerror = $bind(this,this.eventHandler);
	this.request.onreadystatechange = $bind(this,this.eventHandler);
	this.request.onload = $bind(this,this.eventHandler);
	this.request.onloadend = $bind(this,this.eventHandler);
	this.request.onloadstart = $bind(this,this.eventHandler);
	this.request.onprogress = $bind(this,this.eventHandler);
	this.request.send(null);
};
HttpRequestDemo.__name__ = true;
HttpRequestDemo.prototype = {
	eventHandler: function(e) {
		console.log("" + e.type + " e = " + Std.string(e));
		console.log("request.readyState " + this.request.readyState);
		console.log("request.response " + Std.string(this.request.response));
		console.log("request.responseText " + this.request.responseText);
		console.log("request.responseType " + this.request.responseType);
		console.log("request.responseXML " + Std.string(this.request.responseXML));
	}
}
var Main = function() { }
Main.__name__ = true;
Main.main = function() {
	new HttpRequestDemo();
	new BrowserDemo();
	new CanvasDemo();
}
var Std = function() { }
Std.__name__ = true;
Std.string = function(s) {
	return js.Boot.__string_rec(s,"");
}
var js = {}
js.Boot = function() { }
js.Boot.__name__ = true;
js.Boot.__string_rec = function(o,s) {
	if(o == null) return "null";
	if(s.length >= 5) return "<...>";
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) t = "object";
	switch(t) {
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) return o[0];
				var str = o[0] + "(";
				s += "\t";
				var _g1 = 2, _g = o.length;
				while(_g1 < _g) {
					var i = _g1++;
					if(i != 2) str += "," + js.Boot.__string_rec(o[i],s); else str += js.Boot.__string_rec(o[i],s);
				}
				return str + ")";
			}
			var l = o.length;
			var i;
			var str = "[";
			s += "\t";
			var _g = 0;
			while(_g < l) {
				var i1 = _g++;
				str += (i1 > 0?",":"") + js.Boot.__string_rec(o[i1],s);
			}
			str += "]";
			return str;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString) {
			var s2 = o.toString();
			if(s2 != "[object Object]") return s2;
		}
		var k = null;
		var str = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) { ;
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str.length != 2) str += ", \n";
		str += s + k + " : " + js.Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str += "\n" + s + "}";
		return str;
	case "function":
		return "<function>";
	case "string":
		return o;
	default:
		return String(o);
	}
}
js.Browser = function() { }
js.Browser.__name__ = true;
js.Browser.getLocalStorage = function() {
	try {
		var s = js.Browser.window.localStorage;
		s.getItem("");
		return s;
	} catch( e ) {
		return null;
	}
}
js.Browser.getSessionStorage = function() {
	try {
		var s = js.Browser.window.sessionStorage;
		s.getItem("");
		return s;
	} catch( e ) {
		return null;
	}
}
js.Browser.createXMLHttpRequest = function() {
	if(typeof XMLHttpRequest != "undefined") return new XMLHttpRequest();
	if(typeof ActiveXObject != "undefined") return new ActiveXObject("Microsoft.XMLHTTP");
	throw "Unable to create XMLHttpRequest object.";
}
js.html = {}
js.html._CanvasElement = {}
js.html._CanvasElement.CanvasUtil = function() { }
js.html._CanvasElement.CanvasUtil.__name__ = true;
js.html._CanvasElement.CanvasUtil.getContextWebGL = function(canvas,attribs) {
	var _g = 0, _g1 = ["webgl","experimental-webgl"];
	while(_g < _g1.length) {
		var name = _g1[_g];
		++_g;
		var ctx = canvas.getContext(name,attribs);
		if(ctx != null) return ctx;
	}
	return null;
}
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; };
String.__name__ = true;
Array.__name__ = true;
js.Browser.window = typeof window != "undefined" ? window : null;
js.Browser.document = typeof window != "undefined" ? window.document : null;
js.Browser.location = typeof window != "undefined" ? window.location : null;
js.Browser.navigator = typeof window != "undefined" ? window.navigator : null;
Main.main();
})();
