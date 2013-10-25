
package ;

import python.Debug;
import python.lib.Builtin;

class IterDemo {

	public static function main () {
		var a = [1,2,3];

		var z = (a.length > 3) ? "hey" : "dump";

		

		var it = Builtin.map(function (x) return x + 1, a);

		

		Debug.dump(it);
		for (a in it.toHaxeIterator()) {
			trace(a);
		}
		
	}

}