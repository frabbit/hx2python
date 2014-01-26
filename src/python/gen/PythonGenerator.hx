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
 *
 *
 */
package python.gen;

import haxe.macro.Context;
import haxe.macro.Compiler;
import haxe.macro.Type;
import haxe.macro.Expr;
import haxe.Timer;
import python.gen.PythonPrinter;
using Lambda;
import python.gen.PythonPrinterTyped;
import python.gen.PythonTransformer;
import haxe.macro.JSGenApi;
import python.gen.Tools;

using StringTools;

class PythonGenerator
{

    static var imports = [];

    var api : JSGenApi;
    var buf : StringBuf;
    var packages : haxe.ds.StringMap<Bool>;

    var staticInits : Array<Void->Void>;

    var indentCount : Int;    

    var typedExprPrinter : PythonPrinterTyped;

    var transformTime:Float;
    var printTime:Float;

    public function new(api)
    {
        printTime = 0.0;
        transformTime = 0.0;
        typedExprPrinter = new PythonPrinterTyped();
        indentCount = 0;
        staticInits = [];
        this.api = api;

        buf = new StringBuf();
        packages = new haxe.ds.StringMap();

        //api.setTypeAccessor(getType);
    }

    function getType(t : Type)
    {
        return switch(t) {
            case TInst(c, _): getPath(c.get());
            case TEnum(e, _): getPath(e.get());
            case TAbstract(e, _): getPath(e.get());
            case TLazy(l): getType(l());
            default: throw "assert " + t;
        };
    }

    inline function print(str)
    {
        buf.add(str);
    }
    inline function printLine(str)
    {
        print(str + "\n");
    }

    inline function newline()
    {
        print("\n");
    }

    function genStaticFuncExpr(e:TypedExpr,name,cl:ClassType, metas:Array<MetadataEntry>, extraArgs:Array<String>, indent:String = "\t") 
    {
        var context = PrintContexts.create(indent);
        

        var expr = switch (e.expr) 
        {
            case TFunction(f):
                var args = extraArgs.map(function (s) return { value : null, v : { id : 0, name : s, t : TDynamic(null), capture : false, extra : null}}).concat(f.args);
                { expr : TypedExprDef.TFunction({ args : args, t : f.t, expr : f.expr}), pos : e.pos, t : e.t };
            case _ : e;
        }
        var expr1 = transformExpr(expr);

        var fieldName = cl.name + "_statics_" + name;

        var exprString = switch (expr1.expr) 
        {
            case TFunction(f): tfuncStr(f,context, fieldName);
            case _ :           fieldName + " = " + typedExprStr(expr1,context);
        }

        print(indent);

        printPyMetas(metas, "");
        
        print(exprString); 
        newline();
        print(getPath(cl) + "." + name + " = " + fieldName);
    }

    function genFuncExpr(e:TypedExpr,name, metas:Array<MetadataEntry>, extraArgs:Array<String>, indent:String = "\t") 
    {
        var context = PrintContexts.create(indent);

        var expr:TypedExpr = switch (e.expr) {
            case TFunction(f):
                
                var args = extraArgs.map(function (s) return { value : null, v : { id : 0, name : s, t : TDynamic(null), capture : false, extra : null}}).concat(f.args);
                { expr : TFunction({ args : args, t : f.t, expr : f.expr}), pos : e.pos, t : e.t };
            case _ : e;
        }

        var expr1 = transformExpr(expr);

        var fieldName = name;

        var exprString = switch (expr1.expr) {
            case TFunction(f):
                tfuncStr(f,context, fieldName);
                    
            case _ : 
                fieldName + " = " + typedExprStr(expr1,context);
        }

        printPyMetas(metas, indent);
        print(indent);
        print(exprString); 
    }
    public function printPyMetas (metas:Array<MetadataEntry>, indent:String) 
    {
        for (m in metas) {
            switch (m.params[0].expr) {
                case EConst(CString(s)):
                    print(indent + "@" + s + "\n");
                case _ : throw "unexpected";
            }
        }
    }

