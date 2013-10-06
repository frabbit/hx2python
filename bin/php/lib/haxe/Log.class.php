<?php

class haxe_Log {
	public function __construct(){}
	static function trace($v, $infos = null) { return call_user_func_array(self::$trace, array($v, $infos)); }
	public static $trace = null;
	function __toString() { return 'haxe.Log'; }
}
haxe_Log::$trace = array(new _hx_lambda(array(), "haxe_Log_0"), 'execute');
function haxe_Log_0($v, $infos) {
	{
		if($infos !== null && $infos->customParams !== null) {
			$extra = "";
			{
				$_g = 0; $_g1 = $infos->customParams;
				while($_g < $_g1->length) {
					$v1 = $_g1[$_g];
					++$_g;
					$extra .= "," . Std::string($v1);
					unset($v1);
				}
			}
			_hx_trace(Std::string($v) . _hx_string_or_null($extra), $infos);
		} else {
			_hx_trace($v, $infos);
		}
	}
}
