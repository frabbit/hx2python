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
 */
package haxe.macro;

import haxe.macro.Type;
import haxe.macro.Expr;
using Lambda;

class DartGenerator
{

    static var imports = [];

    var api : JSGenApi;
    var buf : StringBuf;
    var packages : haxe.ds.StringMap<Bool>;
    var forbidden : haxe.ds.StringMap<Bool>;

    public function new(api)
    {
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
            default: throw "assert";
        };
    }

    inline function print(str)
    {
        buf.add(str);
    }

    inline function newline()
    {
        print("\n");
        var x = indentCount;

        while(x-- > 0)
            print("\t");
    }

    inline function genExpr(e)
    {
        var expr = haxe.macro.Context.getTypedExpr(e);
        var exprString = new DartPrinter().printExpr(expr);

        print(exprString);
    }

    function field(p : String)
    {
        return DartPrinter.handleKeywords(p);
//        return api.isKeyword(p) ? '$' + p : "" + p;
    }

    function getPath(t : BaseType)
    {
        return (t.pack.length == 0) ? t.name : t.pack.join("_") + "_" + t.name;
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
            print('var $field;');
        }
        else switch( f.kind )
        {
            case FMethod(_):
                print('$field');
                genExpr(e);
                newline();
            default:
                print('var $field = ');
                genExpr(e);
                print(";");
                newline();
        }
        newline();
    }

    function genStaticField(c : ClassType, p : String, f : ClassField)
    {
        checkFieldName(c, f);
        var field = field(f.name);
        var e = f.expr();
        if(e == null)
        {
            print('static var $field;'); //TODO(av) initialisation of static vars if needed
            newline();
        }
        else switch( f.kind ) {
            case FMethod(_):
                print('static $field ');
                genExpr(e);
                newline();
            default:
                print('static var $field = ');
                genExpr(e);
                print(";");
                newline();
//                statics.add( { c : c, f : f } );
        }
    }

    function genClass(c : ClassType)
    {

        for(meta in c.meta.get())
        {
            if(meta.name == ":library")
            {
                for(param in meta.params)
                {
                    switch(param.expr){
                        case EConst(CString(s)):
                            if(Lambda.indexOf(imports, s) == - 1)
                                imports.push(s);
                        default:
                    }

                }
            }

            if(meta.name == ":remove")
            {
                return;
            }
        }

        api.setCurrentClass(c);
        var p = getPath(c);

        if(c.isInterface)
            print('abstract class $p');
        else
            print('class $p');

        if(c.superClass != null)
        {
            var psup = getPath(c.superClass.t.get());
            print(' extends $psup');
        }

        if(c.interfaces.length > 0)
        {
            var me = this;
            var inter = c.interfaces.map(function(i) return me.getPath(i.t.get())).join(",");
            print(' implements $inter');
        }

//        var name = p.split(".").map(api.quoteString).join(",");


        openBlock();

        if(c.constructor != null)
        {
            newline();
            print('$p');
            genExpr(c.constructor.get().expr());
            newline();
        }

        for(f in c.statics.get())
            genStaticField(c, p, f);

        for(f in c.fields.get())
        {
            switch( f.kind ) {
                case FVar(r, _):
                    if(r == AccResolve) continue;
                default:
            }
            genClassField(c, p, f);
        }

        closeBlock();

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
        print('class $p extends Enum {');
        newline();
        print('$p(t, i, [p]):super(t, i, p);');
        newline();
        for(c in e.constructs.keys())
        {
            var c = e.constructs.get(c);
            var f = field(c.name);
            print('static final $f = ');
            switch( c.type ) {
                case TFun(args, _):
                    var sargs = args.map(function(a) return a.name).join(",");
                    print('($sargs) => new $p("${c.name}", ${c.index}, [$sargs]);');
                default:
                    print('new $p(${api.quoteString(c.name)}, ${c.index});');
            }
            newline();
        }
//        var meta = api.buildMetaData(e);
//        if(meta != null)
//        {
//            print('$p.__meta__ = ');
//            genExpr(meta);
//            newline();
//        }

        print("}");
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
                if(! c.isExtern) genClass(c);
            case TEnum(r, _):
                var e = r.get();
                if(! e.isExtern) genEnum(e);
            default:
        }
    }

    function generateBaseEnum()
    {
        print("abstract class Enum {
    String tag;
    int index;
    List params;
    Enum(this.tag, this.index, [this.params]);
    toString()=>params == null ? tag : tag + '(' + params.join(',') + ')';
}");                                 // String toString() { return haxe.Boot.enum_to_string(this); }
        newline();
    }

    public function generate()
    {
        if(api.main != null)
        {
            print("main()=>");
            genExpr(api.main);
            print(";");
            newline();
        }

        for(t in api.types)
            genType(t);

        var importsBuf = new StringBuf();    //currently only works within a single output file. Needs to be handled module by module

        for(mpt in imports)
            importsBuf.add("import '" + mpt + "';\n");

        var combined = importsBuf.toString() + buf.toString();

        sys.io.File.saveContent(api.outputFile, combined);
    }

    static var indentCount : Int = 0;

    function openBlock()
    {
        newline();
        print("{");
        indentCount ++;
        newline();
    }

    function closeBlock()
    {
        indentCount --;
        newline();
        print("}");
        newline();
        newline();
    }

    #if macro
	public static function use() {
		Compiler.setCustomJSGenerator(function(api) new DartGenerator(api).generate());
	}
	#end

}
