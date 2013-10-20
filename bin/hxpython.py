_hx_classes = dict()
class Int:
    pass
_hx_classes['Int'] = Int
class Float:
    pass
_hx_classes['Float'] = Float
class Dynamic:
    pass
_hx_classes['Dynamic'] = Dynamic
import math as _hx_math

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
class ArrayDemo:


	def __init__(self):
		def _hx_local_0():
			return AnonObject(fileName = "ArrayDemo.hx" ,lineNumber = 6 ,className = "ArrayDemo" ,methodName = "new" )
		print(Std.string("ArrayDemo"))
		list()
		a1 = [1, 2, 3]
		def _hx_local_1():
			return AnonObject(fileName = "ArrayDemo.hx" ,lineNumber = 14 ,className = "ArrayDemo" ,methodName = "new" )
		print(Std.string(a1))
		a1.append(4)
		__builtin__.len(a1)
		
		def _hx_local_2():
			return AnonObject(fileName = "ArrayDemo.hx" ,lineNumber = 18 ,className = "ArrayDemo" ,methodName = "new" )
		print(Std.string(a1))
		a2 = [1, 2, 3]
		def _hx_local_3(x):
			return 100 + x
		def _hx_local_4():
			return AnonObject(fileName = "ArrayDemo.hx" ,lineNumber = 22 ,className = "ArrayDemo" ,methodName = "new" )
		print(Std.string(list(map(_hx_local_3, a2))))
	






ArrayDemo._hx_class = ArrayDemo
ArrayDemo._hx_class_name = "ArrayDemo"
_hx_classes['ArrayDemo'] = ArrayDemo
ArrayDemo._hx_fields = []
ArrayDemo._hx_props = []
ArrayDemo._hx_methods = []
ArrayDemo._hx_statics = []
ArrayDemo._hx_interfaces = []

class ControlFlowDemo:


	def __init__(self):
		self.NAMED_FUNCTION()
		jimmy = 22
		def _hx_local_0():
			return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 12 ,className = "ControlFlowDemo" ,methodName = "new" )
		print(Std.string("\n\n-------------CONDITIONAL---------------\n"))
		if ControlFlowDemo.STATIC_VAR == "staticVar":
			def _hx_local_1():
				return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 17 ,className = "ControlFlowDemo" ,methodName = "new" )
			print(Std.string("STATIC_VAR == \"staticVar\" is true"))
		
		else:
			def _hx_local_2():
				return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 21 ,className = "ControlFlowDemo" ,methodName = "new" )
			print(Std.string("STATIC_VAR == \"staticVar\" is false"))
			def _hx_local_3():
				return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 22 ,className = "ControlFlowDemo" ,methodName = "new" )
			print(Std.string("STATIC_VAR == \"staticVar\" is false"))
		
		def _hx_local_4():
			return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 25 ,className = "ControlFlowDemo" ,methodName = "new" )
		print(Std.string("\n\n-------------SWITCH---------------\n"))
		jimmy = 33
		if jimmy == 1:
			def _hx_local_5():
				return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 31 ,className = "ControlFlowDemo" ,methodName = "new" )
			print(Std.string("jimmy is 1"))
		
		elif jimmy == 3:
			def _hx_local_6():
				return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 32 ,className = "ControlFlowDemo" ,methodName = "new" )
			print(Std.string("jimmy is 3"))
		
		elif jimmy == 88:
			def _hx_local_7():
				return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 33 ,className = "ControlFlowDemo" ,methodName = "new" )
			print(Std.string("jimmy is 88"))
		
		elif jimmy == 33:
			def _hx_local_8():
				return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 34 ,className = "ControlFlowDemo" ,methodName = "new" )
			print(Std.string("jimmy is 33"))
		
		else:
			def _hx_local_9():
				return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 35 ,className = "ControlFlowDemo" ,methodName = "new" )
			print(Std.string("default: don\'t konw how old jimmy is"))
		
		def _hx_local_10():
			return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 51 ,className = "ControlFlowDemo" ,methodName = "new" )
		print(Std.string("\n\n-------------WHILE---------------\n"))
		count = 0
		def _hx_local_12():
			def _hx_local_11():
				nonlocal count
				_hx_r = count
				count = count + 1
				return _hx_r
				
			
			return _hx_local_11() < 3
		
		while _hx_local_12():
			def _hx_local_13():
				return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 56 ,className = "ControlFlowDemo" ,methodName = "new" )
			print(Std.string("count = ") + Std.string(count))
		
		def _hx_local_14():
			return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 59 ,className = "ControlFlowDemo" ,methodName = "new" )
		print(Std.string("\n\n-------------FOR---------------\n"))
		_g = 0
		while _g < 3:
			def _hx_local_15():
				nonlocal _g
				_hx_r = _g
				_g = _g + 1
				return _hx_r
				
			
			i = _hx_local_15()
			def _hx_local_16():
				return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 63 ,className = "ControlFlowDemo" ,methodName = "new" )
			print(Std.string("i = ") + Std.string(i))
		
		
		def _hx_local_17():
			return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 66 ,className = "ControlFlowDemo" ,methodName = "new" )
		print(Std.string("-------------FOR OVER ITERTOR---------------"))
		it = [1, 2, 3, 4]
		_g = 0
		while _g < len(it):
			i = it[_g]
			_g = _g + 1
			def _hx_local_18():
				return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 72 ,className = "ControlFlowDemo" ,methodName = "new" )
			print(Std.string(i))
		
		
		def _hx_local_19():
			return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 75 ,className = "ControlFlowDemo" ,methodName = "new" )
		print(Std.string("\n\n-------------TRY CATCH: SUCCESS---------------\n"))
		str = "string"
		x = "anotherString"
		def _hx_local_20(a,b):
			return a + b
		noError = _hx_local_20
		def _hx_local_22():
			return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 88 ,className = "ControlFlowDemo" ,methodName = "new" )
		try:
			noError(str, x)
			def _hx_local_21():
				return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 84 ,className = "ControlFlowDemo" ,methodName = "new" )
			print(Std.string("no error"))
		
		except Exception as _hx_e:
			_hx_e1 = _hx_e.val if isinstance(_hx_e, _HxException) else _hx_e
			if True:
				e = _hx_e1
				print(Std.string("error = ") + Std.string(e))
			else:
				raise _hx_e
		def _hx_local_23():
			return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 91 ,className = "ControlFlowDemo" ,methodName = "new" )
		print(Std.string("\n\n-------------TRY CATCH: ERROR---------------\n"))
		str1 = "string"
		x1 = 0
		def _hx_local_24(a,b):
			return a + b
		causeError = _hx_local_24
		def _hx_local_26():
			return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 104 ,className = "ControlFlowDemo" ,methodName = "new" )
		try:
			causeError(str1, x1)
			def _hx_local_25():
				return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 100 ,className = "ControlFlowDemo" ,methodName = "new" )
			print(Std.string("no error"))
		
		except Exception as _hx_e:
			_hx_e1 = _hx_e.val if isinstance(_hx_e, _HxException) else _hx_e
			if True:
				e = _hx_e1
				print(Std.string("Success: error = ") + Std.string(e))
			else:
				raise _hx_e
		def _hx_local_27():
			return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 107 ,className = "ControlFlowDemo" ,methodName = "new" )
		print(Std.string("\n\n--------------------------------------------\n"))
	
	def NAMED_FUNCTION(self):
		None





ControlFlowDemo.STATIC_VAR = "staticVar"#transformed"staticVar"


ControlFlowDemo._hx_class = ControlFlowDemo
ControlFlowDemo._hx_class_name = "ControlFlowDemo"
_hx_classes['ControlFlowDemo'] = ControlFlowDemo
ControlFlowDemo._hx_fields = []
ControlFlowDemo._hx_props = []
ControlFlowDemo._hx_methods = ["NAMED_FUNCTION"]
ControlFlowDemo._hx_statics = ["STATIC_VAR"]
ControlFlowDemo._hx_interfaces = []

class Main:

	pass




def Main_statics_main():
	Tools.log(":::::ReflectDemo::::::")
	ReflectDemo.main()
	Tools.log(":::::TypeDemo::::::")
	TypeDemo.main()
	Tools.log(":::::StdDemo::::::")
	StdDemo.main()
	Tools.log(":::::PropertyDemo::::::")
	PropertyDemo.main()
	Tools.log(":::::VariousExpressionDemo::::::")
	VariousExpressions.main()
	
