
package ;


import python.Debug;
import python.lib.Re;

class NativeRegexDemo {

	
	public static function main () {
		var r = Re.compile("h(e*llo) (?P<other>world)");

		var mo = r.match("heeeeello world");

		var x = r.findall("h");

		


		var r = Re.compile("(e)x(a)x(c)");

		var x = r.findall("exaxce\nexae");

		trace(x);
		//trace(mo.group(1));
		//trace(mo.groupById("other"));

	}
}