<?php

class Color extends Enum {
	public static function Alpha($a, $c) { return new Color("Alpha", 3, array($a, $c)); }
	public static $BLACK;
	public static $RED;
	public static function RGB($r, $g, $b) { return new Color("RGB", 2, array($r, $g, $b)); }
	public static $__constructors = array(3 => 'Alpha', 1 => 'BLACK', 0 => 'RED', 2 => 'RGB');
	}
Color::$BLACK = new Color("BLACK", 1);
Color::$RED = new Color("RED", 0);