Main.main = Main_statics_main


Main._hx_class = Main
Main._hx_class_name = "Main"
_hx_classes['Main'] = Main
Main._hx_fields = []
Main._hx_props = []
Main._hx_methods = []
Main._hx_statics = ["main"]
Main._hx_interfaces = []

class _PropertyDemo_PropertyDemo_Foo:


	def __init__(self):
		self.z = 5
	def get_z(self):
		return self.z

	# var z






_PropertyDemo_PropertyDemo_Foo._hx_class = _PropertyDemo_PropertyDemo_Foo
_PropertyDemo_PropertyDemo_Foo._hx_class_name = "_PropertyDemo._PropertyDemo.Foo"
_hx_classes['_PropertyDemo._PropertyDemo.Foo'] = _PropertyDemo_PropertyDemo_Foo
_PropertyDemo_PropertyDemo_Foo._hx_fields = []
_PropertyDemo_PropertyDemo_Foo._hx_props = ["z"]
_PropertyDemo_PropertyDemo_Foo._hx_methods = ["get_z"]
_PropertyDemo_PropertyDemo_Foo._hx_statics = []
_PropertyDemo_PropertyDemo_Foo._hx_interfaces = []

class PropertyDemo_B:

	pass






PropertyDemo_B._hx_class = PropertyDemo_B
PropertyDemo_B._hx_class_name = "_PropertyDemo.B"
_hx_classes['_PropertyDemo.B'] = PropertyDemo_B
PropertyDemo_B._hx_fields = []
PropertyDemo_B._hx_props = []
PropertyDemo_B._hx_methods = []
PropertyDemo_B._hx_statics = []
PropertyDemo_B._hx_interfaces = []

class PropertyDemo_A:

	pass






PropertyDemo_A._hx_class = PropertyDemo_A
PropertyDemo_A._hx_class_name = "_PropertyDemo.A"
_hx_classes['_PropertyDemo.A'] = PropertyDemo_A
PropertyDemo_A._hx_fields = []
PropertyDemo_A._hx_props = []
PropertyDemo_A._hx_methods = []
PropertyDemo_A._hx_statics = []
PropertyDemo_A._hx_interfaces = [PropertyDemo_B]

class PropertyDemo_C:

	pass






PropertyDemo_C._hx_class = PropertyDemo_C
PropertyDemo_C._hx_class_name = "_PropertyDemo.C"
_hx_classes['_PropertyDemo.C'] = PropertyDemo_C
PropertyDemo_C._hx_fields = []
PropertyDemo_C._hx_props = []
PropertyDemo_C._hx_methods = []
PropertyDemo_C._hx_statics = []
PropertyDemo_C._hx_interfaces = [PropertyDemo_B,PropertyDemo_A]

class PropertyDemo_Z:


	def __init__(self):
		None






PropertyDemo_Z._hx_class = PropertyDemo_Z
PropertyDemo_Z._hx_class_name = "_PropertyDemo.Z"
_hx_classes['_PropertyDemo.Z'] = PropertyDemo_Z
PropertyDemo_Z._hx_fields = []
PropertyDemo_Z._hx_props = []
PropertyDemo_Z._hx_methods = []
PropertyDemo_Z._hx_statics = []
PropertyDemo_Z._hx_interfaces = [PropertyDemo_C,PropertyDemo_B,PropertyDemo_A]

class Enum:
    # String tag;
    # int index;
    # List params;
    def __init__(self, tag, index, params):
        self.tag = tag
        self.index = index
        self.params = params
    
    def __str__(self):
        if params == None:
            res = tag
        else:
            res = tag + '(' + ','.join(params) + ')'
        res

class PropertyDemo_MyEnum(Enum):
	def __init__(self, t, i, p): 
		super(PropertyDemo_MyEnum,self).__init__(t, i, p)


PropertyDemo_MyEnum.MyEnum1 = PropertyDemo_MyEnum("MyEnum1", 0, list())
PropertyDemo_MyEnum.constructs = ["MyEnum1"]
PropertyDemo_MyEnum._hx_class_name = "_PropertyDemo.MyEnum"
_hx_classes['_PropertyDemo.MyEnum'] = PropertyDemo_MyEnum

class PropertyDemo:

	pass




def PropertyDemo_statics_main():
	PropertyDemo_Z
	x = PropertyDemo_Z()
	Std._hx_is(x, PropertyDemo_A)
	f = _PropertyDemo_PropertyDemo_Foo()
	def _hx_local_0():
		return AnonObject(fileName = "PropertyDemo.hx" ,lineNumber = 35 ,className = "PropertyDemo" ,methodName = "main" )
	print(Std.string(Std._hx_is(1, Int)))
	def _hx_local_1():
		return AnonObject(fileName = "PropertyDemo.hx" ,lineNumber = 36 ,className = "PropertyDemo" ,methodName = "main" )
	print(Std.string(Std._hx_is(1, Float)))
	def _hx_local_2():
		return AnonObject(fileName = "PropertyDemo.hx" ,lineNumber = 37 ,className = "PropertyDemo" ,methodName = "main" )
	print(Std.string(Std._hx_is(1.1, Float)))
	def _hx_local_3():
		return AnonObject(fileName = "PropertyDemo.hx" ,lineNumber = 38 ,className = "PropertyDemo" ,methodName = "main" )
	print(Std.string(Std._hx_is(1.1, Int)))
	e1 = PropertyDemo_MyEnum.MyEnum1
	def _hx_local_4():
		return AnonObject(fileName = "PropertyDemo.hx" ,lineNumber = 41 ,className = "PropertyDemo" ,methodName = "main" )
	print(Std.string(Std._hx_is(e1, PropertyDemo_MyEnum)))
	def _hx_local_5():
		return AnonObject(fileName = "PropertyDemo.hx" ,lineNumber = 44 ,className = "PropertyDemo" ,methodName = "main" )
	print(Std.string(f.get_z()))
	def _hx_local_6():
		return AnonObject(fileName = "PropertyDemo.hx" ,lineNumber = 47 ,className = "PropertyDemo" ,methodName = "main" )
	print(Std.string(Std._hx_is(x, PropertyDemo_A)))
	
PropertyDemo.main = PropertyDemo_statics_main


PropertyDemo._hx_class = PropertyDemo
PropertyDemo._hx_class_name = "PropertyDemo"
_hx_classes['PropertyDemo'] = PropertyDemo
PropertyDemo._hx_fields = []
PropertyDemo._hx_props = []
PropertyDemo._hx_methods = []
PropertyDemo._hx_statics = ["main"]
PropertyDemo._hx_interfaces = []

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
def Reflect_statics_fields(o):
	a = []
	if o is not None:
		if __builtin__.hasattr(o, "__dict__"):
			d = __builtin__.getattr(o, "__dict__")
			keys = d.keys()
			for k in keys:
				a.append(k)
	
		
	
	return a
	def _hx_local_1():
		def _hx_local_0():
			raise _HxException("not implemented")
			return None
		
		return _hx_local_0()
	
	return _hx_local_1()
	
Reflect.fields = Reflect_statics_fields


Reflect._hx_class = Reflect
Reflect._hx_class_name = "Reflect"
_hx_classes['Reflect'] = Reflect
Reflect._hx_fields = []
Reflect._hx_props = []
Reflect._hx_methods = []
Reflect._hx_statics = ["field","getProperty","fields"]
Reflect._hx_interfaces = []

class ReflectDemo:

	pass




