<?php

class Main {
	public function __construct(){}
	static function main() {
		try {
			haxe_Log::trace(_hx_deref(new _hx_array(array(1, 2)))->concat(new _hx_array(array(3, 4)))->toString(), _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 26, "className" => "Main", "methodName" => "main")));
			haxe_Log::trace(Std::string(_hx_array_get(new _hx_array(array(1, 2, 3)), 1)), _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 27, "className" => "Main", "methodName" => "main")));
			haxe_Log::trace(Std::string(_hx_deref(new _hx_array(array(1, 2, 3)))->copy()), _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 28, "className" => "Main", "methodName" => "main")));
		}catch(Exception $__hx__e) {
			$_ex_ = ($__hx__e instanceof HException) ? $__hx__e->e : $__hx__e;
			if(is_string($e = $_ex_)){
				haxe_Log::trace("catch String", _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 30, "className" => "Main", "methodName" => "main")));
			}
			else if(($x = $_ex_) instanceof Main){
				haxe_Log::trace("catch class", _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 32, "className" => "Main", "methodName" => "main")));
			}
			else if(($x2 = $_ex_) instanceof Color){
				haxe_Log::trace("catch enum", _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 34, "className" => "Main", "methodName" => "main")));
			}
			else { $d = $_ex_;
			{
				haxe_Log::trace("catch dynamic", _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 36, "className" => "Main", "methodName" => "main")));
			}}
		}
		try {
			haxe_Log::trace(_hx_deref(new _hx_array(array(1, 2)))->concat(new _hx_array(array(3, 4)))->toString(), _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 39, "className" => "Main", "methodName" => "main")));
			haxe_Log::trace(Std::string(_hx_array_get(new _hx_array(array(1, 2, 3)), 1)), _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 40, "className" => "Main", "methodName" => "main")));
			haxe_Log::trace(Std::string(_hx_deref(new _hx_array(array(1, 2, 3)))->copy()), _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 41, "className" => "Main", "methodName" => "main")));
		}catch(Exception $__hx__e) {
			$_ex_ = ($__hx__e instanceof HException) ? $__hx__e->e : $__hx__e;
			if(is_string($e2 = $_ex_)){
				haxe_Log::trace("catch String", _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 43, "className" => "Main", "methodName" => "main")));
			}
			else if(($x3 = $_ex_) instanceof Main){
				haxe_Log::trace("catch class", _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 45, "className" => "Main", "methodName" => "main")));
			}
			else if(($x4 = $_ex_) instanceof Color){
				haxe_Log::trace("catch enum", _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 47, "className" => "Main", "methodName" => "main")));
			} else throw $__hx__e;;
		}
		try {
			haxe_Log::trace(_hx_deref(new _hx_array(array(1, 2)))->concat(new _hx_array(array(3, 4)))->toString(), _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 50, "className" => "Main", "methodName" => "main")));
			haxe_Log::trace(Std::string(_hx_array_get(new _hx_array(array(1, 2, 3)), 1)), _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 51, "className" => "Main", "methodName" => "main")));
			haxe_Log::trace(Std::string(_hx_deref(new _hx_array(array(1, 2, 3)))->copy()), _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 52, "className" => "Main", "methodName" => "main")));
		}catch(Exception $__hx__e) {
			$_ex_ = ($__hx__e instanceof HException) ? $__hx__e->e : $__hx__e;
			if(is_string($e3 = $_ex_)){
				haxe_Log::trace("catch String", _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 54, "className" => "Main", "methodName" => "main")));
			}
			else { $x5 = $_ex_;
			{
				haxe_Log::trace("catch class", _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 56, "className" => "Main", "methodName" => "main")));
			}}
			else if(($x6 = $_ex_) instanceof Color){
				haxe_Log::trace("catch enum", _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 58, "className" => "Main", "methodName" => "main")));
			}
		}
		$def = 500;
		{
			$a = "hi";
			$a;
		}
		{
			$a = 1;
			$a;
		}
		$u = 5;
		haxe_Log::trace($u, _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 76, "className" => "Main", "methodName" => "main")));
		{
			$u1 = 10;
			haxe_Log::trace($u1, _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 79, "className" => "Main", "methodName" => "main")));
		}
		haxe_Log::trace($u, _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 81, "className" => "Main", "methodName" => "main")));
		$z = Main_0($d, $def, $e, $u, $x);
		$z2 = Main_1($d, $def, $e, $u, $x, $z);
		if(Main_2($d, $def, $e, $u, $x, $z, $z2)) {
			haxe_Log::trace("hello", _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 88, "className" => "Main", "methodName" => "main")));
		}
		$b = false;
		if($b) {
			haxe_Log::trace("hello", _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 91, "className" => "Main", "methodName" => "main")));
		}
		$z = 1;
		$z1 = Main_3($b, $d, $def, $e, $u, $x, $z, $z2);
		call_user_func($z1);
		$x7 = true;
		while($x7) {
			$x7 = false;
			$z3 = 5;
			if($z3 === 5) {
				haxe_Log::trace($z3, _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 111, "className" => "Main", "methodName" => "main")));
				break;
			}
			1;
			unset($z3);
		}
		do {
			$x7 = false;
		} while($x7);
		$c = Color::RGB(10, 11, 23);
		$t = Main_4($b, $c, $d, $def, $e, $u, $x, $z, $z1, $z2);
		if($x7) {
			throw new HException("whatever");
		}
		$x1 = 1;
		switch($x1) {
		case 1:{
			haxe_Log::trace("it's 1", _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 142, "className" => "Main", "methodName" => "main")));
		}break;
		default:{
			haxe_Log::trace("not 1", _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 144, "className" => "Main", "methodName" => "main")));
			haxe_Log::trace("not 1", _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 145, "className" => "Main", "methodName" => "main")));
		}break;
		}
		switch($x1) {
		case 1:{
			$__hx__t = ($c);
			switch($__hx__t->index) {
			case 0:
			{
				haxe_Log::trace("it's 1 red", _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 151, "className" => "Main", "methodName" => "main")));
			}break;
			default:{
				haxe_Log::trace("not 1 red", _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 152, "className" => "Main", "methodName" => "main")));
			}break;
			}
		}break;
		default:{
			haxe_Log::trace("not 1 red", _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 152, "className" => "Main", "methodName" => "main")));
		}break;
		}
		{
			$_g = 0;
			while($_g < 10) {
				$i = $_g++;
				haxe_Log::trace($i, _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 156, "className" => "Main", "methodName" => "main")));
				unset($i);
			}
		}
		{
			$_g = 0; $_g1 = new _hx_array(array(0, 1, 2));
			while($_g < $_g1->length) {
				$i = $_g1[$_g];
				++$_g;
				haxe_Log::trace($i, _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 160, "className" => "Main", "methodName" => "main")));
				unset($i);
			}
		}
	}
	function __toString() { return 'Main'; }
}
function Main_0(&$d, &$def, &$e, &$u, &$x) {
	{
		$q = 5;
		$z1 = Main_5($d, $def, $e, $q, $u, $x);
		return $z1 + 2;
	}
}
function Main_1(&$d, &$def, &$e, &$u, &$x, &$z) {
	{
		$q1 = 99;
		return array(new _hx_lambda(array(&$d, &$def, &$e, &$e2, &$e3, &$q1, &$u, &$x, &$x2, &$x3, &$x4, &$x5, &$x6, &$z), "Main_6"), 'execute');
	}
}
function Main_2(&$d, &$def, &$e, &$u, &$x, &$z, &$z2) {
	{
		$x7 = 0;
		return $x7 > 0;
	}
}
function Main_3(&$b, &$d, &$def, &$e, &$u, &$x, &$z, &$z2) {
	if(Main_7($b, $d, $def, $e, $u, $x, $z, $z2)) {
		return array(new _hx_lambda(array(&$b, &$d, &$def, &$e, &$e2, &$e3, &$u, &$x, &$x2, &$x3, &$x4, &$x5, &$x6, &$z, &$z2), "Main_8"), 'execute');
	} else {
		return array(new _hx_lambda(array(&$b, &$d, &$def, &$e, &$e2, &$e3, &$u, &$x, &$x2, &$x3, &$x4, &$x5, &$x6, &$z, &$z2), "Main_9"), 'execute');
	}
}
function Main_4(&$b, &$c, &$d, &$def, &$e, &$u, &$x, &$z, &$z1, &$z2) {
	$__hx__t = ($c);
	switch($__hx__t->index) {
	case 0:
	{
		haxe_Log::trace("it's red", _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 127, "className" => "Main", "methodName" => "main")));
		return $c;
	}break;
	case 2:
	$c_eRGB_2 = $__hx__t->params[2]; $c_eRGB_1 = $__hx__t->params[1]; $c_eRGB_0 = $__hx__t->params[0];
	{
		switch($c_eRGB_0) {
		case 20:{
			haxe_Log::trace("has 20 red", _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 128, "className" => "Main", "methodName" => "main")));
			return $c;
		}break;
		case 10:{
			haxe_Log::trace("has 10 red", _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 129, "className" => "Main", "methodName" => "main")));
			return $c;
		}break;
		default:{
			haxe_Log::trace("other rgb", _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 130, "className" => "Main", "methodName" => "main")));
			return $c;
		}break;
		}
	}break;
	case 1:
	{
		haxe_Log::trace("it's black", _hx_anonymous(array("fileName" => "Main.hx", "lineNumber" => 131, "className" => "Main", "methodName" => "main")));
		return $c;
	}break;
	case 3:
	$c_eAlpha_1 = $__hx__t->params[1]; $c_eAlpha_0 = $__hx__t->params[0];
	{
		$__hx__t2 = ($c_eAlpha_1);
		switch($__hx__t2->index) {
		case 1:
		{
			return $c;
		}break;
		case 2:
		$c_eAlpha_1_eRGB_2 = $__hx__t2->params[2]; $c_eAlpha_1_eRGB_1 = $__hx__t2->params[1]; $c_eAlpha_1_eRGB_0 = $__hx__t2->params[0];
		{
			switch($c_eAlpha_1_eRGB_0) {
			case 10:{
				return $c;
			}break;
			default:{
				return $c;
			}break;
			}
		}break;
		default:{
			return $c;
		}break;
		}
	}break;
	}
}
function Main_5(&$d, &$def, &$e, &$q, &$u, &$x) {
	{
		$d2 = 0;
		return $d2 + $q + 1;
	}
}
function Main_6(&$d, &$def, &$e, &$q1, &$u, &$x, &$z) {
	{
		return $q1;
	}
}
function Main_7(&$b, &$d, &$def, &$e, &$u, &$x, &$z, &$z2) {
	{
		$z = (($b) ? 2 : 3);
		return $z > 2;
	}
}
function Main_8(&$b, &$d, &$def, &$e, &$u, &$x, &$z, &$z2) {
	{
		return $z + 1;
	}
}
function Main_9(&$b, &$d, &$def, &$e, &$u, &$x, &$z, &$z2) {
	{
		return $z + 2;
	}
}
