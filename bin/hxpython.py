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

	pass




def ArrayDemo_statics_main():
	def _hx_local_0():
		return AnonObject(fileName = "ArrayDemo.hx" ,lineNumber = 6 ,className = "ArrayDemo" ,methodName = "main" )
	print(Std.string("ArrayDemo"))
	list()
	a1 = [1, 2, 3]
	def _hx_local_1():
		return AnonObject(fileName = "ArrayDemo.hx" ,lineNumber = 14 ,className = "ArrayDemo" ,methodName = "main" )
	print(Std.string(a1))
	a1.append(4)
	__builtin__.len(a1)
	
	def _hx_local_2():
		return AnonObject(fileName = "ArrayDemo.hx" ,lineNumber = 18 ,className = "ArrayDemo" ,methodName = "main" )
	print(Std.string(a1))
	a2 = [1, 2, 3]
	def _hx_local_3(x = None):
		return 100 + x
	def _hx_local_4():
		return AnonObject(fileName = "ArrayDemo.hx" ,lineNumber = 22 ,className = "ArrayDemo" ,methodName = "main" )
	print(Std.string(list(map(_hx_local_3, a2))))
	
ArrayDemo.main = ArrayDemo_statics_main


ArrayDemo._hx_class = ArrayDemo
ArrayDemo._hx_class_name = "ArrayDemo"
_hx_classes['ArrayDemo'] = ArrayDemo
ArrayDemo._hx_fields = []
ArrayDemo._hx_props = []
ArrayDemo._hx_methods = []
ArrayDemo._hx_statics = ["main"]
ArrayDemo._hx_interfaces = []

class ControlFlowDemo:


	def __init__(self = None):
		self.NAMED_FUNCTION()
		jimmy = 22
		def _hx_local_0():
			return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 16 ,className = "ControlFlowDemo" ,methodName = "new" )
		print(Std.string("\n\n-------------CONDITIONAL---------------\n"))
		if ControlFlowDemo.STATIC_VAR == "staticVar":
			def _hx_local_1():
				return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 21 ,className = "ControlFlowDemo" ,methodName = "new" )
			print(Std.string("STATIC_VAR == \"staticVar\" is true"))
		
		else:
			def _hx_local_2():
				return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 25 ,className = "ControlFlowDemo" ,methodName = "new" )
			print(Std.string("STATIC_VAR == \"staticVar\" is false"))
			def _hx_local_3():
				return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 26 ,className = "ControlFlowDemo" ,methodName = "new" )
			print(Std.string("STATIC_VAR == \"staticVar\" is false"))
		
		def _hx_local_4():
			return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 29 ,className = "ControlFlowDemo" ,methodName = "new" )
		print(Std.string("\n\n-------------SWITCH---------------\n"))
		jimmy = 33
		if jimmy == 1:
			def _hx_local_5():
				return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 35 ,className = "ControlFlowDemo" ,methodName = "new" )
			print(Std.string("jimmy is 1"))
		
		elif jimmy == 3:
			def _hx_local_6():
				return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 36 ,className = "ControlFlowDemo" ,methodName = "new" )
			print(Std.string("jimmy is 3"))
		
		elif jimmy == 88:
			def _hx_local_7():
				return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 37 ,className = "ControlFlowDemo" ,methodName = "new" )
			print(Std.string("jimmy is 88"))
		
		elif jimmy == 33:
			def _hx_local_8():
				return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 38 ,className = "ControlFlowDemo" ,methodName = "new" )
			print(Std.string("jimmy is 33"))
		
		else:
			def _hx_local_9():
				return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 39 ,className = "ControlFlowDemo" ,methodName = "new" )
			print(Std.string("default: don\'t konw how old jimmy is"))
		
		def _hx_local_10():
			return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 55 ,className = "ControlFlowDemo" ,methodName = "new" )
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
				return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 60 ,className = "ControlFlowDemo" ,methodName = "new" )
			print(Std.string("count = ") + Std.string(count))
		
		def _hx_local_14():
			return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 63 ,className = "ControlFlowDemo" ,methodName = "new" )
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
				return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 67 ,className = "ControlFlowDemo" ,methodName = "new" )
			print(Std.string("i = ") + Std.string(i))
		
		
		def _hx_local_17():
			return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 70 ,className = "ControlFlowDemo" ,methodName = "new" )
		print(Std.string("-------------FOR OVER ITERTOR---------------"))
		it = [1, 2, 3, 4]
		_g = 0
		while _g < len(it):
			i = it[_g]
			_g = _g + 1
			def _hx_local_18():
				return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 76 ,className = "ControlFlowDemo" ,methodName = "new" )
			print(Std.string(i))
		
		
		def _hx_local_19():
			return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 79 ,className = "ControlFlowDemo" ,methodName = "new" )
		print(Std.string("\n\n-------------TRY CATCH: SUCCESS---------------\n"))
		str = "string"
		x = "anotherString"
		def _hx_local_20(a = None,b = None):
			return a + b
		noError = _hx_local_20
		def _hx_local_22():
			return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 92 ,className = "ControlFlowDemo" ,methodName = "new" )
		try:
			noError(str, x)
			def _hx_local_21():
				return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 88 ,className = "ControlFlowDemo" ,methodName = "new" )
			print(Std.string("no error"))
		
		except Exception as _hx_e:
			_hx_e1 = _hx_e.val if isinstance(_hx_e, _HxException) else _hx_e
			if True:
				e = _hx_e1
				print(Std.string("error = ") + Std.string(e))
			else:
				raise _hx_e
		def _hx_local_23():
			return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 95 ,className = "ControlFlowDemo" ,methodName = "new" )
		print(Std.string("\n\n-------------TRY CATCH: ERROR---------------\n"))
		str1 = "string"
		x1 = 0
		def _hx_local_24(a = None,b = None):
			return a + b
		causeError = _hx_local_24
		def _hx_local_26():
			return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 108 ,className = "ControlFlowDemo" ,methodName = "new" )
		try:
			causeError(str1, x1)
			def _hx_local_25():
				return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 104 ,className = "ControlFlowDemo" ,methodName = "new" )
			print(Std.string("no error"))
		
		except Exception as _hx_e:
			_hx_e1 = _hx_e.val if isinstance(_hx_e, _HxException) else _hx_e
			if True:
				e = _hx_e1
				print(Std.string("Success: error = ") + Std.string(e))
			else:
				raise _hx_e
		def _hx_local_27():
			return AnonObject(fileName = "ControlFlowDemo.hx" ,lineNumber = 111 ,className = "ControlFlowDemo" ,methodName = "new" )
		print(Std.string("\n\n--------------------------------------------\n"))
	
	def NAMED_FUNCTION(self = None):
		None





ControlFlowDemo.STATIC_VAR = "staticVar"#transformed"staticVar"
def ControlFlowDemo_statics_main():
	ControlFlowDemo()
ControlFlowDemo.main = ControlFlowDemo_statics_main


ControlFlowDemo._hx_class = ControlFlowDemo
ControlFlowDemo._hx_class_name = "ControlFlowDemo"
_hx_classes['ControlFlowDemo'] = ControlFlowDemo
ControlFlowDemo._hx_fields = []
ControlFlowDemo._hx_props = []
ControlFlowDemo._hx_methods = ["NAMED_FUNCTION"]
ControlFlowDemo._hx_statics = ["STATIC_VAR","main"]
ControlFlowDemo._hx_interfaces = []

class HxOverrides:

	pass






HxOverrides._hx_class = HxOverrides
HxOverrides._hx_class_name = "HxOverrides"
_hx_classes['HxOverrides'] = HxOverrides
HxOverrides._hx_fields = []
HxOverrides._hx_props = []
HxOverrides._hx_methods = []
HxOverrides._hx_statics = []
HxOverrides._hx_interfaces = []

class List:


	def __init__(self = None):
		self.length = 0
	def iterator(self = None):
		def _hx_local_3():
			def _hx_local_2():
				def _hx_local_0():
					return self.h is not None
				def _hx_local_1():
					if self.h is None:
						return None
					
					x = self.h[0]
					self.h = self.h[1]
					return x
				
				return AnonObject(h = self.h ,hasNext = _hx_local_0 ,next = _hx_local_1 )
			
			return _hx_local_2()
		
		return _hx_local_3()
	

	def add(self = None,item = None):
		x = [item]
		if self.h is None:
			self.h = x
		else:
			self.q[1] = x
		self.q = x
		_hx_r = self.length
		self.length = self.length + 1
		_hx_r
		
	

	# var length
	# var q
	# var h