def ReflectDemo_statics_main():
	def _hx_local_0():
		return AnonObject(age = 17 ,name = "hey" )
	o = _hx_local_0()
	def _hx_local_1():
		return AnonObject(fileName = "ReflectDemo.hx" ,lineNumber = 9 ,className = "ReflectDemo" ,methodName = "main" )
	print(Std.string(Reflect.fields(o)))
	__builtin__.setattr(o, "age", 22)
	def _hx_local_2():
		return AnonObject(fileName = "ReflectDemo.hx" ,lineNumber = 13 ,className = "ReflectDemo" ,methodName = "main" )
	print(Std.string(o.age))
	__builtin__.setattr(o, "name", "jimmy")
	def _hx_local_3():
		return AnonObject(fileName = "ReflectDemo.hx" ,lineNumber = 19 ,className = "ReflectDemo" ,methodName = "main" )
	print(Std.string(Reflect.field(o, "name")))
	def _hx_local_4():
		return AnonObject(fileName = "ReflectDemo.hx" ,lineNumber = 21 ,className = "ReflectDemo" ,methodName = "main" )
	print(Std.string(Reflect.field(o, "name_x")))
	def _hx_local_5():
		return AnonObject(fileName = "ReflectDemo.hx" ,lineNumber = 23 ,className = "ReflectDemo" ,methodName = "main" )
	print(Std.string(Reflect.getProperty(o, "name")))
	tmp = 1
	if not Reflect.getProperty(o, "name") is None:
		def _hx_local_6():
			return AnonObject(fileName = "ReflectDemo.hx" ,lineNumber = 27 ,className = "ReflectDemo" ,methodName = "main" )
		print(Std.string("hey"))
	
	elif o.age > 10:
		def _hx_local_7():
			return AnonObject(fileName = "ReflectDemo.hx" ,lineNumber = 29 ,className = "ReflectDemo" ,methodName = "main" )
		print(Std.string(tmp))
	
	else:
		def _hx_local_8():
			return AnonObject(fileName = "ReflectDemo.hx" ,lineNumber = 31 ,className = "ReflectDemo" ,methodName = "main" )
		print(Std.string("whatever"))
	
	
ReflectDemo.main = ReflectDemo_statics_main


ReflectDemo._hx_class = ReflectDemo
ReflectDemo._hx_class_name = "ReflectDemo"
_hx_classes['ReflectDemo'] = ReflectDemo
ReflectDemo._hx_fields = []
ReflectDemo._hx_props = []
ReflectDemo._hx_methods = []
ReflectDemo._hx_statics = ["main"]
ReflectDemo._hx_interfaces = []

class Std:

	pass




def Std_statics__hx_is(v,t):
	if v is None:
		return False
	elif t is None:
		return False
	elif t == Dynamic:
		return True
	elif t == Int and __builtin__.isinstance(v, int):
		return True
	elif t == Float and __builtin__.isinstance(v, (float,int)) or __builtin__.isinstance(v, int):
		return True
	elif t == str:
		return __builtin__.isinstance(v, str)
	elif __builtin__.isinstance(v, t):
		return True
	elif _hx_inspect.isclass(t):
		def _hx_local_0():
			loop1 = None
			def _hx_local_1(intf):
				f = Reflect.field(intf, "_hx_interfaces")
				if f is not None:
					_g = 0
					while _g < len(f):
						i = f[_g]
						_g = _g + 1
						if i == t:
							return True
						else:
							l = loop1(i)
							if l:
								return True
							
						
					
					
					return False
				
				else:
					return False
			
			loop1 = _hx_local_1
			return loop1
		
		loop = _hx_local_0()
		return loop(v.__class__)
	
	else:
		return False
Std._hx_is = Std_statics__hx_is
def Std_statics_string(s):
	return python_Boot.__string_rec(s, "")
	if Std._hx_is(s, Int):
		return str(s)
	
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
def Std_statics_int(x):
	return int(x)
Std.int = Std_statics_int
def Std_statics_parseInt(x):
	return int(float(x))
Std.parseInt = Std_statics_parseInt


Std._hx_class = Std
Std._hx_class_name = "Std"
_hx_classes['Std'] = Std
Std._hx_fields = []
Std._hx_props = []
Std._hx_methods = []
Std._hx_statics = ["is","string","int","parseInt"]
Std._hx_interfaces = []

class StdDemo:

	pass




def StdDemo_statics_main():
	def _hx_local_0():
		return AnonObject(fileName = "StdDemo.hx" ,lineNumber = 10 ,className = "StdDemo" ,methodName = "main" )
	print(Std.string("\n\n-------------Std.is---------------\n"))
	isIt = Std._hx_is("someString", str)
	def _hx_local_1():
		return AnonObject(fileName = "StdDemo.hx" ,lineNumber = 16 ,className = "StdDemo" ,methodName = "main" )
	print(Std.string("Std.is(\'someString\', String\') = ") + Std.string(isIt))
	def _hx_local_2():
		return AnonObject(fileName = "StdDemo.hx" ,lineNumber = 17 ,className = "StdDemo" ,methodName = "main" )
	print(Std.string("Std.is(12, String\') = ") + Std.string(Std._hx_is(12, str)))
	baseClass = bits_BaseClass()
	aClass = bits_AClass()
	bClass = bits_BClass()
	def _hx_local_3():
		return AnonObject(fileName = "StdDemo.hx" ,lineNumber = 23 ,className = "StdDemo" ,methodName = "main" )
	print(Std.string("Std.is(baseClass, BaseClass) = ") + Std.string(Std._hx_is(baseClass, bits_BaseClass)))
	def _hx_local_4():
		return AnonObject(fileName = "StdDemo.hx" ,lineNumber = 24 ,className = "StdDemo" ,methodName = "main" )
	print(Std.string("Std.is(aClass, BaseClass) = ") + Std.string(Std._hx_is(aClass, bits_BaseClass)))
	def _hx_local_5():
		return AnonObject(fileName = "StdDemo.hx" ,lineNumber = 25 ,className = "StdDemo" ,methodName = "main" )
	print(Std.string("Std.is(bClass, InterfaceDemo) = ") + Std.string(Std._hx_is(bClass, bits_InterfaceDemo)))
	def _hx_local_6():
		return AnonObject(fileName = "StdDemo.hx" ,lineNumber = 26 ,className = "StdDemo" ,methodName = "main" )
	print(Std.string("Std.is(baseClass, String) = ") + Std.string(Std._hx_is(baseClass, str)))
	def _hx_local_7():
		return AnonObject(fileName = "StdDemo.hx" ,lineNumber = 45 ,className = "StdDemo" ,methodName = "main" )
	print(Std.string("\n\n-------------Std.int----4.12345-----------\n"))
	_hx_float = 4.12345
	def _hx_local_8():
		return AnonObject(fileName = "StdDemo.hx" ,lineNumber = 48 ,className = "StdDemo" ,methodName = "main" )
	print(Std.string("4.12345 Std.int(float) = ") + Std.string(int(_hx_float)))
	def _hx_local_9():
		return AnonObject(fileName = "StdDemo.hx" ,lineNumber = 50 ,className = "StdDemo" ,methodName = "main" )
	print(Std.string("\n\n-------------Std.int----some string-----------\n"))
	dynamicString = "someString"
	def _hx_local_10():
		return AnonObject(fileName = "StdDemo.hx" ,lineNumber = 60 ,className = "StdDemo" ,methodName = "main" )
	try:
		Std.int(dynamicString)
	except Exception as _hx_e:
		_hx_e1 = _hx_e.val if isinstance(_hx_e, _HxException) else _hx_e
		if True:
			e = _hx_e1
			print(Std.string("Std.int(dynamicString) error = ") + Std.string(e))
		else:
			raise _hx_e
	def _hx_local_11():
		return AnonObject(fileName = "StdDemo.hx" ,lineNumber = 63 ,className = "StdDemo" ,methodName = "main" )
	print(Std.string("\n\n-------------Std.parseInt----\'123\'-----------\n"))
	stringInt = "123"
	def _hx_local_12():
		return AnonObject(fileName = "StdDemo.hx" ,lineNumber = 66 ,className = "StdDemo" ,methodName = "main" )
	print(Std.string("123 : Std.parseInt(stringInt) = ") + Std.string(int(float("123"))))
	def _hx_local_13():
		return AnonObject(fileName = "StdDemo.hx" ,lineNumber = 68 ,className = "StdDemo" ,methodName = "main" )
	print(Std.string("\n-------------Std.parseInt----\'12.345\'-----------\n"))
	stringFloat = "12.345"
	def _hx_local_14():
		return AnonObject(fileName = "StdDemo.hx" ,lineNumber = 78 ,className = "StdDemo" ,methodName = "main" )
	try:
		int(float(stringFloat))
	except Exception as _hx_e:
		_hx_e1 = _hx_e.val if isinstance(_hx_e, _HxException) else _hx_e
		if True:
			e = _hx_e1
			print(Std.string("12.345 : Std.parseInt(stringFloat) error = ") + Std.string(e))
		else:
			raise _hx_e
	def _hx_local_15():
		return AnonObject(fileName = "StdDemo.hx" ,lineNumber = 81 ,className = "StdDemo" ,methodName = "main" )
	print(Std.string("\n-------------Std.parseInt----\'abc\'-----------\n"))
	abc = "abc"
	def _hx_local_16():
		return AnonObject(fileName = "StdDemo.hx" ,lineNumber = 91 ,className = "StdDemo" ,methodName = "main" )
	try:
		int(float(abc))
	except Exception as _hx_e:
		_hx_e1 = _hx_e.val if isinstance(_hx_e, _HxException) else _hx_e
		if True:
			e = _hx_e1
			print(Std.string("abc : Std.parseInt(abc) error = ") + Std.string(e))
		else:
			raise _hx_e
	def _hx_local_17():
		return AnonObject(fileName = "StdDemo.hx" ,lineNumber = 94 ,className = "StdDemo" ,methodName = "main" )
	print(Std.string("\n-------------Std.parseInt----dybamicBool-----------\n"))
	dynamicBool = True
	def _hx_local_18():
		return AnonObject(fileName = "StdDemo.hx" ,lineNumber = 104 ,className = "StdDemo" ,methodName = "main" )
	try:
		Std.parseInt(dynamicBool)
	except Exception as _hx_e:
		_hx_e1 = _hx_e.val if isinstance(_hx_e, _HxException) else _hx_e
		if True:
			e = _hx_e1
			print(Std.string("dybamicBool : Std.parseInt(dybamicBool) error = ") + Std.string(e))
		else:
			raise _hx_e
	def _hx_local_19():
		return AnonObject(fileName = "StdDemo.hx" ,lineNumber = 108 ,className = "StdDemo" ,methodName = "main" )
	print(Std.string("\n\n-------------Std.parseFloat----\'12.345\'-----------\n"))
	stringFloat1 = "12.345"
	def _hx_local_20():
		return AnonObject(fileName = "StdDemo.hx" ,lineNumber = 111 ,className = "StdDemo" ,methodName = "main" )
	print(Std.string("12.345 : Std.parseInt(stringFloat) = ") + Std.string(float(stringFloat1)))
	def _hx_local_21():
		return AnonObject(fileName = "StdDemo.hx" ,lineNumber = 114 ,className = "StdDemo" ,methodName = "main" )
	print(Std.string("\n\n-------------Std.random----30-----------\n"))
	rand = int(_hx_random.random() * 30)
	def _hx_local_22():
		return AnonObject(fileName = "StdDemo.hx" ,lineNumber = 117 ,className = "StdDemo" ,methodName = "main" )
	print(Std.string("Std.random(30) = ") + Std.string(int(_hx_random.random() * 30)))
	def _hx_local_23():
		return AnonObject(fileName = "StdDemo.hx" ,lineNumber = 119 ,className = "StdDemo" ,methodName = "main" )
	print(Std.string("Std.random(3) = ") + Std.string(int(_hx_random.random() * 3)))
	def _hx_local_24():
		return AnonObject(fileName = "StdDemo.hx" ,lineNumber = 120 ,className = "StdDemo" ,methodName = "main" )
	print(Std.string("Std.random(3) = ") + Std.string(int(_hx_random.random() * 3)))
	def _hx_local_25():
		return AnonObject(fileName = "StdDemo.hx" ,lineNumber = 121 ,className = "StdDemo" ,methodName = "main" )
	print(Std.string("Std.random(3) = ") + Std.string(int(_hx_random.random() * 3)))
	def _hx_local_26():
		return AnonObject(fileName = "StdDemo.hx" ,lineNumber = 122 ,className = "StdDemo" ,methodName = "main" )
	print(Std.string("Std.random(3) = ") + Std.string(int(_hx_random.random() * 3)))
	def _hx_local_27():
		return AnonObject(fileName = "StdDemo.hx" ,lineNumber = 123 ,className = "StdDemo" ,methodName = "main" )
	print(Std.string("Std.random(3) = ") + Std.string(int(_hx_random.random() * 3)))
	
