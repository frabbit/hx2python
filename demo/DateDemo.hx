
package ;


class DateDemo {

	public static function main () {
		var d = Date.now();
		trace(d.toString());

		trace(Date.fromTime(python.lib.Time.time()).toString());

		trace(Date.fromTime(DateTools.makeUtc(d.getFullYear(), d.getMonth(), d.getDate(), d.getHours(), d.getMinutes(), d.getSeconds())).toString());

		//trace(Time.time());
	}

}