List._hx_class = List
List._hx_class_name = "List"
_hx_classes['List'] = List
List._hx_fields = ["length","q","h"]
List._hx_props = []
List._hx_methods = ["iterator","add"]
List._hx_statics = []
List._hx_interfaces = []

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
	Tools.log(":::::SerializeDemo::::::")
	SerializeDemo.main()
	Tools.log(":::::SimpleDemo::::::")
	SimpleDemo.main()
	Tools.log(":::::ReflectDemo::::::")
	ReflectDemo.main()
	Tools.log(":::::ArrayDemo::::::")
	ArrayDemo.main()
	Tools.log(":::::ControlFlowDemo::::::")
	ControlFlowDemo.main()
	
Main.main = Main_statics_main


Main._hx_class = Main
Main._hx_class_name = "Main"
_hx_classes['Main'] = Main
Main._hx_fields = []
Main._hx_props = []
Main._hx_methods = []
Main._hx_statics = ["main"]
Main._hx_interfaces = []

class Map_IMap:

	pass






Map_IMap._hx_class = Map_IMap
Map_IMap._hx_class_name = "IMap"
_hx_classes['IMap'] = Map_IMap
Map_IMap._hx_fields = []
Map_IMap._hx_props = []
Map_IMap._hx_methods = []
Map_IMap._hx_statics = []
Map_IMap._hx_interfaces = []

class _PropertyDemo_PropertyDemo_Foo:


	def __init__(self = None):
		self.z = 5
	def get_z(self = None):
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
PropertyDemo_B._hx_class_name = "B"
_hx_classes['B'] = PropertyDemo_B
PropertyDemo_B._hx_fields = []
PropertyDemo_B._hx_props = []
PropertyDemo_B._hx_methods = []
PropertyDemo_B._hx_statics = []
PropertyDemo_B._hx_interfaces = []

class PropertyDemo_A:

	pass






PropertyDemo_A._hx_class = PropertyDemo_A
PropertyDemo_A._hx_class_name = "A"
_hx_classes['A'] = PropertyDemo_A
PropertyDemo_A._hx_fields = []
PropertyDemo_A._hx_props = []
PropertyDemo_A._hx_methods = []
PropertyDemo_A._hx_statics = []
PropertyDemo_A._hx_interfaces = [PropertyDemo_B]

class PropertyDemo_C:

	pass






PropertyDemo_C._hx_class = PropertyDemo_C
PropertyDemo_C._hx_class_name = "C"
_hx_classes['C'] = PropertyDemo_C
PropertyDemo_C._hx_fields = []
PropertyDemo_C._hx_props = []
PropertyDemo_C._hx_methods = []
PropertyDemo_C._hx_statics = []
PropertyDemo_C._hx_interfaces = [PropertyDemo_B,PropertyDemo_A]

class PropertyDemo_Z:


	def __init__(self = None):
		None






PropertyDemo_Z._hx_class = PropertyDemo_Z
PropertyDemo_Z._hx_class_name = "Z"
_hx_classes['Z'] = PropertyDemo_Z
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
PropertyDemo_MyEnum._hx_class = PropertyDemo_MyEnum
PropertyDemo_MyEnum._hx_class_name = "MyEnum"
_hx_classes['MyEnum'] = PropertyDemo_MyEnum

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




def Reflect_statics_field(o = None,field = None):
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
def Reflect_statics_getProperty(o = None,field = None):
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
def Reflect_statics_fields(o = None):
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
def Reflect_statics_isFunction(f = None):
	return __builtin__.callable(f)
Reflect.isFunction = Reflect_statics_isFunction
def Reflect_statics_deleteField(o = None,field = None):
	def _hx_local_1():
		def _hx_local_0():
			raise _HxException("not implemented")
			return None
		
		return _hx_local_0()
	
	return _hx_local_1()
	
Reflect.deleteField = Reflect_statics_deleteField


Reflect._hx_class = Reflect
Reflect._hx_class_name = "Reflect"
_hx_classes['Reflect'] = Reflect
Reflect._hx_fields = []
Reflect._hx_props = []
Reflect._hx_methods = []
Reflect._hx_statics = ["field","getProperty","fields","isFunction","deleteField"]
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

class SerializeDemo:

	pass




def SerializeDemo_statics_main():
	Tools.highlight(SerializeDemo.serializeEnum, "serializeEnum")
	Tools.highlight(SerializeDemo.serializeClass, "serializeClass")
	Tools.highlight(SerializeDemo.serializeStructure, "serializeStructure")
	
SerializeDemo.main = SerializeDemo_statics_main
def SerializeDemo_statics_serializeStructure():
	def _hx_local_0():
		return AnonObject(age = 17 ,name = "jim" ,drinks = 3.5 )
	o = _hx_local_0()
	s = haxe_Serializer.run(o)
	def _hx_local_1():
		return AnonObject(fileName = "SerializeDemo.hx" ,lineNumber = 27 ,className = "SerializeDemo" ,methodName = "serializeStructure" )
	print(Std.string(s))
	o2 = haxe_Unserializer.run(s)
	def _hx_local_2():
		return AnonObject(fileName = "SerializeDemo.hx" ,lineNumber = 32 ,className = "SerializeDemo" ,methodName = "serializeStructure" )
	print(Std.string(o2.age))
	def _hx_local_3():
		return AnonObject(fileName = "SerializeDemo.hx" ,lineNumber = 33 ,className = "SerializeDemo" ,methodName = "serializeStructure" )
	print(Std.string(o2.name))
	def _hx_local_4():
		return AnonObject(fileName = "SerializeDemo.hx" ,lineNumber = 34 ,className = "SerializeDemo" ,methodName = "serializeStructure" )
	print(Std.string(o2.drinks))
	s2 = haxe_Serializer.run(o2)
	def _hx_local_5():
		return AnonObject(fileName = "SerializeDemo.hx" ,lineNumber = 39 ,className = "SerializeDemo" ,methodName = "serializeStructure" )
	print(Std.string(s2))
	
SerializeDemo.serializeStructure = SerializeDemo_statics_serializeStructure
def SerializeDemo_statics_serializeEnum():
	x = Types_EnumMoney.Euro
	s = haxe_Serializer.run(x)
	def _hx_local_0():
		return AnonObject(fileName = "SerializeDemo.hx" ,lineNumber = 47 ,className = "SerializeDemo" ,methodName = "serializeEnum" )
	print(Std.string(s))
	u = haxe_Unserializer.run(s)
	s2 = haxe_Unserializer.run(s)
	def _hx_local_1():
		return AnonObject(fileName = "SerializeDemo.hx" ,lineNumber = 51 ,className = "SerializeDemo" ,methodName = "serializeEnum" )
	print(Std.string(s))
	def _hx_local_2():
		return AnonObject(fileName = "SerializeDemo.hx" ,lineNumber = 52 ,className = "SerializeDemo" ,methodName = "serializeEnum" )
	print(Std.string(s2))
	def _hx_local_3():
		return AnonObject(fileName = "SerializeDemo.hx" ,lineNumber = 54 ,className = "SerializeDemo" ,methodName = "serializeEnum" )
	print(Std.string(x))
	def _hx_local_4():
		return AnonObject(fileName = "SerializeDemo.hx" ,lineNumber = 55 ,className = "SerializeDemo" ,methodName = "serializeEnum" )
	print(Std.string(u))
	x1 = bits_EnumDemo.One
	s1 = haxe_Serializer.run(x1)
	def _hx_local_5():
		return AnonObject(fileName = "SerializeDemo.hx" ,lineNumber = 60 ,className = "SerializeDemo" ,methodName = "serializeEnum" )
	print(Std.string(s1))
	u1 = haxe_Unserializer.run(s1)
	s21 = haxe_Unserializer.run(s1)
	def _hx_local_6():
		return AnonObject(fileName = "SerializeDemo.hx" ,lineNumber = 64 ,className = "SerializeDemo" ,methodName = "serializeEnum" )
	print(Std.string(s1))
	def _hx_local_7():
		return AnonObject(fileName = "SerializeDemo.hx" ,lineNumber = 65 ,className = "SerializeDemo" ,methodName = "serializeEnum" )
	print(Std.string(s21))
	def _hx_local_8():
		return AnonObject(fileName = "SerializeDemo.hx" ,lineNumber = 67 ,className = "SerializeDemo" ,methodName = "serializeEnum" )
	print(Std.string(x1))
	def _hx_local_9():
		return AnonObject(fileName = "SerializeDemo.hx" ,lineNumber = 68 ,className = "SerializeDemo" ,methodName = "serializeEnum" )
	print(Std.string(u1))
	
SerializeDemo.serializeEnum = SerializeDemo_statics_serializeEnum
def SerializeDemo_statics_serializeClass():
	cl = Types_ClassA()
	cl1 = haxe_Serializer.run(cl)
	c2 = haxe_Unserializer.run(cl1)
	def _hx_local_0():
		return AnonObject(fileName = "SerializeDemo.hx" ,lineNumber = 80 ,className = "SerializeDemo" ,methodName = "serializeClass" )
	print(Std.string(c2.x))
	