    function genExpr(e:TypedExpr, ?field:String = "", ?indent:String = "")
    {
        var context = PrintContexts.create("\t" + indent);
       
        var e = switch (e.expr) {
            case TFunction(f):
                { expr : TBlock([e]), t : e.t, pos : e.pos};
            case _ : e;
        }

        var expr2 = transformToValue(e);

        var name = "_hx_init_" + field.split(".").join("_");
        function maybeSplitExpr(expr2:TypedExpr) return switch (expr2.expr) 
        {
            case TBlock(es) if (field != ""):
                var ex1 = es.copy();
                var last = ex1.pop();
                var newLast = { expr : TReturn(last), pos : last.pos, t : last.t };
                

                var newBlock = { expr : TBlock(ex1.concat([newLast])), pos : expr2.pos, t : last.t};
                
                var fName = { expr : TLocal({ name : name, t : TFun([], last.t), capture : false, extra : null, id : 0}), t:TFun([], last.t), pos : last.pos};
                var callF = { expr : TCall(fName, []), pos : last.pos, t : last.t};

                { e1 : newBlock, e2 : callF };

            case _ : { e1 : null, e2 : expr2};
        }
        var r = maybeSplitExpr(expr2);

        if (r.e1 != null) {
            var exprString1 = typedExprStr(r.e1,context);
            var exprString2 = typedExprStr(r.e2,context);

            print(indent + "def " + name + "():\n\t" + exprString1 + "\n");
            print(indent + field + " = " + exprString2);

        } else {
            var exprString2 = typedExprStr(r.e2,context);
            if (field == "") print(exprString2);
            else print(indent + field + " = " + exprString2);
        }
        
    }
    
    function transformToValue(e) 
    {
        var s = Timer.stamp();
        var r = PythonTransformer.transformToValue(e);
        var t = Timer.stamp()-s;
        transformTime += t;

        return r;
    }

    function transformExpr (e:TypedExpr) 
    {
        var s = Timer.stamp();

        var r =  PythonTransformer.transform(e);
        var t = Timer.stamp()-s;
        transformTime += t;
        return r;
    }

    function tfuncStr (f, context, name) 
    {
        var s = Timer.stamp();
        var r = typedExprPrinter.printFunction(f,context, name);
        var t = Timer.stamp()-s;
        printTime += t;
        return r;   
    }

    function typedExprStr (e:TypedExpr, context) 
    {
        var s = Timer.stamp();
        var r = typedExprPrinter.printExpr(e,context);
        var t = Timer.stamp()-s;
        printTime += t;
        return r;   
        
    }

    function handleKeywords(p : String)
    {
        return PythonPrinterTyped.handleKeywords(p);
    }

    function getFullName (t:BaseType) 
    {
       var hasPack = t.pack.length > 0;
       var pack1 = t.pack.join(".");
       var pack2 = t.pack.join("_");

       var moduleName = { var p = t.module.split("."); p[p.length-1];};
       
       var hasModule = (moduleName != t.name);



       var hasModulePrefix = (hasPack && hasModule);
       var hasTypePrefix = (hasPack || hasModule);

       var modulePrefix1 = hasModulePrefix ? "." : "";
       

       var typePrefix1 = hasTypePrefix ? "." : "";
       

       var moduleStr = hasModule ? "_" + moduleName : "";
       return if (!t.isPrivate) {
            var typePrefix1 = hasPack ? "." : ""; 
            pack1 + typePrefix1 + t.name;
       } else {
            pack1 + modulePrefix1 + moduleStr + typePrefix1 + t.name;
       }
       
    }

    function getPath(t : BaseType, isDefinition:Bool = true)
    {
        return typedExprPrinter.printBaseType(t, PrintContexts.create(""), isDefinition);
    }

    
    function genClassField(c : ClassType, p : String, f : ClassField)
    {
        var field = handleKeywords(f.name);
        var e = f.expr();
        if(e == null)
        {
            print('\t# var $field');

        }
        else switch( f.kind )
        {
            case FMethod(_):
                
                var pyMetas = f.meta.get().filter(function (m) return m.name == ":python");
                genFuncExpr(e, field, pyMetas, ["self"]);
                newline();

            case _ :
                genExpr(e, '# var $field', '\t');
                newline();
        }
        newline();
    }

    function genStaticField(c : ClassType, p : String, f : ClassField)
    {
        var p = getPath(c);
        var field = handleKeywords(f.name);
        var e = f.expr();
        if(e == null)
        {
            print('$p.$field = None;\n'); //TODO(av) initialisation of static vars if needed
            
        }
        else switch( f.kind ) {
            case FMethod(_):
                var pyMetas = f.meta.get().filter(function (m) return m.name == ":python");
                genStaticFuncExpr(e, field, c, pyMetas, [], "");
                newline();
            case _ :
                
                genExpr(e, '$p.$field');
                
                newline();
        }
    }

    

