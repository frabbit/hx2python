
package ;

using python.Macros;

class DateDemo {

	public static function main () {
		var d = Date.now();
		trace(d.toString());

		trace(Date.fromTime(python.lib.Time.time()).toString());

		trace(Date.fromTime(DateTools.makeUtc(d.getFullYear(), d.getMonth(), d.getDate(), d.getHours(), d.getMinutes(), d.getSeconds())).toString());

		//trace(Time.time());
		var d = python.lib.datetime.DateTime.now();
		//d.replace( @:named("tzinfo") python.lib.datetime.Timezone.utc );

		var x = d.replace.callNamed({ tzinfo : python.lib.datetime.Timezone.utc });
		trace(x);

	}

}