SerializeDemo.serializeClass = SerializeDemo_statics_serializeClass


SerializeDemo._hx_class = SerializeDemo
SerializeDemo._hx_class_name = "SerializeDemo"
_hx_classes['SerializeDemo'] = SerializeDemo
SerializeDemo._hx_fields = []
SerializeDemo._hx_props = []
SerializeDemo._hx_methods = []
SerializeDemo._hx_statics = ["main","serializeStructure","serializeEnum","serializeClass"]
SerializeDemo._hx_interfaces = []

class SimpleDemo:

	pass




def SimpleDemo_statics_main():
	z = 10
	x = 0
	if z > 2:
		x = 7
	else:
		x = 10
	def _hx_local_0():
		return AnonObject(fileName = "SimpleDemo.hx" ,lineNumber = 18 ,className = "SimpleDemo" ,methodName = "main" )
	print(Std.string(x))
	def _hx_local_1():
		return AnonObject(fileName = "SimpleDemo.hx" ,lineNumber = 19 ,className = "SimpleDemo" ,methodName = "main" )
	print(Std.string(z))
	
SimpleDemo.main = SimpleDemo_statics_main


SimpleDemo._hx_class = SimpleDemo
SimpleDemo._hx_class_name = "SimpleDemo"
_hx_classes['SimpleDemo'] = SimpleDemo
SimpleDemo._hx_fields = []
SimpleDemo._hx_props = []
SimpleDemo._hx_methods = []
SimpleDemo._hx_statics = ["main"]
SimpleDemo._hx_interfaces = []

class Std:

	pass




def Std_statics__hx_is(v = None,t = None):
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
			def _hx_local_1(intf = None):
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
def Std_statics_string(s = None):
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
def Std_statics_int(x = None):
	return int(x)
Std.int = Std_statics_int
def Std_statics_parseInt(x = None):
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

from io import StringIO as _hx_StringIO
class StringTools:

	pass




def StringTools_statics_urlEncode(s = None):
	from urllib.parse import quote
	return quote(s)
	
StringTools.urlEncode = StringTools_statics_urlEncode
def StringTools_statics_urlDecode(s = None):
	from urllib.parse import unquote
	return unquote(s)
	
StringTools.urlDecode = StringTools_statics_urlDecode
def StringTools_statics_fastCodeAt(s = None,index = None):
	if index < __builtin__.len(s):
		return ord(s[index])
	else:
		return -1
StringTools.fastCodeAt = StringTools_statics_fastCodeAt


StringTools._hx_class = StringTools
StringTools._hx_class_name = "StringTools"
_hx_classes['StringTools'] = StringTools
StringTools._hx_fields = []
StringTools._hx_props = []
StringTools._hx_methods = []
StringTools._hx_statics = ["urlEncode","urlDecode","fastCodeAt"]
StringTools._hx_interfaces = []

class Tools:

	pass




def Tools_statics_highlight(f = None,name = None):
	Tools.log("------------------------------------------start " + name + "\n")
	f()
	Tools.log("------------------------------------------end " + name + "\n")
	
Tools.highlight = Tools_statics_highlight
def Tools_statics_log(f = None):
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
Type_ValueType._hx_class = Type_ValueType
Type_ValueType._hx_class_name = "ValueType"
_hx_classes['ValueType'] = Type_ValueType

class Type:

	pass




def Type_statics_getClassName(c = None):
	if __builtin__.hasattr(c, "_hx_class_name"):
		return c._hx_class_name
	else:
		try:
			s = c.__name__
		except Exception as _hx_e:
			_hx_e1 = _hx_e.val if isinstance(_hx_e, _HxException) else _hx_e
			if True:
				e = _hx_e1
				None
			else:
				raise _hx_e
	res = None
	return res
	
Type.getClassName = Type_statics_getClassName
def Type_statics_getEnumName(e = None):
	return e._hx_class_name
Type.getEnumName = Type_statics_getEnumName
def Type_statics_resolveClass(name = None):
	cl = _hx_classes[name]
	if cl is None or not cl._hx_class:
		return None
	
	return cl
	
Type.resolveClass = Type_statics_resolveClass
def Type_statics_resolveEnum(name = None):
	return Type.resolveClass(name)
Type.resolveEnum = Type_statics_resolveEnum
def Type_statics_createInstance(cl = None,args = None):
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
def Type_statics_createEmptyInstance(cl = None):
	return cl.__new__(cl)
Type.createEmptyInstance = Type_statics_createEmptyInstance
def Type_statics_createEnum(e = None,constr = None,params = None):
	f = Reflect.field(e, constr)
	if f is None:
		raise _HxException("No such constructor " + constr)
	
	if Reflect.isFunction(f):
		if params is None:
			raise _HxException("Constructor " + constr + " need parameters")
		
		def _hx_local_1():
			def _hx_local_0():
				raise _HxException("not implemented")
				return None
			
			return _hx_local_0()
		
		return _hx_local_1()
	
	
	if params is not None and __builtin__.len(params) != 0:
		raise _HxException("Constructor " + constr + " does not need parameters")
	
	return f
	
Type.createEnum = Type_statics_createEnum
def Type_statics_getEnumConstructs(e = None):
	def _hx_local_1():
		def _hx_local_0():
			raise _HxException("getEnumConstructs not implemented")
			return None
		
		return _hx_local_0()
	
	return _hx_local_1()
	
Type.getEnumConstructs = Type_statics_getEnumConstructs
def Type_statics_typeof(v = None):
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
def Type_statics_enumConstructor(e = None):
	return e.tag
Type.enumConstructor = Type_statics_enumConstructor
def Type_statics_enumParameters(e = None):
	return e.params
Type.enumParameters = Type_statics_enumParameters
def Type_statics_enumIndex(e = None):
	return e.index
Type.enumIndex = Type_statics_enumIndex


Type._hx_class = Type
Type._hx_class_name = "Type"
_hx_classes['Type'] = Type
Type._hx_fields = []
Type._hx_props = []
Type._hx_methods = []
Type._hx_statics = ["getClassName","getEnumName","resolveClass","resolveEnum","createInstance","createEmptyInstance","createEnum","getEnumConstructs","typeof","enumConstructor","enumParameters","enumIndex"]
Type._hx_interfaces = []

class TypeDemo_Foo:


	def __init__(self = None):
		self.z = 5
	# var z






TypeDemo_Foo._hx_class = TypeDemo_Foo
TypeDemo_Foo._hx_class_name = "Foo"
_hx_classes['Foo'] = TypeDemo_Foo
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


	def __init__(self = None):
		self.x = 10
	# var x






Types_ClassA._hx_class = Types_ClassA
Types_ClassA._hx_class_name = "ClassA"
_hx_classes['ClassA'] = Types_ClassA
Types_ClassA._hx_fields = ["x"]
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
Types_EnumMoney._hx_class = Types_EnumMoney
Types_EnumMoney._hx_class_name = "EnumMoney"
_hx_classes['EnumMoney'] = Types_EnumMoney

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
VariousExpressions_Color._hx_class = VariousExpressions_Color
VariousExpressions_Color._hx_class_name = "Color"
_hx_classes['Color'] = VariousExpressions_Color

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


	def __init__(self = None,z = None):
		self.q = z
	def walk(self = None):
		def _hx_local_0():
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 27 ,className = "Sub" ,methodName = "walk" )
		print(Std.string("walk ") + Std.string(self.q))
	

	# var q






VariousExpressions_Sub._hx_class = VariousExpressions_Sub
VariousExpressions_Sub._hx_class_name = "Sub"
_hx_classes['Sub'] = VariousExpressions_Sub
VariousExpressions_Sub._hx_fields = ["q"]
VariousExpressions_Sub._hx_props = []
VariousExpressions_Sub._hx_methods = ["walk"]
VariousExpressions_Sub._hx_statics = []
VariousExpressions_Sub._hx_interfaces = []

class VariousExpressions_Hui:

	pass






VariousExpressions_Hui._hx_class = VariousExpressions_Hui
VariousExpressions_Hui._hx_class_name = "Hui"
_hx_classes['Hui'] = VariousExpressions_Hui
VariousExpressions_Hui._hx_fields = []
VariousExpressions_Hui._hx_props = []
VariousExpressions_Hui._hx_methods = []
VariousExpressions_Hui._hx_statics = []
VariousExpressions_Hui._hx_interfaces = []

class VariousExpressions_HuiBu:

	pass






VariousExpressions_HuiBu._hx_class = VariousExpressions_HuiBu
VariousExpressions_HuiBu._hx_class_name = "HuiBu"
_hx_classes['HuiBu'] = VariousExpressions_HuiBu
VariousExpressions_HuiBu._hx_fields = []
VariousExpressions_HuiBu._hx_props = []
VariousExpressions_HuiBu._hx_methods = []
VariousExpressions_HuiBu._hx_statics = []
VariousExpressions_HuiBu._hx_interfaces = []

