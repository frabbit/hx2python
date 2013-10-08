class Int:
    pass
class Float:
    pass
class Dynamic:
    pass
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
class HxOverrides:

	pass






HxOverrides._hx_class = HxOverrides
HxOverrides._hx_fields = []
HxOverrides._hx_props = []
HxOverrides._hx_methods = []
HxOverrides._hx_statics = []
HxOverrides._hx_interfaces = []

class List:


	def __init__(self):
		self.length = 0
	def iterator(self):
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
	

	def add(self,item):
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
List._hx_fields = ["length","q","h"]
List._hx_props = []
List._hx_methods = ["iterator","add"]
List._hx_statics = []
List._hx_interfaces = []

class Main:

	pass




def Main_statics_main():
	SerializeDemo.main()
Main.main = Main_statics_main


Main._hx_class = Main
Main._hx_fields = []
Main._hx_props = []
Main._hx_methods = []
Main._hx_statics = ["main"]
Main._hx_interfaces = []

class Map_IMap:

	pass






Map_IMap._hx_class = Map_IMap
Map_IMap._hx_fields = []
Map_IMap._hx_props = []
Map_IMap._hx_methods = []
Map_IMap._hx_statics = []
Map_IMap._hx_interfaces = []

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
def Reflect_statics_isFunction(f):
	def _hx_local_1():
		def _hx_local_0():
			raise _HxException("not implemented")
			return None
		
		return _hx_local_0()
	
	return _hx_local_1()
	
Reflect.isFunction = Reflect_statics_isFunction
def Reflect_statics_deleteField(o,field):
	def _hx_local_1():
		def _hx_local_0():
			raise _HxException("not implemented")
			return None
		
		return _hx_local_0()
	
	return _hx_local_1()
	
Reflect.deleteField = Reflect_statics_deleteField


Reflect._hx_class = Reflect
Reflect._hx_fields = []
Reflect._hx_props = []
Reflect._hx_methods = []
Reflect._hx_statics = ["field","fields","isFunction","deleteField"]
Reflect._hx_interfaces = []

class SerializeDemo_A:


	def __init__(self):
		self.x = 10
	# var x






SerializeDemo_A._hx_class = SerializeDemo_A
SerializeDemo_A._hx_fields = ["x"]
SerializeDemo_A._hx_props = []
SerializeDemo_A._hx_methods = []
SerializeDemo_A._hx_statics = []
SerializeDemo_A._hx_interfaces = []

class SerializeDemo:

	pass




def SerializeDemo_statics_main():
	def _hx_local_0():
		return AnonObject(age = 17 ,name = "jim" ,drinks = 3.5 )
	o = _hx_local_0()
	s = haxe_Serializer.run(o)
	def _hx_local_1():
		return AnonObject(fileName = "SerializeDemo.hx" ,lineNumber = 18 ,className = "SerializeDemo" ,methodName = "main" )
	print(Std.string("after serialize: "))
	def _hx_local_2():
		return AnonObject(fileName = "SerializeDemo.hx" ,lineNumber = 19 ,className = "SerializeDemo" ,methodName = "main" )
	print(Std.string(s))
	o2 = haxe_Unserializer.run(s)
	def _hx_local_3():
		return AnonObject(fileName = "SerializeDemo.hx" ,lineNumber = 23 ,className = "SerializeDemo" ,methodName = "main" )
	print(Std.string("after unserialize: "))
	def _hx_local_4():
		return AnonObject(fileName = "SerializeDemo.hx" ,lineNumber = 24 ,className = "SerializeDemo" ,methodName = "main" )
	print(Std.string(o2.age))
	def _hx_local_5():
		return AnonObject(fileName = "SerializeDemo.hx" ,lineNumber = 25 ,className = "SerializeDemo" ,methodName = "main" )
	print(Std.string(o2.name))
	def _hx_local_6():
		return AnonObject(fileName = "SerializeDemo.hx" ,lineNumber = 26 ,className = "SerializeDemo" ,methodName = "main" )
	print(Std.string(o2.drinks))
	s2 = haxe_Serializer.run(o2)
	def _hx_local_7():
		return AnonObject(fileName = "SerializeDemo.hx" ,lineNumber = 30 ,className = "SerializeDemo" ,methodName = "main" )
	print(Std.string("after serialized again: "))
	def _hx_local_8():
		return AnonObject(fileName = "SerializeDemo.hx" ,lineNumber = 31 ,className = "SerializeDemo" ,methodName = "main" )
	print(Std.string(s2))
	cl = SerializeDemo_A()
	cl1 = haxe_Serializer.run(cl)
	c2 = haxe_Unserializer.run(cl1)
	def _hx_local_9():
		return AnonObject(fileName = "SerializeDemo.hx" ,lineNumber = 39 ,className = "SerializeDemo" ,methodName = "main" )
	print(Std.string(c2.x))
	