StdDemo.main = StdDemo_statics_main


StdDemo._hx_class = StdDemo
StdDemo._hx_class_name = "StdDemo"
_hx_classes['StdDemo'] = StdDemo
StdDemo._hx_fields = []
StdDemo._hx_props = []
StdDemo._hx_methods = []
StdDemo._hx_statics = ["main"]
StdDemo._hx_interfaces = []

class Tools:

	pass




def Tools_statics_highlight(f,name):
	Tools.log("------------------------------------------start " + name + "\n")
	f()
	Tools.log("------------------------------------------end " + name + "\n")
	
Tools.highlight = Tools_statics_highlight
def Tools_statics_log(f):
	def _hx_local_0():
		return AnonObject(fileName = "Tools.hx" ,lineNumber = 13 ,className = "Tools" ,methodName = "log" )
	print(Std.string(f))
	
Tools.log = Tools_statics_log


Tools._hx_class = Tools
Tools._hx_class_name = "Tools"
_hx_classes['Tools'] = Tools
Tools._hx_fields = []
Tools._hx_props = []
Tools._hx_methods = []
Tools._hx_statics = ["highlight","log"]
Tools._hx_interfaces = []

class Type_ValueType(Enum):
	def __init__(self, t, i, p): 
		super(Type_ValueType,self).__init__(t, i, p)


Type_ValueType.TInt = Type_ValueType("TInt", 1, list())

Type_ValueType.TUnknown = Type_ValueType("TUnknown", 8, list())

Type_ValueType.TFunction = Type_ValueType("TFunction", 5, list())

Type_ValueType.TNull = Type_ValueType("TNull", 0, list())

def _Type_ValueType_statics_TEnum (e): 
	return Type_ValueType("TEnum", 7, [e])
Type_ValueType.TEnum = _Type_ValueType_statics_TEnum

Type_ValueType.TFloat = Type_ValueType("TFloat", 2, list())

def _Type_ValueType_statics_TClass (c): 
	return Type_ValueType("TClass", 6, [c])
Type_ValueType.TClass = _Type_ValueType_statics_TClass

Type_ValueType.TBool = Type_ValueType("TBool", 3, list())

Type_ValueType.TObject = Type_ValueType("TObject", 4, list())
Type_ValueType.constructs = ["TInt","TUnknown","TFunction","TNull","TEnum","TFloat","TClass","TBool","TObject"]
Type_ValueType._hx_class_name = "_Type.ValueType"
_hx_classes['_Type.ValueType'] = Type_ValueType

class Type:

	pass




def Type_statics_createInstance(cl,args):
	l = __builtin__.len(args)
	if l == 0:
		return cl()
	elif l == 1:
		return cl(args[0])
	elif l == 2:
		return cl(args[0], args[1])
	elif l == 3:
		return cl(args[0], args[1], args[2])
	elif l == 4:
		return cl(args[0], args[1], args[2], args[3])
	elif l == 5:
		return cl(args[0], args[1], args[2], args[3], args[4])
	elif l == 6:
		return cl(args[0], args[1], args[2], args[3], args[4], args[5])
	elif l == 7:
		return cl(args[0], args[1], args[2], args[3], args[4], args[5], args[6])
	elif l == 8:
		return cl(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7])
	else:
		raise _HxException("Too many arguments")
	return None
	
Type.createInstance = Type_statics_createInstance
def Type_statics_createEmptyInstance(cl):
	return cl.__new__(cl)
Type.createEmptyInstance = Type_statics_createEmptyInstance
def Type_statics_typeof(v):
	if v is None:
		return Type_ValueType.TNull
	elif __builtin__.isinstance(v, bool):
		return Type_ValueType.TBool
	elif __builtin__.isinstance(v, int):
		return Type_ValueType.TInt
	elif __builtin__.isinstance(v, float):
		return Type_ValueType.TFloat
	elif __builtin__.hasattr(v, "__class__"):
		if __builtin__.isinstance(v, AnonObject):
			return Type_ValueType.TObject
		
		if __builtin__.isinstance(v, Enum):
			return Type_ValueType.TEnum(v.__class__)
		
		return Type_ValueType.TClass(v.__class__)
	
	elif __builtin__.callable(v):
		return Type_ValueType.TFunction
	else:
		return Type_ValueType.TUnknown