class VariousExpressions_Child(VariousExpressions_Sub):


	def __init__(self = None):
		super().__init__(77)
	def walk(self = None):
		super().walk()
		def _hx_local_0():
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 41 ,className = "Child" ,methodName = "walk" )
		print(Std.string("hey"))
	







VariousExpressions_Child._hx_class = VariousExpressions_Child
VariousExpressions_Child._hx_class_name = "Child"
_hx_classes['Child'] = VariousExpressions_Child
VariousExpressions_Child._hx_fields = []
VariousExpressions_Child._hx_props = []
VariousExpressions_Child._hx_methods = ["walk"]
VariousExpressions_Child._hx_statics = []
VariousExpressions_Child._hx_interfaces = [VariousExpressions_Hui]
VariousExpressions_Child._hx_super = VariousExpressions_Sub

class VariousExpressions_Whatever:


	def __init__(self = None):
		None
	def get_hello(self = None):
		return 1







VariousExpressions_Whatever._hx_class = VariousExpressions_Whatever
VariousExpressions_Whatever._hx_class_name = "Whatever"
_hx_classes['Whatever'] = VariousExpressions_Whatever
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
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 67 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string(VariousExpressions_Whatever().get_hello()))
	x = 65
	z = 3 + x
	def _hx_local_2():
		def _hx_local_1():
			c = z
			return "".join(map(chr, [c]))
		
		return "String.fromCharcode(" + Std.string(z) + ") = " + _hx_local_1()
	
	def _hx_local_3():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 71 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string(_hx_local_2()))
	def _hx_local_4():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 72 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string(__builtin__.len("hello world")))
	def _hx_local_5():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 73 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string(_VariousExpressions_VariousExpressions_Sum.jup))
	umlaut = "UMLAUTE: äöüÄÖÜß"
	gurki = 511111
	t22 = (1, "tupleB")
	def _hx_local_6():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 78 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string(t22[1]))
	def _hx_local_8():
		def _hx_local_7():
			nonlocal gurki
			gurki = 121212121
			return gurki
			
		
		return AnonObject(x = _hx_local_7 )
	
	t221 = (1, "tupleB", _hx_local_8())
	def _hx_local_9():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 80 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string(t221[2].x()))
	mySub = VariousExpressions_Sub(177)
	def _hx_local_10():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 86 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string(__builtin__.hasattr(mySub, "walk")))
	mySub.walk()
	child = VariousExpressions_Child()
	child.walk()
	def _hx_local_11():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 91 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string(Std._hx_is(child, VariousExpressions_Hui)))
	def _hx_local_12():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 92 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string(Std._hx_is(child, VariousExpressions_HuiBu)))
	def _hx_local_13():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 96 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string(type(umlaut)))
	python_Lib._hx_print("hey")
	python_Lib.println(["hey", "heyho"])
	def _hx_local_14():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 103 ,className = "VariousExpressions" ,methodName = "main" )
	def _hx_local_14():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 103 ,className = "VariousExpressions" ,methodName = "main" )
	def _hx_local_15():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 106 ,className = "VariousExpressions" ,methodName = "main" )
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
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 115 ,className = "VariousExpressions" ,methodName = "main" )
	def _hx_local_20():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 117 ,className = "VariousExpressions" ,methodName = "main" )
	def _hx_local_21():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 119 ,className = "VariousExpressions" ,methodName = "main" )
	try:
		def _hx_local_16():
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 111 ,className = "VariousExpressions" ,methodName = "main" )
		print(Std.string(str([1, 2]) + Std.string([3, 4])))
		def _hx_local_17():
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 112 ,className = "VariousExpressions" ,methodName = "main" )
		print(Std.string([1, 2, 3][1]))
		def _hx_local_18():
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 113 ,className = "VariousExpressions" ,methodName = "main" )
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
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 126 ,className = "VariousExpressions" ,methodName = "main" )
	def _hx_local_26():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 128 ,className = "VariousExpressions" ,methodName = "main" )
	def _hx_local_27():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 130 ,className = "VariousExpressions" ,methodName = "main" )
	try:
		def _hx_local_22():
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 122 ,className = "VariousExpressions" ,methodName = "main" )
		print(Std.string(str([1, 2]) + Std.string([3, 4])))
		def _hx_local_23():
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 123 ,className = "VariousExpressions" ,methodName = "main" )
		print(Std.string([1, 2, 3][1]))
		def _hx_local_24():
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 124 ,className = "VariousExpressions" ,methodName = "main" )
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
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 149 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string(u))
	u1 = 10
	def _hx_local_29():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 152 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string(u1))
	
	def _hx_local_30():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 155 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string(VariousExpressions.zy))
	def _hx_local_31():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 156 ,className = "VariousExpressions" ,methodName = "main" )
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
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 163 ,className = "VariousExpressions" ,methodName = "main" )
		print(Std.string("hello"))
	
	
	b = False
	if b:
		def _hx_local_38():
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 166 ,className = "VariousExpressions" ,methodName = "main" )
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
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 187 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string("x from tryCatch:") + Std.string(x1))
	def _hx_local_49():
		def _hx_local_48():
			return AnonObject(x = 5 )
		_hx_local_50 = _hx_local_48().x = 10
		return _hx_local_50
	
	x2 = _hx_local_49()
	def _hx_local_51():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 191 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string("new X : ") + Std.string(x2))
	def _hx_local_53():
		def _hx_local_52(x3 = None):
			return x3 * 3
		return AnonObject(x = 5 ,y = 10 ,z = _hx_local_52 )
	
	z4 = _hx_local_53()
	def _hx_local_55():
		def _hx_local_54():
			return 2 if z4.x < 0 else 17
		return 1 if z4.x > 10 else _hx_local_54()
	
	z11 = _hx_local_55()
	def _hx_local_56():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 202 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string("z11:") + Std.string(z11))
	z4.x = z4.x + 10
	def _hx_local_57():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 204 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string("z.z(2): ") + Std.string(z4.z(2)))
	def _hx_local_58():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 205 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string("z:") + Std.string(z4.x))
	x3 = True
	while x3:
		x3 = False
		z5 = 5
		if z5 == 5:
			def _hx_local_59():
				return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 215 ,className = "VariousExpressions" ,methodName = "main" )
			print(Std.string(z5))
			break
		
		
		1
	
	def _hx_local_60():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 226 ,className = "VariousExpressions" ,methodName = "main" )
	def _hx_local_61():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 228 ,className = "VariousExpressions" ,methodName = "main" )
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
				return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 238 ,className = "VariousExpressions" ,methodName = "main" )
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
								return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 239 ,className = "VariousExpressions" ,methodName = "main" )
							print(Std.string("has 20 red"))
							return c
						
						def _hx_local_71():
							def _hx_local_67():
								def _hx_local_68():
									return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 240 ,className = "VariousExpressions" ,methodName = "main" )
								print(Std.string("has 10 red"))
								return c
							
							def _hx_local_69():
								def _hx_local_70():
									return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 241 ,className = "VariousExpressions" ,methodName = "main" )
								print(Std.string("other rgb"))
								return c
							
							return _hx_local_67() if c_eRGB_0 == 10 else _hx_local_69()
						
						return _hx_local_65() if c_eRGB_0 == 20 else _hx_local_71()
					
					return _hx_local_72()
				
				return _hx_local_73()
			
			def _hx_local_84():
				def _hx_local_74():
					def _hx_local_75():
						return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 242 ,className = "VariousExpressions" ,methodName = "main" )
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
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 255 ,className = "VariousExpressions" ,methodName = "main" )
		print(Std.string("it\'s 1"))
	
	else:
		def _hx_local_88():
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 257 ,className = "VariousExpressions" ,methodName = "main" )
		print(Std.string("not 1"))
		def _hx_local_89():
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 258 ,className = "VariousExpressions" ,methodName = "main" )
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
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 263 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string(_hx_local_90()))
	if x4 == 1:
		if c.tag == "RED":
			def _hx_local_96():
				return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 266 ,className = "VariousExpressions" ,methodName = "main" )
			print(Std.string("it\'s 1 red"))
	
		else:
			def _hx_local_97():
				return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 267 ,className = "VariousExpressions" ,methodName = "main" )
			print(Std.string("not 1 red"))
	
	else:
		def _hx_local_98():
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 267 ,className = "VariousExpressions" ,methodName = "main" )
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
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 271 ,className = "VariousExpressions" ,methodName = "main" )
		print(Std.string(i))
	
	
	_g = 0
	_g1 = [0, 1, 2]
	while _g < len(_g1):
		i = _g1[_g]
		_g = _g + 1
		def _hx_local_101():
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 275 ,className = "VariousExpressions" ,methodName = "main" )
		print(Std.string(i))
	
	
	def _hx_local_102():
		return 23.1
	hey = _hx_local_102
	def _hx_local_103():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 280 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string("----------------"))
	zy = 1
	def _hx_local_104():
		nonlocal zy
		def _hx_local_105():
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 283 ,className = "VariousExpressions" ,methodName = "main" )
		print(Std.string(zy))
		zy = zy + 2
		def _hx_local_106():
			nonlocal zy
			def _hx_local_107():
				return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 286 ,className = "VariousExpressions" ,methodName = "main" )
			print(Std.string(zy))
			zy = zy + 7
			def _hx_local_108():
				return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 288 ,className = "VariousExpressions" ,methodName = "main" )
			print(Std.string(zy))
			
		
		zwei = _hx_local_106
		zwei()
		def _hx_local_109():
			return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 292 ,className = "VariousExpressions" ,methodName = "main" )
		print(Std.string(zy))
		
	
	f = _hx_local_104
	f()
	def _hx_local_110():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 296 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string(zy))
	def _hx_local_111():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 297 ,className = "VariousExpressions" ,methodName = "main" )
	print(Std.string("----------------"))
	def _hx_local_112():
		return AnonObject(fileName = "VariousExpressions.hx" ,lineNumber = 299 ,className = "VariousExpressions" ,methodName = "main" )
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


	def __init__(self = None):
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


	def __init__(self = None):
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


	def __init__(self = None):
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

