
package python.lib.io;

import python.lib.io.IOBase;

extern class TextIOBase extends IOBase {

	public var encoding:String;

	public function write (s:String):Int;
}