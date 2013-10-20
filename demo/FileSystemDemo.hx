
package ;

import python.lib.Os;
import python.lib.Types.FileExistsError;

class FileSystemDemo {

	public static function main () {
		try {
		Os.makedirs("bin/hello/world/where/are/you");
		} catch (e:FileExistsError) {
			trace(e);
		}
		trace(python.FileSystem.exists("bin/hello"));
		trace(python.FileSystem.exists("bin/hello_not"));
		trace(python.FileSystem.readDirectory("."));

		trace(python.FileSystem.stat("."));
	}

}