
package ;

// must be defined before (in python code) using a python decorator
@:preCode("
def lazy(fn):
	attr_name = '_lazy_' + fn.__name__
	def _lazyprop(self):
		if not hasattr(self, attr_name):
			setattr(self, attr_name, fn(self))
		return getattr(self, attr_name)
	return _lazyprop
")
@:keep class LazyDefine {
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