    function getMembersWithInitExpr (classFields:Array<ClassField>) 
    {
        var memberInit = [];
        for(f in classFields)
        {
            switch( f.kind ) {
                case FVar(AccResolve | AccCall, _):
                case FVar(_, _) if (f.expr() == null):
                    memberInit.push({name:f.name, pos : f.pos, t:f.type, cf : f});
                case _:
            }
        }
        return memberInit;
    }

    function genClassConstructor (c:ClassType, cType:Type, classFields:Array<ClassField>) 
    {
        if(c.constructor != null)
        {
            var memberInits = getMembersWithInitExpr(classFields);
    
            newline();
            
            var pyMetas = c.constructor.get().meta.get().filter(function (m) return m.name == ":python");

            var constructorExpr = c.constructor.get().expr();

            if (memberInits.length > 0) 
            {
                switch (constructorExpr.expr) 
                {
                    case TFunction(f):
                        var memberData = memberInits.map(function (x) return {v : { id : 0, name : x.name, t : x.t, capture : false, extra : null}, expr : { expr : TConst(TNull), t : x.t, pos : x.pos}, cf: x.cf});

                        
                        var memberAssigns = memberData.map(function (x) {
                            var tthis = { expr : TConst(TThis), pos : x.expr.pos, t : cType }
                            // TODO remove FDynamic
                            var left = { expr : TField(tthis, FDynamic(x.cf.name)), pos : x.expr.pos, t : x.expr.t }
                            return { expr : TBinop(OpAssign, left, x.expr), pos : x.expr.pos, t : x.cf.type };
                        });
                        
                        var b1 = { expr : TBlock(memberAssigns.concat([f.expr])), pos : constructorExpr.pos, t: f.t};

                        f.expr = b1;
                    case _ : 
                }
            }
            
            genFuncExpr(constructorExpr,"__init__", pyMetas, ["self"]);
            newline();
        }
    }

    function genClassEmptyConstructor(typeName:String, classFields:Array<ClassField>) {
        var sName = typeName + "_hx_empty_init";

        printLine("def "+ sName +" (_hx_o):");

        var foundFields = false;
        for (c in classFields) {
            switch (c.kind) {
                case FVar(AccResolve | AccCall, _):
                case FVar(_, _): 
                    foundFields = true; 
                    printLine("\t_hx_o." + handleKeywords(c.name) + " = None");
                case _ :
            }
            
        }
        if (!foundFields) {
            printLine("\tpass");            
        }

        printLine(typeName + "._hx_empty_init = " + sName);
    }

    function collectClassStaticsData (classFields:Array<ClassField>) {
        var fields = [];
                
        for(f in classFields)
        {
            switch( f.kind ) 
            {
                case FVar(AccResolve, _): continue;
                case FVar(AccCall, _): 
                    if (f.meta.has(":isVar")) {
                        fields.push(f.name);
                    }
                case FVar(_, _): fields.push(f.name);
                case _: fields.push(f.name);
            }
        }
        return fields;   
    }

    function collectClassFieldData (classFields:Array<ClassField>) 
    {
        var fields = [];
        var props = [];
        var methods = [];
        
        for(f in classFields)
        {
            switch( f.kind ) 
            {
                case FVar(AccResolve, _): continue;
                case FVar(AccCall, _): 
                    
                    if (f.meta.has(":isVar")) {
                        fields.push(f.name);
                    } else {
                        props.push(f.name);
                    }
                case FVar(_, _): fields.push(f.name);
                case _: methods.push(f.name);
            }
        }
        return { fields : fields, props : props, methods : methods };
    }

    function genClass(c : ClassType, cType:Type, cRef:Ref<ClassType>)
    {
        

        printLine("# print " + c.module + "." + c.name);

        if (!c.isExtern) 
        {
            api.setCurrentClass(c);

            var p = getPath(c, true);
            var pName = getFullName(c);
            
            print('class $p');

            var bases = [];
            var superClass = null;
            if(c.superClass != null)
            {
                var psup = getPath(c.superClass.t.get());
                bases.push(psup);
                superClass = psup;
                
            }
            var interfaces = [];
            if(c.interfaces.length > 0)
            {
                var me = this;
                var inter = c.interfaces.map(function(i) return me.getPath(i.t.get())).join(",");
                interfaces.push(inter);
            }

            if (bases.length > 0) {
                print("(" + bases.join(",") + ")");
            } 
            print(":");
            
            openBlock();

            var classFields = c.fields.get();

            genClassConstructor(c, cType, classFields);



            
            
            for(f in classFields)
            {
                genClassField(c, p, f);
            }

            var x = collectClassFieldData(classFields);

            var usePass = (c.constructor == null && x.methods.length == 0) || c.isInterface;

            if (usePass) printLine("\tpass");

            closeBlock();

            genClassData (c, x.fields, x.props, x.methods, superClass, interfaces, p, pName);
            
            genClassMetaData(c, p);

            genClassEmptyConstructor(p, classFields);
            
            genClassStatics(c, p);
            
        }

        genClassInit(c);
        
    }