SerializeDemo.main = SerializeDemo_statics_main


SerializeDemo._hx_class = SerializeDemo
SerializeDemo._hx_fields = []
SerializeDemo._hx_props = []
SerializeDemo._hx_methods = []
SerializeDemo._hx_statics = ["main"]
SerializeDemo._hx_interfaces = []

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


Std._hx_class = Std
Std._hx_fields = []
Std._hx_props = []
Std._hx_methods = []
Std._hx_statics = ["is","string"]
Std._hx_interfaces = []

from io import StringIO as _hx_StringIO
class StringTools:

	pass




def StringTools_statics_urlEncode(s):
	from urllib.parse import quote
	return quote(s)
	
StringTools.urlEncode = StringTools_statics_urlEncode
def StringTools_statics_urlDecode(s):
	from urllib.parse import unquote
	return unquote(s)
	
StringTools.urlDecode = StringTools_statics_urlDecode


StringTools._hx_class = StringTools
StringTools._hx_fields = []
StringTools._hx_props = []
StringTools._hx_methods = []
StringTools._hx_statics = ["urlEncode","urlDecode"]
StringTools._hx_interfaces = []

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


class Type:

	pass




def Type_statics_getClassName(c):
	res = None
	def _hx_local_0():
		return AnonObject(fileName = "Type.hx" ,lineNumber = 62 ,className = "Type" ,methodName = "getClassName" )
	print(Std.string(c))
	def _hx_local_2():
		return AnonObject(fileName = "Type.hx" ,lineNumber = 70 ,className = "Type" ,methodName = "getClassName" )
	try:
		s = c.__name__
		res = ".".join(s.split("_"))
		def _hx_local_1():
			return AnonObject(fileName = "Type.hx" ,lineNumber = 68 ,className = "Type" ,methodName = "getClassName" )
		print(Std.string(res))
	
	except Exception as _hx_e:
		_hx_e1 = _hx_e.val if isinstance(_hx_e, _HxException) else _hx_e
		if True:
			e = _hx_e1
			print(Std.string(e))
		else:
			raise _hx_e
	return res
	
Type.getClassName = Type_statics_getClassName
def Type_statics_getEnumName(e):
	return Type.getClassName(e._hx_class)
Type.getEnumName = Type_statics_getEnumName
def Type_statics_resolveClass(name):
	name1 = "_".join(name.split("."))
	return globals()[name1]
	
Type.resolveClass = Type_statics_resolveClass
def Type_statics_resolveEnum(name):
	return Type.resolveClass(name)
Type.resolveEnum = Type_statics_resolveEnum
def Type_statics_createEmptyInstance(cl):
	return cl.__new__(cl)
Type.createEmptyInstance = Type_statics_createEmptyInstance
def Type_statics_createEnum(e,constr,params):
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
def Type_statics_getEnumConstructs(e):
	def _hx_local_1():
		def _hx_local_0():
			raise _HxException("getEnumConstructs not implemented")
			return None
		
		return _hx_local_0()
	
	return _hx_local_1()
	
Type.getEnumConstructs = Type_statics_getEnumConstructs
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
Type._hx_fields = []
Type._hx_props = []
Type._hx_methods = []
Type._hx_statics = ["getClassName","getEnumName","resolveClass","resolveEnum","createEmptyInstance","createEnum","getEnumConstructs","typeof"]
Type._hx_interfaces = []

class haxe_Serializer:


	def __init__(self):
		self.buf = _hx_StringIO()
		self.cache = list()
		self.useCache = haxe_Serializer.USE_CACHE
		self.useEnumIndex = haxe_Serializer.USE_ENUM_INDEX
		self.shash = haxe_ds_StringMap()
		self.scount = 0
	
	def serialize(self,v):
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
				self.buf.write(Std.string(v[1]))
			
			else:
				self.serializeString(v[0])
			self.buf.write(":")
			l = v["length"]
			self.buf.write(Std.string(l - 2))
			_g1 = 2
			while _g1 < l:
				def _hx_local_12():
					nonlocal _g1
					_hx_r = _g1
					_g1 = _g1 + 1
					return _hx_r
					
				
				i = _hx_local_12()
				self.serialize(v[i])
			
			
			_this = self.cache
			x = v
			_this.append(x)
			__builtin__.len(_this)
			
			
		
		elif _g.tag == "TFunction":
			raise _HxException("Cannot serialize function")
		else:
			raise _HxException("Cannot serialize " + Std.string(v))
	

	def serializeFields(self,v):
		_g = 0
		_g1 = Reflect.fields(v)
		while _g < len(_g1):
			f = _g1[_g]
			_g = _g + 1
			self.serializeString(f)
			self.serialize(Reflect.field(v, f))
		
		
		self.buf.write("g")
	

	def serializeRef(self,v):
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
	

	def serializeString(self,s):
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
	

	def toString(self):
		return self.buf.getvalue()

	# var useEnumIndex
	# var useCache
	# var scount
	# var shash
	# var cache
	# var buf




	USE_CACHE = False#transformedFalse
	USE_ENUM_INDEX = False#transformedFalse
	BASE64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789%:"#transformed"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789%:"
