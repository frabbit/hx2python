(function () { "use strict";
var $estr = function() { return js.Boot.__string_rec(this,''); };
function $extend(from, fields) {
	function inherit() {}; inherit.prototype = from; var proto = new inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var ArrayDemo = function() {
	console.log("ArrayDemo");
	new Array();
	var a1 = [1,2,3];
	console.log(a1);
	a1.push(4);
	console.log(a1);
	var a2 = [1,2,3];
	console.log(a2.map(function(x) {
		return 100 + x;
	}));
};
var ControlFlowDemo = function() {
	this.NAMED_FUNCTION();
	var jimmy = 22;
	console.log("\n\n-------------CONDITIONAL---------------\n");
	if(ControlFlowDemo.STATIC_VAR == "staticVar") console.log("STATIC_VAR == \"staticVar\" is true"); else {
		console.log("STATIC_VAR == \"staticVar\" is false");
		console.log("STATIC_VAR == \"staticVar\" is false");
	}
	console.log("\n\n-------------SWITCH---------------\n");
	jimmy = 33;
	switch(jimmy) {
	case 1:
		console.log("jimmy is 1");
		break;
	case 3:
		console.log("jimmy is 3");
		break;
	case 88:
		console.log("jimmy is 88");
		break;
	case 33:
		console.log("jimmy is 33");
		break;
	default:
		console.log("default: don't konw how old jimmy is");
	}
	console.log("\n\n-------------WHILE---------------\n");
	var count = 0;
	while(count++ < 3) console.log("count = " + Std.string(count));
	console.log("\n\n-------------FOR---------------\n");
	var _g = 0;
	while(_g < 3) {
		var i = _g++;
		console.log("i = " + Std.string(i));
	}
	console.log("-------------FOR OVER ITERTOR---------------");
	var it = [1,2,3,4];
	var _g = 0;
	while(_g < it.length) {
		var i = it[_g];
		++_g;
		console.log(i);
	}
	console.log("\n\n-------------TRY CATCH: SUCCESS---------------\n");
	var str = "string";
	var x = "anotherString";
	var noError = function(a,b) {
		return a + b;
	};
	try {
		noError(str,x);
		console.log("no error");
	} catch( e ) {
		console.log("error = " + Std.string(e));
	}
	console.log("\n\n-------------TRY CATCH: ERROR---------------\n");
	var str1 = "string";
	var x1 = 0;
	var causeError = function(a,b) {
		return a + b;
	};
	try {
		causeError(str1,x1);
		console.log("no error");
	} catch( e ) {
		console.log("Success: error = " + Std.string(e));
	}
	console.log("\n\n--------------------------------------------\n");
};
ControlFlowDemo.prototype = {
	NAMED_FUNCTION: function() {
	}
}
var Color = { __constructs__ : ["RED","BLACK","RGB","Alpha"] }
Color.RED = ["RED",0];
Color.RED.toString = $estr;
Color.RED.__enum__ = Color;
Color.BLACK = ["BLACK",1];
Color.BLACK.toString = $estr;
Color.BLACK.__enum__ = Color;
Color.RGB = function(r,g,b) { var $x = ["RGB",2,r,g,b]; $x.__enum__ = Color; $x.toString = $estr; return $x; }
Color.Alpha = function(a,c) { var $x = ["Alpha",3,a,c]; $x.__enum__ = Color; $x.toString = $estr; return $x; }
var _Main = {}
_Main.Sum = function() { }
var Sub = function(z) {
	this.q = z;
};
Sub.prototype = {
	walk: function() {
		console.log("walk " + this.q);
	}
}
var Hui = function() { }
var HuiBu = function() { }
var Child = function() {
	Sub.call(this,77);
};
Child.__interfaces__ = [Hui];
Child.__super__ = Sub;
Child.prototype = $extend(Sub.prototype,{
	walk: function() {
		Sub.prototype.walk.call(this);
		console.log("hey");
	}
});
var Main = function() { }
Main.main = function() {
	console.log(_Main.Sum.jup);
	var umlaut = "UMLAUTE: äöüÄÖÜß";
	var gurki = 511111;
	var t22 = __python_tuple__(1,"tupleB");
	console.log(__python_array_get__(t22,1));
	var t221 = __python_tuple__(1,"tupleB",{ x : function() {
		gurki = 121212121;
		return gurki;
	}});
	console.log(__python_array_get__(t221,2).x());
	var mySub = new Sub(177);
	console.log(Reflect.hasField(mySub,"walk"));
	mySub.walk();
	var child = new Child();
	child.walk();
	console.log(js.Boot.__instanceof(child,Hui));
	console.log(js.Boot.__instanceof(child,HuiBu));
	console.log(Std.string((__python__("type"))(umlaut)));
	python.Lib.print("hey");
	python.Lib.println(["hey","heyho"]);
	new ControlFlowDemo();
	new ArrayDemo();
	try {
		console.log([1,2].concat([3,4]).toString());
	} catch( e ) {
		if( js.Boot.__instanceof(e,String) ) {
			console.log("catch String");
		} else throw(e);
	}
	try {
		console.log([1,2].concat([3,4]).toString());
		console.log(Std.string([1,2,3][1]));
		console.log(Std.string([1,2,3].slice()));
	} catch( $e0 ) {
		if( js.Boot.__instanceof($e0,String) ) {
			var e = $e0;
			console.log("catch String");
		} else if( js.Boot.__instanceof($e0,Main) ) {
			var x = $e0;
			console.log("catch class");
		} else if( js.Boot.__instanceof($e0,Color) ) {
			var x = $e0;
			console.log("catch enum");
		} else throw($e0);
	}
	try {
		console.log([1,2].concat([3,4]).toString());
		console.log(Std.string([1,2,3][1]));
		console.log(Std.string([1,2,3].slice()));
	} catch( $e1 ) {
		if( js.Boot.__instanceof($e1,String) ) {
			var e = $e1;
			console.log("catch String");
		} else {
		var x = $e1;
		console.log("catch class");
		}
	}
	var def = 500;
	var a = "hi";
	a;
	var a = 1;
	a;
	var u = 5;
	console.log(u);
	var u1 = 10;
	console.log(u1);
	console.log(Main.zy);
	console.log(u);
	var z = (function($this) {
		var $r;
		var q = 5;
		var z1 = (function($this) {
			var $r;
			var d = 0;
			$r = d + q + 1;
			return $r;
		}($this));
		$r = z1 + 2;
		return $r;
	}(this));
	var z2 = (function($this) {
		var $r;
		var q1 = 99;
		$r = function() {
			return q1;
		};
		return $r;
	}(this));
	if((function($this) {
		var $r;
		var x = 0;
		$r = x > 0;
		return $r;
	}(this))) console.log("hello");
	var b = false;
	if(b) console.log("hello");
	z = 1;
	var z1 = (function($this) {
		var $r;
		z = b?2:3;
		$r = z > 2;
		return $r;
	}(this))?function() {
		return z + 1;
	}:function() {
		return z + 2;
	};
	z1();
	var x = (function($this) {
		var $r;
		try {
			$r = (function($this) {
				var $r;
				throw null;
				$r = 1;
				return $r;
			}($this));
		} catch( $e2 ) {
			if( js.Boot.__instanceof($e2,String) ) {
				var e = $e2;
				$r = 17;
			} else {
			var e = $e2;
			$r = 15;
			}
		}
		return $r;
	}(this));
	console.log("x from tryCatch:" + x);
	var z3 = { x : 5, y : 10, z : function(x1) {
		return x1 * 3;
	}};
	z3.x += 10;
	console.log("z.z(2): " + z3.z(2));
	console.log("z:" + z3.x);
	var x1 = true;
	while(x1) {
		x1 = false;
		var z4 = 5;
		if(z4 == 5) {
			console.log(z4);
			break;
		}
		1;
	}
	do x1 = false; while(x1);
	var c = Color.RGB(10,11,23);
	var t = (function($this) {
		var $r;
		var $e = (c);
		switch( $e[1] ) {
		case 0:
			$r = (function($this) {
				var $r;
				console.log("it's red");
				$r = c;
				return $r;
			}($this));
			break;
		case 2:
			var c_eRGB_2 = $e[4], c_eRGB_1 = $e[3], c_eRGB_0 = $e[2];
			$r = (function($this) {
				var $r;
				switch(c_eRGB_0) {
				case 20:
					$r = (function($this) {
						var $r;
						console.log("has 20 red");
						$r = c;
						return $r;
					}($this));
					break;
				case 10:
					$r = (function($this) {
						var $r;
						console.log("has 10 red");
						$r = c;
						return $r;
					}($this));
					break;
				default:
					$r = (function($this) {
						var $r;
						console.log("other rgb");
						$r = c;
						return $r;
					}($this));
				}
				return $r;
			}($this));
			break;
		case 1:
			$r = (function($this) {
				var $r;
				console.log("it's black");
				$r = c;
				return $r;
			}($this));
			break;
		case 3:
			var c_eAlpha_1 = $e[3], c_eAlpha_0 = $e[2];
			$r = (function($this) {
				var $r;
				var $e = (c_eAlpha_1);
				switch( $e[1] ) {
				case 1:
					$r = c;
					break;
				case 2:
					var c_eAlpha_1_eRGB_2 = $e[4], c_eAlpha_1_eRGB_1 = $e[3], c_eAlpha_1_eRGB_0 = $e[2];
					$r = (function($this) {
						var $r;
						switch(c_eAlpha_1_eRGB_0) {
						case 10:
							$r = c;
							break;
						default:
							$r = c;
						}
						return $r;
					}($this));
					break;
				default:
					$r = c;
				}
				return $r;
			}($this));
			break;
		}
		return $r;
	}(this));
	t;
	if(x1) throw "whatever";
	var x2 = 1;
	switch(x2) {
	case 1:
		console.log("it's 1");
		break;
	default:
		console.log("not 1");
		console.log("not 1");
	}
	console.log(Std.string((function($this) {
		var $r;
		var z4 = 0;
		$r = (function($this) {
			var $r;
			try {
				$r = (function($this) {
					var $r;
					throw "whatever";
					$r = "juhu";
					return $r;
				}($this));
			} catch( s ) {
				if( js.Boot.__instanceof(s,String) ) {
					$r = s;
				} else throw(s);
			}
			return $r;
		}($this));
		return $r;
	}(this))));
	switch(x2) {
	case 1:
		switch( (c)[1] ) {
		case 0:
			console.log("it's 1 red");
			break;
		default:
			console.log("not 1 red");
		}
		break;
	default:
		console.log("not 1 red");
	}
	var _g = 0;
	while(_g < 10) {
		var i = _g++;
		console.log(i);
	}
	var _g = 0, _g1 = [0,1,2];
	while(_g < _g1.length) {
		var i = _g1[_g];
		++_g;
		console.log(i);
	}
	var hey = function() {
		return 23.1;
	};
	console.log("----------------");
	var zy = 1;
	var f = function() {
		console.log(zy);
		zy += 2;
		var zwei = function() {
			console.log(zy);
			zy += 7;
			console.log(zy);
		};
		zwei();
		console.log(zy);
	};
	f();
	console.log(zy);
	console.log("----------------");
	console.log(hey());
}
var Reflect = function() { }
Reflect.hasField = function(o,field) {
	return Object.prototype.hasOwnProperty.call(o,field);
}
var Std = function() { }
Std.string = function(s) {
	return js.Boot.__string_rec(s,"");
}
var js = {}
js.Boot = function() { }
var python = {}
python.Lib = function() { }
python.Lib.print = function(v) {
	python.lib.Sys.stdout.write(Std.string(v));
	python.lib.Sys.stdout.flush();
}
python.Lib.println = function(v) {
	var _g = 0;
	while(_g < v.length) {
		var e = v[_g];
		++_g;
		(__python__("print"))(Std.string(e));
	}
}
__python__("import sys as python_lib_Sys");
ControlFlowDemo.STATIC_VAR = "staticVar";
_Main.Sum.jup = "hi";
Main.zy = 900;
Main.main();
})();
