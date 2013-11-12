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
using Lambda;
using haxe.macro.Tools;

using haxe.macro.PythonPrinter.PrintContexts;
using StringTools;

typedef PrintContext = {
	indent : String,
	nextAnonFunc : Void -> String
}



class PrintContexts {
	public static function create (indent:String) {
		var n = 0;
		return {
			indent : indent,
			nextAnonFunc : function () return "anon_" + n++
		}
	}
	public static function incIndent (p:PrintContext) {
		return { indent : p.indent + "\t", nextAnonFunc : p.nextAnonFunc };
	}
}

class PythonPrinter {
	var tabs:String;
	var tabString:String;

	static var keywords = [
		"and",       "del",       "from",      "not",       "while",
		"as",        "elif",      "global",    "or",        "with",
		"assert",    "else",      "if",        "pass",      "yield",
		"break",     "except",    "import",    "print",		"float",
		"class",     "exec",      "in",        "raise",
		"continue",  "finally",   "is",        "return",
		"def",       "for",       "lambda",    "try"
];

 

    static var standardTypes:Map<String, String> = [
        "Array" => "List",
        "Int" => "int",
        "Float" => "double",
    ];

    public static var pathHack = new StringMap();

    public static function mapStandardTypes(typeName)
    {
        var mappedType = standardTypes.get(typeName);
        return mappedType == null ? typeName : mappedType;
    }

