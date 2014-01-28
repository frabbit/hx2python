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

import python.lib.Builtin;
import python.internal.ArrayImpl;
import python.lib.Types;

@:native("list")
extern class Array<T> implements ArrayAccess<T> extends ArrayImpl {

	public var length(get,null) : Int;

	private inline function get_length ():Int return ArrayImpl.get_length(this);
	

	public function new() : Void;


	public inline function concat( a : Array<T>) : Array<T> {
		
		return ArrayImpl.concat(this, a);
	}

	public inline function copy() : Array<T> {
		return ArrayImpl.copy(this);
	}

	@:runtime public inline function iterator() : Iterator<T> {
		return ArrayImpl.iterator(this);
	}

	public function insert( pos : Int, x : T ) : Void;


	public inline function join( sep : String ) : String {
		return ArrayImpl.join(this, sep);
	}

	public inline function toString() : String {
		return ArrayImpl.toString(this);
	}

	@:runtime public inline function pop() : Null<T> {
		return ArrayImpl.pop(this);
	}

	@:runtime public inline function push(x:T) : Int {
		return ArrayImpl.push(this,x);
	}

	public inline function unshift(x : T) : Void {
		return ArrayImpl.unshift(this,x);
	}

	public inline function indexOf(x : T, ?fromIndex:Int) : Int {
		return ArrayImpl.indexOf(this,x, fromIndex);
	}

	public inline function lastIndexOf(x : T, ?fromIndex:Int) : Int {
		return ArrayImpl.lastIndexOf(this,x, fromIndex);
	}

	public inline function remove(x : T) : Bool {
		return ArrayImpl.remove(this,x);
		
	}

	public function reverse() : Void;

	@:runtime public inline function shift() : Null<T> {
		return ArrayImpl.shift(this);
	}

	public inline function slice( pos : Int, ?end : Int ) : Array<T> {
		return ArrayImpl.slice(this, pos, end);
	}

	public inline function sort(f:T->T->Int) : Void {
		return ArrayImpl.sort(this, f);
	}

	public inline function splice( pos : Int, len : Int ) : Array<T> {
		return ArrayImpl.splice(this, pos, len);
	}

	public inline function map<S>( f : T -> S ) : Array<S> {
		return ArrayImpl.map(this, f);
	}

	public inline function filter( f : T -> Bool ) : Array<T> {
		return ArrayImpl.filter(this,f);
	}


	
	@:keep private inline function __get(idx:Int):T
	{
		return ArrayImpl.__get(this, idx);
	}

	@:keep private inline function __set(idx:Int, val:T):T
	{
		return ArrayImpl.__set(this, idx,val);
	}

	@:keep private inline function __unsafe_get(idx:Int):T
	{
		return ArrayImpl.__unsafe_get(this, idx);
	}

	@:keep private inline function __unsafe_set(idx:Int, val:T):T
	{
		return ArrayImpl.__unsafe_set(this, idx,val);
	}

	@:noCompletion public function __iter__ ():PyIterator<T>;

	
}