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

    

    public function new(api)
    {

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

    inline function genStaticFuncExpr(e,name,cl:ClassType, extraArgs:Array<String>, indent:String = "\t") {


        var context = PrintContexts.create(indent);
        var expr = haxe.macro.Context.getTypedExpr(e);
        var expr = switch (expr.expr) {
            case EFunction(_,f):

                f.args = extraArgs.map(function (s) return { value : null, name : s, opt : false, type:null}).concat(f.args);
                { expr : EFunction(cl.name + "_statics_" + name, f), pos : expr.pos };
            case _ : expr;
        }
        var expr1 = PythonTransformer.transform(expr);
        //var exprString = new PythonPrinter().printExpr(expr,context);

        var exprString = new PythonPrinter().printExpr(expr1,context);

        print(indent);
        print(exprString); 

        print("\n");
        print(getPath(cl) + "." + name + " = " + cl.name + "_statics_" + name);
    }

    inline function genFuncExpr(e,name, extraArgs:Array<String>, indent:String = "\t") {

        var context = PrintContexts.create(indent);
        var expr = haxe.macro.Context.getTypedExpr(e);
        var expr = switch (expr.expr) {
            case EFunction(_,f):
                f.args = extraArgs.map(function (s) return { value : null, name : s, opt : false, type:null}).concat(f.args);
                { expr : EFunction(name, f), pos : expr.pos };
            case _ : expr;
        }
        var expr1 = PythonTransformer.transform(expr);

        var exprString = new PythonPrinter().printExpr(expr1,context);

        print(indent);
        print(exprString); 
    }

    inline function genExpr(e)
    {
        var context = PrintContexts.create("\t");
        var expr = haxe.macro.Context.getTypedExpr(e);
        var expr2 = PythonTransformer.transform(expr);
        var exprString = new PythonPrinter().printExpr(expr,context);

        var exprString2 = new PythonPrinter().printExpr(expr2,context);
        print(exprString);
        print("#transformed");
        print(exprString2);
    }

    function field(p : String)
    {
        return PythonPrinter.handleKeywords(p);
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

       return pack1 + modulePrefix1 + moduleStr + typePrefix1 + t.name;
    }

    function getPath(t : BaseType)
    {
        var fullPath = t.name;

        //trace(t.module);
        //trace(t.name);
        //trace(t.pack);

       if(t.pack.length > 0 || t.module != t.name || t.isPrivate)
       {

           var hasPack = t.pack.length > 0;
           var pack1 = t.pack.join(".");
           var pack2 = t.pack.join("_");

           var moduleName = { var p = t.module.split("."); p[p.length-1];};
           
           var hasModule = (moduleName != t.name);



           var hasModulePrefix = (hasPack && hasModule);
           var hasTypePrefix = (hasPack || hasModule);

           var modulePrefix1 = hasModulePrefix ? "." : "";
           var modulePrefix2 = hasModulePrefix ? "_" : "";

           var typePrefix1 = hasTypePrefix ? "." : "";
           var typePrefix2 = hasTypePrefix ? "_" : "";

           var moduleStr = hasModule ? moduleName : "";

           var native = t.meta.get().filter(function (e) return e.name == ":native");
           var nativeName = if (native.length == 1 && native[0].params.length == 1) {
            switch (native[0].params[0].expr) {
                case EConst(CString(nativeName)): nativeName;
                case _  : null;
            }
           } else {
            null;
           }


            

           var dotPath = if (nativeName != null) {
            ((t.module.length > 0) ? (t.module + ".") : "") + nativeName;
           } else {
            pack1 + modulePrefix1 + moduleStr + typePrefix1 + t.name;
           }

           fullPath = if (nativeName != null) {
             nativeName;
           } else {
              pack2 + modulePrefix2 + moduleStr + typePrefix2 + t.name; 
           }
           
           dotPath = dotPath.split("_" + moduleName + ".").join("");
           
           
           //trace(dotPath);
           //trace(fullPath);
           if(!PythonPrinter.pathHack.exists(dotPath))
               PythonPrinter.pathHack.set(dotPath, fullPath);

            if (!t.isPrivate) {
                
               var typePrefix3 = hasPack ? "." : "";
               var dotPath3 = if (nativeName != null) {
                 ((t.module.length > 0) ? (t.module + ".") : "") + nativeName;
               } else {
                pack1 + typePrefix3 + t.name;
               }
               
               //trace(dotPath3);
               if(!PythonPrinter.pathHack.exists(dotPath3))
                  PythonPrinter.pathHack.set(dotPath3, fullPath);
            }
       }

        return fullPath;
    }

    function checkFieldName(c : ClassType, f : ClassField)
    {
        if(forbidden.exists(f.name))
            Context.error("The field " + f.name + " is not allowed in Dart", c.pos);
    }

    function genClassField(c : ClassType, p : String, f : ClassField)
    {
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

                genFuncExpr(e, field, ["self"]);
                newline();
            default:
                print('\t# var $field = ');
                genExpr(e);
                
                newline();
        }
        newline();
    }

    function genStaticField(c : ClassType, p : String, f : ClassField)
    {
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

                genStaticFuncExpr(e, field, c, [], "");
                newline();
            default:
                print('$p.$field = ');
                genExpr(e);
                
                newline();
//                statics.add( { c : c, f : f } );
        }
    }

    function genClass(c : ClassType)
    {

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

            if(c.constructor != null)
            {
                usePass = false;
                newline();
                
                //print('"""\n');
                //var g = api.generateStatement(c.constructor.get().expr());
                //print(g);
                //print('\n"""\n');

                //print('\tdef __init__(self');

                
                genFuncExpr(c.constructor.get().expr(),"__init__", ["self"]);
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
                    
                    default:
                        methods.push(f.name);
                        usePass = false;
                }
                genClassField(c, p, f);
            }
            
            if (usePass) print("\tpass\n");

            var statics = [];
            for(f in c.statics.get()) {
                statics.push(f.name);
            }
            

            closeBlock();

            print("\n");
            //trace("len statics:" + c.statics.get().length);
            for(f in c.statics.get()) {
                //trace(c.name + "::" +f.name);
                genStaticField(c, p, f);
            }
            var fieldChar = fields.length > 0 ? '"' : '';
            var propsChar = props.length > 0 ? '"' : '';
            var methodsChar = methods.length > 0 ? '"' : '';
            print("\n\n" + p + "._hx_class = " + p + "\n");
            print(p + "._hx_class_name = \"" + pName + "\"\n");
            print("_hx_classes['" + pName + "'] = " + p + "\n");
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
            print("\n");
        }
        if (c.init != null) {
            var t = haxe.macro.Context.getTypedExpr(c.init);
            var trans = PythonTransformer.transform(t);
            print(new PythonPrinter().printExpr(trans,PrintContexts.create("")));
            print("\n");
        }

    }

    static var firstEnum = true;

    function genEnum(e : EnumType)
    {
        if(firstEnum)
        {
            generateBaseEnum();
            firstEnum = false;
        }

        var p = getPath(e);
        var pName = getFullName(e);

        print('class $p(Enum):');
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
                    var sargs = args.map(function(a) return a.name).join(",");
                    print('def _${p}_statics_${f} ($sargs): \n\treturn $p("${c.name}", ${c.index}, [$sargs])\n');
                    print('$p.$f = _${p}_statics_${f}');
                default:
                    print('$p.$f = $p(${api.quoteString(c.name)}, ${c.index}, list())');
            }
            newline();
        }
        var fix = enumConstructs.length > 0 ? '"' : '';
        var enumConstructsStr = fix + enumConstructs.join('","') + fix;

        print('$p.constructs = [$enumConstructsStr]');
        newline();
        print(p + "._hx_class_name = \"" + pName + "\"\n");

        print("_hx_classes['" + pName + "'] = " + p);
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
        print('$p$f = ');
        genExpr(cf.expr());
        newline();
    }

    function genType(t : Type)
    {
        switch( t ) {
            case TInst(c, _):
                var c = c.get();
                genClass(c);

            case TEnum(r, _):
                var e = r.get();
                if(! e.isExtern) genEnum(e);
            default:
        }
    }

    function generateBaseEnum()
    {
        print("class Enum:
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
        print("class AnonObject(object):
    def __init__(self, **kwargs):
        self.__dict__.update(kwargs)\n");

    }

    public function generate()
    {

        print("_hx_classes = dict()\n");
        print("class Int:
    pass\n");
        print("_hx_classes['Int'] = Int\n");
        print("class Float:
    pass\n");
        print("_hx_classes['Float'] = Float\n");
        print("class Dynamic:
    pass\n");
        print("_hx_classes['Dynamic'] = Dynamic\n");

        print("import math as _hx_math\n");

        PythonPrinter.pathHack.set("StdTypes.Int", "Int");
        PythonPrinter.pathHack.set("StdTypes.Float", "Float");
        PythonPrinter.pathHack.set("StdTypes.Dynamic", "Dynamic");

        generateBaseException();
        generateBaseAnon();

        //print("String = str\n");

        for(t in api.types)
            genPathHacks(t);

        for(t in api.types)
            genType(t);

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
	public static function use() {
		Compiler.setCustomJSGenerator(function(api) new PythonGenerator(api).generate());
	}
	#end

}
