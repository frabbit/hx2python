
package python.lib.xml.etree;

import python.lib.Types.Tup2;

import python.lib.Types;

extern class XMLParser {

}

extern class Element {
	public function getroot ():ElementTree;
	public var tag:String;
	public var attrib : Dict<String, String>;
	public var text:Null<String>;


	public function get <T>(key:String, def:T = null):T;
	public function set (key:String, val:String):Void;

	public function copy ():Element;

	public function keys ():Array<String>;	
	public function items ():Array<Tup2<String, String>>;

	public function iter (tag:String):PyIterable<Element>;
	public function iterfind (tag:String, namespaces:Dict<String,String> = null):PyIterator<Element>;
	public function find (match:String, namespaces:Dict<String,String> = null):Null<Element>;
	public function findall (match:String, namespaces:Dict<String,String> = null):Array<Element>;

	static function __init__ ():Void 
	{
		Macros.importFromAs("xml.etree.ElementTree", "Element", "python.lib.xml.etree.Element");
	}
}

extern class ElementTree {



	public static function XML(text:String, ?parser:XMLParser):Element;
	public static function parse(xml:String):ElementTree;

	public function iter (tag:String):PyIterable<Element>;
	public function find (match:String, namespaces:Dict<String,String> = null):Null<Element>;
	public function getroot ():Element;




	static function __init__ ():Void 
	{
		Macros.importAs("xml.etree.ElementTree", "python.lib.xml.etree.ElementTree");
	}

}