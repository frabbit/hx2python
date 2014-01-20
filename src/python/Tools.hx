
package python;

class Tools {

	

	public static function substring( s:String, startIndex : Int, ?endIndex : Int ) : String {
		return untyped __python__("s[startIndex:endIndex]");
	}	

	public static function substr( s:String, startIndex : Int, ?len : Int ) : String {
		if (len == null) {
			return untyped __python__("s[startIndex:]");
		} else {
			if (len == 0) return "";
			return untyped __python__("s[startIndex:startIndex+len]");
		}
		
	}


}