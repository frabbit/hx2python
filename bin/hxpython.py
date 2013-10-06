
class _HxException(Exception):
    # String tag;
    # int index;
    # List params;
    def __init__(self, val):
        try:
            message = Std.string(val)
        except Exception as e:
            message = '_HxException'
        Exception.__init__(self, message)
        self.val = val


class AnonObject(object):
    def __init__(self, **kwargs):
        self.__dict__.update(kwargs)
class Array:


	def __init__(self):
		self._hx_a = []
		self.length = 0
	
	def __unsafe_set(self,idx,val):
		self._hx_a[idx] = val
		return val
	

	def __unsafe_get(self,idx):
		return self._hx_a[idx]

	def __set(self,idx,v):
		_hx_a = self._hx_a
		if idx >= self.length:
			self.length = idx + 1
		
		_hx_a[idx] = v
		return v
	

	def __get(self,idx):
		_hx_a = self._hx_a
		if idx >= len(_hx_a) or idx < 0:
			return None
		
		return self._hx_a[idx]
	

	# var length
	# var _hx_a




def Array_statics_new1(a,l):
	inst = Array()
	inst._hx_a = a
	inst.length = l
	return inst
	
Array.new1 = Array_statics_new1
class Main:

	pass



def Main_statics_main():
	ReflectDemo.main()
	TypeDemo.main()
	
Main.main = Main_statics_main
class Reflect:

	pass



def Reflect_statics_field(o,field):
	v = None
	try:
		v = __builtin__.getattr(o, field)
	except Exception as _hx_e:
		_hx_e1 = _hx_e.val if isinstance(_hx_e, _HxException) else _hx_e
		if True:
			e = _hx_e1
			None
		else:
			raise _hx_e
	return v
	
Reflect.field = Reflect_statics_field
def Reflect_statics_getProperty(o,field):
	tmp = None
	if o is None:
		return None
	else:
		tmp = Reflect.field(o, "get_" + field)
		if tmp is not None and __builtin__.callable(tmp):
			return tmp()
		else:
			return Reflect.field(o, field)
	
	
Reflect.getProperty = Reflect_statics_getProperty
class ReflectDemo:

	pass



def ReflectDemo_statics_main():
	o = AnonObject(age = 17 ,name = "hey" )
	setattr(o, "age", 22)
	print(Std.string(o.age))
	setattr(o, "name", "jimmy")
	print(Std.string(Reflect.field(o, "name")))
	print(Std.string(Reflect.field(o, "name_x")))
	print(Std.string(Reflect.getProperty(o, "name")))
	tmp = 1
	if not (Reflect.getProperty(o, "name") is None):
		print(Std.string("hey"))
	elif o.age > 10:
		print(Std.string(tmp))
	else:
		print(Std.string("whatever"))
	
ReflectDemo.main = ReflectDemo_statics_main
class Std:

	pass



def Std_statics__hx_is(v,t):
	if t == str:
		return isinstance(v, str)
	return isinstance(v, t)
	
Std._hx_is = Std_statics__hx_is
def Std_statics_string(s):
	if Std._hx_is(s, str):
		return s
	
	try:
		return s.toString()
	except Exception as _hx_e:
		_hx_e1 = _hx_e.val if isinstance(_hx_e, _HxException) else _hx_e
		if True:
			e = _hx_e1
			try:
				return s.__str__()
			except Exception as _hx_e:
				_hx_e1 = _hx_e.val if isinstance(_hx_e, _HxException) else _hx_e
				if True:
					e1 = _hx_e1
					try:
						return str(s)
					except Exception as _hx_e:
						_hx_e1 = _hx_e.val if isinstance(_hx_e, _HxException) else _hx_e
						if True:
							e2 = _hx_e1
							return "##Cannot convert to String##"
						else:
							raise _hx_e
				else:
					raise _hx_e
		else:
			raise _hx_e
	
Std.string = Std_statics_string
class Type:

	pass



def Type_statics_createInstance(cl,args):
	l = args.length
	if l == 0:
		return cl()
	elif l == 1:
		return cl(args._hx_a[0])
	elif l == 2:
		return cl(args._hx_a[0], args._hx_a[1])
	elif l == 3:
		return cl(args._hx_a[0], args._hx_a[1], args._hx_a[2])
	elif l == 4:
		return cl(args._hx_a[0], args._hx_a[1], args._hx_a[2], args._hx_a[3])
	elif l == 5:
		return cl(args._hx_a[0], args._hx_a[1], args._hx_a[2], args._hx_a[3], args._hx_a[4])
	elif l == 6:
		return cl(args._hx_a[0], args._hx_a[1], args._hx_a[2], args._hx_a[3], args._hx_a[4], args._hx_a[5])
	elif l == 7:
		return cl(args._hx_a[0], args._hx_a[1], args._hx_a[2], args._hx_a[3], args._hx_a[4], args._hx_a[5], args._hx_a[6])
	elif l == 8:
		return cl(args._hx_a[0], args._hx_a[1], args._hx_a[2], args._hx_a[3], args._hx_a[4], args._hx_a[5], args._hx_a[6], args._hx_a[7])
	else:
		raise _HxException("Too many arguments")
	return None
	
Type.createInstance = Type_statics_createInstance
def Type_statics_createEmptyInstance(cl):
	return cl.__new__(cl)
Type.createEmptyInstance = Type_statics_createEmptyInstance
class TypeDemo_Foo:


	def __init__(self):
		self.z = 5
	# var z




class TypeDemo:

	pass



def TypeDemo_statics_main():
	f = Type.createEmptyInstance(TypeDemo_Foo)
	print(Std.string(Std._hx_is(f, TypeDemo_Foo)))
	f2 = Type.createInstance(TypeDemo_Foo, Array.new1([], 0))
	print(Std.string(f2.z))
	
TypeDemo.main = TypeDemo_statics_main
import builtins as __builtin__
import sys as python_lib_Sys
Main.main()#transformedMain.main()