class bits_EnumDemo(Enum):
	def __init__(self, t, i, p): 
		super(bits_EnumDemo,self).__init__(t, i, p)


def _bits_EnumDemo_statics_Jimmy (age): 
	return bits_EnumDemo("Jimmy", 1, [age])
bits_EnumDemo.Jimmy = _bits_EnumDemo_statics_Jimmy

bits_EnumDemo.One = bits_EnumDemo("One", 0, list())
bits_EnumDemo.constructs = ["Jimmy","One"]
bits_EnumDemo._hx_class = bits_EnumDemo
bits_EnumDemo._hx_class_name = "bits.EnumDemo"
_hx_classes['bits.EnumDemo'] = bits_EnumDemo

class haxe_Serializer:


	def __init__(self = None):
		self.buf = _hx_StringIO()
		self.cache = list()
		self.useCache = haxe_Serializer.USE_CACHE
		self.useEnumIndex = haxe_Serializer.USE_ENUM_INDEX
		self.shash = haxe_ds_StringMap()
		self.scount = 0
	
	def serialize(self = None,v = None):
		_g = Type.typeof(v)
		if _g.tag == "TNull":
			self.buf.write("n")
		elif _g.tag == "TInt":
			if v == 0:
				self.buf.write("z")
				return
			
			
			self.buf.write("i")
			self.buf.write(Std.string(v))
		
		elif _g.tag == "TFloat":
			def _hx_local_0():
				f = v
				return _hx_math.isnan(f)
			
			if _hx_local_0():
				self.buf.write("k")
			else:
				def _hx_local_1():
					f = v
					return not _hx_math.isinf(f)
				
				if not _hx_local_1():
					def _hx_local_2():
						return "m" if v < 0 else "p"
					self.buf.write(Std.string(_hx_local_2()))
				
				else:
					self.buf.write("d")
					self.buf.write(Std.string(v))
				
			
		
		elif _g.tag == "TBool":
			def _hx_local_3():
				return "t" if v else "f"
			self.buf.write(Std.string(_hx_local_3()))
		
		elif _g.tag == "TClass":
			c = _g.params[0]
			if c == str:
				self.serializeString(v)
				return
			
			
			if self.useCache and self.serializeRef(v):
				return
			
			_g1 = Type.getClassName(c)
			if _g1 == "Array":
				ucount = 0
				self.buf.write("a")
				l = v["length"]
				_g2 = 0
				while _g2 < l:
					def _hx_local_4():
						nonlocal _g2
						_hx_r = _g2
						_g2 = _g2 + 1
						return _hx_r
						
					
					i = _hx_local_4()
					if v[i] is None:
						_hx_r = ucount
						ucount = ucount + 1
						_hx_r
					
					else:
						if ucount > 0:
							if ucount == 1:
								self.buf.write("n")
							else:
								self.buf.write("u")
								self.buf.write(Std.string(ucount))
							
							ucount = 0
						
						
						self.serialize(v[i])
					
				
				
				if ucount > 0:
					if ucount == 1:
						self.buf.write("n")
					else:
						self.buf.write("u")
						self.buf.write(Std.string(ucount))
				
				
				self.buf.write("h")
			
			elif _g1 == "List":
				self.buf.write("l")
				v1 = v
				for i in v1.iterator(): self.serialize(i)
				self.buf.write("h")
			
			elif _g1 == "Date":
				d = v
				self.buf.write("v")
				self.buf.write(Std.string(HxOverrides.dateStr(d)))
			
			elif _g1 == "haxe.ds.StringMap":
				self.buf.write("b")
				v1 = v
				for k in v1.keys(): self.serializeString(k)
				self.serialize(v1.get(k))
				
				self.buf.write("h")
			
			elif _g1 == "haxe.ds.IntMap":
				self.buf.write("q")
				v1 = v
				for k in v1.keys(): self.buf.write(":")
				self.buf.write(Std.string(k))
				self.serialize(v1.get(k))
				
				self.buf.write("h")
			
			elif _g1 == "haxe.ds.ObjectMap":
				self.buf.write("M")
				v1 = v
				for k in v1.keys(): id = Reflect.field(k, "__id__")
				Reflect.deleteField(k, "__id__")
				self.serialize(k)
				__builtin__.setattr(k, "__id__", id)
				self.serialize(v1.h[k._hx_id__])
				
				self.buf.write("h")
			
			elif _g1 == "haxe.io.Bytes":
				v1 = v
				i = 0
				max = v1.length - 2
				charsBuf = _hx_StringIO()
				b64 = haxe_Serializer.BASE64
				while i < max:
					def _hx_local_5():
						nonlocal i
						_hx_r = i
						i = i + 1
						return _hx_r
						
					
					b1 = v1.b[_hx_local_5()]
					def _hx_local_6():
						nonlocal i
						_hx_r = i
						i = i + 1
						return _hx_r
						
					
					b2 = v1.b[_hx_local_6()]
					def _hx_local_7():
						nonlocal i
						_hx_r = i
						i = i + 1
						return _hx_r
						
					
					b3 = v1.b[_hx_local_7()]
					charsBuf.write(Std.string(b64[b1 >> 2]))
					charsBuf.write(Std.string(b64[b1 << 4 | b2 >> 4 & 63]))
					charsBuf.write(Std.string(b64[b2 << 2 | b3 >> 6 & 63]))
					charsBuf.write(Std.string(b64[b3 & 63]))
				
				if i == max:
					def _hx_local_8():
						nonlocal i
						_hx_r = i
						i = i + 1
						return _hx_r
						
					
					b1 = v1.b[_hx_local_8()]
					def _hx_local_9():
						nonlocal i
						_hx_r = i
						i = i + 1
						return _hx_r
						
					
					b2 = v1.b[_hx_local_9()]
					charsBuf.write(Std.string(b64[b1 >> 2]))
					charsBuf.write(Std.string(b64[b1 << 4 | b2 >> 4 & 63]))
					charsBuf.write(Std.string(b64[b2 << 2 & 63]))
				
				elif i == max + 1:
					def _hx_local_10():
						nonlocal i
						_hx_r = i
						i = i + 1
						return _hx_r
						
					
					b1 = v1.b[_hx_local_10()]
					charsBuf.write(Std.string(b64[b1 >> 2]))
					charsBuf.write(Std.string(b64[b1 << 4 & 63]))
				
				
				chars = charsBuf.getvalue()
				self.buf.write("s")
				self.buf.write(Std.string(__builtin__.len(chars)))
				self.buf.write(":")
				self.buf.write(Std.string(chars))
			
			else:
				_this = self.cache
				if __builtin__.len(_this) == 0:
					None
				else:
					_this.pop()
				
				if __builtin__.hasattr(v, "hxSerialize"):
					self.buf.write("C")
					self.serializeString(Type.getClassName(c))
					_this = self.cache
					x = v
					_this.append(x)
					__builtin__.len(_this)
					
					v.hxSerialize(self)
					self.buf.write("g")
				
				else:
					self.buf.write("c")
					self.serializeString(Type.getClassName(c))
					_this = self.cache
					x = v
					_this.append(x)
					__builtin__.len(_this)
					
					self.serializeFields(v)
				
			
			
			
		
		elif _g.tag == "TObject":
			if self.useCache and self.serializeRef(v):
				return
			
			self.buf.write("o")
			self.serializeFields(v)
		
		elif _g.tag == "TEnum":
			e = _g.params[0]
			if self.useCache and self.serializeRef(v):
				return
			
			_this = self.cache
			if __builtin__.len(_this) == 0:
				None
			else:
				_this.pop()
			
			def _hx_local_11():
				return "j" if self.useEnumIndex else "w"
			self.buf.write(Std.string(_hx_local_11()))
			self.serializeString(Type.getEnumName(e))
			if self.useEnumIndex:
				self.buf.write(":")
				self.buf.write(Std.string(Type.enumIndex(v)))
			
			else:
				self.serializeString(Type.enumConstructor(v))
			self.buf.write(":")
			arr = Type.enumParameters(v)
			def _hx_local_12():
				return AnonObject(fileName = "Serializer.hx" ,lineNumber = 463 ,className = "haxe.Serializer" ,methodName = "serialize" )
			print(Std.string(arr))
			def _hx_local_13():
				return AnonObject(fileName = "Serializer.hx" ,lineNumber = 464 ,className = "haxe.Serializer" ,methodName = "serialize" )
			print(Std.string(arr is not None))
			if arr is not None:
				self.buf.write(Std.string(__builtin__.len(arr)))
				_g1 = 0
				while _g1 < len(arr):
					v1 = arr[_g1]
					_g1 = _g1 + 1
					self.serialize(v1)
				
				
			
			else:
				self.buf.write("0")
			_this = self.cache
			x = v
			_this.append(x)
			__builtin__.len(_this)
			
			
		
		elif _g.tag == "TFunction":
			raise _HxException("Cannot serialize function")
		else:
			raise _HxException("Cannot serialize " + Std.string(v))
	

	def serializeFields(self = None,v = None):
		_g = 0
		_g1 = Reflect.fields(v)
		while _g < len(_g1):
			f = _g1[_g]
			_g = _g + 1
			self.serializeString(f)
			self.serialize(Reflect.field(v, f))
		
		
		self.buf.write("g")
	

	def serializeRef(self = None,v = None):
		vt = __js__("typeof")(v)
		_g1 = 0
		_g = __builtin__.len(self.cache)
		while _g1 < _g:
			def _hx_local_0():
				nonlocal _g1
				_hx_r = _g1
				_g1 = _g1 + 1
				return _hx_r
				
			
			i = _hx_local_0()
			ci = self.cache[i]
			if __js__("typeof")(ci) == vt and ci == v:
				self.buf.write("r")
				self.buf.write(Std.string(i))
				return True
			
			
		
		
		_this = self.cache
		_this.append(v)
		__builtin__.len(_this)
		
		return False
	

	def serializeString(self = None,s = None):
		x = self.shash.get(s)
		if x is not None:
			self.buf.write("R")
			self.buf.write(Std.string(x))
			return
		
		
		def _hx_local_0():
			_hx_r = self.scount
			self.scount = self.scount + 1
			return _hx_r
		
		self.shash.set(s, _hx_local_0())
		self.buf.write("y")
		s = StringTools.urlEncode(s)
		self.buf.write(Std.string(__builtin__.len(s)))
		self.buf.write(":")
		self.buf.write(Std.string(s))
	

	def toString(self = None):
		return self.buf.getvalue()

	# var useEnumIndex
	# var useCache
	# var scount
	# var shash
	# var cache
	# var buf




