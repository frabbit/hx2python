
package python.lib.subprocess;

import python.lib.Subprocess.StartupInfo;
import python.lib.Types;

typedef PopenOptions = {
	?bufsize : Int,
	?executable  : String,
	?stdin  : FileObject,
	?stdout  : FileObject,
	?stderr : FileObject,
	?preexec_fn : Void->Void,
	?close_fds : Bool,
	?shell : Bool,
	?cwd : String,
	?env : Dict<String, String>,
	?universal_newlines : Bool,
	?startupinfo : StartupInfo,
	?creationflags : Int,
}

extern class Popen {

	public static inline function create (args:Array<String>, o:PopenOptions):Popen {
		return new Popen(args, o.bufsize, o.executable, o.stdin, o.stdout, o.stderr, o.preexec_fn,
			o.close_fds, o.shell, o.cwd, o.env, o.universal_newlines, o.startupinfo, o.creationflags);
	}

	public function new (args:Array<String>, bufsize:Int=0, executable:String = null, 
			stdin:FileObject = null, stdout:FileObject = null, stderr:FileObject=null, preexec_fn:Void->Void=null, 
			close_fds:Bool=false, shell:Bool=false, cwd:String=null, env:Dict<String,String>=null, 
			universal_newlines:Bool=false, startupinfo:StartupInfo=null, creationflags:Int=0):Void;


	public function kill ():Void;

	public function communicate (input:Bytes = null, timeout:Null<Int> = null):Tup2<Bytes, Bytes>;

	static function __init__ ():Void 
	{
		python.Macros.importFromAs("subprocess", "Popen", "python.lib.subprocess.Popen");
	}

}