    public static function handleKeywords(name)
    {
        if(keywords.indexOf(name) != -1)
            return "_hx_" + name;
        return name;
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

	public function printConstant(c:Constant) return switch(c) {
		case CIdent("this"): "self";
		case CIdent("null"): "None";
		case CIdent("true"): "True";
		case CIdent("false"): "False";
		case CString(s): printString(s);
		case CIdent(s):
			
			handleKeywords(s);
		case CInt(s), CFloat(s):
			s;
			
		case CRegexp(s,opt): '~/$s/$opt';
	}

	public function printTypeParam(param:TypeParam,context) return switch(param) {
		case TPType(ct): printComplexType(ct,context);
		case TPExpr(e): printExpr(e,context);
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
        '@${meta.name}'
		+ (meta.params.length > 0 ? '(${printExprs(meta.params,", ",context)})' : "");

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
		  case FVar(t, eo): 'var ${field.name}' + opt(t, printComplexType.bind(_,context), " : ") + opt(eo, printExpr.bind(_,context), " = ");
		  case FProp(get, set, t, eo): 'var ${field.name}($get, $set)' + opt(t, printComplexType.bind(_,context), " : ") + opt(eo, printExpr.bind(_,context), " = ");
		  case FFun(func): printFunction(func,context, field.name);
		}

	public function printTypeParamDecl(tpd:TypeParamDecl,context:PrintContext) return
		tpd.name
		+ (tpd.params != null && tpd.params.length > 0 ? "<" + tpd.params.map(printTypeParamDecl.bind(_,context)).join(", ") + ">" : "")
		+ (tpd.constraints != null && tpd.constraints.length > 0 ? ":(" + tpd.constraints.map(printComplexType.bind(_,context)).join(", ") + ")" : "");

    public function printArgs(args:Array<FunctionArg>,context)
    {
        var argString = "";
        var optional = false;

        for(i in 0 ... args.length)
        {
            var arg = args[i];
            
            var argValue = printExpr(arg.value,context);
            var argIsNull = arg.value == null;
            if((arg.opt || !argIsNull) && !optional)
            {
                optional = true;
                argString += "";
            }
            
            
            argString += handleKeywords(arg.name);

            if(argValue != null && !argIsNull)
                argString += ' = $argValue';

            if(i < args.length - 1)
                argString += ",";
        }

        if(optional) argString += "";

        return argString;
    }

	public function printFunction(func:Function,context:PrintContext, name:String = null) return

		"def " + (name == null ? context.nextAnonFunc() : name) + "(" + printArgs(func.args,context) + ")" + ':\n${context.indent}\t'
//		+ "( " + func.args.map(printFunctionArg).join(", ") + " )"
//		+ opt(func.ret, printComplexType, " : ")
		+ opt(func.expr, printExpr.bind(_,context.incIndent()), "");

	public function printVar(v:Var,context)
    {
        return
        handleKeywords(v.name)
        //		+ opt(v.type, printComplexType, " : ")
        + opt(v.expr, printOpAssignRight.bind(_,context), " = ");
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

    function printCall(e1, el:Array<Expr>, context)
    {
        var id = printExpr(e1, context);

        var result =  switch(id)
        {
        	case "super":
        		var params = el.copy();
        		'super().__init__(${printExprs(params,", ", context)})';
            case "trace" :
                formatPrintCall(el, context);
            case "__python_kwargs__":
                '**${printExpr(el[0],context)}';
            case "__python_varargs__":
                '*${printExpr(el[0],context)}';
            case "__python__":   switch(el[0].expr)
            {
                case EConst(CString(s)): s;
                default:"";
            };
            case "__named_arg__":
                var name = switch(el[0].expr)
                {
                    case EConst(CString(s)): s;
                    default: throw "unexpected";
                };  
                '$name=${printExpr(el[1], context)}';
            case "__feature__":'';
            case "__named__":
                	
                //trace(el);
                //for (e in el) {
                //    trace(ExprTools.toString(e));
                //}
                var fields = switch (el[1].expr) {
                    case EObjectDecl(fields): fields;
                    case _ : throw "unexpected ERRRRRRORRRR";
                }
            	
                //trace(fields);
                
            	'${printExpr(el[0], context)}(${printExprsNamed(fields,", ", context)})';
            case "__define_feature__":
            	printExpr(el[1], context);
            case "__call__":
            	var params = el.copy();
            	var first = params[0];params.shift();
                '${printExpr(first, context)}(${printExprs(params,", ", context)})';
            case "__field__":
                
                var first = el[0];
                var field = switch (el[1].expr) {
                    case EConst(CString(id)):id;
                    case _ : throw "unexpected";
                }
                '${printExpr(first, context)}.$field';
            case "__python_tuple__":
            	'(${printExprs(el, ", ", context)})';
            case "__python_array_get__":
                '${printExpr(el.shift(), context)}[${printExprs(el,":", context)}]';
            case "__python_in__":
                '${printExpr(el[0], context)} in ${printExpr(el[1], context)}';
            case "__python_del__":
                'del ${printExpr(el[0], context)}';
            case "__python_binop__":
                var op = switch (el[1].expr) {
                    case EConst(CString(id)):id;
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

    function extractString(e)
    {
        return switch(e.expr)
        {
            case EConst(CString(s)):s;
            default:"####";
        }
    }

    function formatPrintCall(el:Array<Expr>, context:PrintContext)
    {
        var expr = el[0];
        var posInfo = Std.string(expr.pos);
        posInfo = posInfo.substring(5, posInfo.indexOf(" "));

        var traceString = printExpr(expr, context);

        var toStringCall = switch(expr.expr)
        {
            case EConst(CString(_)):"";
            default:".toString()";
        }

        var traceStringParts = traceString.split(" + ");
        var toString = ".toString()";

        for(i in 0 ... traceStringParts.length)
        {
            var part = traceStringParts[i];


            if(!traceStringParts[i].startsWith("Std.string("))
            {
                traceStringParts[i] = "Std.string("+traceStringParts[i]+")";
            }
        }

        traceString = traceStringParts.join(" + ");

        return 'print($traceString)';
    }

    function print_field(e1, name, context:PrintContext)
    {
    	var obj = switch (e1.expr) {
    		case EConst(CIdent("super")):
    			"super()";
    		case _: '${printExpr(e1, context)}';
    	}
        var expr = '$obj.${handleKeywords(name)}';


        var expr = applyPathHack(expr);
        

        return expr;
    }

    function printIfElse(econd, eif, eelse, context:PrintContext, ?asElif = false)
    {
    	var econd1 = switch (econd.expr) {
    		case EParenthesis(e):e;
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
	

	public function printOpAssignRight(e:Expr, context:PrintContext):String {
		function printExpr1 (e) return printExpr(e, context, false);
		return switch (e.expr) 
		{
			case EIf({ expr : EParenthesis(econd)}, eif, eelse) | 
				 EIf(econd, eif, eelse): '${printExpr1(eif)} if ${printExpr1(econd)} else ${printExpr1(eelse)}';
			case _ : printExpr1(e);

		}
	}


	public function printExpr(e:Expr, context:PrintContext, top = false)
	{
        //trace(ExprTools.toString(e));
		var indent = context.indent;
		function printExpr1 (e) return printExpr(e, context);
		function printExprIndented (e) return printExpr(e, context.incIndent());
//        trace(e);
		//if (e == null) trace("WARNING: #NULL");
        return try e == null ? "None" : switch(e.expr) {
		case EConst(c): printConstant(c);
		case EArray(e1, e2): '${printExpr1(e1)}[${printExpr1(e2)}]';
		case EBinop(OpAssign, e1, e2): '${printExpr1(e1)} = ' + printOpAssignRight(e2, context);
		case EBinop(OpEq, e1, e2 = { expr : EConst(CIdent("null"))}):
			'${printExpr1(e1)} is ${printExpr1(e2)}';
		case EBinop(OpNotEq, e1, e2 = { expr : EConst(CIdent("null"))}):
			'${printExpr1(e1)} is not ${printExpr1(e2)}'; 
		
        case EBinop(OpUShr, e1, e2): 
            '_hx_rshift(${printExpr1(e1)}, ${printExpr1(e2)})';
        case EBinop(op, e1, e2): 
			//trace(ExprTools.toString(e));
			//trace(ExprTools.toString(e));
			'${printExpr1(e1)} ${printBinop(op)} ${printExpr1(e2)}';
		
		
		case EField(e1, n):/* trace(e);*/ print_field(e1, n, context);
		case EParenthesis(e1): '(${printExpr1(e1)})';
		case EObjectDecl(fl):
			"_Hx_AnonObject(" + fl.map(function(fld) return '${handleKeywords(fld.field)} = ${printExpr1(fld.expr)} ').join(",") + ")";
		case EArrayDecl(el): '[${printExprs(el, ", ",context)}]';
		case ECall({expr : EField(e1, "iterator")}, []): 
            'HxOverrides_iterator(${printExpr1(e1)})';
        case ECall(e1, el): printCall(e1, el.copy(),context);
		case ENew(tp, el): 
			//trace(tp);
			var id = printTypePath(tp,context);
			//trace(id);
			var realId = applyPathHack(id);
			'${realId}(${printExprs(el,", ",context)})';
		case EUnop(op, true, e1): printExpr1(e1) + printUnop(op);
		case EUnop(op, false, e1): printUnop(op) + printExpr1(e1);
		//case EFunction(no, func) if (no != null): '$n' + printFunction(func,context);
		case EFunction(name, func):/* "function " +*/printFunction(func,context,name);
		
		case EVars(vl): vl.map(printVar.bind(_, context)).join('\n$indent');
		case EBlock([]): 'pass\n${indent}';
		case EBlock(el):
            var old = tabs;
			tabs = context.indent;
			var s = printExprs(el, '\n$tabs',context);
			tabs = old;
			s + '\n$tabs';
		case EFor(e1, e2): 'for ${printExpr1(e1)}: ${printExpr1(e2)}';
		case EIn(e1, e2): '${printExpr1(e1)} in ${printExpr1(e2)}';
		
		case EIf(econd, eif, eelse) if (eelse != null && switch (eelse.expr) { case EIf(_,_,_): true; case _ : false;}): 
			// here we could print pythons elif
			printIfElse(econd, eif, eelse,context, true);
		case EIf(econd, eif, eelse): printIfElse(econd, eif, eelse,context);
		// revert length property access in generated whiles from for (dirty hack)
		case EWhile({ expr : EBinop(OpLt, eleft = { expr : EConst(CIdent(g1))}, { expr : EField( eright={ expr:EConst(CIdent(g2))}, "length")})}, e1, true) if (g1.substr(0,2) == "_g"):
			printExpr1(macro while ($eleft < len($eright)) $e1);
		case EWhile(econd, e1, true): 'while ${printExpr1(econd)}:\n$indent\t${printExprIndented(e1)}';
		case EWhile(econd, e1, false): "not supported for python target";
		case ESwitch(e1, cl, edef): /*trace(e); */ printSwitch(e1, cl, edef,context);
		case ETry(e1, cl):
			printTry(e1, cl,context);
			
//		case EReturn(eo): "return " + printExpr1(eo);
		case EReturn(eo): 'return' + opt(eo, printOpAssignRight.bind(_,context), " ");
		case EBreak: "break";
		case EContinue: "continue";
		case EUntyped(e1): "" +printExpr1(e1);
		case EThrow(e1): "raise _HxException(" +printExpr1(e1) + ")";
		case ECast(e1, cto) if (cto != null): '${printExpr1(e1)}';
		case ECast(e1, _): /*"cast " +*/printExpr1(e1);
		case EDisplay(e1, _): '#DISPLAY(${printExpr1(e1)})';
		case EDisplayNew(tp): '#DISPLAY(${printTypePath(tp,context)})';
		case ETernary(econd, eif, eelse): '${printExpr1(econd)} ? ${printExpr1(eif)} : ${printExpr1(eelse)}';
		case ECheckType(e1, ct): '${printExpr1(e1)}';
		case EMeta(meta, e1): 
            trace("it's an EMeta");
            printMetadata(meta,context) + " " +printExpr1(e1);
	} catch (ex:Dynamic) { trace("error for Expr:" + ExprTools.toString(e)); throw "error";};
    }

    function printTry (e1:Expr, cl:Array<Catch>, context:PrintContext) 
    {
    
    	var indent = context.indent;
    	function printExprIndented (e) return printExpr(e, context.incIndent());
    	var tryStr = 'try:\n$indent\t${printExprIndented(e1)}\n$indent';

    	var except = 'except Exception as _hx_e:\n$indent\t_hx_e1 = _hx_e.val if isinstance(_hx_e, _HxException) else _hx_e\n$indent\t';
    	var catchStr = cl.mapi(printCatch.bind(_, _, context.incIndent())).join('\n$indent\t');

    	var exceptEnd = '\n$indent\telse:\n$indent\t\traise _hx_e';

    	return tryStr + except + catchStr + exceptEnd;
    }

    function printCatch (index:Int, c:Catch, context:PrintContext) 
    {
    	var indent = context.indent;
    	return switch (c.type) {
    		case ComplexType.TPath(p):
    			var type = printTypePath(p, context);
    			var type = applyPathHack(type);
    			//trace(p);
    			var res = if (type == "String") {
    				'if isinstance(_hx_e1, str):\n$indent\t${c.name} = _hx_e1\n$indent\t' + printExpr(c.expr, context.incIndent());
    			}  else if (type == "Dynamic") {
    				'if True:\n$indent\t${c.name} = _hx_e1\n$indent\t' + printExpr(c.expr, context.incIndent());
    			} else {
    				'if isinstance(_hx_e1, $type):\n$indent\t${c.name} = _hx_e1\n$indent\t' + printExpr(c.expr, context.incIndent());
    			}
    			if (index > 0) {
    				res = "el" + res;
    			}
    			res;
    		case _ : throw "catching of types other than tpath is not yet implemented";
    			

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

    function printSwitchCase(c:Case,context)
    {
        return 'case ${printExprs(c.values, ", ",context)}'
               + (c.guard != null ? ' if ${printExpr(c.guard,context)}: ' : ":")
               + (c.expr != null ? (opt(c.expr, printExpr.bind(_, context))) + "\nbreak" : "");
    }

	public function printExprs(el:Array<Expr>, sep:String,context) {
		return el.map(printExpr.bind(_,context)).join(sep);
	}

    public function printExprsNamed(el:Array<{ field : String, expr : Expr}>, sep:String,context) {
        return el.map(function (x) return x.field + " = " + printExpr(x.expr,context)).join(sep);
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
							case FFun(func): field.name + printFunction(func,context);
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

	function opt<T>(v:T, f:T->String, prefix = "") return v == null ? "" : (prefix + f(v));
}