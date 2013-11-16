
package python.internal;

using Lambda;



class KeywordHandler {

	static var keywords = [
		"and" => true,       "del" => true,       "from" => true,      "not" => true,       "while" => true,
		"as" => true,        "elif" => true,      "global" => true,    "or" => true,        "with" => true,
		"assert" => true,    "else" => true,      "if" => true,        "pass" => true,      "yield" => true,
		"break" => true,     "except" => true,    "import" => true,    "print" => true,		"float" => true,
		"class" => true,     "exec" => true,      "in" => true,        "raise" => true,
		"continue" => true,  "finally" => true,   "is" => true,        "return" => true,
		"def" => true,       "for" => true,       "lambda" => true,    "try" => true
	];

	public static function handleKeywords(name:String)
    {
        if(keywords.exists(name))
            return "_hx_" + name;
        return name;
    }

    public static function unhandleKeywords(name:String)
    {
    	if (name.substr(0,4) == "_hx_") {
    		var real = name.substr(4);
    		if (keywords.exists(real)) return real;
    	}
    	return name;
    }

}