/*
 * Copyright (C)2005-2013 Haxe Foundation
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

package python.gen;

import haxe.ds.StringMap;
import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.TypedExprTools;
import python.internal.KeywordHandler;
using Lambda;
using haxe.macro.Tools;

import python.gen.PythonPrinter.PrintContext;
using python.gen.PythonPrinter.PrintContexts;
using StringTools;


class PythonPrinterTyped {
	var tabs:String;
	var tabString:String;

    var baseTypeCache:Map<String, String>;
    

	public function new(?tabString = "\t") 
    {
        baseTypeCache = new Map();
		tabs = "\t";
		this.tabString = tabString;
	}

    public static function handleKeywords(name)
    {
        return KeywordHandler.handleKeywords(name);
    }


	public inline function printUnop(op:Unop) return switch(op) 
    {
		case OpIncrement: throw "unexpected operator ++";
		case OpDecrement: throw "unexpected operator --";
		case OpNot: "not ";
		case OpNeg: "-";
		case OpNegBits: "~";
	}

	public inline function printBinop(op:Binop) return switch(op) 
    {
		case OpAdd: "+";
		case OpMult: "*";
		case OpDiv: "/";
		case OpSub: "-";
		case OpAssign: "=";
		case OpEq: "==";
		case OpNotEq: "!=";
		case OpGt: ">";
		case OpGte: ">=";
		case OpLt: "<";
		case OpLte: "<=";
		case OpAnd: "&";
		case OpOr: "|";
		case OpXor: "^";
		case OpBoolAnd: "and";
		case OpBoolOr: "or";
		case OpShl: "<<";
		case OpShr: ">>";
		case OpUShr: ">>>"; // there is no unsigned right shift operator in python, use >> instad???
		case OpMod: "%";
		case OpInterval: "..."; throw "unexpected operator ... (OpInterval)";
		case OpArrow: "=>"; throw "unexpected operator =>";
		case OpAssignOp(op): throw "unexpected assign operator " + printBinop(op);
			
	}
	public function printString(s:String) 
    {
		return '"' + s.split("\\").join("\\\\").split('"').join('\\"').split("\n").join("\\n").split("\r").join("\\r").split("\t").join("\\t") #if sys .split("\x00").join("\\x00") #end + '"';
	}

	public function printConstant(c:TConstant) return switch(c) 
    {
		case TThis: "self";
		case TNull: "None";
		case TBool(true): "True";
		case TBool(false): "False";
		case TString(s): printString(s);
		case TInt(s): ""+s;
        case TFloat(s): s;
		case TSuper: "super";
	}


    
    public function printBaseType(tp:BaseType,context:PrintContext, ?isDefinition:Bool = false)
    {
        
        var key = tp.module + tp.name + "_" + Std.string(isDefinition);
        if (baseTypeCache.exists(key)) {
            return baseTypeCache.get(key);
        }

        var isPrivate = tp.isPrivate;
        var isExtern = tp.isExtern;

        var moduleStart = tp.module.lastIndexOf(".");
        if (moduleStart == -1) moduleStart = 0;

        var module = tp.module.substr(moduleStart);


        var hasPack = tp.pack.length > 0;

        var hasModule = module != tp.name;

        var native = tp.meta.get().find(function (e) return e.name == ":native");
        var isNative = native != null;

        var res = if (isNative) {
             switch (native.params[0].expr) {
                case EConst(CString(x)): x;
                case _ : throw "unexpected";
            }
        } else {
            var pre = isDefinition ? "" : "_hx_c.";
                    
            if (hasModule && isPrivate) {
                var prefix = pre+tp.module.split(".").join("_");

                prefix + (if (prefix.length > 0) "_" else "") + handleKeywords(tp.name);        
            } else {
                pre+tp.pack.join("_") + (if (hasPack) "_" else "") + handleKeywords(tp.name);        
            }
            
        }
        baseTypeCache.set(key, res);
        return res;
    }

	public function printMetadata(meta:MetadataEntry,context) 
    {
        return '@${meta.name}';
    }

	public function printAccess(access:Access) return switch(access) 
    {
		case AStatic: "static";
		case APublic: "public";
		case APrivate: "private";
		case AOverride: "override";
		case AInline: "inline";
		case ADynamic: "dynamic";
		case AMacro: "macro";
	}

    public function printArgs(args:Array<{v:TVar, value:Null<TConstant>}>,context:PrintContext)
    {
        var argString = "";
        var optional = false;

        for(i in 0 ... args.length)
        {

            var arg = args[i];

            var isKwArgs =  switch (arg.v.t) {
                case TAbstract(x,_): x.get().name == "KwArgs";
                case _ : false;
            }
            
            var prefix = isKwArgs ? "**" : "";

            var argValue = if (arg.value != null) printConstant(arg.value) else "";
            var argIsNull = arg.value == null;
            if((arg.value != null) && !optional)
            {
                optional = true;
                argString += "";
            }
            
            
            argString += prefix + handleKeywords(arg.v.name);

            if(argValue != null && !argIsNull && !isKwArgs) {
                argString += ' = $argValue';
            }

            if(i < args.length - 1)
                argString += ",";
        }

        if(optional) argString += "";

        return argString;
    }

	public function printFunction(func:TFunc,context:PrintContext, name:String = null) 
    {
        return
		"def " + (name == null ? context.nextAnonFunc() : name) + "(" + printArgs(func.args,context) + ")" + ':\n${context.indent}\t'
		+ opt(func.expr, printExpr.bind(_,context.incIndent()), "");
    }

	public function printVar(v:TVar, expr:Null<TypedExpr>,context)
    {
        function def () {
            return
            handleKeywords(v.name)
            //      + opt(v.type, printComplexType, " : ")
            + if (expr != null) opt(expr, printOpAssignRight.bind(_,context), " = ") else " = None";
        }

        return if (expr != null) {
            if (expr.expr != null)
            {
                switch (expr.expr) {
                    case TFunction(f):
                        printFunction(f,context,v.name);
                    case _ : def();
                }
            } else {
                def();
            }
        } else {

            def();
        }
    }

    function isType <X:BaseType>(p:String, t:String) 
    {
        return function (r:Ref<X>) {
            var x = r.get();
            return x.pack.join(".") == p && x.name == t;
        }
    }

    function isType1 (p:String, s:String) 
    {
        return function (t:Type) return switch (t)
        {
            case TInst(isType(p, s) => true,_) : true;

            case TAbstract(isType(p, s) => true,_) : true;
            case TEnum(isType(p, s) => true,_) : true;
            case _ : false;
        }
    }

    function printCall(e1, el:Array<TypedExpr>, context)
    {
        var id = printExpr(e1, context);

        var result =  switch(id)
        {
        	case "super":
        		var params = el.copy();
        		'super().__init__(${printExprs(params,", ", context)})';
            case "`trace" :
                var s = switch (el[0].t) {
                    case TInst(isType("", "String") => true, _): '${printExpr(el[0],context)}';
                    case _ : 'Std.string(${printExpr(el[0],context)})';
                }
                'print($s)';
                //formatPrintCall(el, context);
            case "__python_kwargs__":
                '**${printExpr(el[0],context)}';
            case "__python_varargs__":
                '*${printExpr(el[0],context)}';
            case "__python__":   switch(el[0].expr)
            {
                case TConst(TString(s)): s;
                default:printExpr(el[0], context);
            };
            case "__named_arg__":
                var name = switch(el[0].expr)
                {
                    case TConst(TString(s)): s;
                    default: throw "unexpected";
                };  
                '$name=${printExpr(el[1], context)}';
            case "__feature__":'';
            case "__named__":
                var last = el[el.length-1];
                var res = el.copy();
                res.pop();
                res.shift();
                
                var fields = switch (last.expr) {
                    case TObjectDecl(fields): fields;
                    case _ : throw "unexpected ERRRRRRORRRR";
                }
            	
                //trace(fields);
                
                if (res.length > 0) {
                    '${printExpr(el[0], context)}(${printExprs(res,", ", context)}, ${printExprsNamed(fields,", ", context)})';        
                } else {
                    '${printExpr(el[0], context)}(${printExprsNamed(fields,", ", context)})';        
                }

            	
            case "__define_feature__":
            	printExpr(el[1], context);
            case "__call__":
            	var params = el.copy();
            	var first = params[0];params.shift();
                '${printExpr(first, context)}(${printExprs(params,", ", context)})';
            case "__field__":
                
                var first = el[0];
                var field = switch (el[1].expr) {
                    case TConst(TString(id)):id;
                    case _ : throw "unexpected";
                }
                '${printExpr(first, context)}.$field';
            case "__python_tuple__":
            	'(${printExprs(el, ", ", context)})';
            case "__python_array_get__":
                '${printExpr(el.shift(), context)}[${printExprs(el,":", context)}]';
            case "__python_in__":
                '${printExpr(el[0], context)} in ${printExpr(el[1], context)}';
            case "__python_for__":
                var f = el[0];
                switch (f.expr) {
                    case TBlock([{ expr : TVar(v1,_)}, e2, block]):
                        var f1 = v1.name;
                        var i = context.incIndent().indent;
                        'for $f1 in ${printExpr(e2, context)}:\n$i${printExpr(block, context.incIndent())}';        
                    case _ : 
                        throw "unexpected";
                }
                
                
            case "__python_del__":
                'del ${printExpr(el[0], context)}';
            case "__python_binop__":
                var op = switch (el[1].expr) {
                    case TConst(TString(id)):id;
                    case _ : throw "unexpected";
                }
                '${printExpr(el[0], context)} $op ${printExpr(el[2], context)}';
            case "__python_array_set__":
                '${printExpr(el[0], context)}[${printExpr(el[1], context)}] = ${printExpr(el[2], context)}';
            case "__assert__":
                'assert(${printExprs(el,", ",context)})';
            case "__new_named__":
                'new ${extractString(el.shift())}(${printExprs(el,", ", context)})';
            case "__new__":
            	'${printExpr(el.shift(), context)}(${printExprs(el,", ", context)})';
            case "__call_global__":
                '${extractString(el.shift())}(${printExprs(el,", ", context)})';
            case "__is__":
                '(${printExpr(el[0],context)} is ${printExpr(el[1],context)})';
            case "__as__":
                '(${printExpr(el[0],context)} as ${printExpr(el[1],context)})';
            case "__int_parse__":
                'int.parse(${printExpr(el[0],context)})';
            case "__double_parse__":
                'double.parse(${printExpr(el[0],context)})';
            default:
               '$id(${printExprs(el,", ",context)})';
        }
        return result;
    }

    function extractString(e:TypedExpr)
    {
        return switch(e.expr)
        {
            case TConst(TString(s)):s;
            default:"####";
        }
    }

    function printField(e1:TypedExpr, fa:FieldAccess, context:PrintContext, isAssign:Bool = false)
    {
        

    	var obj = switch (e1.expr) {
    		case TConst(TSuper): "super()";
    		case _: '${printExpr(e1, context)}';
    	}



        var name = switch (fa) {
            case FInstance(_, cf): cf.get().name;
            case FStatic(_,cf): cf.get().name;
            case FAnon(cf): cf.get().name;
            case FDynamic(s): s;
            case FClosure(_,cf): cf.get().name;
            case FEnum(_,ef): ef.name;
        }

        function doDefault() {
            return '$obj.${handleKeywords(name)}';
        }

        /*function doReplace () {
            return switch (name) {
                case "iterator":
                    '_hx_functools.partial(HxOverrides_iterator, $obj)';
                case "map":
                    '_hx_functools.partial(HxOverrides_map, $obj)';
                case "filter":
                    '_hx_functools.partial(HxOverrides_filter, $obj)';
                case _ : 
                    '$obj.${handleKeywords(name)}';
            }
        }*/
        /*
        if (name == "iterator") {
            trace(fa + " => " + e1.pos);
        }
        */
        return switch (fa) {
            case FInstance(isType("", "list") => true, cf) if (cf.get().name == "length" || cf.get().name == "get_length"):
                "_hx_builtin.len(" + printExpr(e1, context) + ")";
            case FInstance(x = isType("", "String") => true, cf) if (cf.get().name == "toUpperCase"):
                printExpr(e1, context) + ".toupper";
            case FInstance(isType("", "String") => true, cf) if (cf.get().name == "toLowerCase"):
                printExpr(e1, context) + ".tolower";

            case FInstance(ct, cf): 
                //var ct = ct.get();
                doDefault();
            case FStatic(_,cf): doDefault();
            case FAnon(cf) if (name == "iterator"): 
                switch (cf.get().type) {
                    case TFun(args,_) if (args.length == 0): 
                        '_hx_functools.partial(HxOverrides_iterator, $obj)';        
                    case _ : doDefault();
                }
            case FAnon(_):
                doDefault();
            case FDynamic("iterator"):
                '_hx_functools.partial(HxOverrides_iterator, $obj)';
            case FDynamic("length") if (!isAssign):
                'HxOverrides_length($obj)';
            case FDynamic("filter") if (!isAssign):
                '_hx_functools.partial(HxOverrides_filter, $obj)';
            case FDynamic("map") if (!isAssign):
                '_hx_functools.partial(HxOverrides_map, $obj)';
            case FDynamic(_):
                doDefault();
            case FClosure(ct,cf): 
                doDefault();
            case FEnum(_,ef): 
                doDefault();
        }

    }

    function printIfElse(econd:TypedExpr, eif:TypedExpr, eelse:TypedExpr, context:PrintContext, ?asElif = false)
    {
    	var econd1 = switch (econd.expr) {
    		case TParenthesis(e):e;
    		case _ : econd;
    	}
        var ifExpr = printExpr(eif, context.incIndent());
        var lastChar = ifExpr.charAt(ifExpr.length - 1);
        if(lastChar != ";" && lastChar != "}")
        {
            ifExpr += "";
        }
        var indent = context.indent;
        var elseStr = if (asElif) {
        	opt(eelse,printExpr.bind(_, context),"el");
    	} else {
    		opt(eelse,printExpr.bind(_, context.incIndent()),"else:\n"+indent +"\t");
    	}
        return 
        'if ${printExpr(econd1, context)}:\n$indent\t$ifExpr\n$indent${elseStr}';
    }

	public function printOpAssignRight(e:TypedExpr, context:PrintContext):String 
    {
		function printExpr1 (e) return printExpr(e, context, false);
		return switch (e.expr) 
		{
			case TIf({ expr : TParenthesis(econd)}, eif, eelse) | 
				 TIf(econd, eif, eelse): '${printExpr1(eif)} if ${printExpr1(econd)} else ${printExpr1(eelse)}';
			case _ : printExpr1(e);
		}
	}

    public function printModuleType (t:ModuleType, context:PrintContext) 
    {
        return switch (t) 
        {
            case TClassDecl(ct): printBaseType(ct.get(),context);
            case TEnumDecl(ct): printBaseType(ct.get(),context);
            case TTypeDecl(ct): printBaseType(ct.get(),context);
            case TAbstract(ct): printBaseType(ct.get(),context);
        }
    }

    function isUnderlyingString (t:Type) {
        return switch (haxe.macro.Context.follow(t)) {
            case TAbstract(t, p):

               isType1("", "String")(t.get().type);
            case _ : false;
        }
    }

	public function printExpr(e:TypedExpr, context:PrintContext, top = false)
	{

		var indent = context.indent;
		inline function printExpr1 (e) return printExpr(e, context);
		inline function printExprIndented (e) return printExpr(e, context.incIndent());


        return try e == null ? "None" : switch(e.expr) {
		case TConst(c): printConstant(c);
        case TTypeExpr(t): printModuleType(t, context);
        case TLocal(t): handleKeywords(t.name);
        case TPatMatch: "not supported";
        case TEnumParameter(e,ef, index): 
            '${printExpr1(e)}.params[${index}]';
        
        case TArray(e1, e2): 
            '_hx_array_get(${printExpr1(e1)},${printExpr1(e2)})';
		case TBinop(OpAssign, { expr : TArray(e1, e2)}, e3): 
            '_hx_array_set(${printExpr1(e1)},${printExpr1(e2)}, ${printExpr1(e3)})';
        case TBinop(OpAssign, field = { expr : TField(ef1, fa)}, e2):
            '${printField(ef1, fa, context, true)} = ' + printOpAssignRight(e2, context);
        case TBinop(OpAssign, e1, e2): 
            '${printExpr1(e1)} = ' + printOpAssignRight(e2, context);
		case TBinop(OpEq, e1, e2 = { expr : TConst(TNull)}):
			'${printExpr1(e1)} is ${printExpr1(e2)}';
		case TBinop(OpNotEq, e1, e2 = { expr : TConst(TNull)}):
			'${printExpr1(e1)} is not ${printExpr1(e2)}'; 
        case TBinop(OpMod, e1, e2) if (isType1("", "Int")(e1.t) && isType1("", "Int")(e2.t)):
            '${printExpr1(e1)} % ${printExpr1(e2)}';
        case TBinop(OpMod, e1, e2):
            '_hx_modf(${printExpr1(e1)}, ${printExpr1(e2)})';

        case TBinop(OpUShr, e1, e2): 
            '_hx_rshift(${printExpr1(e1)}, ${printExpr1(e2)})';
        case TBinop(OpAdd, e1, e2) if (isType1("", "String")(e.t) || isUnderlyingString(e.t)):
            
            function safeString(ex:TypedExpr) 
                return if (ex.expr.match(TConst(TString(_)))) printExpr1(ex) else "Std.string(" + printExpr1(ex) + ")";

            var e1Str = safeString(e1);
            var e2Str = safeString(e2);
            '$e1Str + $e2Str';

        case TBinop(OpAdd, e1, e2) if (e.t.match(TDynamic(_))):
            'python_Boot._add_dynamic(${printExpr1(e1)},${printExpr1(e2)})';
        case TBinop(op, e1, e2): 
			'${printExpr1(e1)} ${printBinop(op)} ${printExpr1(e2)}';
		case TField(e1, fa):
            printField(e1, fa, context);
            
		case TParenthesis(e1): '(${printExpr1(e1)})';
		case TObjectDecl(fl):
			"_hx_c._hx_AnonObject(" + fl.map(function(fld) return '${handleKeywords(fld.name)} = ${printExpr1(fld.expr)} ').join(",") + ")";
		case TArrayDecl(el): '[${printExprs(el, ", ",context)}]';
        case TCall({ expr : TField(e1, FAnon(cf))}, []) if (cf.get().name == "toUpperCase"):
            "_hx_toUpperCase(" + printExpr1(e1) + ")";
        case TCall(e1, el): printCall(e1, el.copy(),context);
		case TNew(tp, _, el): 
			var id = printBaseType(tp.get(),context);
			
			'${id}(${printExprs(el,", ",context)})';
		case TUnop(op, true, e1): printExpr1(e1) + printUnop(op);
		case TUnop(op, false, e1): printUnop(op) + printExpr1(e1);
		case TFunction(func):/* "function " +*/printFunction(func,context);
		
		case TVar(v,e): 
            printVar(v, e, context);
		case TBlock([]): 'pass\n${indent}';
		case TBlock(el):
            
            var old = tabs;
			tabs = context.indent;
			var s = printExprs(el, '\n$tabs',context);
			tabs = old;
			s + '\n$tabs';
		case TFor(v, e1, e2): 
            var ctxSub = context.incIndent();
            var ind1 = context.indent;
            var ind2 = ctxSub.indent;
            '_it = ${printExpr1(e1)}\n'
            + '${ind1}while _it.hasNext():\n'
            + '$ind2${v.name} = _it.next()\n'
            + '$ind2${printExpr(e2,ctxSub)}';
		
		case TIf(econd, eif, eelse):
            if (eelse != null && switch (eelse.expr) { case TIf(_,_,_): true; case _ : false;}) 
			    printIfElse(econd, eif, eelse,context, true);
            else {
                printIfElse(econd, eif, eelse,context);
            }
		case TWhile(econd, e1, true): 'while ${printExpr1(econd)}:\n$indent\t${printExprIndented(e1)}';
		case TWhile(econd, e1, false): "not supported for python target";
		case TSwitch(e1, cl, edef): 
            throw "unexpected tswitch";
		case TTry(e1, cl):
			printTry(e1, cl,context);
			
		case TReturn(eo): 'return' + opt(eo, printOpAssignRight.bind(_,context), " ");
		case TBreak: "break";
		case TContinue: "continue";
		case TThrow(e1): "raise _HxException(" +printExpr1(e1) + ")";
		case TCast(e1, cto) if (cto != null): '${printExpr1(e1)}';
		case TCast(e1, _): printExpr1(e1);
        case TMeta({ name : ":ternaryIf"}, { expr : TIf(econd, eif, eelse)}):
             '${printExpr1(eif)} if ${printExpr1(econd)} else ${printExpr1(eelse)}';
		case TMeta(meta, e1): 
            printExpr1(e1);
	} catch (ex:Dynamic) { 
        trace("ERROR");
        trace(e.expr.getName());

        trace("error for Expr:" + TypedExprTools.toString(e, true)); 
        neko.Lib.rethrow(ex);
    };
    }

    function printTry (e1:TypedExpr, cl:Array<{v:TVar, expr:TypedExpr}>, context:PrintContext) 
    {
    	var indent = context.indent;
    	function printExprIndented (e:TypedExpr) return printExpr(e, context.incIndent());
    	var tryStr = 'try:\n$indent\t${printExprIndented(e1)}\n$indent';

    	var except = 'except Exception as _hx_e:\n$indent\t_hx_e1 = _hx_e.val if isinstance(_hx_e, _HxException) else _hx_e\n$indent\t';
    	var catchStr = cl.mapi(printCatch.bind(_, _, context.incIndent())).join('\n$indent\t');

    	var exceptEnd = '\n$indent\telse:\n$indent\t\traise _hx_e';

    	return tryStr + except + catchStr + exceptEnd;
    }

    function printCatch (index:Int, c:{v:TVar, expr:TypedExpr}, context:PrintContext) 
    {
    	var indent = context.indent;

        function handleBaseType (bt:BaseType) {
            var cx = bt;
            var type = printBaseType(cx, context);
            
            //trace(p);
            var res = if (type == "String") {
                'if isinstance(_hx_e1, str):\n$indent\t${c.v.name} = _hx_e1\n$indent\t' + printExpr(c.expr, context.incIndent());
            } else {
                'if isinstance(_hx_e1, $type):\n$indent\t${c.v.name} = _hx_e1\n$indent\t' + printExpr(c.expr, context.incIndent());
            }
            if (index > 0) {
                res = "el" + res;
            }
            return res;
        }

    	return switch (c.v.t) 
        {
            case TDynamic(_):
                'if True:\n$indent\t${c.v.name} = _hx_e1\n$indent\t' + printExpr(c.expr, context.incIndent());
            case TInst(ct, _): handleBaseType(ct.get());
            case TEnum(ct, _): handleBaseType(ct.get());
            

    		case x : 

                'catch ' + Std.string(x);
                //throw "catching of types other than tpath is not yet implemented";
    	}
    	
    }
	public function printExprs(el:Array<TypedExpr>, sep:String,context) 
    {
		return el.map(printExpr.bind(_,context)).join(sep);
	}

    public function printExprsNamed(el:Array<{ name : String, expr : TypedExpr}>, sep:String,context) 
    {
        return el.map(function (x) return x.name + " = " + printExpr(x.expr,context)).join(sep);
    }

	public function opt<T>(v:T, f:T->String, prefix = "") return v == null ? "" : (prefix + f(v));
}