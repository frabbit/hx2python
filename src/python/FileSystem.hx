
package python;

import python.lib.Os;
import python.lib.os.Path;

class FileSystem {

	public static function exists( path : String ) : Bool {
		return Path.exists(path);
	}

}