Type.typeof = Type_statics_typeof


Type._hx_class = Type
Type._hx_class_name = "Type"
_hx_classes['Type'] = Type
Type._hx_fields = []
Type._hx_props = []
Type._hx_methods = []
Type._hx_statics = ["createInstance","createEmptyInstance","typeof"]
Type._hx_interfaces = []

class TypeDemo_Foo:


	def __init__(self):
		self.z = 5
	# var z






TypeDemo_Foo._hx_class = TypeDemo_Foo
TypeDemo_Foo._hx_class_name = "_TypeDemo.Foo"
_hx_classes['_TypeDemo.Foo'] = TypeDemo_Foo
TypeDemo_Foo._hx_fields = ["z"]
TypeDemo_Foo._hx_props = []
TypeDemo_Foo._hx_methods = []
TypeDemo_Foo._hx_statics = []
TypeDemo_Foo._hx_interfaces = []

class TypeDemo:

	pass




def TypeDemo_statics_main():
	Tools.highlight(TypeDemo.createInstance, "createInstance")
	Tools.highlight(TypeDemo.typeOfInt, "typeOfInt")
	Tools.highlight(TypeDemo.typeOfBool, "typeOfBool")
	Tools.highlight(TypeDemo.typeOfFloat, "typeOfFloat")
	Tools.highlight(TypeDemo.typeOfString, "typeOfString")
	Tools.highlight(TypeDemo.typeOfStructure, "typeOfStructure")
	Tools.highlight(TypeDemo.typeOfEnum, "typeOfEnum")
	Tools.highlight(TypeDemo.typeOfClass, "typeOfClass")
	
TypeDemo.main = TypeDemo_statics_main
def TypeDemo_statics_createInstance():
	f = Type.createEmptyInstance(TypeDemo_Foo)
	Tools.log(Std._hx_is(f, TypeDemo_Foo))
	f2 = Type.createInstance(TypeDemo_Foo, [])
	Tools.log(f2.z)
	
TypeDemo.createInstance = TypeDemo_statics_createInstance
def TypeDemo_statics_typeOfInt():
	Tools.log(Type.typeof(1))
TypeDemo.typeOfInt = TypeDemo_statics_typeOfInt
def TypeDemo_statics_typeOfBool():
	Tools.log(Type.typeof(True))
TypeDemo.typeOfBool = TypeDemo_statics_typeOfBool
def TypeDemo_statics_typeOfFloat():
	Tools.log(Type.typeof(1.1))
TypeDemo.typeOfFloat = TypeDemo_statics_typeOfFloat
def TypeDemo_statics_typeOfString():
	Tools.log(Type.typeof("foo"))
TypeDemo.typeOfString = TypeDemo_statics_typeOfString
def TypeDemo_statics_typeOfStructure():
	def _hx_local_0():
		return AnonObject(x = "hey" ,y = 17 )
	Tools.log(Type.typeof(_hx_local_0()))
	
TypeDemo.typeOfStructure = TypeDemo_statics_typeOfStructure
def TypeDemo_statics_typeOfEnum():
	Tools.log(Type.typeof(Types_EnumMoney.Dollar))
TypeDemo.typeOfEnum = TypeDemo_statics_typeOfEnum
def TypeDemo_statics_typeOfClass():
	Tools.log(Type.typeof(Types_ClassA()))
TypeDemo.typeOfClass = TypeDemo_statics_typeOfClass


TypeDemo._hx_class = TypeDemo
TypeDemo._hx_class_name = "TypeDemo"
_hx_classes['TypeDemo'] = TypeDemo
TypeDemo._hx_fields = []
TypeDemo._hx_props = []
TypeDemo._hx_methods = []
TypeDemo._hx_statics = ["main","createInstance","typeOfInt","typeOfBool","typeOfFloat","typeOfString","typeOfStructure","typeOfEnum","typeOfClass"]
TypeDemo._hx_interfaces = []

class Types_ClassA:


	def __init__(self):
		None






Types_ClassA._hx_class = Types_ClassA
Types_ClassA._hx_class_name = "_Types.ClassA"
_hx_classes['_Types.ClassA'] = Types_ClassA
Types_ClassA._hx_fields = []
Types_ClassA._hx_props = []
Types_ClassA._hx_methods = []
Types_ClassA._hx_statics = []
Types_ClassA._hx_interfaces = []

class Types_EnumMoney(Enum):
	def __init__(self, t, i, p): 
		super(Types_EnumMoney,self).__init__(t, i, p)


Types_EnumMoney.Dollar = Types_EnumMoney("Dollar", 1, list())

Types_EnumMoney.Euro = Types_EnumMoney("Euro", 0, list())
Types_EnumMoney.constructs = ["Dollar","Euro"]
Types_EnumMoney._hx_class_name = "_Types.EnumMoney"
_hx_classes['_Types.EnumMoney'] = Types_EnumMoney

class VariousExpressions_Color(Enum):
	def __init__(self, t, i, p): 
		super(VariousExpressions_Color,self).__init__(t, i, p)


VariousExpressions_Color.BLACK = VariousExpressions_Color("BLACK", 1, list())

def _VariousExpressions_Color_statics_Alpha (a,c): 
	return VariousExpressions_Color("Alpha", 3, [a,c])
VariousExpressions_Color.Alpha = _VariousExpressions_Color_statics_Alpha

VariousExpressions_Color.RED = VariousExpressions_Color("RED", 0, list())

def _VariousExpressions_Color_statics_RGB (r,g,b): 
	return VariousExpressions_Color("RGB", 2, [r,g,b])
VariousExpressions_Color.RGB = _VariousExpressions_Color_statics_RGB
VariousExpressions_Color.constructs = ["BLACK","Alpha","RED","RGB"]
VariousExpressions_Color._hx_class_name = "_VariousExpressions.Color"
_hx_classes['_VariousExpressions.Color'] = VariousExpressions_Color

class _VariousExpressions_VariousExpressions_Sum:

	pass




_VariousExpressions_VariousExpressions_Sum.jup = "hi"#transformed"hi"


_VariousExpressions_VariousExpressions_Sum._hx_class = _VariousExpressions_VariousExpressions_Sum
_VariousExpressions_VariousExpressions_Sum._hx_class_name = "_VariousExpressions._VariousExpressions.Sum"
_hx_classes['_VariousExpressions._VariousExpressions.Sum'] = _VariousExpressions_VariousExpressions_Sum
_VariousExpressions_VariousExpressions_Sum._hx_fields = []
_VariousExpressions_VariousExpressions_Sum._hx_props = []
_VariousExpressions_VariousExpressions_Sum._hx_methods = []
_VariousExpressions_VariousExpressions_Sum._hx_statics = ["jup"]
_VariousExpressions_VariousExpressions_Sum._hx_interfaces = []

class VariousExpressions_Sub:


	def __init__(self,z):
		self.q = z
	def walk(self):
		def _hx_local_0():
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 26 ,className = "Sub" ,methodName = "walk" )
		print(Std.string("walk ") + Std.string(self.q))
	

	# var q






VariousExpressions_Sub._hx_class = VariousExpressions_Sub
VariousExpressions_Sub._hx_class_name = "_VariousExpressions.Sub"
_hx_classes['_VariousExpressions.Sub'] = VariousExpressions_Sub
VariousExpressions_Sub._hx_fields = ["q"]
VariousExpressions_Sub._hx_props = []
VariousExpressions_Sub._hx_methods = ["walk"]
VariousExpressions_Sub._hx_statics = []
VariousExpressions_Sub._hx_interfaces = []

class VariousExpressions_Hui:

	pass






VariousExpressions_Hui._hx_class = VariousExpressions_Hui
VariousExpressions_Hui._hx_class_name = "_VariousExpressions.Hui"
_hx_classes['_VariousExpressions.Hui'] = VariousExpressions_Hui
VariousExpressions_Hui._hx_fields = []
VariousExpressions_Hui._hx_props = []
VariousExpressions_Hui._hx_methods = []
VariousExpressions_Hui._hx_statics = []
VariousExpressions_Hui._hx_interfaces = []

class VariousExpressions_HuiBu:

	pass






