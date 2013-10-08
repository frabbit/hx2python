
package python.lib;

typedef Iterator<T> = {
	function next ():T;
}

typedef Iterable<T> = {
	function __iter__():Iterator<T>;
	
}



typedef Hashable = {
	public function __hash__():Int;
}

typedef Equal = {
	public function __eq__(other:Dynamic):Int;
}

typedef Comparable = {
	
	public function __cmp__(other:Dynamic):Int;
}

extern class FileObject {
	
	public function write (s:String):Void;
	public function flush ():Void;
	public function close ():Void;
	public function tell (offset:Int, whence:Int = 0):Void;


}

//typedef DictKey<T> = {
//	function __hash__():Int;
//	function __eq__(other:Dynamic):Int;
//	function __cmp__(other:Dynamic):Int;
//}

@:native("set")
extern class Set<T> 
{

	public function new (?iterable:python.lib.Types.Iterable<T>):Void;

	public inline function length ():Int 
	{
		return python.lib.Builtin.len(this);
	}
}


@:native("dict")
extern class Dict<K, V>
{
	public function new ():Void;

	public inline function length ():Int 
	{
		return python.lib.Builtin.len(this);
	}
}


extern class Tuple implements ArrayAccess<Dynamic> {

}

extern class Tup2<A,B> 
{
	public static inline function create <A,B>(a:A, b:B):Tup2<A,B> return untyped __python_tuple__(a,b);
	public var _1(get, null):A;
	public inline function get__1():A return untyped __python_array_get__(this, 0);
	public var _2(get, null):B;
	public inline function get__2():B return untyped __python_array_get__(this, 1);
}

extern class Tup3<A,B,C> 
{
	public static inline function create <A,B,C>(a:A, b:B,c:C):Tup3<A,B,C> return untyped __python_tuple__(a,b,c);
	public var _1(get, null):A;
	public inline function get__1():A return untyped __python_array_get__(this, 0);
	public var _2(get, null):B;
	public inline function get__2():B return untyped __python_array_get__(this, 1);
	public var _3(get, null):C;
	public inline function get__3():C return untyped __python_array_get__(this, 2);
}

extern class Tup4<A,B,C,D> 
{
	public static inline function create <A,B,C,D>(a:A, b:B,c:C,d:D):Tup4<A,B,C,D> return untyped __python_tuple__(a,b,c,d);
	public var _1(get, null):A;
	public inline function get__1():A return untyped __python_array_get__(this, 0);
	public var _2(get, null):B;
	public inline function get__2():B return untyped __python_array_get__(this, 1);
	public var _3(get, null):C;
	public inline function get__3():C return untyped __python_array_get__(this, 2);
	public var _4(get, null):D;
	public inline function get__4():D return untyped __python_array_get__(this, 3);
}



@:native("BaseException")
extern class BaseException 
{
	public function new ():Void;
}



@:native("BufferError")
extern class BufferError extends BaseException
{
	
}

@:native("GeneratorExit")
extern class GeneratorExit extends BaseException
{
	
}

@:native("KeyboardInterrupt")
extern class KeyboardInterrupt extends BaseException
{
	
}

@:native("Exception")
extern class Exception extends BaseException 
{

}

@:native("SyntaxError")
extern class SyntaxError extends Exception
{
	
}

@:native("StopIteration")
extern class StopIteration extends Exception
{
	
}

@:native("RuntimeError")
extern class RuntimeError extends Exception
{
	
}

@:native("NotImplementedError")
extern class NotImplementedError extends RuntimeError
{
	
}

@:native("IndentationError")
extern class IndentationError extends SyntaxError
{
	
}

@:native("EnvironmentError")
extern class EnvironmentError extends Exception
{
	
}

@:native("OSError")
extern class OSError extends EnvironmentError
{
	
}

@:native("BlockingIOError")
extern class BlockingIOError extends OSError
{
	
}

@:native("ChildProcessError")
extern class ChildProcessError extends OSError
{
	
}

