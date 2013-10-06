<?php

class Std {
	public function __construct(){}
	static function string($s) {
		return _hx_string_rec($s, "");
	}
	function __toString() { return 'Std'; }
}
