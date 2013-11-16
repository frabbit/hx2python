import python.lib.Builtin;
import python.lib.Re;
import python.lib.Re.MatchObject;
import python.lib.Re.Pattern;

class EReg {

	/**
		Creates a new regular expression with pattern `r` and modifiers `opt`.
		
		This is equivalent to the shorthand syntax `~/r/opt`
		
		If `r` or `opt` are null, the result is unspecified.
	**/

	var pattern:Pattern;
	var matchObj:MatchObject;
	var global:Bool;
	

	public function new( r : String, opt : String ) {
		global = false;
		var options = 0;
		for (i in 0...opt.length) {
			var c = StringTools.fastCodeAt(opt, i);
			if (c == "m".code) options |= Re.M;
			if (c == "i".code) options |= Re.I;
			if (c == "s".code) options |= Re.S;
			if (c == "u".code) options |= Re.U;
			if (c == "g".code) global = true;
		}
		
		

		

		pattern = Re.compile(r, options);
	}

	/**
		Tells if `this` regular expression matches String `s`.
		
		This method modifies the internal state.
		
		If `s` is `null`, the result is unspecified.
	**/
	public function match( s : String ) : Bool {
		matchObj = global ? Re.search(pattern, s) : Re.match(pattern, s);
		return matchObj != null;
	}

	/**
		Returns the matched sub-group `n` of `this` EReg.
		
		This method should only be called after `this.match` or
		`this.matchSub`, and then operates on the String of that operation.
		
		The index `n` corresponds to the n-th set of parentheses in the pattern
		of `this` EReg. If no such sub-group exists, an exception is thrown.
		
		If `n` equals 0, the whole matched substring is returned.
	**/
	public function matched( n : Int ) : String {
		return matchObj.group(n);
	}

	/**
		Returns the part to the left of the last matched substring.
		
		If the most recent call to `this.match` or `this.matchSub` did not
		match anything, the result is unspecified.
		
		If the global g modifier was in place for the matching, only the
		substring to the left of the leftmost match is returned.
		
		The result does not include the matched part.
	**/
	public function matchedLeft() : String {
		return matchObj.string.substr(0, matchObj.start());
	}

	/**
		Returns the part to the right of the last matched substring.
		
		If the most recent call to `this.match` or `this.matchSub` did not
		match anything, the result is unspecified.
		
		If the global g modifier was in place for the matching, only the
		substring to the right of the leftmost match is returned.
		
		The result does not include the matched part.
	**/
	public function matchedRight() : String {
		return matchObj.string.substr(matchObj.end());
	}

	/**
		Returns the position and length of the last matched substring, within
		the String which was last used as argument to `this.match` or
		`this.matchSub`.
		
		If the most recent call to `this.match` or `this.matchSub` did not
		match anything, the result is unspecified.
		
		If the global g modifier was in place for the matching, the position and
		length of the leftmost substring is returned.
	**/
	public function matchedPos() : { pos : Int, len : Int } {
		return { pos : matchObj.pos, len : matchObj.end() - matchObj.start() };
	}

	/**
		Tells if `this` regular expression matches a substring of String `s`.
		
		This function expects `pos` and `len` to describe a valid substring of
		`s`, or else the result is unspecified. To get more robust behavior,
		`this.matchSub(s.substr(pos,len))` can be used instead.
		
		This method modifies the internal state.
		
		If `s` is null, the result is unspecified.
	**/
	public function matchSub( s : String, pos : Int, len : Int = 0):Bool {
		return this.match(s.substr(pos, len));
	}

	/**
		Splits String `s` at all substrings `this` EReg matches.
		
		If a match is found at the start of `s`, the result contains a leading
		empty String "" entry.
		
		If a match is found at the end of `s`, the result contains a trailing
		empty String "" entry.
		
		If two matching substrings appear next to each other, the result
		contains the empty String "" between them.
		
		By default, this method splits `s` into two parts at the first matched
		substring. If the global g modifier is in place, `s` is split at each
		matched substring.
		
		If `s` is null, the result is unspecified.
	**/
	public function split( s : String ) : Array<String> {
		return if (global) {
			var ret = [];
			var lastEnd = 0;
			for (x in Re.finditer(pattern, s)) {
				ret.push(s.substring(lastEnd, x.start() ));
				lastEnd = x.end();
			}
			ret.push(s.substr(lastEnd));
			return ret;
		} else {
			this.match(s);
			if (matchObj == null) {
				
				return [s];
			} else {
				trace(matchObj.lastindex);
				return [ s.substring(0, matchObj.start()), s.substr(matchObj.end()) ];
			}

		}
	}

	/**
		Replaces the first substring of `s` which `this` EReg matches with `by`.
		
		If `this` EReg does not match any substring, the result is `s`.
		
		By default, this method replaces only the first matched substring. If
		the global g modifier is in place, all matched substrings are replaced.
		
		If `by` contains `$1` to `$9`, the digit corresponds to number of a
		matched sub-group and its value is used instead. If no such sub-group
		exists, the replacement is unspecified. The string `$$` becomes `$`.
		
		If `s` or `by` are null, the result is unspecified.
	**/
	public function replace( s : String, by : String ) : String 
	{
		function replace (x:MatchObject) {
			var res = by;
			var g = x.groups();
			for (i in 0...g.length) {
				res = res.split("$"+Builtin.str(i+1)).join(g[i]);
			}
			return res;
		}
		return Re.sub(pattern, replace, s, global ? 0 : 1 );
	}

	/**
		For each occurence of the pattern in the string `s`, the function `f` is called and
		can return the string that needs to be replaced. All occurences are matched anyway,
		and setting the `g` flag might cause some incorrect behavior on some platforms.
	**/
	public function map( s : String, f : EReg -> String ) : String {
		var buf = new StringBuf();
		while( true ) {
			if( !match(s) )
				break;
			buf.add(matchedLeft());
			buf.add(f(this));
			s = matchedRight();
		}
		buf.add(s);
		return buf.toString();
	}
}