
package python.lib;

import python.lib.Types.Bytes;

class StringTools {

	public static function encode(s:String, encoding:String="utf-8", errors:String="strict"):Bytes {
		return untyped __field__(s, "encode")(encoding, errors);
	}

}