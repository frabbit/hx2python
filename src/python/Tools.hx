
package python;

class Tools {

	

	public static function substring( s:String, startIndex : Int, ?endIndex : Int ) : String {
		return untyped __python__("s[startIndex:endIndex]");
	}	


}