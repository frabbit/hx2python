
package python.gen;

import haxe.io.Path;
import haxe.macro.Context;

import haxe.ds.Option;
import haxe.macro.Expr.Position;
import haxe.macro.Type;
class Tools {
	
	public static function getFileContent (path:String, relative:Bool = false) 
	{
		var file = if (relative) 
		{
			var pos = Context.getPosInfos((macro null).pos);
			var dir = Path.directory(pos.file);
			var file = Path.addTrailingSlash(dir) + path;
			file;
		} 
		else 
		{
			path;
		}
		var content = sys.io.File.getContent(file);

		return content;
	}
}

class TypedExprTools 
{
	public static inline function withExpr (e:TypedExpr, td:TypedExprDef) {
		return toTExpr(td, e.t, e.pos);
	}

	public static inline function toTExpr (e:TypedExprDef, t:Type, pos:Position) {
		return { expr : e, t : t, pos : pos};
	}

	public static function iter(e:TypedExpr, f:TypedExpr -> Void):Void 
	{
	
		return switch(e.expr) {
			case TConst(_) | TLocal(_) | TBreak | TContinue | TTypeExpr(_):
			case TArray(e1, e2)
			   | TBinop(_, e1, e2)
			   | TFor(_, e1, e2)
			   | TWhile(e1, e2, _):
				f(e1);
				f(e2);
			
			case TEnumParameter(e1, _, _)
			   | TThrow(e1)
			   | TField(e1, _)
			   | TParenthesis(e1)
			   | TUnop(_, _, e1)
			   | TReturn(e1)
			   | TCast(e1, _):
				f(e1);

			case TArrayDecl(el)
			   | TBlock(el)
			   | TNew(_, _, el):

				for (e in el) f(e);
			case TObjectDecl(fl):
			
			case TCall(e1, el):
				f(e1);
				for (e in el) f(e);
			
			case TVar(v, e):
				f(e);
			 	//for (v in vl) f(v.expr);
			
			case TFunction(fn):
				f(fn.expr);
			case TIf(e1, e2, e3):
				f(e1);
				f(e2);
				f(e3);

			case TSwitch(e1, cases, e2):
				f(e1);
				for (c in cases) {
					f(c.expr);
					for (v in c.values) {
						f(v);
					}

				}
			case TPatMatch: 
			case TTry(e1, catches): 
				f(e1);
				for (c in catches) f(c.expr);
			 
			case TMeta(m, e1): 
				f(e1);
		}
	}
}