    function genClassMetaData (c:ClassType, pName:String) {
        print('$pName._hx_meta = _hx_c._hx_AnonObject(');
        print("obj=");
        print(getMetaEntries(c.meta.get()));
        print(",statics=");
        genMetaMembers([for (f in c.statics.get()) f] );
        print(",fields=");
        var fields:Array<{ name : String, meta : MetaAccess }> = [for (f in c.fields.get()) f];
        if (c.constructor != null) {
            fields.unshift(c.constructor.get());
        }
        genMetaMembers( fields );
        print(')\n');
    }
    function genEnumMetaData (c:EnumType, pName:String) {
        print('$pName._hx_meta = _hx_c._hx_AnonObject(');
        print("obj=");
        print(getMetaEntries(c.meta.get()));
        print(",fields=");
        genMetaMembers([for (k in c.constructs.keys()) { name : k, meta : c.constructs.get(k).meta} ]);
        print(')\n');
    }



    function genMetaMembers (fields:Array<{ name : String, meta : MetaAccess }>) {
        print("_hx_c._hx_AnonObject(");
        var first = true;
        for (f in fields) {
            var metas = f.meta.get();
            var realMetas = [for (m in metas) if (!m.name.startsWith(":")) m];
            if (realMetas.length > 0) {
                var prefix = if (first) { first = false;"";} else ",";
                var name = if (f.name == "new") "_" else f.name;
                print(prefix + handleKeywords(name) + " = " + getMetaEntries(realMetas));
            }
        }
        print(")");
    }

    function getMetaEntries (metas:Metadata) 
    {
        var printer = new PythonPrinter();
        var ctx = PrintContexts.create("\t\t");
        var str = "_hx_c._hx_AnonObject(";
        var first = true;
        for (m in metas) {
            if (!m.name.startsWith(":")) {
                var prefix = if (first) { first = false;"";} else ",";
                var val = if (m.params == null || m.params.length == 0) "None" else
                    "[" + m.params.map(printer.printExpr.bind(_,ctx)).join(",") + "]";
                str += prefix + m.name + " = " + val;
            }
        }
        str += ")";
        return str;
    }


    function genClassData (c:ClassType, fields, props, methods, superClass, interfaces, p, pName) 
    {
        
        //trace("len statics:" + c.statics.get().length);
        var fieldStr = {
            var f = fields.length > 0 ? '"' : '';
            f + fields.join('","') + f;
        }
        
        var propsStr = {
            var f = props.length > 0 ? '"' : '';
            f + props.join('","') + f;
        }
        
        var methodsStr = {
            var f = methods.length > 0 ? '"' : '';
            f + methods.join('","') + f;
        }

        var staticsStr = {
            var statics = collectClassStaticsData(c.statics.get());
            var f = statics.length > 0 ? '"' : '';
            f + statics.join('","') + f;
        }

        newline();
        printLine('$p._hx_class = $p');
        printLine('$p._hx_class_name = "$pName"');
        printLine('_hx_classes["$pName"] = $p');
        printLine('_hx_c.$p = $p');
        printLine('$p._hx_fields = [$fieldStr]');
        printLine('$p._hx_props = [$propsStr]');
        printLine('$p._hx_methods = [$methodsStr]');
        printLine('$p._hx_statics = [$staticsStr]');
        printLine('$p._hx_interfaces = [${interfaces.join(',')}]');
        
        if (superClass != null) 
        {
            printLine('$p._hx_super = $superClass');
        }
    }

    function genClassStatics (c:ClassType, path:String) {
        staticInits.push(function () {
            for(f in c.statics.get()) 
            {
                genStaticField(c, path, f);
            }
            print("\n");
        });
    }

    function genClassInit (c:ClassType) {
        if (c.init != null) {
            staticInits.push(function () {
                var t = c.init;
                var trans = transformExpr(t);
                
                print(typedExprStr(trans,PrintContexts.create("")));
                print("\n");
            });
        }
    }