haxe_Serializer.USE_CACHE = False#transformedFalse
haxe_Serializer.USE_ENUM_INDEX = False#transformedFalse
haxe_Serializer.BASE64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789%:"#transformed"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789%:"
def Serializer_statics_run(v = None):
	s = haxe_Serializer()
	s.serialize(v)
	return s.toString()
	
haxe_Serializer.run = Serializer_statics_run


haxe_Serializer._hx_class = haxe_Serializer
haxe_Serializer._hx_class_name = "haxe.Serializer"
_hx_classes['haxe.Serializer'] = haxe_Serializer
haxe_Serializer._hx_fields = ["useEnumIndex","useCache","scount","shash","cache","buf"]
haxe_Serializer._hx_props = []
haxe_Serializer._hx_methods = ["serialize","serializeFields","serializeRef","serializeString","toString"]
haxe_Serializer._hx_statics = ["USE_CACHE","USE_ENUM_INDEX","BASE64","run"]
haxe_Serializer._hx_interfaces = []

class haxe_Unserializer:


	def __init__(self = None,buf = None):
		self.buf = buf
		self.length = __builtin__.len(buf)
		self.pos = 0
		self.scache = list()
		self.cache = list()
		r = haxe_Unserializer.DEFAULT_RESOLVER
		if r is None:
			r = Type
			haxe_Unserializer.DEFAULT_RESOLVER = r
		
		
		self.setResolver(r)
	
	def unserialize(self = None):
		def _hx_local_0():
			_hx_r = self.pos
			self.pos = self.pos + 1
			return _hx_r
		
		_g = StringTools.fastCodeAt(self.buf, _hx_local_0())
		if _g == 110:
			return None
		elif _g == 116:
			return True
		elif _g == 102:
			return False
		elif _g == 122:
			return 0
		elif _g == 105:
			return self.readDigits()
		elif _g == 100:
			p1 = self.pos
			while True:
				c = StringTools.fastCodeAt(self.buf, self.pos)
				if c >= 43 and c < 58 or c == 101 or c == 69:
					_hx_r = self.pos
					self.pos = self.pos + 1
					_hx_r
				
				else:
					break
			
			def _hx_local_4():
				def _hx_local_1():
					_this = self.buf
					len = self.pos - p1
					def _hx_local_3():
						def _hx_local_2():
							return __builtin__.len(_this) - p1 if len is None else p1 + len
						return python_Tools.substring(_this, p1, _hx_local_2())
					
					return _hx_local_3()
				
				return float(_hx_local_1())
			
			return _hx_local_4()
		
		elif _g == 121:
			len = self.readDigits()
			def _hx_local_7():
				def _hx_local_6():
					def _hx_local_5():
						_hx_r = self.pos
						self.pos = self.pos + 1
						return _hx_r
					
					return StringTools.fastCodeAt(self.buf, _hx_local_5()) != 58
				
				return _hx_local_6() or self.length - self.pos < len
			
			if _hx_local_7():
				raise _HxException("Invalid string length")
			
			def _hx_local_8():
				_this = self.buf
				pos = self.pos
				def _hx_local_10():
					def _hx_local_9():
						return __builtin__.len(_this) - pos if len is None else pos + len
					return python_Tools.substring(_this, pos, _hx_local_9())
				
				return _hx_local_10()
			
			s = _hx_local_8()
			self.pos = self.pos + len
			s = StringTools.urlDecode(s)
			_this = self.scache
			_this.append(s)
			__builtin__.len(_this)
			
			return s
		
		elif _g == 107:
			return _hx_float("nan")
		elif _g == 109:
			return _hx_float("-inf")
		elif _g == 112:
			return _hx_float("inf")
		elif _g == 97:
			buf = self.buf
			a = list()
			_this = self.cache
			_this.append(a)
			__builtin__.len(_this)
			
			while True:
				c = StringTools.fastCodeAt(self.buf, self.pos)
				if c == 104:
					_hx_r = self.pos
					self.pos = self.pos + 1
					_hx_r
					
					break
				
				
				if c == 117:
					_hx_r = self.pos
					self.pos = self.pos + 1
					_hx_r
					
					n = self.readDigits()
					a[__builtin__.len(a) + n - 1] = None
				
				else:
					x = self.unserialize()
					a.append(x)
					__builtin__.len(a)
				
			
			return a
		
		elif _g == 111:
			def _hx_local_11():
				return AnonObject()
			o = _hx_local_11()
			_this = self.cache
			_this.append(o)
			__builtin__.len(_this)
			
			self.unserializeObject(o)
			return o
		
		elif _g == 114:
			n = self.readDigits()
			if n < 0 or n >= __builtin__.len(self.cache):
				raise _HxException("Invalid reference")
			
			return self.cache[n]
		
		elif _g == 82:
			n = self.readDigits()
			if n < 0 or n >= __builtin__.len(self.scache):
				raise _HxException("Invalid string reference")
			
			return self.scache[n]
		
		elif _g == 120:
			raise _HxException(self.unserialize())
		elif _g == 99:
			name = self.unserialize()
			cl = self.resolver.resolveClass(name)
			if cl is None:
				raise _HxException("Class not found " + name)
			
			o = Type.createEmptyInstance(cl)
			_this = self.cache
			_this.append(o)
			__builtin__.len(_this)
			
			self.unserializeObject(o)
			return o
		
		elif _g == 119:
			name = self.unserialize()
			edecl = self.resolver.resolveEnum(name)
			if edecl is None:
				raise _HxException("Enum not found " + name)
			
			e = self.unserializeEnum(edecl, self.unserialize())
			_this = self.cache
			_this.append(e)
			__builtin__.len(_this)
			
			return e
		
		elif _g == 106:
			name = self.unserialize()
			edecl = self.resolver.resolveEnum(name)
			if edecl is None:
				raise _HxException("Enum not found " + name)
			
			_hx_r = self.pos
			self.pos = self.pos + 1
			_hx_r
			
			index = self.readDigits()
			tag = Type.getEnumConstructs(edecl)[index]
			if tag is None:
				raise _HxException("Unknown enum index " + name + "@" + index)
			
			e = self.unserializeEnum(edecl, tag)
			_this = self.cache
			_this.append(e)
			__builtin__.len(_this)
			
			return e
		
		elif _g == 108:
			l = List()
			_this = self.cache
			_this.append(l)
			__builtin__.len(_this)
			
			buf = self.buf
			while StringTools.fastCodeAt(self.buf, self.pos) != 104:
				l.add(self.unserialize())
			_hx_r = self.pos
			self.pos = self.pos + 1
			_hx_r
			
			return l
		
		elif _g == 98:
			h = haxe_ds_StringMap()
			_this = self.cache
			_this.append(h)
			__builtin__.len(_this)
			
			buf = self.buf
			while StringTools.fastCodeAt(self.buf, self.pos) != 104:
				s = self.unserialize()
				h.set(s, self.unserialize())
			
			_hx_r = self.pos
			self.pos = self.pos + 1
			_hx_r
			
			return h
		
		elif _g == 113:
			h = haxe_ds_IntMap()
			_this = self.cache
			_this.append(h)
			__builtin__.len(_this)
			
			buf = self.buf
			def _hx_local_12():
				_hx_r = self.pos
				self.pos = self.pos + 1
				return _hx_r
			
			c = StringTools.fastCodeAt(self.buf, _hx_local_12())
			while c == 58:
				i = self.readDigits()
				h.set(i, self.unserialize())
				def _hx_local_13():
					_hx_r = self.pos
					self.pos = self.pos + 1
					return _hx_r
				
				c = StringTools.fastCodeAt(self.buf, _hx_local_13())
			
			if c != 104:
				raise _HxException("Invalid IntMap format")
			
			return h
		
		elif _g == 77:
			h = haxe_ds_ObjectMap()
			_this = self.cache
			_this.append(h)
			__builtin__.len(_this)
			
			buf = self.buf
			while StringTools.fastCodeAt(self.buf, self.pos) != 104:
				s = self.unserialize()
				h.set(s, self.unserialize())
			
			_hx_r = self.pos
			self.pos = self.pos + 1
			_hx_r
			
			return h
		
		elif _g == 118:
			def _hx_local_14():
				_this = self.buf
				pos = self.pos
				return python_Tools.substring(_this, pos, pos + 19)
			
			d = HxOverrides.strDate(_hx_local_14())
			_this = self.cache
			_this.append(d)
			__builtin__.len(_this)
			
			self.pos = self.pos + 19
			return d
		
		elif _g == 115:
			len = self.readDigits()
			buf = self.buf
			def _hx_local_17():
				def _hx_local_16():
					def _hx_local_15():
						_hx_r = self.pos
						self.pos = self.pos + 1
						return _hx_r
					
					return StringTools.fastCodeAt(self.buf, _hx_local_15()) != 58
				
				return _hx_local_16() or self.length - self.pos < len
			
			if _hx_local_17():
				raise _HxException("Invalid bytes length")
			
			codes = haxe_Unserializer.CODES
			if codes is None:
				codes = haxe_Unserializer.initCodes()
				haxe_Unserializer.CODES = codes
			
			
			i = self.pos
			rest = len & 3
			def _hx_local_19():
				def _hx_local_18():
					return rest - 1 if rest >= 2 else 0
				return len >> 2 * 3 + _hx_local_18()
			
			size = _hx_local_19()
			max = i + len - rest
			bytes = haxe_io_Bytes.alloc(size)
			bpos = 0
			while i < max:
				def _hx_local_20():
					nonlocal i
					_hx_r = i
					i = i + 1
					return _hx_r
					
				
				c1 = codes[StringTools.fastCodeAt(buf, _hx_local_20())]
				def _hx_local_21():
					nonlocal i
					_hx_r = i
					i = i + 1
					return _hx_r
					
				
				c2 = codes[StringTools.fastCodeAt(buf, _hx_local_21())]
				def _hx_local_22():
					nonlocal bpos
					_hx_r = bpos
					bpos = bpos + 1
					return _hx_r
					
				
				bytes.b[_hx_local_22()] = c1 << 2 | c2 >> 4 & 255
				def _hx_local_23():
					nonlocal i
					_hx_r = i
					i = i + 1
					return _hx_r
					
				
				c3 = codes[StringTools.fastCodeAt(buf, _hx_local_23())]
				def _hx_local_24():
					nonlocal bpos
					_hx_r = bpos
					bpos = bpos + 1
					return _hx_r
					
				
				bytes.b[_hx_local_24()] = c2 << 4 | c3 >> 2 & 255
				def _hx_local_25():
					nonlocal i
					_hx_r = i
					i = i + 1
					return _hx_r
					
				
				c4 = codes[StringTools.fastCodeAt(buf, _hx_local_25())]
				def _hx_local_26():
					nonlocal bpos
					_hx_r = bpos
					bpos = bpos + 1
					return _hx_r
					
				
				bytes.b[_hx_local_26()] = c3 << 6 | c4 & 255
			
			if rest >= 2:
				def _hx_local_27():
					nonlocal i
					_hx_r = i
					i = i + 1
					return _hx_r
					
				
				c1 = codes[StringTools.fastCodeAt(buf, _hx_local_27())]
				def _hx_local_28():
					nonlocal i
					_hx_r = i
					i = i + 1
					return _hx_r
					
				
				c2 = codes[StringTools.fastCodeAt(buf, _hx_local_28())]
				def _hx_local_29():
					nonlocal bpos
					_hx_r = bpos
					bpos = bpos + 1
					return _hx_r
					
				
				bytes.b[_hx_local_29()] = c1 << 2 | c2 >> 4 & 255
				if rest == 3:
					def _hx_local_30():
						nonlocal i
						_hx_r = i
						i = i + 1
						return _hx_r
						
					
					c3 = codes[StringTools.fastCodeAt(buf, _hx_local_30())]
					def _hx_local_31():
						nonlocal bpos
						_hx_r = bpos
						bpos = bpos + 1
						return _hx_r
						
					
					bytes.b[_hx_local_31()] = c2 << 4 | c3 >> 2 & 255
				
				
			
			
			self.pos = self.pos + len
			_this = self.cache
			_this.append(bytes)
			__builtin__.len(_this)
			
			return bytes
		
		elif _g == 67:
			name = self.unserialize()
			cl = self.resolver.resolveClass(name)
			if cl is None:
				raise _HxException("Class not found " + name)
			
			o = Type.createEmptyInstance(cl)
			_this = self.cache
			x = o
			_this.append(x)
			__builtin__.len(_this)
			
			o.hxUnserialize(self)
			def _hx_local_33():
				def _hx_local_32():
					_hx_r = self.pos
					self.pos = self.pos + 1
					return _hx_r
				
				return StringTools.fastCodeAt(self.buf, _hx_local_32()) != 103
			
			if _hx_local_33():
				raise _HxException("Invalid custom data")
			
			return o
		
		else:
			None
		
		_hx_r = self.pos
		self.pos = self.pos - 1
		_hx_r
		
		raise _HxException("Invalid char " + self.buf[self.pos] + " at position " + self.pos)
	

	def unserializeEnum(self = None,edecl = None,tag = None):
		def _hx_local_1():
			def _hx_local_0():
				_hx_r = self.pos
				self.pos = self.pos + 1
				return _hx_r
			
			return StringTools.fastCodeAt(self.buf, _hx_local_0()) != 58
		
		if _hx_local_1():
			raise _HxException("Invalid enum format")
		
		nargs = self.readDigits()
		if nargs == 0:
			return Type.createEnum(edecl, tag)
		
		args = list()
		def _hx_local_3():
			def _hx_local_2():
				nonlocal nargs
				_hx_r = nargs
				nargs = nargs - 1
				return _hx_r
				
			
			return _hx_local_2() > 0
		
		while _hx_local_3():
			x = self.unserialize()
			args.append(x)
			__builtin__.len(args)
		
		return Type.createEnum(edecl, tag, args)
	

	def unserializeObject(self = None,o = None):
		while True:
			if self.pos >= self.length:
				raise _HxException("Invalid object")
			
			if StringTools.fastCodeAt(self.buf, self.pos) == 103:
				break
			
			k = self.unserialize()
			if not Std._hx_is(k, str):
				raise _HxException("Invalid object key")
			
			v = self.unserialize()
			__builtin__.setattr(o, k, v)
		
		_hx_r = self.pos
		self.pos = self.pos + 1
		_hx_r
		
	

	def readDigits(self = None):
		k = 0
		s = False
		fpos = self.pos
		while True:
			c = StringTools.fastCodeAt(self.buf, self.pos)
			if c == -1:
				break
			
			if c == 45:
				if self.pos != fpos:
					break
				
				s = True
				_hx_r = self.pos
				self.pos = self.pos + 1
				_hx_r
				
				continue
			
			
			if c < 48 or c > 57:
				break
			
			k = k * 10 + c - 48
			_hx_r = self.pos
			self.pos = self.pos + 1
			_hx_r
			
		
		if s:
			k = k * -1
		
		return k
	

	def setResolver(self = None,r = None):
		if r is None:
			def _hx_local_2():
				def _hx_local_0(_ = None):
					return None
				def _hx_local_1(_ = None):
					return None
				return AnonObject(resolveClass = _hx_local_0 ,resolveEnum = _hx_local_1 )
			
			self.resolver = _hx_local_2()
	
		else:
			self.resolver = r

	# var resolver
	# var scache
	# var cache
	# var length
	# var pos
	# var buf