VariousExpressions_HuiBu._hx_class = VariousExpressions_HuiBu
VariousExpressions_HuiBu._hx_class_name = "_VariousExpressions.HuiBu"
_hx_classes['_VariousExpressions.HuiBu'] = VariousExpressions_HuiBu
VariousExpressions_HuiBu._hx_fields = []
VariousExpressions_HuiBu._hx_props = []
VariousExpressions_HuiBu._hx_methods = []
VariousExpressions_HuiBu._hx_statics = []
VariousExpressions_HuiBu._hx_interfaces = []

class VariousExpressions_Child(VariousExpressions_Sub):


	def __init__(self):
		super().__init__(77)
	def walk(self):
		super().walk()
		def _hx_local_0():
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 40 ,className = "Child" ,methodName = "walk" )
		print(Std.string("hey"))
	







VariousExpressions_Child._hx_class = VariousExpressions_Child
VariousExpressions_Child._hx_class_name = "_VariousExpressions.Child"
_hx_classes['_VariousExpressions.Child'] = VariousExpressions_Child
VariousExpressions_Child._hx_fields = []
VariousExpressions_Child._hx_props = []
VariousExpressions_Child._hx_methods = ["walk"]
VariousExpressions_Child._hx_statics = []
VariousExpressions_Child._hx_interfaces = [VariousExpressions_Hui]
VariousExpressions_Child._hx_super = VariousExpressions_Sub

class VariousExpressions_Whatever:


	def __init__(self):
		None
	def get_hello(self):
		return 1







VariousExpressions_Whatever._hx_class = VariousExpressions_Whatever
VariousExpressions_Whatever._hx_class_name = "_VariousExpressions.Whatever"
_hx_classes['_VariousExpressions.Whatever'] = VariousExpressions_Whatever
VariousExpressions_Whatever._hx_fields = []
VariousExpressions_Whatever._hx_props = []
VariousExpressions_Whatever._hx_methods = ["get_hello"]
VariousExpressions_Whatever._hx_statics = []
VariousExpressions_Whatever._hx_interfaces = []

class VariousExpressions:

	pass




