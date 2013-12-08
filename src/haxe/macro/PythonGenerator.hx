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
package haxe.macro;

import haxe.macro.Type;
import haxe.macro.Expr;
import haxe.macro.PythonPrinter;
using Lambda;
import haxe.macro.PythonTransformer;
class PythonGenerator
{

    static var imports = [];

    var api : JSGenApi;
    var buf : StringBuf;
    var packages : haxe.ds.StringMap<Bool>;
    var forbidden : haxe.ds.StringMap<Bool>;

    var staticInits : Array<Void->Void>;

    

    public function new(api)
    {

        staticInits = [];
        //PythonPrinter.pathHack.set("String", "str");
        this.api = api;

        buf = new StringBuf();
        packages = new haxe.ds.StringMap();
        forbidden = new haxe.ds.StringMap();

        api.setTypeAccessor(getType);
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

    inline function newline()
    {
        print("\n");
        /*
        var x = indentCount;

        while(x-- > 0)
            print("\t");
        */
    }

    inline function genStaticFuncExpr(e:TypedExpr,name,cl:ClassType, metas:Array<MetadataEntry>, extraArgs:Array<String>, indent:String = "\t") {


        var context = PrintContexts.create(indent);
        //var expr = haxe.macro.Context.getTypedExpr(e);



        var expr = switch (e.expr) {
            case TFunction(f):

                // f.args = extraArgs.map(function (s) return { value : null, name : s, opt : false, type:null}).concat(f.args);
                // { expr : EFunction(cl.name + "_statics_" + name, f), pos : expr.pos };
                var args = extraArgs.map(function (s) return { value : null, v : { id : 0, name : s, t : TDynamic(null), capture : false, extra : null}}).concat(f.args);
                { expr : TypedExprDef.TFunction({ args : args, t : f.t, expr : f.expr}), pos : e.pos, t : e.t };
            case _ : e;
        }
        var expr1 = PythonTransformer.transform(expr);
        //var exprString = new PythonPrinter().printExpr(expr,context);

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

        print("\n");
        print(getPath(cl) + "." + name + " = " + fieldName);
    }

    public function printPyMetas (metas:Array<MetadataEntry>, indent:String) {
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
        //var expr = haxe.macro.Context.getTypedExpr(e);
        var expr:TypedExpr = switch (e.expr) {
            case TFunction(f):
                //trace(f);
                var args = extraArgs.map(function (s) return { value : null, v : { id : 0, name : s, t : TDynamic(null), capture : false, extra : null}}).concat(f.args);
                { expr : TFunction({ args : args, t : f.t, expr : f.expr}), pos : e.pos, t : e.t };
            case _ : e;
        }
        //var expr = haxe.macro.Context.getTypedExpr(e);
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
        //var expr = haxe.macro.Context.getTypedExpr(e);
        
        //trace(ExprTools.toString(Context.getTypedExpr(e)));
        var e = switch (e.expr) {

            case TFunction(f):
                trace("here");
                { expr : TBlock([e]), t : e.t, pos : e.pos};
            case _ : e;

        }

        var expr2 = PythonTransformer.transformToValue(e);
        //trace(ExprTools.toString(Context.getTypedExpr(expr2)));
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
        //var exprString = new PythonPrinter().printExpr(expr,context);

        
        //print(exprString);
        //print("#transformed");

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

    function field(p : String)
    {
        return PythonPrinterTyped.handleKeywords(p);
//        return api.isKeyword(p) ? '$' + p : "" + p;
    }

    function genPathHacks(t:Type)
    {
        switch( t ) {
            case TInst(c, _):
                var c = c.get();
                getPath(c);
            case TEnum(r, _):

                var e = r.get();

                getPath(e);
            default:
                //trace(t);
        }
    }

    function getFullName (t:BaseType) {
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
        return return new haxe.macro.PythonPrinterTyped().printBaseType(t, PrintContexts.create(""), true);
        
    }

    function checkFieldName(c : ClassType, f : ClassField)
    {
        if(forbidden.exists(f.name))
            Context.error("The field " + f.name + " is not allowed in Dart", c.pos);
    }

    function genClassField(c : ClassType, p : String, f : ClassField)
    {
        //trace("gen instance " + f.name);
        checkFieldName(c, f);
        var field = field(f.name);
        var e = f.expr();
        if(e == null)
        {
            print('\t# var $field');
        }
        else switch( f.kind )
        {
            case FMethod(_):
                //print('"""\n');
                //var g = api.generateStatement(e);
                //print(g);
                //print('\n"""\n');

                //print('\tdef $field(self');
                var pyMetas = f.meta.get().filter(function (m) return m.name == ":python");
                genFuncExpr(e, field, pyMetas, ["self"]);
                newline();
            default:
                
                genExpr(e, '# var $field', '\t');
                
                newline();
        }
        newline();
    }

    function genStaticField(c : ClassType, p : String, f : ClassField)
    {
        //trace("gen static " + f.name);
        checkFieldName(c, f);

        var p = getPath(c);
        //trace(f.name);
        var field = field(f.name);
        var e = f.expr();
        if(e == null)
        {
            print('$p.$field = None;\n'); //TODO(av) initialisation of static vars if needed
            
        }
        else switch( f.kind ) {
            case FMethod(_):
                //print('"""\n');
                //var g = api.generateStatement(e);
                //print(g);
                //print('\n"""\n');
                //print('\tdef $field(');
                
                var pyMetas = f.meta.get().filter(function (m) return m.name == ":python");
                //trace(TypedExprTools.toString(e));
                genStaticFuncExpr(e, field, c, pyMetas, [], "");
                newline();
            default:
                
                genExpr(e, '$p.$field');
                
                newline();
//                statics.add( { c : c, f : f } );
        }
    }

    function genClass(c : ClassType, cType:Type, cRef:Ref<ClassType>)
    {
        //trace("gen:" + c.pack.join(".") + "." + c.name);
        
        var initApplied = false;

        print("# print " + c.module + "." + c.name + "\n");

        if (c.pack.length > 0 && c.pack[0] == "js") return;

        

        if (!c.isExtern) 
        {

        

            for(meta in c.meta.get())
            {
                // if(meta.name == ":library" || meta.name == ":feature")
                // {

                //     for(param in meta.params)
                //     {
                //         switch(param.expr){
                //             case EConst(CString(s)):
                //                 if(Lambda.indexOf(imports, s) == - 1)
                //                     imports.push(s);
                //             default:
                //         }

                //     }
                // }

                // if(meta.name == ":remove")
                // {
                //     return;
                // }
            }

            api.setCurrentClass(c);

            var p = getPath(c);
            var pName = getFullName(c);
            print('class $p');
            //trace(p);

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
                //bases.push(inter);
                interfaces.push(inter);
                //print(' implements $inter');
            }



            if (bases.length > 0) {
                print("(" + bases.join(",") + ")");
            } 
            print(":");
            

    //        var name = p.split(".").map(api.quoteString).join(",");

            
            openBlock();

            var usePass = true;
            var memberInit = [];
            for(f in c.fields.get())
            {
                
                //trace(f);    
                
                
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
            


            if(c.constructor != null)
            {
                usePass = false;
                newline();
                
                //print('"""\n');
                //var g = api.generateStatement(c.constructor.get().expr());
                //print(g);
                //print('\n"""\n');

                //print('\tdef __init__(self');

                var pyMetas = c.constructor.get().meta.get().filter(function (m) return m.name == ":python");

                var constructorExpr = c.constructor.get().expr();

                if (memberInit.length > 0) {
                    switch (constructorExpr.expr) {
                        case TFunction(f):
                            var memberData = memberInit.map(function (x) return {v : { id : 0, name : x.name, t : x.t, capture : false, extra : null}, expr : { expr : TConst(TNull), t : x.t, pos : x.pos}, cf: x.cf});

                            
                            var memberAssigns = memberData.map(function (x) {
                                var tthis = { expr : TConst(TThis), pos : x.expr.pos, t : cType }
                                //trace(TypedExprTools.toString(tthis));
                                // TODO remove FDynamic
                                var left = { expr : TField(tthis, FDynamic(x.cf.name)), pos : x.expr.pos, t : x.expr.t }
                                //trace(TypedExprTools.toString(left));
                                return { expr : TBinop(OpAssign, left, x.expr), pos : x.expr.pos, t : x.cf.type };
                            });

                            //trace(memberAssigns);


                            
                            var b1 = { expr : TBlock(memberAssigns.concat([f.expr])), pos : constructorExpr.pos, t: f.t};

                            f.expr = b1;
                            //trace("here we are");
                        case _ : 

                    }
                }
                //trace("now");
                //trace(c.name);
                genFuncExpr(constructorExpr,"__init__", pyMetas, ["self"]);
                //trace("now2");
                newline();
            }

            
            var fields = [];
            var props = [];
            var methods = [];

            for(f in c.fields.get())
            {
                
                //trace(f);    
                
                
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

            var statics = [];
            for(f in c.statics.get()) {
                statics.push(f.name);
            }
            

            closeBlock();

            

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
            
            staticInits.push(function () {

                for(f in c.statics.get()) {
                    //trace(c.name + "::" +f.name);
                    genStaticField(c, p, f);
                }
                if (c.init != null) {
                    initApplied = true;
                    var t = c.init;
                    var trans = PythonTransformer.transform(t);
                    print(new PythonPrinterTyped().printExpr(trans,PrintContexts.create("")));
                    print("\n");

                }

                print("\n");
            });
        }

        if (!initApplied && c.init != null) {
            staticInits.push(function () {
                initApplied = true;
                var t = c.init;
                var trans = PythonTransformer.transform(t);
                
                print(new PythonPrinterTyped().printExpr(trans,PrintContexts.create("")));
                print("\n");
            });
        }

    }

    static var firstEnum = true;

    function genEnum(e : EnumType)
    {
        

        var p = getPath(e);
        var pName = getFullName(e);

        print('class $p(_hx_Enum):');
        newline();
        print('\tdef __init__(self, t, i, p): \n\t\tsuper($p,self).__init__(t, i, p)');

        
        newline();
        print('\n');
        var enumConstructs = [];
        for(c in e.constructs.keys())
        {
            newline();
            var c = e.constructs.get(c);

            enumConstructs.push(c.name);

            var f = field(c.name);
            
            switch( c.type ) {
                case TFun(args, _):
                    var sargs = args.map(function(a) return PythonPrinter.handleKeywords(a.name)).join(",");
                    var sargs2 = args.map(function(a) return PythonPrinter.handleKeywords(a.name) + if (a.opt) " = None" else ""  ).join(",");
                    print('def _${p}_statics_${f} ($sargs2): \n\treturn $p("${c.name}", ${c.index}, [$sargs])\n');
                    print('$p.$f = _${p}_statics_${f}');
                default:
                    print('$p.$f = $p(${api.quoteString(c.name)}, ${c.index}, list())');
            }
            newline();
        }
        var fix = enumConstructs.length > 0 ? '"' : '';
        var enumConstructsStr = fix + enumConstructs.join('","') + fix;

        print('$p._hx_constructs = [$enumConstructsStr]');
        newline();
        print(p + "._hx_class = " + p + "\n");
        print(p + "._hx_class_name = \"" + pName + "\"\n");

        print("_hx_classes['" + pName + "'] = " + p+"\n");
        print("_hx_c."+p+" = " + p);
        newline();

//        var meta = api.buildMetaData(e);
//        if(meta != null)
//        {
//            print('$p.__meta__ = ');
//            genExpr(meta);
//            newline();
//        }

        newline();
    }


    function genStaticValue(c : ClassType, cf : ClassField)
    {
        var p = getPath(c);
        var f = field(cf.name);
        
        genExpr(cf.expr(),'$p$f');
        newline();
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
            default:
                //trace("not generated: " + t);
        }
    }

    function generateBaseEnum()
    {
        print("class _hx_Enum:
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
");                                 // String toString() { return haxe.Boot.enum_to_string(this); }
        newline();
        print("_hx_Enum._hx_class_name = 'Enum'\n");
        print("_hx_Enum._hx_class = _hx_Enum\n");
        print("_hx_classes['Enum'] = _hx_Enum\n");
        print("_hx_c._hx_Enum = _hx_Enum\n");
    }

    function generateBaseException()
    {
        print("
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

");                                 // String toString() { return haxe.Boot.enum_to_string(this); }
        newline();
    }

    function generateBaseAnon () {
        print("class _Hx_AnonObject(object):
    def __init__(self, **kwargs):
        self.__dict__.update(kwargs)\n");

    }

    public function generate()
    {
        generateBaseAnon();
        print("import builtins as _hx_builtin\n");
        print("_hx_classes = dict()\n");
        print("_hx_c = _Hx_AnonObject()\n");
        print("import functools as _hx_functools\n");
        print("class Int:
    pass\n");
        print("Int._hx_class_name = 'Int'\n");
        print("Int._hx_class = Int\n");
        print("_hx_classes['Int'] = Int\n");
        print("_hx_c.Int = Int\n");
        print("class Bool:
    pass\n");
        print("Bool._hx_class_name = 'Bool'\n");
        print("Bool._hx_class = Bool\n");

        print("_hx_classes['Bool'] = Bool\n");
        print("_hx_c.Bool = Bool\n");
        print("class Float:
    pass\n");
        print("Float._hx_class_name = 'Float'\n");
        print("Float._hx_class = Float\n");
        print("_hx_classes['Float'] = Float\n");
        print("_hx_c.Float = Float\n");
        print("class Dynamic:
    pass\n");
        print("Dynamic._hx_class_name = 'Dynamic'\n");
        print("Dynamic._hx_class = Dynamic\n");
        print("_hx_classes['Dynamic'] = Dynamic\n");
        print("_hx_c.Dynamic = Dynamic\n");
        print("class Class:
    pass\n");
        print("Class._hx_class_name = 'Class'\n");
        print("Class._hx_class = Class\n");
        print("_hx_classes['Class'] = Class\n");
        print("_hx_c.Class = Class\n");

        print("def _hx_rshift(val, n):\n\treturn (val % 0x100000000) >> n\n");
        print("def _hx_modf(a,b):\n\treturn float('nan') if (b == 0.0) else a % b if a > 0 else -(-a % b)\n");
        print("def _hx_array_get(a,i):\n\t");
        print("return a[i] if (i < len(a) and i > -1) else None\n");
        print("def _hx_array_set(a,i,v):\n\t");
        print("l = len(a)\n\t");
        print("while l < i:\n\t\t");
        print("a.append(None)\n\t\t");
        print("l+=1\n\t");
        print("if l == i:\n\t\t");
        print("a.append(v)\n\t");
        print("else:\n\t\t");
        print("a[i] = v\n\t");
        print("return v\n");
        print('
def _hx_toUpperCase (x):
    if (isinstance(x, str)):
        return x.upper()
    return x.toUpperCase()
');
        




        print("import math as _hx_math\n");
        generateBaseEnum();




        generateHxOverrides();
        generateBaseException();
        

        //print("String = str\n");



        for(t in api.types)
            genPathHacks(t);

        //trace(PythonPrinter.pathHack);

        var boot = Context.getType("python.Boot");

        genType(boot);

        for(t in api.types) {

            switch( t ) {
                case TInst(c, _):
                    var c = c.get();
                    if (!(c.name == "Boot" && c.pack.length == 1 && c.pack[0] == "python")) {
                        genType(t);
                    }           
                case _ : genType(t);
            }
            
        }

        for (s in staticInits) {
            s();
        }
        

        if(api.main != null)
        {
            

            genExpr(api.main);
            
            newline();
        }
        var importsBuf = new StringBuf();    //currently only works within a single output file. Needs to be handled module by module

        for(mpt in imports)
            importsBuf.add("import '" + mpt + "'");



        var combined = importsBuf.toString() + buf.toString();

        sys.io.File.saveContent(api.outputFile, combined);
    }
    function generateHxOverrides () 
    {
        var cl = "def HxOverrides_iterator(it):\n"
               + "\tif isinstance(it, list):\n"
               + "\t\treturn python_internal_ArrayImpl.iterator(it)\n"
               + "\telse:\n"
               + "\t\treturn it.iterator()\n";
        print(cl);
    }

    static var indentCount : Int = 0;

    function openBlock()
    {
        newline();
        
        indentCount ++;
        newline();
    }

    function closeBlock()
    {
        indentCount --;
        newline();
        
        newline();
        newline();
    }

    #if macro
	public static function use() 
    {
        Compiler.allowPackage("sys");
        Compiler.include("python.Boot");
		Compiler.setCustomJSGenerator(function(api) new PythonGenerator(api).generate());
	}
	#end

}
