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
import python.gen.PythonPrinter;
using Lambda;
import python.gen.PythonPrinterTyped;
import python.gen.PythonTransformer;
import haxe.macro.JSGenApi;
import python.gen.Tools;


class PythonGenerator
{

    static var imports = [];

    var api : JSGenApi;
    var buf : StringBuf;
    var packages : haxe.ds.StringMap<Bool>;

    var staticInits : Array<Void->Void>;

    var indentCount : Int;    

    public function new(api)
    {
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

    inline function genStaticFuncExpr(e:TypedExpr,name,cl:ClassType, metas:Array<MetadataEntry>, extraArgs:Array<String>, indent:String = "\t") 
    {
        var context = PrintContexts.create(indent);
        

        var expr = switch (e.expr) {
            case TFunction(f):

                // f.args = extraArgs.map(function (s) return { value : null, name : s, opt : false, type:null}).concat(f.args);
                // { expr : EFunction(cl.name + "_statics_" + name, f), pos : expr.pos };
                var args = extraArgs.map(function (s) return { value : null, v : { id : 0, name : s, t : TDynamic(null), capture : false, extra : null}}).concat(f.args);
                { expr : TypedExprDef.TFunction({ args : args, t : f.t, expr : f.expr}), pos : e.pos, t : e.t };
            case _ : e;
        }
        var expr1 = PythonTransformer.transform(expr);

        var fieldName = cl.name + "_statics_" + name;

        var exprString = switch (expr1.expr) {
            case TFunction(f):
                new PythonPrinterTyped().printFunction(f,context, fieldName);
                    
            case _ : 
                fieldName + " = " + new PythonPrinterTyped().printExpr(expr1,context);
        }

        print(indent);

        printPyMetas(metas, "");
        
        print(exprString); 
        newline();
        print(getPath(cl) + "." + name + " = " + fieldName);
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

    inline function genFuncExpr(e:TypedExpr,name, metas:Array<MetadataEntry>, extraArgs:Array<String>, indent:String = "\t") 
    {
        var context = PrintContexts.create(indent);

        var expr:TypedExpr = switch (e.expr) {
            case TFunction(f):
                
                var args = extraArgs.map(function (s) return { value : null, v : { id : 0, name : s, t : TDynamic(null), capture : false, extra : null}}).concat(f.args);
                { expr : TFunction({ args : args, t : f.t, expr : f.expr}), pos : e.pos, t : e.t };
            case _ : e;
        }

        var expr1 = PythonTransformer.transform(expr);

        var fieldName = name;

        var exprString = switch (expr1.expr) {
            case TFunction(f):
                new PythonPrinterTyped().printFunction(f,context, fieldName);
                    
            case _ : 
                fieldName + " = " + new PythonPrinterTyped().printExpr(expr1,context);
        }

        printPyMetas(metas, indent);
        print(indent);
        print(exprString); 
    }

    inline function genExpr(e:TypedExpr, ?field:String = "", ?indent:String = "")
    {
        var context = PrintContexts.create("\t" + indent);
       
        var e = switch (e.expr) {

            case TFunction(f):
                trace("here");
                { expr : TBlock([e]), t : e.t, pos : e.pos};
            case _ : e;

        }

        var expr2 = PythonTransformer.transformToValue(e);

        var name = "_hx_init_" + field.split(".").join("_");
        function transformExpr(expr2:TypedExpr) return switch (expr2.expr) 
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
        var r = transformExpr(expr2);

        if (r.e1 != null) {
            var exprString1 = new PythonPrinterTyped().printExpr(r.e1,context);
            var exprString2 = new PythonPrinterTyped().printExpr(r.e2,context);

            print(indent + "def " + name + "():\n\t" + exprString1 + "\n");
            print(indent + field + " = " + exprString2);

        } else {
            var exprString2 = new PythonPrinterTyped().printExpr(r.e2,context);
            if (field == "") print(exprString2);
            else print(indent + field + " = " + exprString2);
        }
        
    }

    function handleKeywords(p : String)
    {
        return PythonPrinterTyped.handleKeywords(p);
    }

    //function genPathHacks(t:Type)
    //{
    //    switch( t ) {
    //        case TInst(c, _):
    //            var c = c.get();
    //            getPath(c);
    //        case TEnum(r, _):
//
//    //            var e = r.get();
//
//    //            getPath(e);
//    //        default:
//    //            //trace(t);
//    //    }
    //}

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

    function getPath(t : BaseType)
    {
        return return new PythonPrinterTyped().printBaseType(t, PrintContexts.create(""), true);
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

    



    function genClassConstructor (c:ClassType, cType:Type) 
    {
        if(c.constructor != null)
        {
            var memberInit = [];
            for(f in c.fields.get())
            {
                switch( f.kind ) {
                    case FVar(r, _):

                        if(r == AccResolve) continue;
                        switch (r) {
                            case AccCall:
                            default: 
                                if (f.expr() == null) {
                                    memberInit.push({name:f.name, pos : f.pos, t:f.type, cf : f});
                                }
                        }
                    case _:
                }
            }
            newline();
            
            var pyMetas = c.constructor.get().meta.get().filter(function (m) return m.name == ":python");

            var constructorExpr = c.constructor.get().expr();

            if (memberInit.length > 0) 
            {
                switch (constructorExpr.expr) {
                    case TFunction(f):
                        var memberData = memberInit.map(function (x) return {v : { id : 0, name : x.name, t : x.t, capture : false, extra : null}, expr : { expr : TConst(TNull), t : x.t, pos : x.pos}, cf: x.cf});

                        
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

    function genClass(c : ClassType, cType:Type, cRef:Ref<ClassType>)
    {
        print("# print " + c.module + "." + c.name + "\n");

        if (!c.isExtern) 
        {
            api.setCurrentClass(c);

            var p = getPath(c);
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

            genClassConstructor(c, cType);

            
            var fields = [];
            var props = [];
            var methods = [];
            var usePass = c.constructor != null;

            for(f in c.fields.get())
            {
                switch( f.kind ) {

                    case FVar(r, _):
                        if(r == AccResolve) continue;
                        switch (r) {
                            case AccCall: props.push(f.name);
                            default: fields.push(f.name);
                        }
                    case _:
                        methods.push(f.name);
                        usePass = false;
                }
                genClassField(c, p, f);
            }
            
            if (c.isInterface) usePass = true;
            
            if (usePass) print("\tpass\n");

            

            closeBlock();

            
            
            genClassData (c, fields, props, methods, superClass, interfaces, p, pName);
            
            
            genClassStatics(c, p);
            
        }

        genClassInit(c);
        
    }

    function genClassData (c:ClassType, fields, props, methods, superClass, interfaces, p, pName) 
    {
        var statics = [for(f in c.statics.get()) f.name];
        //trace("len statics:" + c.statics.get().length);
        var fieldChar = fields.length > 0 ? '"' : '';
        var propsChar = props.length > 0 ? '"' : '';
        var methodsChar = methods.length > 0 ? '"' : '';
        print("\n\n" + p + "._hx_class = " + p + "\n");
        print(p + "._hx_class_name = \"" + pName + "\"\n");
        print("\n");
        print("_hx_classes['" + pName + "'] = " + p + "\n");
        print("_hx_c."+p+" = "+p+"\n");
        //print("\n\n" + p + "._hx_name = " + p + "\n");
        print(p + "._hx_fields = [" + fieldChar + fields.join('","') + fieldChar + "]\n");
        print(p + "._hx_props = [" + propsChar + props.join('","') + propsChar + "]\n");
        print(p + "._hx_methods = [" + methodsChar + methods.join('","') + methodsChar + "]\n");
        var staticsChar = statics.length > 0 ? '"' : '';
        print(p + "._hx_statics = [" + staticsChar + statics.join('","') + staticsChar + "]\n");
        print(p + "._hx_interfaces = [" + interfaces.join(',') + "]\n");
        if (superClass != null) {
            print(p + "._hx_super = " + superClass + "\n");
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
                var trans = PythonTransformer.transform(t);
                
                print(new PythonPrinterTyped().printExpr(trans,PrintContexts.create("")));
                print("\n");
            });
        }
    }

    function genEnum(e : EnumType)
    {
        var p = getPath(e);
        var pName = getFullName(e);

        printLine('class $p(_hx_Enum):');
        printLine('\tdef __init__(self, t, i, p):');
        printLine('\t\tsuper($p,self).__init__(t, i, p)');

        newline();

        var enumConstructs = [];
        for(c in e.constructs.keys())
        {

            var c = e.constructs.get(c);

            enumConstructs.push(c.name);

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
        var enumConstructsStr = fix + enumConstructs.join('","') + fix;

        printLine('$p._hx_constructs = [$enumConstructsStr]');
        printLine('$p._hx_class = $p');
        printLine('$p._hx_class_name = "$pName"');
        printLine('_hx_classes["$pName"] = $p');
        printLine('_hx_c.$p = $p');
    }

    function genType(t : Type)
    {
        switch( t ) {
            case TInst(c, _):
                var c1 = c.get();
                // don't generate js classes
                if (c1.pack.length > 0 && c1.pack[0] == "js") return;
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

    function genTypes () 
    {
        for(t in api.types) 
        {
            switch( t ) {
                case TInst(c, _):
                    if (!isBootClass(c.get())) {
                        genType(t);
                    }           
                case _ : genType(t);
            }
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

    public function generate()
    {
        genBootCode();

        genBootClass();

        
        genTypes();
                
        genStaticInits();
        
        
        genMain();
        
        writeFile();
        
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
