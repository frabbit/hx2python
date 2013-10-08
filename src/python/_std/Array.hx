/*
 * Copyright (C)2005-2012 Haxe Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */


@:native("list")
extern class Array<T> implements ArrayAccess<T> {

	

	public var length(get,null) : Int;

	private inline function get_length ():Int return python.lib.Builtin.len(cast this);
	

	public function new() : Void;


	public inline function concat( a : Array<T>) : Array<T> {
		
		return untyped (untyped this) + (untyped a);
	}

	public inline function copy() : Array<T> {
		return untyped list(this);
	}

	public inline function iterator() : Iterator<T> {
		return throw "not implemented";
	}

	public inline function insert( pos : Int, x : T ) : Void {
		return throw "not implemented";
	}

	public inline function join( sep : String ) : String {
		return untyped sep.join(this);
	}

	public inline function toString() : String {
		return untyped str(this);
	}

	public inline function pop() : Null<T> {
		return if (this.length == 0) null else untyped(this).pop();
	}

	public inline function push(x:T) : Int {
		untyped this.append(x);
		
		return length;
	}

	public inline function unshift(x : T) : Void {
		return throw "not implemented";
	}

	public inline function remove(x : T) : Bool {
		return throw "not implemented";
	}

	public inline function reverse() : Void {
		return throw "not implemented";
	}

	public inline function shift() : Null<T> {
		return throw "not implemented";
	}

	public inline function slice( pos : Int, ?end : Int ) : Array<T> {
		return throw "not implemented";
	}

	public inline function sort(f:T->T->Int) : Void {
		return throw "not implemented";
	}

	public inline function splice( pos : Int, len : Int ) : Array<T> {
		return throw "not implemented";
	}

	public inline function map<S>( f : T -> S ) : Array<S> {
		return untyped list(untyped __python__("map")(f,this));
	}

	public function filter( f : T -> Bool ) : Array<T> {
		return Builtin.filter(f, this);
	}


	
	@:keep private inline function __get(idx:Int):T
	{
		var _hx_a = this;
		if (idx >= _hx_a.length || idx < 0)
			return null;

		return untyped this[idx];
	}

	@:keep private inline function __set(idx:Int, v:T):T
	{
		var _hx_a = this;

		untyped _hx_a[idx] = v;
		return v;
	}

	@:keep private inline function __unsafe_get(idx:Int):T
	{
		return untyped this[idx];
	}

	@:keep private inline function __unsafe_set(idx:Int, val:T):T
	{
		untyped this[idx] = val;
		return val;
	}

	
}