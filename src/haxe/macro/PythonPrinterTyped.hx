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

package haxe.macro;

import haxe.ds.StringMap;
import haxe.macro.Expr;
import haxe.macro.Type;

import python.internal.KeywordHandler;
using Lambda;
using haxe.macro.Tools;

import haxe.macro.PythonPrinter.PrintContext;
using haxe.macro.PythonPrinter.PrintContexts;
using StringTools;


class PythonPrinterTyped {
	var tabs:String;
	var tabString:String;

 

    static var standardTypes:Map<String, String> = [
        "Array" => "List",
        "Int" => "int",
        "Float" => "double",
    ];

    public static var pathHack= new StringMap();

    public static function mapStandardTypes(typeName)
    {
        var mappedType = standardTypes.get(typeName);
        return mappedType == null ? typeName : mappedType;
    }

    public static function handleKeywords(name)
    {
        return KeywordHandler.handleKeywords(name);
    }

    public function applyPathHack (id:String) 
    {

        //var newId = if (id.indexOf(".") > 0) id.replace(".", "_") else id;
        

        var realId = if (pathHack.exists(id)) {
            pathHack.get(id);
        } else {
            id;
        }
        //trace(id + " => " + realId);
        return realId;
    }

	public function new(?tabString = "\t") {
		tabs = "\t";
		this.tabString = tabString;
	}

	public function printUnop(op:Unop) return switch(op) {
		case OpIncrement: throw "unexpected operator ++";
		case OpDecrement: throw "unexpected operator --";
		case OpNot: "not ";
		case OpNeg: "-";
		case OpNegBits: "~";
	}