    function genEnum(e : EnumType)
    {
        var p = getPath(e);
        var pName = getFullName(e);

        printLine('class $p(_hx_c.Enum):');
        printLine('\tdef __init__(self, t, i, p):');
        printLine('\t\tsuper($p,self).__init__(t, i, p)');

        newline();

        var enumConstructs = [];
        for(c in e.constructs.keys())
        {

            var c = e.constructs.get(c);

            enumConstructs.push({ name : c.name, index: c.index });

            var f = handleKeywords(c.name);
            
            switch( c.type ) {
                case TFun(args, _):
                    var paramsStr = args.map(function(a) return handleKeywords(a.name) + if (a.opt) " = None" else ""  ).join(",");
                    var argsStr = args.map(function(a) return handleKeywords(a.name)).join(",");
                    
                    printLine('def _${p}_statics_${f} ($paramsStr):');
                    printLine('\treturn $p("${c.name}", ${c.index}, [$argsStr])');
                    printLine('$p.$f = _${p}_statics_${f}');
                default:
                    printLine('$p.$f = $p(${api.quoteString(c.name)}, ${c.index}, list())');
            }
            newline();
        }
        var fix = enumConstructs.length > 0 ? '"' : '';
        var enumConstructs = enumConstructs.copy();
        enumConstructs.sort(function (a,b) return a.index < b.index ? -1 : a.index > b.index ? 1 : 0);
        var enumConstructsStr = fix + enumConstructs.map(function (x) return x.name).join('","') + fix;

        printLine('$p._hx_constructs = [$enumConstructsStr]');
        printLine('$p._hx_class = $p');
        printLine('$p._hx_class_name = "$pName"');
        printLine('_hx_classes["$pName"] = $p');
        printLine('_hx_c.$p = $p');

        genEnumMetaData(e, p);
    }

    function genType(t : Type)
    {
        switch( t ) {
            case TInst(c, _):
                var c1 = c.get();
                genClass(c1, t, c);
            case TEnum(r, _):
                var e = r.get();
                if(! e.isExtern) genEnum(e);
            case _ :
        }
    }

    function genBootClass () 
    {
        var boot = Context.getType("python.Boot");
        genType(boot);
    }

    function isBootClass (c:ClassType) 
    {
        return c.name == "Boot" && c.pack.length == 1 && c.pack[0] == "python";
    }


    function filterTypes (f:Array<Type>) 
    {
        function isJsType (c:BaseType) {
            return c.pack.length > 0 && c.pack[0] == "js";
        }
        function filter (t) return switch (t) {
            case TInst(c,_): 
                var cf = c.get(); 
                !isBootClass(cf) && !isJsType(cf);
            case TEnum(c,_): 
                var cf = c.get(); 
                !isJsType(cf);
            case _ : true;
        }

        return [for(t in api.types) if (filter(t)) t];
    }

    function genTypes () 
    {
        var filtered = filterTypes(api.types);

        for (f in filtered) 
        {
            genType(f);
        }
    }

    function genStaticInits () 
    {
        for (s in staticInits) {
            s();
        }
    }

    function genMain () {
        if(api.main != null)
        {
            genExpr(api.main);
        }
    }

    function writeFile ()
    {
        sys.io.File.saveContent(api.outputFile, buf.toString());
    }

    function genBootCode () 
    {
        var bootcode = Tools.getFileContent("bootcode.py", true);
        print(bootcode);
    }

    function genResources() {
        var res = Context.getResources();
        var keys = res.keys();
        if (keys.hasNext()) {
            var file = Compiler.getOutput();
            print("def _hx_resources__():\n\treturn {");

            var first = true;
            for (k in keys) {
                var prefix = if (first) { first = false; "";} else ",";
                print(prefix + "'" + k + "':'" + haxe.crypto.Base64.encode(res.get(k)) + "'");
            }
            print("}\n");
        }
        
    }

    public function generate()
    {
        

        genResources();
        genBootCode();

        genBootClass();

        genTypes();

        genStaticInits();
        
        genMain();

        writeFile();

        trace("Transform Time: " + transformTime);   
        trace("Print Time: " + printTime);   
    }

    function openBlock()
    {
        newline();
        
        indentCount++;
        newline();
    }

    function closeBlock()
    {
        indentCount--;
        newline();
        
        newline();
        newline();
    }

    #if macro
	public static function use() 
    {
        
        Compiler.allowPackage("sys");
        Compiler.include("python.Boot");
        

		Compiler.setCustomJSGenerator(function(api) {
            new PythonGenerator(api).generate();
        });
	}
	#end

}