haxe_Unserializer.DEFAULT_RESOLVER = Type#transformedType
haxe_Unserializer.BASE64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789%:"#transformed"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789%:"
haxe_Unserializer.CODES = None#transformedNone
def Unserializer_statics_initCodes():
	codes = list()
	_g1 = 0
	_g = __builtin__.len(haxe_Unserializer.BASE64)
	while _g1 < _g:
		def _hx_local_0():
			nonlocal _g1
			_hx_r = _g1
			_g1 = _g1 + 1
			return _hx_r
			
		
		i = _hx_local_0()
		codes[StringTools.fastCodeAt(haxe_Unserializer.BASE64, i)] = i
	
	
	return codes
	
haxe_Unserializer.initCodes = Unserializer_statics_initCodes
def Unserializer_statics_run(v = None):
	return haxe_Unserializer(v).unserialize()
haxe_Unserializer.run = Unserializer_statics_run


haxe_Unserializer._hx_class = haxe_Unserializer
haxe_Unserializer._hx_class_name = "haxe.Unserializer"
_hx_classes['haxe.Unserializer'] = haxe_Unserializer
haxe_Unserializer._hx_fields = ["resolver","scache","cache","length","pos","buf"]
haxe_Unserializer._hx_props = []
haxe_Unserializer._hx_methods = ["unserialize","unserializeEnum","unserializeObject","readDigits","setResolver"]
haxe_Unserializer._hx_statics = ["DEFAULT_RESOLVER","BASE64","CODES","initCodes","run"]
haxe_Unserializer._hx_interfaces = []