	public function printBinop(op:Binop) return switch(op) {
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
	public function printString(s:String) {
		return '"' + s.split("\\").join("\\\\").split('"').join('\\"').split("\n").join("\\n").split("\r").join("\\r").split("\t").join("\\t") #if sys .split("\x00").join("\\x00") #end + '"';
	}

	public function printConstant(c:TConstant) return switch(c) {
		case TThis: "self";
		case TNull: "None";
		case TBool(true): "True";
		case TBool(false): "False";
		case TString(s): printString(s);
		//case CIdent(s):
		//	
		//	handleKeywords(s);
		case TInt(s):
			""+s;
        case TFloat(s):
            s;
		case TSuper: "super";
		//case CRegexp(s,opt): '~/$s/$opt';
	}

	public function printTypeParam(param:TypeParam,context) return switch(param) {
		case TPType(ct):printComplexType(ct,context);
		case TPExpr(e): context.regular.printExpr(e,context);
	}

    public function printBaseType(tp:BaseType,context:PrintContext){
        var isPrivate = tp.isPrivate;
        var isExtern = tp.isExtern;

        var moduleStart = tp.module.lastIndexOf(".");
        if (moduleStart == -1) moduleStart = 0;

        var module = tp.module.substr(moduleStart);


        var hasPack = tp.pack.length > 0;

        var hasModule = module != tp.name;

        var native = tp.meta.get().find(function (e) return e.name == ":native");
        var isNative = native != null;

        if (isNative) {
            return switch (native.params[0].expr) {
                case EConst(CString(x)): x;
                case _ : throw "unexpected";
            }
        } else {
            if (hasModule && isPrivate) {
                var prefix = tp.module.split(".").join("_");

                return prefix + (if (prefix.length > 0) "_" else "") + tp.name;        
            } else {
                return tp.pack.join("_") + (if (hasPack) "_" else "") + tp.name;        
            }
            
        }
        
        
        
        //+ (tp.params.length > 0 ? "<" + tp.params.map(printTypeParam.bind(_,context)).join(", ") + ">" : "");
    }

    
	public function printTypePath(tp:TypePath,context:PrintContext){
        //trace(tp);
        //if(tp.sub != null) return tp.name + "." + tp.sub ;
        return
        (tp.pack.length > 0 ? tp.pack.join(".") + "." : "")
        + tp.name
		+ (tp.sub != null ? '.${tp.sub}' : "");
		//+ (tp.params.length > 0 ? "<" + tp.params.map(printTypeParam.bind(_,context)).join(", ") + ">" : "");
    }
    

	// TODO: check if this can cause loops
	public function printComplexType(ct:ComplexType,context:PrintContext) return switch(ct) {
		case TPath(tp): printTypePath(tp,context);
		case TFunction(args, ret): (args.length>0 ? args.map(printComplexType.bind(_,context)).join(" -> ") : "Void") + " -> " + printComplexType(ret,context);
		case TAnonymous(fields): "{ " + [for (f in fields) printField(f,context) + "; "].join("") + "}";
		case TParent(ct): "(" + printComplexType(ct,context) + ")";
		case TOptional(ct): "?" + printComplexType(ct,context);
		case TExtend(tp, fields): '{${printTypePath(tp,context)} >, ${fields.map(printField.bind(_,context)).join(", ")} }';
	}

	public function printMetadata(meta:MetadataEntry,context) return
        '@${meta.name}';
		//+ (meta.params.length > 0 ? '(${printExprs(meta.params,", ",context)})' : "");

	public function printAccess(access:Access) return switch(access) {
		case AStatic: "static";
		case APublic: "public";
		case APrivate: "private";
		case AOverride: "override";
		case AInline: "inline";
		case ADynamic: "dynamic";
		case AMacro: "macro";
	}

	public function printField(field:Field,context:PrintContext) return
		(field.doc != null && field.doc != "" ? "/**\n" + tabs + tabString + StringTools.replace(field.doc, "\n", "\n" + tabs + tabString) + "\n" + tabs + "**/\n" + tabs : "")
		+ (field.meta != null && field.meta.length > 0 ? field.meta.map(printMetadata.bind(_,context)).join(" ") + " " : "")
		+ (field.access != null && field.access.length > 0 ? field.access.map(printAccess).join(" ") + " " : "")
		+ switch(field.kind) {
		  case FieldType.FVar(t, eo): 'var ${field.name}' + opt(t, printComplexType.bind(_,context), " : ") + context.regular.opt(eo, context.regular.printExpr.bind(_,context), " = ");
		  case FieldType.FProp(get, set, t, eo): 'var ${field.name}($get, $set)' + opt(t, printComplexType.bind(_,context), " : ") + context.regular.opt(eo, context.regular.printExpr.bind(_,context), " = ");
		  case FieldType.FFun(func): context.regular.printFunction(func,context, field.name);
		}

	public function printTypeParamDecl(tpd:TypeParamDecl,context:PrintContext) return
		tpd.name
		+ (tpd.params != null && tpd.params.length > 0 ? "<" + tpd.params.map(printTypeParamDecl.bind(_,context)).join(", ") + ">" : "")
		+ (tpd.constraints != null && tpd.constraints.length > 0 ? ":(" + tpd.constraints.map(printComplexType.bind(_,context)).join(", ") + ")" : "");

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

	public function printFunction(func:TFunc,context:PrintContext, name:String = null) return

		"def " + (name == null ? context.nextAnonFunc() : name) + "(" + printArgs(func.args,context) + ")" + ':\n${context.indent}\t'
//		+ "( " + func.args.map(printFunctionArg).join(", ") + " )"
//		+ opt(func.ret, printComplexType, " : ")
		+ opt(func.expr, printExpr.bind(_,context.incIndent()), "");

	public function printVar(v:{v:TVar, expr:Null<TypedExpr>},context)
    {
        function def () {
            return
            handleKeywords(v.v.name)
            //      + opt(v.type, printComplexType, " : ")
            + if (v.expr != null) opt(v.expr, printOpAssignRight.bind(_,context), " = ") else " = None";
        }

        return if (v.expr != null) {
            switch (v.expr.expr) {
                case TFunction(f):
                    printFunction(f,context,v.v.name);
                case _ : def();
            }
        } else {

            def();
        }
    }

//    function justPath(expr)
//    {
//        return switch(expr.expr)
//        {
//            case EConst(CIdent(s)):s;
//            case EField(e, field): justPath(e) + "_" + field;
//            default:"";
//        }
//       // return printExpr(expr);
//    }

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
                //trace(el);
                //for (e in el) {
                //    trace(ExprTools.toString(e));
                //}
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
                    case TBlock([{ expr : TVars([v1])}, e2, block]):
                        var f1 = v1.v.name;
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
            	//trace(Lambda.array({ iterator : pathHack.keys}));
            	var realId = applyPathHack(id);
               '$realId(${printExprs(el,", ",context)})';
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

    // function formatPrintCall(el:Array<TypedExpr>, context:PrintContext)
    // {
    //     var expr = el[0];
    //     var posInfo = Std.string(expr.pos);
    //     posInfo = posInfo.substring(5, posInfo.indexOf(" "));

    //     var traceString = printExpr(expr, context);

    //     var toStringCall = switch(expr.expr)
    //     {
    //         case TConst(TString(_)):"";
    //         default:".toString()";
    //     }

    //     var traceStringParts = traceString.split(" + ");
    //     var toString = ".toString()";

    //     for(i in 0 ... traceStringParts.length)
    //     {
    //         var part = traceStringParts[i];


    //         if(!traceStringParts[i].startsWith("Std.string("))
    //         {
    //             traceStringParts[i] = "Std.string("+traceStringParts[i]+")";
    //         }
    //     }

    //     traceString = traceStringParts.join(" + ");

    //     return 'print($traceString)';
    // }

    function print_field(e1:TypedExpr, fa:FieldAccess, context:PrintContext)
    {
    	var obj = switch (e1.expr) {
    		case TConst(TSuper):
    			"super()";
    		case _: '${printExpr(e1, context)}';
    	}
        var name = switch (fa) {
            case FInstance(_, cf): 
                cf.get().name;
                
            case FStatic(_,cf): cf.get().name;
            case FAnon(cf): cf.get().name;
            case FDynamic(s): s;
            case FClosure(_,cf): cf.get().name;
            case FEnum(_,ef): ef.name;
        }
        var expr = if (name == "iterator") {
            '_hx_functools.partial(HxOverrides_iterator, $obj)';
        } else {
            '$obj.${handleKeywords(name)}';
        }
        


        var expr = applyPathHack(expr);
        

        return expr;
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

//    public function enterExpr(e:Expr)
//    {
//
//    }
	

	public function printOpAssignRight(e:TypedExpr, context:PrintContext):String {
		function printExpr1 (e) return printExpr(e, context, false);
		return switch (e.expr) 
		{
			case TIf({ expr : TParenthesis(econd)}, eif, eelse) | 
				 TIf(econd, eif, eelse): '${printExpr1(eif)} if ${printExpr1(econd)} else ${printExpr1(eelse)}';
			case _ : printExpr1(e);

		}
	}


    public function printModuleType (t:ModuleType, context:PrintContext) {

        return switch (t) {
            case TClassDecl(ct): printBaseType(ct.get(),context);
            case TEnumDecl(ct): printBaseType(ct.get(),context);
            case TTypeDecl(ct): printBaseType(ct.get(),context);
            case TAbstract(ct): printBaseType(ct.get(),context);
        }
    }

	public function printExpr(e:TypedExpr, context:PrintContext, top = false)
	{
        //trace(ExprTools.toString(e));
		var indent = context.indent;
		function printExpr1 (e) return printExpr(e, context);
		function printExprIndented (e) return printExpr(e, context.incIndent());
//        trace(e);
		//if (e == null) trace("WARNING: #NULL");
        return try e == null ? "None" : switch(e.expr) {
		case TConst(c): printConstant(c);
        case TTypeExpr(t): printModuleType(t, context);
        case TLocal(t): handleKeywords(t.name);
        case TPatMatch: "not supported";
        case TEnumParameter(e,ef, index): '${printExpr1(e)}.params[${ef.index}]';
		case TArray(e1, e2): '${printExpr1(e1)}[${printExpr1(e2)}]';
		case TBinop(OpAssign, e1, e2): '${printExpr1(e1)} = ' + printOpAssignRight(e2, context);
		case TBinop(OpEq, e1, e2 = { expr : TConst(TNull)}):
			'${printExpr1(e1)} is ${printExpr1(e2)}';
		case TBinop(OpNotEq, e1, e2 = { expr : TConst(TNull)}):
			'${printExpr1(e1)} is not ${printExpr1(e2)}'; 
		
        case TBinop(OpUShr, e1, e2): 
            '_hx_rshift(${printExpr1(e1)}, ${printExpr1(e2)})';
        case TBinop(OpAdd, e1, e2) if (isType1("", "String")(e.t)):
            var e1Str = if (!isType1("", "String")(e1.t) && !isType1("", "Dynamic")(e1.t)) "Std.string(" + printExpr1(e1) + ")" else printExpr1(e1);
            var e2Str = if (!isType1("", "String")(e2.t) && !isType1("", "Dynamic")(e2.t)) "Std.string(" + printExpr1(e2) + ")" else printExpr1(e2);

            '$e1Str + $e2Str';

        case TBinop(op, e1, e2): 
			//trace(ExprTools.toString(e));
			//trace(ExprTools.toString(e));
			'${printExpr1(e1)} ${printBinop(op)} ${printExpr1(e2)}';
		
		
		case TField(e1, fa):

            switch (fa) {
                case FInstance(isType("", "list") => true, cf) if (cf.get().name == "length" || cf.get().name == "get_length"):
                    
                    "len(" + printExpr1(e1) + ")";
                case FInstance(ct, cf) if (cf.get().name == "length"):
                    
                    //trace(ct.get().name);
                    print_field(e1, fa, context);        

                case _ : 
                    print_field(e1, fa, context);        
            }
            
		case TParenthesis(e1): '(${printExpr1(e1)})';
		case TObjectDecl(fl):
			"_Hx_AnonObject(" + fl.map(function(fld) return '${handleKeywords(fld.name)} = ${printExpr1(fld.expr)} ').join(",") + ")";
		case TArrayDecl(el): '[${printExprs(el, ", ",context)}]';
		//case TCall({expr : TField(e1, "iterator")}, []): 
        //    'HxOverrides_iterator(${printExpr1(e1)})';
        case TCall(e1, el): printCall(e1, el.copy(),context);
		case TNew(tp, _, el): 
			//trace(tp);
			var id = printBaseType(tp.get(),context);
			//trace(id);
			var realId = applyPathHack(id);
			'${realId}(${printExprs(el,", ",context)})';
		case TUnop(op, true, e1): printExpr1(e1) + printUnop(op);
		case TUnop(op, false, e1): printUnop(op) + printExpr1(e1);
		//case EFunction(no, func) if (no != null): '$n' + printFunction(func,context);
		case TFunction(func):/* "function " +*/printFunction(func,context);
		
		case TVars(vl): vl.map(printVar.bind(_, context)).join('\n$indent');
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
		//case TIn(e1, e2): '${printExpr1(e1)} in ${printExpr1(e2)}';
		
		case TIf(econd, eif, eelse) if (eelse != null && switch (eelse.expr) { case TIf(_,_,_): true; case _ : false;}): 
			// here we could print pythons elif
			printIfElse(econd, eif, eelse,context, true);
		case TIf(econd, eif, eelse): printIfElse(econd, eif, eelse,context);
		// revert length property access in generated whiles from for (dirty hack)
		//case TWhile({ expr : TBinop(OpLt, eleft = { expr : TLocal({name: g1})}, { expr : TField( eright={ expr:TLocal({ name :g2})}, "length")})}, e1, true) if (g1.substr(0,2) == "_g"):
		//	printExpr1(macro while ($eleft < len($eright)) $e1);
		case TWhile(econd, e1, true): 'while ${printExpr1(econd)}:\n$indent\t${printExprIndented(e1)}';
		case TWhile(econd, e1, false): "not supported for python target";
		case TSwitch(e1, cl, edef): /*trace(e); */ printSwitch(e1, cl, edef,context);
		case TTry(e1, cl):
			printTry(e1, cl,context);
			
//		case EReturn(eo): "return " + printExpr1(eo);
		case TReturn(eo): 'return' + opt(eo, printOpAssignRight.bind(_,context), " ");
		case TBreak: "break";
		case TContinue: "continue";
		//case TUntyped(e1): "" +printExpr1(e1);
		case TThrow(e1): "raise _HxException(" +printExpr1(e1) + ")";
		case TCast(e1, cto) if (cto != null): '${printExpr1(e1)}';
		case TCast(e1, _): /*"cast " +*/printExpr1(e1);
		
		//case TTernary(econd, eif, eelse): 
        
        case TMeta([{ name : ":ternaryIf"}], { expr : TIf(econd, eif, eelse)}):
            //trace("print ternary");
             '${printExpr1(eif)} if ${printExpr1(econd)} else ${printExpr1(eelse)}';
		case TMeta(meta, e1): 

            //trace("it's an EMeta");
            //var r = "";
            //for (m in meta) {
            //    r += printMetadata(m,context) + " ";
            //}
            //r;
            printExpr1(e1);
	} catch (ex:Dynamic) { 
        trace("error for Expr:" + TypedExprTools.toString(e)); 
        trace(ex);
        trace(CallStack.toString(CallStack.exceptionStack()));
        throw ex;
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
            var type = applyPathHack(type);
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

    	return switch (c.v.t) {
            case TDynamic(_):
                'if True:\n$indent\t${c.v.name} = _hx_e1\n$indent\t' + printExpr(c.expr, context.incIndent());
            case TInst(ct, _): handleBaseType(ct.get());
            case TEnum(ct, _): handleBaseType(ct.get());
            

    		case x : 

                'catch ' + Std.string(x);
                //throw "catching of types other than tpath is not yet implemented";
    			

    	}
    	
    }


    function printSwitch(e1, cl, edef,context:PrintContext)
    {
    	/*
        trace(e1);
        trace(cl);
        trace(edef);
		*/
        var old = tabs;
        tabs += tabString;
        var s = 'switch ${printExpr(e1,context)} {\n$tabs' +
                    cl.map(printSwitchCase.bind(_,context)).join('\n$tabs');
        if (edef != null)
            s += '\n${tabs}default: ' + (edef.expr == null ? "" : printExpr(edef,context) + ";");

        tabs = old;
        s += '\n$tabs}';

        return s;
    }

    function printSwitchCase(c:{values:Array<TypedExpr>, expr:TypedExpr},context)
    {
        return "not implemented";
        //return 'case ${printExprs(c.values, ", ",context)}'
        //       + (c.guard != null ? ' if ${printExpr(c.guard,context)}: ' : ":")
        //       + (c.expr != null ? (opt(c.expr, printExpr.bind(_, context))) + "\nbreak" : "");
    }

	public function printExprs(el:Array<TypedExpr>, sep:String,context) {
		return el.map(printExpr.bind(_,context)).join(sep);
	}

    public function printExprsNamed(el:Array<{ name : String, expr : TypedExpr}>, sep:String,context) {
        return el.map(function (x) return x.name + " = " + printExpr(x.expr,context)).join(sep);
    }

	public function printClass(t:TypeDefinition, superClass, interfaces:Array<TypePath>, isInterface,context) 
	{
		var head = "class " + t.name;

		var extends1 = if (superClass != null) [superClass] else [];

		var interfaces1 = if (interfaces != null) interfaces else [];

		var allExtends = extends1.concat(interfaces);

		var extendsStr = if (allExtends.length == 0) "" else "(" + [for (tp in allExtends) printTypePath(tp,context)].join(",");
		
		return head + extendsStr + ":"
		+ "\n\t"
		+ [for (f in t.fields) {
			var fstr = printField(f,context);
			tabs + fstr + switch(f.kind) {
				case FVar(_, _), FProp(_, _, _, _): "";
				case FFun(func) if (func.expr == null): "";
				case _: "";
			};
		}].join("\n\t")
		+ "\n";
	}

	public function printTypeDefinition(t:TypeDefinition, context:PrintContext, printPackage = true):String {
		var old = tabs;
		tabs = tabString;

		var str = t == null ? "#NULL" :
			(printPackage && t.pack.length > 0 && t.pack[0] != "" ? "package " + t.pack.join("_") + ";\n" : "") +
			(t.meta != null && t.meta.length > 0 ? t.meta.map(printMetadata.bind(_,context)).join(" ") + " " : "") + (t.isExtern ? "extern " : "") + switch (t.kind) {
				case TDEnum:
					"enum " + t.name + (t.params.length > 0 ? "<" + t.params.map(printTypeParamDecl.bind(_,context)).join(", ") + ">" : "") + " {\n"
					+ [for (field in t.fields)
						tabs + (field.doc != null && field.doc != "" ? "/**\n" + tabs + tabString + StringTools.replace(field.doc, "\n", "\n" + tabs + tabString) + "\n" + tabs + "**/\n" + tabs : "")
						+ (field.meta != null && field.meta.length > 0 ? field.meta.map(printMetadata.bind(_,context)).join(" ") + " " : "")
						+ (switch(field.kind) {
							case FVar(_, _): field.name;
							case FProp(_, _, _, _): throw "FProp is invalid for TDEnum.";
							case FFun(func): field.name + context.regular.printFunction(func,context);
						}) + ";"
					].join("\n")
					+ "\n}";
				case TDStructure:
					"typedef " + t.name + (t.params.length > 0 ? "<" + t.params.map(printTypeParamDecl.bind(_,context)).join(", ") + ">" : "") + " = {\n"
					+ [for (f in t.fields) {
						tabs + printField(f,context) + ";";
					}].join("\n")
					+ "\n}";
				case TDClass(superClass, interfaces, isInterface):
					printClass(t, superClass, interfaces, isInterface,context);
				case TDAlias(ct):
					"typedef " + t.name + (t.params.length > 0 ? "<" + t.params.map(printTypeParamDecl.bind(_,context)).join(", ") + ">" : "") + " = "
					+ printComplexType(ct,context)
					+ ";";
				case TDAbstract(tthis, from, to):
					"abstract " + t.name
					+ (tthis == null ? "" : "(" + printComplexType(tthis,context) + ")")
					+ (t.params.length > 0 ? "<" + t.params.map(printTypeParamDecl.bind(_,context)).join(", ") + ">" : "")
					+ (from == null ? "" : [for (f in from) " from " + printComplexType(f,context)].join(""))
					+ (to == null ? "" : [for (t in to) " to " + printComplexType(t,context)].join(""))
					+ " {\n"
					+ [for (f in t.fields) {
						var fstr = printField(f,context);
						tabs + fstr + switch(f.kind) {
							case FVar(_, _), FProp(_, _, _, _): ";";
							case FFun(func) if (func.expr == null): ";";
							case _: "";
						};
					}].join("\n")
					+ "\n}";
			}

		tabs = old;
		return str;
	}

	public function opt<T>(v:T, f:T->String, prefix = "") return v == null ? "" : (prefix + f(v));
}