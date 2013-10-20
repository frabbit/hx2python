
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

	public static inline function create (args:Array<String>, o:PopenOptions) {
		return new Popen(args, o.bufsize, o.executable, o.stdin, o.stdout, o.stderr, o.preexec_fn,
			o.close_fds, o.shell, o.cwd, o.env, o.universal_newlines, o.startupinfo, o.creationflags);
	}

	public function new (args:Array<String>, bufsize=0, executable = null, 
			stdin = null, stdout = null, stderr=null, preexec_fn=null, 
			close_fds=false, shell=false, cwd=null, env=null, 
			universal_newlines=false, startupinfo=null, creationflags=0);


	static function __init__ ():Void 
	{
		python.Macros.importFromAs("subprocess", "Popen" "python.lib.subprocess.Popen");
	}

}