def Serializer_statics_run(v):
	s = haxe_Serializer()
	s.serialize(v)
	return s.toString()
	
haxe_Serializer.run = Serializer_statics_run


haxe_Serializer._hx_class = haxe_Serializer
haxe_Serializer._hx_fields = ["useEnumIndex","useCache","scount","shash","cache","buf"]
haxe_Serializer._hx_props = []
haxe_Serializer._hx_methods = ["serialize","serializeFields","serializeRef","serializeString","toString"]
haxe_Serializer._hx_statics = ["USE_CACHE","USE_ENUM_INDEX","BASE64","run"]
haxe_Serializer._hx_interfaces = []

class haxe_Unserializer:


	def __init__(self,buf):
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
	
	def unserialize(self):
		def _hx_local_0():
			_hx_r = self.pos
			self.pos = self.pos + 1
			return _hx_r
		
		_g = ord(self.buf[_hx_local_0()])
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
				c = ord(self.buf[self.pos])
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
					
					return ord(self.buf[_hx_local_5()]) != 58
				
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
			return float("nan")
		elif _g == 109:
			return float("-inf")
		elif _g == 112:
			return float("inf")
		elif _g == 97:
			buf = self.buf
			a = list()
			_this = self.cache
			_this.append(a)
			__builtin__.len(_this)
			
			while True:
				c = ord(self.buf[self.pos])
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
			while ord(self.buf[self.pos]) != 104:
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
			while ord(self.buf[self.pos]) != 104:
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
			
			c = ord(self.buf[_hx_local_12()])
			while c == 58:
				i = self.readDigits()
				h.set(i, self.unserialize())
				def _hx_local_13():
					_hx_r = self.pos
					self.pos = self.pos + 1
					return _hx_r
				
				c = ord(self.buf[_hx_local_13()])
			
			if c != 104:
				raise _HxException("Invalid IntMap format")
			
			return h
		
		elif _g == 77:
			h = haxe_ds_ObjectMap()
			_this = self.cache
			_this.append(h)
			__builtin__.len(_this)
			
			buf = self.buf
			while ord(self.buf[self.pos]) != 104:
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
					
					return ord(self.buf[_hx_local_15()]) != 58
				
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
					
				
				c1 = codes[ord(buf[_hx_local_20()])]
				def _hx_local_21():
					nonlocal i
					_hx_r = i
					i = i + 1
					return _hx_r
					
				
				c2 = codes[ord(buf[_hx_local_21()])]
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
					
				
				c3 = codes[ord(buf[_hx_local_23()])]
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
					
				
				c4 = codes[ord(buf[_hx_local_25()])]
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
					
				
				c1 = codes[ord(buf[_hx_local_27()])]
				def _hx_local_28():
					nonlocal i
					_hx_r = i
					i = i + 1
					return _hx_r
					
				
				c2 = codes[ord(buf[_hx_local_28()])]
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
						
					
					c3 = codes[ord(buf[_hx_local_30()])]
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
				
				return ord(self.buf[_hx_local_32()]) != 103
			
			if _hx_local_33():
				raise _HxException("Invalid custom data")
			
			return o
		
		else:
			None
		
		_hx_r = self.pos
		self.pos = self.pos - 1
		_hx_r
		
		raise _HxException("Invalid char " + self.buf[self.pos] + " at position " + self.pos)
	

	def unserializeEnum(self,edecl,tag):
		def _hx_local_1():
			def _hx_local_0():
				_hx_r = self.pos
				self.pos = self.pos + 1
				return _hx_r
			
			return ord(self.buf[_hx_local_0()]) != 58
		
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
	

	def unserializeObject(self,o):
		while True:
			if self.pos >= self.length:
				raise _HxException("Invalid object")
			
			if ord(self.buf[self.pos]) == 103:
				break
			
			k = self.unserialize()
			if not Std._hx_is(k, str):
				raise _HxException("Invalid object key")
			
			v = self.unserialize()
			__builtin__.setattr(o, k, v)
		
		_hx_r = self.pos
		self.pos = self.pos + 1
		_hx_r
		
	

	def readDigits(self):
		k = 0
		s = False
		fpos = self.pos
		while True:
			c = ord(self.buf[self.pos])
			if c is None:
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
	

	def setResolver(self,r):
		if r is None:
			def _hx_local_2():
				def _hx_local_0(_):
					return None
				def _hx_local_1(_):
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




	DEFAULT_RESOLVER = Type#transformedType
	BASE64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789%:"#transformed"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789%:"
	CODES = None#transformedNone
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
		codes[ord(haxe_Unserializer.BASE64[i])] = i
	
	
	return codes
	
