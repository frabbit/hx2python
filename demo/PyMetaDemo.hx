
package ;


// must be defined before (in python code) using a python decorator
@:keep class LazyDefine {
	static function __init__ ():Void {
		untyped __python__("def lazy(fn):");
    	untyped __python__("\tattr_name = '_lazy_' + fn.__name__");
    	untyped __python__("\tdef _lazyprop(self):");
        untyped __python__("\t\tif not hasattr(self, attr_name):");
        untyped __python__("\t\t\tsetattr(self, attr_name, fn(self))");
        untyped __python__("\t\treturn getattr(self, attr_name)");
    	untyped __python__("\treturn _lazyprop");
	}
}

class PyMetaDemo {
	


	public function new () {
		
	}

	@:python("lazy") // usage of python decorator
	public function getX () {
		trace("calcX");

		return 1;
	}

	
	public static function main () {
		var p = new PyMetaDemo();
		trace(p.getX());
		trace(p.getX());

	}
	

	

}