VariousExpressions.zy = 900#transformed900
def VariousExpressions_statics_main():
	def _hx_local_0():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 66 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string(VariousExpressions_Whatever().get_hello()))
	x = 65
	z = 3 + x
	def _hx_local_2():
		def _hx_local_1():
			c = z
			return "".join(map(chr, [c]))
		
		return "String.fromCharcode(" + z + ") = " + _hx_local_1()
	
	def _hx_local_3():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 70 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string(_hx_local_2()))
	def _hx_local_4():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 71 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string(__builtin__.len("hello world")))
	def _hx_local_5():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 72 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string(_VariousExpressions_VariousExpressions_Sum.jup))
	umlaut = "UMLAUTE: äöüÄÖÜß"
	gurki = 511111
	t22 = (1, "tupleB")
	def _hx_local_6():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 76 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string(t22[1]))
	def _hx_local_8():
		def _hx_local_7():
			nonlocal gurki
			gurki = 121212121
			return gurki
			
		
		return AnonObject(x = _hx_local_7 )
	
	t221 = (1, "tupleB", _hx_local_8())
	def _hx_local_9():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 78 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string(t221[2].x()))
	mySub = VariousExpressions_Sub(177)
	def _hx_local_10():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 84 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string(__builtin__.hasattr(mySub, "walk")))
	mySub.walk()
	child = VariousExpressions_Child()
	child.walk()
	def _hx_local_11():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 89 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string(Std._hx_is(child, VariousExpressions_Hui)))
	def _hx_local_12():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 90 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string(Std._hx_is(child, VariousExpressions_HuiBu)))
	def _hx_local_13():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 92 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string(type(umlaut)))
	python_Lib._hx_print("hey")
	python_Lib.println(["hey", "heyho"])
	ControlFlowDemo()
	ArrayDemo()
	def _hx_local_14():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 98 ,className = "VariousExpressions" ,methodName = "main" )
	def _hx_local_14():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 98 ,className = "VariousExpressions" ,methodName = "main" )
	def _hx_local_15():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 101 ,className = "VariousExpressions" ,methodName = "main" )
	try:
		print(Std.string(str([1, 2]) + Std.string([3, 4])))
	except Exception as _hx_e:
		_hx_e1 = _hx_e.val if isinstance(_hx_e, _HxException) else _hx_e
		if isinstance(_hx_e1, str):
			e = _hx_e1
			print(Std.string("catch String"))
		else:
			raise _hx_e
	def _hx_local_19():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 110 ,className = "VariousExpressions" ,methodName = "main" )
	def _hx_local_20():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 112 ,className = "VariousExpressions" ,methodName = "main" )
	def _hx_local_21():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 114 ,className = "VariousExpressions" ,methodName = "main" )
	try:
		def _hx_local_16():
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 106 ,className = "VariousExpressions" ,methodName = "main" )
		print(Std.string(str([1, 2]) + Std.string([3, 4])))
		def _hx_local_17():
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 107 ,className = "VariousExpressions" ,methodName = "main" )
		print(Std.string([1, 2, 3][1]))
		def _hx_local_18():
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 108 ,className = "VariousExpressions" ,methodName = "main" )
		print(Std.string(list([1, 2, 3])))
	
	except Exception as _hx_e:
		_hx_e1 = _hx_e.val if isinstance(_hx_e, _HxException) else _hx_e
		if isinstance(_hx_e1, str):
			e = _hx_e1
			print(Std.string("catch String"))
		elif isinstance(_hx_e1, Main):
			x1 = _hx_e1
			print(Std.string("catch class"))
		elif isinstance(_hx_e1, VariousExpressions_Color):
			x1 = _hx_e1
			print(Std.string("catch enum"))
		else:
			raise _hx_e
	def _hx_local_25():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 121 ,className = "VariousExpressions" ,methodName = "main" )
	def _hx_local_26():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 123 ,className = "VariousExpressions" ,methodName = "main" )
	def _hx_local_27():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 125 ,className = "VariousExpressions" ,methodName = "main" )
	try:
		def _hx_local_22():
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 117 ,className = "VariousExpressions" ,methodName = "main" )
		print(Std.string(str([1, 2]) + Std.string([3, 4])))
		def _hx_local_23():
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 118 ,className = "VariousExpressions" ,methodName = "main" )
		print(Std.string([1, 2, 3][1]))
		def _hx_local_24():
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 119 ,className = "VariousExpressions" ,methodName = "main" )
		print(Std.string(list([1, 2, 3])))
	
	except Exception as _hx_e:
		_hx_e1 = _hx_e.val if isinstance(_hx_e, _HxException) else _hx_e
		if isinstance(_hx_e1, str):
			e = _hx_e1
			print(Std.string("catch String"))
		elif True:
			x1 = _hx_e1
			print(Std.string("catch class"))
		elif isinstance(_hx_e1, VariousExpressions_Color):
			x1 = _hx_e1
			print(Std.string("catch enum"))
		else:
			raise _hx_e
	_hx_def = 500
	a = "hi"
	a
	
	a = 1
	a
	
	u = 5
	def _hx_local_28():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 144 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string(u))
	u1 = 10
	def _hx_local_29():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 147 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string(u1))
	
	def _hx_local_30():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 150 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string(VariousExpressions.zy))
	def _hx_local_31():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 151 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string(u))
	def _hx_local_32():
		q = 5
		def _hx_local_33():
			d = 0
			return d + q + 1
		
		z2 = _hx_local_33()
		return z2 + 2
	
	z1 = _hx_local_32()
	def _hx_local_34():
		q1 = 99
		def _hx_local_35():
			return q1
		return _hx_local_35
	
	z2 = _hx_local_34()
	def _hx_local_36():
		x1 = 0
		return x1 > 0
	
	if _hx_local_36():
		def _hx_local_37():
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 158 ,className = "VariousExpressions" ,methodName = "main" )
		print(Std.string("hello"))
	
	
	b = False
	if b:
		def _hx_local_38():
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 161 ,className = "VariousExpressions" ,methodName = "main" )
		print(Std.string("hello"))
	
	
	z1 = 1
	def _hx_local_43():
		def _hx_local_39():
			def _hx_local_40():
				return 2 if b else 3
			z1 = _hx_local_40()
			return z1 > 2
		
		def _hx_local_41():
			return z1 + 1
		def _hx_local_42():
			return z1 + 2
		return _hx_local_41 if _hx_local_39() else _hx_local_42
	
	z3 = _hx_local_43()
	z3()
	def _hx_local_45():
		_hx_local_44 = None
		def _hx_local_46():
			raise _HxException(None)
			return 1
		
		def _hx_local_46():
			raise _HxException(None)
			return 1
		
		try:
			_hx_t = _hx_local_46()
		except Exception as _hx_e:
			_hx_e1 = _hx_e.val if isinstance(_hx_e, _HxException) else _hx_e
			if isinstance(_hx_e1, str):
				e = _hx_e1
				_hx_local_44 = 17
			elif True:
				e = _hx_e1
				_hx_local_44 = 15
			else:
				raise _hx_e
		return _hx_local_44
	
	x1 = _hx_local_45()
	def _hx_local_47():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 182 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string("x from tryCatch:") + Std.string(x1))
	def _hx_local_49():
		def _hx_local_48():
			return AnonObject(x = 5 )
		_hx_local_50 = _hx_local_48().x = 10
		return _hx_local_50
	
	x2 = _hx_local_49()
	def _hx_local_51():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 186 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string("new X : ") + Std.string(x2))
	def _hx_local_53():
		def _hx_local_52(x3):
			return x3 * 3
		return AnonObject(x = 5 ,y = 10 ,z = _hx_local_52 )
	
	z4 = _hx_local_53()
	def _hx_local_55():
		def _hx_local_54():
			return 2 if z4.x < 0 else 17
		return 1 if z4.x > 10 else _hx_local_54()
	
	z11 = _hx_local_55()
	def _hx_local_56():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 197 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string("z11:") + Std.string(z11))
	z4.x = z4.x + 10
	def _hx_local_57():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 199 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string("z.z(2): ") + Std.string(z4.z(2)))
	def _hx_local_58():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 200 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string("z:") + Std.string(z4.x))
	x3 = True
	while x3:
		x3 = False
		z5 = 5
		if z5 == 5:
			def _hx_local_59():
				return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 210 ,className = "VariousExpressions" ,methodName = "main" )
			print(Std.string(z5))
			break
		
		
		1
	
	def _hx_local_60():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 221 ,className = "VariousExpressions" ,methodName = "main" )
	def _hx_local_61():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 223 ,className = "VariousExpressions" ,methodName = "main" )
	try:
		raise _HxException("s")
	except Exception as _hx_e:
		_hx_e1 = _hx_e.val if isinstance(_hx_e, _HxException) else _hx_e
		if True:
			e = _hx_e1
			print(Std.string("except dynamic"))
		elif isinstance(_hx_e1, str):
			s = _hx_e1
			print(Std.string("except string"))
		else:
			raise _hx_e
	while True:
		x3 = False
		if not x3:
			break
		
	
	c = VariousExpressions_Color.RGB(10, 11, 23)
	def _hx_local_86():
		def _hx_local_62():
			def _hx_local_63():
				return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 233 ,className = "VariousExpressions" ,methodName = "main" )
			print(Std.string("it\'s red"))
			return c
		
		def _hx_local_85():
			def _hx_local_64():
				c_eRGB_0 = c.params[0]
				c_eRGB_1 = c.params[1]
				c_eRGB_2 = c.params[2]
				def _hx_local_73():
					def _hx_local_72():
						def _hx_local_65():
							def _hx_local_66():
								return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 234 ,className = "VariousExpressions" ,methodName = "main" )
							print(Std.string("has 20 red"))
							return c
						
						def _hx_local_71():
							def _hx_local_67():
								def _hx_local_68():
									return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 235 ,className = "VariousExpressions" ,methodName = "main" )
								print(Std.string("has 10 red"))
								return c
							
							def _hx_local_69():
								def _hx_local_70():
									return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 236 ,className = "VariousExpressions" ,methodName = "main" )
								print(Std.string("other rgb"))
								return c
							
							return _hx_local_67() if c_eRGB_0 == 10 else _hx_local_69()
						
						return _hx_local_65() if c_eRGB_0 == 20 else _hx_local_71()
					
					return _hx_local_72()
				
				return _hx_local_73()
			
			def _hx_local_84():
				def _hx_local_74():
					def _hx_local_75():
						return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 237 ,className = "VariousExpressions" ,methodName = "main" )
					print(Std.string("it\'s black"))
					return c
				
				def _hx_local_83():
					def _hx_local_76():
						c_eAlpha_0 = c.params[0]
						c_eAlpha_1 = c.params[1]
						def _hx_local_82():
							def _hx_local_81():
								def _hx_local_80():
									def _hx_local_77():
										c_eAlpha_1_eRGB_0 = c_eAlpha_1.params[0]
										c_eAlpha_1_eRGB_1 = c_eAlpha_1.params[1]
										c_eAlpha_1_eRGB_2 = c_eAlpha_1.params[2]
										def _hx_local_79():
											def _hx_local_78():
												return c if c_eAlpha_1_eRGB_0 == 10 else c
											return _hx_local_78()
										
										return _hx_local_79()
									
									return _hx_local_77() if c_eAlpha_1.tag == "RGB" else c
								
								return c if c_eAlpha_1.tag == "BLACK" else _hx_local_80()
							
							return _hx_local_81()
						
						return _hx_local_82()
					
					return _hx_local_76() if c.tag == "Alpha" else None
				
				return _hx_local_74() if c.tag == "BLACK" else _hx_local_83()
			
			return _hx_local_64() if c.tag == "RGB" else _hx_local_84()
		
		return _hx_local_62() if c.tag == "RED" else _hx_local_85()
	
	t = _hx_local_86()
	t
	if x3:
		raise _HxException("whatever")
	
	x4 = 1
	if x4 == 1:
		def _hx_local_87():
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 250 ,className = "VariousExpressions" ,methodName = "main" )
		print(Std.string("it\'s 1"))
	
	else:
		def _hx_local_88():
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 252 ,className = "VariousExpressions" ,methodName = "main" )
		print(Std.string("not 1"))
		def _hx_local_89():
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 253 ,className = "VariousExpressions" ,methodName = "main" )
		print(Std.string("not 1"))
	
	def _hx_local_90():
		z5 = 0
		def _hx_local_94():
			def _hx_local_92():
				_hx_local_91 = None
				def _hx_local_93():
					raise _HxException("whatever")
					return "juhu"
				
				def _hx_local_93():
					raise _HxException("whatever")
					return "juhu"
				
				try:
					_hx_t = _hx_local_93()
				except Exception as _hx_e:
					_hx_e1 = _hx_e.val if isinstance(_hx_e, _HxException) else _hx_e
					if isinstance(_hx_e1, str):
						s = _hx_e1
						_hx_local_91 = s
					else:
						raise _hx_e
				return _hx_local_91
			
			return _hx_local_92()
		
		return _hx_local_94()
	
	def _hx_local_95():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 258 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string(_hx_local_90()))
	if x4 == 1:
		if c.tag == "RED":
			def _hx_local_96():
				return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 261 ,className = "VariousExpressions" ,methodName = "main" )
			print(Std.string("it\'s 1 red"))
	
		else:
			def _hx_local_97():
				return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 262 ,className = "VariousExpressions" ,methodName = "main" )
			print(Std.string("not 1 red"))
	
	else:
		def _hx_local_98():
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 262 ,className = "VariousExpressions" ,methodName = "main" )
		print(Std.string("not 1 red"))
	
	_g = 0
	while _g < 10:
		def _hx_local_99():
			nonlocal _g
			_hx_r = _g
			_g = _g + 1
			return _hx_r
			
		
		i = _hx_local_99()
		def _hx_local_100():
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 266 ,className = "VariousExpressions" ,methodName = "main" )
		print(Std.string(i))
	
	
	_g = 0
	_g1 = [0, 1, 2]
	while _g < len(_g1):
		i = _g1[_g]
		_g = _g + 1
		def _hx_local_101():
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 270 ,className = "VariousExpressions" ,methodName = "main" )
		print(Std.string(i))
	
	
	def _hx_local_102():
		return 23.1
	hey = _hx_local_102
	def _hx_local_103():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 275 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string("----------------"))
	zy = 1
	def _hx_local_104():
		nonlocal zy
		def _hx_local_105():
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 278 ,className = "VariousExpressions" ,methodName = "main" )
		print(Std.string(zy))
		zy = zy + 2
		def _hx_local_106():
			nonlocal zy
			def _hx_local_107():
				return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 281 ,className = "VariousExpressions" ,methodName = "main" )
			print(Std.string(zy))
			zy = zy + 7
			def _hx_local_108():
				return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 283 ,className = "VariousExpressions" ,methodName = "main" )
			print(Std.string(zy))
			
		
		zwei = _hx_local_106
		zwei()
		def _hx_local_109():
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 287 ,className = "VariousExpressions" ,methodName = "main" )
		print(Std.string(zy))
		
	
	f = _hx_local_104
	f()
	def _hx_local_110():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 291 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string(zy))
	def _hx_local_111():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 292 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string("----------------"))
	def _hx_local_112():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 294 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string(hey()))
	
