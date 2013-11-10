
package python.lib.io;

extern class StringIO {

	public function close():Void;
	public function flush():Void;
	public function readline(limit:Int = -1):String;
	public function getvalue():String;

}