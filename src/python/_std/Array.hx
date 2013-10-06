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



@:coreApi @:final class Array<T> implements ArrayAccess<T> {

	private var _hx_a : python.NativeList<T>;
	public var length(default,null) : Int;

	

	public function new() : Void {
		this._hx_a = untyped __python__("[]");
		this.length = 0;
	}

	@:keep private static function new1<T>(a:python.NativeList<T>,l:Int) : Array<T> {
		var inst = new Array<T>();
		inst._hx_a = a;
		inst.length = l;
		return inst;
	}

	public inline function concat( a : Array<T>) : Array<T> {
		
		return new1(cast ((cast(_hx_a)) + (cast a._hx_a)), length + a.length);
	}

	public inline function copy() : Array<T> {
		return new1(untyped __call__(list, _hx_a), _hx_a.length);
	}

	public function iterator() : Iterator<T> {
		return throw "not implemented";
	}

	public function insert( pos : Int, x : T ) : Void {
		return throw "not implemented";
	}

	public function join( sep : String ) : String {
		return throw "not implemented";
	}

	public function toString() : String {
		return untyped str(_hx_a);
	}

	public function pop() : Null<T> {
		return throw "not implemented";
	}

	public function push(x:T) : Int {
		_hx_a.append(x);
		length+=1;
		return length;
	}

	public function unshift(x : T) : Void {
		return throw "not implemented";
	}

	public function remove(x : T) : Bool {
		return throw "not implemented";
	}

	public function reverse() : Void {
		return throw "not implemented";
	}

	public function shift() : Null<T> {
		return throw "not implemented";
	}

	public function slice( pos : Int, ?end : Int ) : Array<T> {
		return throw "not implemented";
	}

	public function sort(f:T->T->Int) : Void {
		return throw "not implemented";
	}

	public function splice( pos : Int, len : Int ) : Array<T> {
		return throw "not implemented";
	}

	public function map<S>( f : T -> S ) : Array<S> {
		return new1(untyped __python__("list(map(f,self._hx_a))"), length);
	}

	public function filter( f : T -> Bool ) : Array<T> {
		return throw "not implemented";
	}


	/* NEKO INTERNAL */
	@:keep private function __get(idx:Int):T
	{
		var _hx_a = _hx_a;
		if (idx >= _hx_a.length || idx < 0)
			return null;

		return untyped __python__("self._hx_a[idx]");
	}

	@:keep private function __set(idx:Int, v:T):T
	{
		var _hx_a = _hx_a;
		

		if (idx >= length)
			this.length = idx + 1;

		untyped __python_array_set__(_hx_a,idx,v);
		return v;
	}

	@:keep private inline function __unsafe_get(idx:Int):T
	{
		return untyped __python__("self._hx_a[idx]");
	}

	@:keep private inline function __unsafe_set(idx:Int, val:T):T
	{
		untyped __python_array_set__(_hx_a,idx,val);
		return val;
	}

	
}