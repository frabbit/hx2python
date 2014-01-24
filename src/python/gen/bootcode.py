import builtins as _hx_builtin

_hx_classes = dict()

class _hx_AnonObject(object):
    def __init__(self, **kwargs):
        self.__dict__.update(kwargs)

_hx_c = _hx_AnonObject()

_hx_c._hx_AnonObject = _hx_AnonObject


import functools as _hx_functools

class Enum:
    # String tag;
    # int index;
    # List params;
    def __init__(self, tag, index, params):
        self.tag = tag
        self.index = index
        self.params = params
    
    def __str__(self):
        if self.params == None:
            res = self.tag
        else:
            res = self.tag + '(' + ','.join(self.params) + ')'
        res

Enum._hx_class_name = 'Enum'
Enum._hx_class = Enum
_hx_classes['Enum'] = Enum
_hx_c.Enum = Enum

class _HxException(Exception):
    # String tag;
    # int index;
    # List params;
    def __init__(self, val):
        try:
            message = _hx_c.Std.string(val)
        except Exception:
            message = '_HxException'
        Exception.__init__(self, message)
        self.val = val

class Int:
    pass

Int._hx_class_name = 'Int'
Int._hx_class = Int
_hx_classes['Int'] = Int
_hx_c.Int = Int

class Bool:
    pass

Bool._hx_class_name = 'Bool'
Bool._hx_class = Bool

_hx_classes['Bool'] = Bool
_hx_c.Bool = Bool

class Float:
    pass

Float._hx_class_name = 'Float'
Float._hx_class = Float
_hx_classes['Float'] = Float
_hx_c.Float = Float

class Dynamic:
    pass

Dynamic._hx_class_name = 'Dynamic'
Dynamic._hx_class = Dynamic
_hx_classes['Dynamic'] = Dynamic
_hx_c.Dynamic = Dynamic

class Class:
    pass

Class._hx_class_name = 'Class'
Class._hx_class = Class
_hx_classes['Class'] = Class
_hx_c.Class = Class

def _hx_rshift(val, n):
    return (val % 0x100000000) >> n
def _hx_modf(a,b):
    return float('nan') if (b == 0.0) else a % b if a > 0 else -(-a % b)
def _hx_array_get(a,i):
    return a[i] if (i < len(a) and i > -1) else None
def _hx_array_set(a,i,v):
    l = len(a)
    while l < i:
        a.append(None)
        l+=1
    if l == i:
        a.append(v)
    else:
        a[i] = v
    return v

def _hx_toUpperCase (x):
    if isinstance(x, str):
        return x.upper()
    return x.toUpperCase()

import math as _hx_math


def HxOverrides_iterator(x):
    if isinstance(x, list):
        return _hx_c.python_internal_ArrayImpl.iterator(x)
    else:
        return x.iterator()

def HxOverrides_shift(x):
    if isinstance(x, list):
        return _hx_c.python_internal_ArrayImpl.shift(x)
    else:
        return x.shift()

def HxOverrides_filter(x, f):
    if isinstance(x, list):
        return _hx_c.python_internal_ArrayImpl.filter(x,f)
    else:
        return x.filter(f)

def HxOverrides_map(x, f):
    if isinstance(x, list):
        return _hx_c.python_internal_ArrayImpl.map(x,f)
    else:
        return x.filter(f)

def HxOverrides_length(x):
    if isinstance(x, list) or isinstance(x, str):
        return _hx_builtin.len(x)
    else:
        return x.length