VariousExpressions.main = VariousExpressions_statics_main


VariousExpressions._hx_class = VariousExpressions
VariousExpressions._hx_class_name = "VariousExpressions"
_hx_classes['VariousExpressions'] = VariousExpressions
VariousExpressions._hx_fields = []
VariousExpressions._hx_props = []
VariousExpressions._hx_methods = []
VariousExpressions._hx_statics = ["zy","main"]
VariousExpressions._hx_interfaces = []

class bits_BaseClass:


	def __init__(self):
		def _hx_local_0():
			return AnonObject(fileName = "BaseClass.hx" ,lineNumber = 17 ,className = "bits.BaseClass" ,methodName = "new" )
		print(Std.string("BaseClass::new"))
		if bits_BaseClass._instances is None:
			bits_BaseClass._instances = 0
		
		_hx_r = bits_BaseClass._instances
		bits_BaseClass._instances = bits_BaseClass._instances + 1
		_hx_r
		
		self._count = 0
		bits_BaseClass.UninitialisedStaticVar = 1.234
	
	# var _count




bits_BaseClass.UninitialisedStaticVar = None;
bits_BaseClass._instances = None;


bits_BaseClass._hx_class = bits_BaseClass
bits_BaseClass._hx_class_name = "bits.BaseClass"
_hx_classes['bits.BaseClass'] = bits_BaseClass
bits_BaseClass._hx_fields = ["_count"]
bits_BaseClass._hx_props = []
bits_BaseClass._hx_methods = []
bits_BaseClass._hx_statics = ["UninitialisedStaticVar","_instances"]
bits_BaseClass._hx_interfaces = []

class bits_AClass(bits_BaseClass):


	def __init__(self):
		super().__init__()






bits_AClass._hx_class = bits_AClass
bits_AClass._hx_class_name = "bits.AClass"
_hx_classes['bits.AClass'] = bits_AClass
bits_AClass._hx_fields = []
bits_AClass._hx_props = []
bits_AClass._hx_methods = []
bits_AClass._hx_statics = []
bits_AClass._hx_interfaces = []
bits_AClass._hx_super = bits_BaseClass

class bits_InterfaceDemo:

	pass






bits_InterfaceDemo._hx_class = bits_InterfaceDemo
bits_InterfaceDemo._hx_class_name = "bits.InterfaceDemo"
_hx_classes['bits.InterfaceDemo'] = bits_InterfaceDemo
bits_InterfaceDemo._hx_fields = []
bits_InterfaceDemo._hx_props = []
bits_InterfaceDemo._hx_methods = []
bits_InterfaceDemo._hx_statics = []
bits_InterfaceDemo._hx_interfaces = []

class bits_BClass(bits_AClass):


	def __init__(self):
		super().__init__()
		def _hx_local_0():
			return AnonObject(fileName = "BClass.hx" ,lineNumber = 12 ,className = "bits.BClass" ,methodName = "new" )
		print(Std.string("BClass::new"))
		self.apiVar = True
	
	# var apiVar






bits_BClass._hx_class = bits_BClass
bits_BClass._hx_class_name = "bits.BClass"
_hx_classes['bits.BClass'] = bits_BClass
bits_BClass._hx_fields = ["apiVar"]
bits_BClass._hx_props = []
bits_BClass._hx_methods = []
bits_BClass._hx_statics = []
bits_BClass._hx_interfaces = [bits_InterfaceDemo]
bits_BClass._hx_super = bits_AClass

class python_Boot:

	pass




def Boot_statics___string_rec(o,s):
	if o is None:
		return "null"
	
	if __builtin__.len(s) >= 5:
		return "<...>"
	
	builtin = __builtin__
	if builtin.isinstance(o, str):
		return o
	
	if builtin.isinstance(o, bool):
		if o:
			return "true"
		else:
			return "false"
	
	if builtin.isinstance(o, int):
		return str(o)
	
	if builtin.isinstance(o, float):
		return str(o)
	
	if builtin.callable(o) and not builtin.hasattr(o, "__class__"):
		return "<function>"
	
	if builtin.isinstance(o, list):
		l = __builtin__.len(o)
		st = "["
		s = s + "\t"
		_g = 0
		while _g < l:
			def _hx_local_0():
				nonlocal _g
				_hx_r = _g
				_g = _g + 1
				return _hx_r
				
			
			i = _hx_local_0()
			prefix = ""
			if i > 0:
				prefix = ","
			
			st = st + prefix + python_Boot.__string_rec(o[i], s)
		
		
		st = st + "]"
		return st
	
	
	if builtin.hasattr(o, "__class__"):
		if builtin.isinstance(o, AnonObject):
			toStr = None
			try:
				toStr = o
			except Exception as _hx_e:
				_hx_e1 = _hx_e.val if isinstance(_hx_e, _HxException) else _hx_e
				if True:
					e = _hx_e1
					None
				else:
					raise _hx_e
			if toStr is None:
				return "{ ... }"
			else:
				return toStr
		
		
		if builtin.isinstance(o, Enum):
			l = builtin.len(o.params)
			hasParams = l > 0
			if hasParams:
				paramsStr = ""
				_g = 0
				while _g < l:
					def _hx_local_1():
						nonlocal _g
						_hx_r = _g
						_g = _g + 1
						return _hx_r
						
					
					i = _hx_local_1()
					prefix = ""
					if i > 0:
						prefix = ","
					
					paramsStr = paramsStr + prefix + python_Boot.__string_rec(o.params[i], s)
				
				
				return o.tag + "(" + paramsStr + ")"
			
			else:
				return o.tag
		
		
		if builtin.hasattr(o, "_hx_class_name"):
			return o._hx_class_name
		
		if o == str:
			return "String"
		
		return o.__class__.__name__
	
	else:
		try:
			def _hx_local_2(_):
				return True
			_hx_inspect.getmembers(o, _hx_local_2)
			return str(o)
	
		except Exception as _hx_e:
			_hx_e1 = _hx_e.val if isinstance(_hx_e, _HxException) else _hx_e
			if True:
				e = _hx_e1
				return "???"
			else:
				raise _hx_e
	
python_Boot.__string_rec = Boot_statics___string_rec


python_Boot._hx_class = python_Boot
python_Boot._hx_class_name = "python.Boot"
_hx_classes['python.Boot'] = python_Boot
python_Boot._hx_fields = []
python_Boot._hx_props = []
python_Boot._hx_methods = []
python_Boot._hx_statics = ["__string_rec"]
python_Boot._hx_interfaces = []

class python_Lib:

	pass




def Lib_statics__hx_print(v):
	python_lib_Sys.stdout.write(Std.string(v))
	python_lib_Sys.stdout.flush()
	
python_Lib._hx_print = Lib_statics__hx_print
def Lib_statics_println(v):
	_g = 0
	while _g < len(v):
		e = v[_g]
		_g = _g + 1
		print(Std.string(e))
	
	
python_Lib.println = Lib_statics_println


python_Lib._hx_class = python_Lib
python_Lib._hx_class_name = "python.Lib"
_hx_classes['python.Lib'] = python_Lib
python_Lib._hx_fields = []
python_Lib._hx_props = []
python_Lib._hx_methods = []
python_Lib._hx_statics = ["print","println"]
python_Lib._hx_interfaces = []

import builtins as __builtin__
import inspect as _hx_inspect
import random as _hx_random
import sys as python_lib_Sys
Main.main()#transformedMain.main()