class haxe_ds_IntMap:


	def __init__(self = None):
		self.h = {}
	def keys(self = None):
		a = []
		for key in self.h:
			a.append(self.h[key])
		def _hx_local_1():
			def _hx_local_0():
				raise _HxException("not implemented")
				return None
			
			return _hx_local_0()
		
		return _hx_local_1()
	

	def get(self = None,key = None):
		return self.h[key]

	def set(self = None,key = None,value = None):
		self.h[key] = value

	# var h






haxe_ds_IntMap._hx_class = haxe_ds_IntMap
haxe_ds_IntMap._hx_class_name = "haxe.ds.IntMap"
_hx_classes['haxe.ds.IntMap'] = haxe_ds_IntMap
haxe_ds_IntMap._hx_fields = ["h"]
haxe_ds_IntMap._hx_props = []
haxe_ds_IntMap._hx_methods = ["keys","get","set"]
haxe_ds_IntMap._hx_statics = []
haxe_ds_IntMap._hx_interfaces = [Map_IMap]

class haxe_ds_ObjectMap:


	def __init__(self = None):
		def _hx_local_0():
			return AnonObject()
		self.h = _hx_local_0()
		def _hx_local_1():
			return AnonObject()
		self.h._hx_keys__ = _hx_local_1()
	
	def keys(self = None):
		def _hx_local_1():
			def _hx_local_0():
				raise _HxException("not implemented")
				return None
			
			return _hx_local_0()
		
		return _hx_local_1()
	

	def set(self = None,key = None,value = None):
		def _hx_local_4():
			def _hx_local_2():
				def _hx_local_0():
					_hx_local_1 = haxe_ds_ObjectMap.count = haxe_ds_ObjectMap.count + 1
					return _hx_local_1
				
				_hx_local_3 = key._hx_id__ = _hx_local_0()
				return _hx_local_3
			
			return key._hx_id__ if key._hx_id__ is not None else _hx_local_2()
		
		id = _hx_local_4()
		self.h[id] = value
		self.h._hx_keys__[id] = key
	

	# var h




haxe_ds_ObjectMap.count = 0#transformed0


haxe_ds_ObjectMap._hx_class = haxe_ds_ObjectMap
haxe_ds_ObjectMap._hx_class_name = "haxe.ds.ObjectMap"
_hx_classes['haxe.ds.ObjectMap'] = haxe_ds_ObjectMap
haxe_ds_ObjectMap._hx_fields = ["h"]
haxe_ds_ObjectMap._hx_props = []
haxe_ds_ObjectMap._hx_methods = ["keys","set"]
haxe_ds_ObjectMap._hx_statics = ["count"]
haxe_ds_ObjectMap._hx_interfaces = [Map_IMap]

class haxe_ds_StringMap:


	def __init__(self = None):
		self.h = {}
	def keys(self = None):
		a = []
		for key in self.h:
			a.append(self.h[key[1:]])
		def _hx_local_1():
			def _hx_local_0():
				raise _HxException("not implemented")
				return None
			
			return _hx_local_0()
		
		return _hx_local_1()
	

	def get(self = None,key = None):
		return self.h.get("$" + key, None)

	def set(self = None,key = None,value = None):
		self.h["$" + key] = value

	# var h






haxe_ds_StringMap._hx_class = haxe_ds_StringMap
haxe_ds_StringMap._hx_class_name = "haxe.ds.StringMap"
_hx_classes['haxe.ds.StringMap'] = haxe_ds_StringMap
haxe_ds_StringMap._hx_fields = ["h"]
haxe_ds_StringMap._hx_props = []
haxe_ds_StringMap._hx_methods = ["keys","get","set"]
haxe_ds_StringMap._hx_statics = []
haxe_ds_StringMap._hx_interfaces = [Map_IMap]

class haxe_io_Bytes:


	def __init__(self = None,length = None,b = None):
		self.length = length
		self.b = b
	
	# var b
	# var length




def Bytes_statics_alloc(length = None):
	a = list()
	_g = 0
	while _g < length:
		def _hx_local_0():
			nonlocal _g
			_hx_r = _g
			_g = _g + 1
			return _hx_r
			
		
		i = _hx_local_0()
		a.append(0)
		__builtin__.len(a)
	
	
	return haxe_io_Bytes(length, a)
	
haxe_io_Bytes.alloc = Bytes_statics_alloc


haxe_io_Bytes._hx_class = haxe_io_Bytes
haxe_io_Bytes._hx_class_name = "haxe.io.Bytes"
_hx_classes['haxe.io.Bytes'] = haxe_io_Bytes
haxe_io_Bytes._hx_fields = ["b","length"]
haxe_io_Bytes._hx_props = []
haxe_io_Bytes._hx_methods = []
haxe_io_Bytes._hx_statics = ["alloc"]
haxe_io_Bytes._hx_interfaces = []

class python_Boot:

	pass




def Boot_statics___string_rec(o = None,s = None):
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
			def _hx_local_2(_ = None):
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




def Lib_statics__hx_print(v = None):
	python_lib_Sys.stdout.write(Std.string(v))
	python_lib_Sys.stdout.flush()
	
python_Lib._hx_print = Lib_statics__hx_print
def Lib_statics_println(v = None):
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

class python_Tools:

	pass




def Tools_statics_substring(s = None,startIndex = None,endIndex = None):
	return s[startIndex:endIndex]
python_Tools.substring = Tools_statics_substring


python_Tools._hx_class = python_Tools
python_Tools._hx_class_name = "python.Tools"
_hx_classes['python.Tools'] = python_Tools
python_Tools._hx_fields = []
python_Tools._hx_props = []
python_Tools._hx_methods = []
python_Tools._hx_statics = ["substring"]
python_Tools._hx_interfaces = []

import builtins as __builtin__
import inspect as _hx_inspect
import random as _hx_random
import sys as python_lib_Sys
Main.main()#transformedMain.main()