haxe_Unserializer.initCodes = Unserializer_statics_initCodes
def Unserializer_statics_run(v):
	return haxe_Unserializer(v).unserialize()
haxe_Unserializer.run = Unserializer_statics_run


haxe_Unserializer._hx_class = haxe_Unserializer
haxe_Unserializer._hx_fields = ["resolver","scache","cache","length","pos","buf"]
haxe_Unserializer._hx_props = []
haxe_Unserializer._hx_methods = ["unserialize","unserializeEnum","unserializeObject","readDigits","setResolver"]
haxe_Unserializer._hx_statics = ["DEFAULT_RESOLVER","BASE64","CODES","initCodes","run"]
haxe_Unserializer._hx_interfaces = []

class haxe_ds_IntMap:


	def __init__(self):
		self.h = {}
	def keys(self):
		a = []
		for key in self.h:
			a.append(self.h[key])
		def _hx_local_1():
			def _hx_local_0():
				raise _HxException("not implemented")
				return None
			
			return _hx_local_0()
		
		return _hx_local_1()
	

	def get(self,key):
		return self.h[key]

	def set(self,key,value):
		self.h[key] = value

	# var h






haxe_ds_IntMap._hx_class = haxe_ds_IntMap
haxe_ds_IntMap._hx_fields = ["h"]
haxe_ds_IntMap._hx_props = []
haxe_ds_IntMap._hx_methods = ["keys","get","set"]
haxe_ds_IntMap._hx_statics = []
haxe_ds_IntMap._hx_interfaces = [Map_IMap]

class haxe_ds_ObjectMap:


	def __init__(self):
		def _hx_local_0():
			return AnonObject()
		self.h = _hx_local_0()
		def _hx_local_1():
			return AnonObject()
		self.h._hx_keys__ = _hx_local_1()
	
	def keys(self):
		def _hx_local_1():
			def _hx_local_0():
				raise _HxException("not implemented")
				return None
			
			return _hx_local_0()
		
		return _hx_local_1()
	

	def set(self,key,value):
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




	count = 0#transformed0


haxe_ds_ObjectMap._hx_class = haxe_ds_ObjectMap
haxe_ds_ObjectMap._hx_fields = ["h"]
haxe_ds_ObjectMap._hx_props = []
haxe_ds_ObjectMap._hx_methods = ["keys","set"]
haxe_ds_ObjectMap._hx_statics = ["count"]
haxe_ds_ObjectMap._hx_interfaces = [Map_IMap]

class haxe_ds_StringMap:


	def __init__(self):
		self.h = {}
	def keys(self):
		a = []
		for key in self.h:
			a.append(self.h[key[1:]])
		def _hx_local_1():
			def _hx_local_0():
				raise _HxException("not implemented")
				return None
			
			return _hx_local_0()
		
		return _hx_local_1()
	

	def get(self,key):
		return self.h.get("$" + key, None)

	def set(self,key,value):
		self.h["$" + key] = value

	# var h






haxe_ds_StringMap._hx_class = haxe_ds_StringMap
haxe_ds_StringMap._hx_fields = ["h"]
haxe_ds_StringMap._hx_props = []
haxe_ds_StringMap._hx_methods = ["keys","get","set"]
haxe_ds_StringMap._hx_statics = []
haxe_ds_StringMap._hx_interfaces = [Map_IMap]

class haxe_io_Bytes:


	def __init__(self,length,b):
		self.length = length
		self.b = b
	
	# var b
	# var length




def Bytes_statics_alloc(length):
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
haxe_io_Bytes._hx_fields = ["b","length"]
haxe_io_Bytes._hx_props = []
haxe_io_Bytes._hx_methods = []
haxe_io_Bytes._hx_statics = ["alloc"]
haxe_io_Bytes._hx_interfaces = []

class python_Tools:

	pass




def Tools_statics_substring(s,startIndex,endIndex):
	return s[startIndex:endIndex]
python_Tools.substring = Tools_statics_substring


python_Tools._hx_class = python_Tools
python_Tools._hx_fields = []
python_Tools._hx_props = []
python_Tools._hx_methods = []
python_Tools._hx_statics = ["substring"]
python_Tools._hx_interfaces = []

import builtins as __builtin__
import inspect as _hx_inspect
Main.main()#transformedMain.main()
