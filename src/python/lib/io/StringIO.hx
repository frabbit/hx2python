
package python.lib.io;

import python.lib.io.TextIOBase;

extern class StringIO extends TextIOBase 
{
	public function new (s:String):Void;
	public function getvalue():String;

}