@:native("ConnectionError")
extern class ConnectionError extends OSError
{
	
}

@:native("BrokenPipeError")
extern class BrokenPipeError extends ConnectionError
{
	
}

@:native("ConnectionAbortedError")
extern class ConnectionAbortedError extends ConnectionError 
{

}
@:native("ConnectionRefusedError")
extern class ConnectionRefusedError extends ConnectionError 
{

}
@:native("ConnectionResetError")
extern class ConnectionResetError extends ConnectionError 
{

}

@:native("FileExistsError")
extern class FileExistsError extends OSError
{

}
@:native("FileNotFoundError")
extern class FileNotFoundError extends OSError
{

}
@:native("InterruptedError")
extern class InterruptedError extends OSError
{

}
@:native("IsADirectoryError")
extern class IsADirectoryError extends OSError
{

}
@:native("NotADirectoryError")
extern class NotADirectoryError extends OSError
{

}
@:native("PermissionError")
extern class PermissionError extends OSError
{

}
@:native("ProcessLookupError")
extern class ProcessLookupError extends OSError
{

}
@:native("TimeoutError")
extern class TimeoutError extends OSError
{

}


@:native("NameError")
extern class NameError extends Exception
{
	
}

@:native("UnboundLocalError")
extern class UnboundLocalError extends NameError
{
	
}

@:native("MemoryError")
extern class MemoryError extends Exception
{
	
}

@:native("AssertionError")
extern class AssertionError extends Exception
{
	
}

@:native("AttributeError")
extern class AttributeError extends Exception
{
	
}

@:native("EOFError")
extern class EOFError extends Exception
{
	
}

@:native("ArithmeticError")
extern class ArithmeticError extends Exception
{
	
}



@:native("FloatingPointError")
extern class FloatingPointError extends ArithmeticError
{
	
}

@:native("OverflowError")
extern class OverflowError extends ArithmeticError
{
	
}


@:native("ZeroDivisionError")
extern class ZeroDivisionError extends ArithmeticError
{
	
}



@:native("ImportError")
extern class ImportError extends Exception
{
	
}

@:native("LookupError")
extern class LookupError extends Exception
{
	
}

@:native("IndexError")
extern class IndexError extends LookupError
{
	
}

@:native("KeyError")
extern class KeyError extends LookupError
{
	
}







@:native("IOError")
extern class IOError extends EnvironmentError
{
	
}

@:native("VMSError")
extern class VMSError extends OSError
{
	
}

@:native("WindowsError")
extern class WindowsError extends OSError
{
	
}






@:native("ValueError")
extern class ValueError extends Exception
{
	
}

@:native("UnicodeError")
extern class UnicodeError extends ValueError
{

}
@:native("UnicodeDecodeError")
extern class UnicodeDecodeError extends UnicodeError
{

}
@:native("UnicodeEncodeError")
extern class UnicodeEncodeError extends UnicodeError
{

}
@:native("UnicodeTranslateError")
extern class UnicodeTranslateError extends UnicodeError
{

}

@:native("Warning")
extern class Warning extends Exception
{

}

@:native("DeprecationWarning")
extern class DeprecationWarning extends Warning 
{

}
@:native("PendingDeprecationWarning")
extern class PendingDeprecationWarning extends Warning 
{

}
@:native("RuntimeWarning")
extern class RuntimeWarning extends Warning 
{

}
@:native("SyntaxWarning")
extern class SyntaxWarning extends Warning 
{

}
@:native("UserWarning")
extern class UserWarning extends Warning 
{

}
@:native("FutureWarning")
extern class FutureWarning extends Warning 
{

}
@:native("ImportWarning")
extern class ImportWarning extends Warning 
{

}
@:native("UnicodeWarning")
extern class UnicodeWarning extends Warning 
{

}
@:native("BytesWarning")
extern class BytesWarning extends Warning 
{

}
@:native("ResourceWarning")
extern class ResourceWarning extends Warning 
{

}