
package python.gen;

using haxe.macro.ExprTools;

import haxe.macro.Expr;
import haxe.macro.Expr.Binop.OpAdd;
import haxe.macro.Expr.Binop.OpAssignOp;
import haxe.macro.Context;
import haxe.macro.Type;
using python.gen.Tools.TypedExprTools;
using haxe.macro.TypedExprTools;


typedef AdjustedExpr = {
	// the resulting Expr which should be valid for python generation
	expr: TypedExpr,
	// blocks contains expressions which must be placed before expr.
	blocks : Array<TypedExpr>,
	// returns the next free local identifier
	nextId: Void->String,
	// it is important to distinguish between expressions which must evaluate 
	// to a value and expressions which don't (statements) to generate valid python code.
	isValue:Bool
}


class PythonTransformer {

	// Public Interface, takes an Expression, adjust it, so that it can be easily generated to valid python code.

	public static function transform (e:TypedExpr):TypedExpr {
		
		return toExpr(transform1(liftExpr(e)));
	}

	public static function transformToValue (e:TypedExpr):TypedExpr {
		
		return toExpr(transform1(liftExpr(e,true)));
	}

	static function toExpr (e:AdjustedExpr):TypedExpr 
	{
		return if (e.blocks.length > 0) {
			switch (e.expr.expr) {
				case TBlock(exprs):
					{ expr : TBlock(e.blocks.concat(exprs)), pos : e.expr.pos, t : e.expr.t };
				case _ : 
					{ expr : TBlock(e.blocks.concat([e.expr])), pos : e.expr.pos, t : e.expr.t };
			}
		} else {
			e.expr;
		}
	}

	static function newCounter () 
	{
		var n = 0;
		return function () return "_hx_local_" + n++;
	}

	static function forwardTransform (e:TypedExpr, base:AdjustedExpr):AdjustedExpr 
	{
		return transform1(liftExpr(e, base.isValue, base.nextId, base.blocks.copy()));
	} 

	static function liftExpr (e:TypedExpr,?isValue:Bool = false, ?nextId:Void->String, ?blocks:Array<TypedExpr>):AdjustedExpr 
	{
		blocks = if (blocks == null) [] else blocks;

		var next = if (nextId == null) newCounter() else nextId;

		return {
			expr : e,
			blocks : blocks,
			isValue : isValue,
			nextId : next
		}
	}

	static function transformExpr (e:TypedExpr, ?isValue, ?next : Void->String, ?blocks:Array<TypedExpr>):AdjustedExpr 
	{
		return transform1(liftExpr(e,isValue,next, blocks));
	}
	
	static function transformExprsToBlock (exprs:Array<TypedExpr>, blockType:Type, isValue, pos:haxe.macro.Expr.Position, next:Void->String):AdjustedExpr	
	{
		if (exprs.length == 1) {
			return transformExpr(exprs[0], isValue, next);
		}
		var res = [];
		
		for (e in exprs) {
			
			var f = transformExpr(e,isValue, next);

			res = res.concat(f.blocks);
			res.push(f.expr);
		}
		return liftExpr({ expr : TBlock(res), t : blockType, pos : pos});
	}

	static function addNonLocalsToFunc (e:TypedExpr) 
	{
		return switch (e.expr) {
			case TFunction(f):
				// move default parameters into expr
							
				var first = true;
				var localVars = f.args.map(function (x) return x.v.name);
				var localAssigns = [];
				var nonLocals = [];

				function it(e:TypedExpr, lv:Array<String>) {

					function maybeContinue (x:TypedExpr) {
						if (x != null) {
							switch (x.expr) {
								case TFunction(_):
								case _ : x.iter(it.bind(_, lv.copy()));
							}
						}
					}
					if (e != null) {
						switch (e.expr) {
							case TVar(v, expr):
								maybeContinue(expr);
								lv.push(v.name);

							case TBinop(OpAssign,{ expr : TLocal({ name : a})}, e2): 
								if (!Lambda.has(lv, a)) {
									localAssigns.push(a); 
								}
								maybeContinue(e2);
								
								
							case TBinop(OpAssignOp(_),{ expr : TLocal({ name : a})},e2): 
								if (!Lambda.has(lv, a)) {
									localAssigns.push(a); 
								}
								maybeContinue(e2);
							case TUnop(OpIncrement, _, _):
								//trace(e.toString(true));
								//throw "invalid";
							case TUnop(OpDecrement, _, _):
								//trace(e.toString(true));
								//throw "invalid";
							case TFunction(_):
								
							case _ :
								e.iter(it.bind(_, lv.copy()));
						}
					}
				}
				f.expr.iter(it.bind(_, localVars));

				for (a in localAssigns) 
				{
					nonLocals.push(a);
				}
				if (nonLocals.length > 0) {

					var newFunctionExprs = [for( n in nonLocals) {
						var s = "nonlocal " + n; 
						var id = { expr : TLocal({ id : 0, name : "__python__", t : TDynamic(null), extra : null, capture : false }), pos : f.expr.pos, t : TDynamic(null)};
						var id2 = { expr : TLocal({ id : 0, name : s, t : TDynamic(null), extra : null, capture : false }), pos : f.expr.pos, t : TDynamic(null)};
						var e = { expr : TCall(id, [id2]), pos : f.expr.pos, t : TDynamic(null)};
						e;
					}].concat([f.expr]);

					f.expr = { expr : TBlock(newFunctionExprs), t : f.expr.t, pos : f.expr.pos };
				}
				e;
			case _ : throw "assert >> " + e.toString() + " << should be Function expr";
		}
	}

	static function createNonLocal (n:String, pos:Position) 
	{
		var s = "nonlocal " + n; 
		var id = toTExpr( TLocal({ id : 0, name : "__python__", t : TDynamic(null), extra : null, capture : false }), TDynamic(null), pos);
		var id2 = toTExpr( TLocal({ id : 0, name : s, t : TDynamic(null), extra : null, capture : false }), TDynamic(null), pos);
		var e = toTExpr(TCall(id, [id2]), TDynamic(null), pos);
		return e;
	}

	static function toTVar (n:String, t:Type, capture:Bool = false) 
	{
		var capture = if (capture == null) false else capture;
		return { id : 0, name : n, t : t, capture : capture, extra : null};
	}

	static function toTLocalExpr (n:String, t:Type, p:Position, capture:Bool = false):TypedExpr {
		return toTExpr(TLocal(toTVar(n, t, capture)), t, p);
	}

	static function varToTReturnExpr (n:String, t:Type, p:Position, capture:Bool = false):TypedExpr {
		return toTExpr(TReturn(toTExpr(TLocal(toTVar(n, t, capture)), t, p)), t, p);
	}

	static inline function toTExpr (e:TypedExprDef, t:Type, pos:Position) {
		return { expr : e, t : t, pos : pos};
	}

	static function idCall (id:String, idType:Type, retType:Type, pos:Position, capture:Bool = false) 
	{
		var id = toTLocalExpr(id, idType, pos, capture);
		return toTExpr(TCall(id, []), retType, pos);
	}

	static function exprsToFunc (exprs:Array<TypedExpr>, name:String, base:AdjustedExpr, cacheCall:Bool = false) 
	{
		var ex1 = exprs[exprs.length-1];
		var cacheVarName = base.nextId();
		var cacheVar = toTVar(cacheVarName, ex1.t, false);
		var cacheVarLocal = ex1.withExpr(TLocal(cacheVar));
		var cNull = ex1.withExpr(TConst(TNull));
		var cacheVarInit = ex1.withExpr(TVar(cacheVar, cNull));
		var cacheVarRet = ex1.withExpr(TReturn(cacheVarLocal));
		var cacheVarCheckNull = toTExpr(TBinop(OpNotEq, cacheVarLocal, cNull), ex1.t, ex1.pos);

		var cacheVarNonLocal = createNonLocal(cacheVarName, ex1.pos);
		var cacheVarCheckAndRet = ex1.withExpr(TIf(cacheVarCheckNull, cacheVarRet, null));

		if (exprs.length == 1) 
		{
			switch (exprs[0].expr) {
				case TFunction(f) if (f.args.length == 0): 
					var l = toTLocalExpr(name, f.t, f.expr.pos);
					var substitute = toTExpr(TCall(l, []), f.t, f.expr.pos);
					return liftExpr(substitute, [exprs[0]]);
				case _ : 
			}
		}
	
		function convertReturnExpr (expr:TypedExpr):Array<TypedExpr> 
		{
			return switch (expr.expr) 
			{
				case TFunction(f): 
					var ret = varToTReturnExpr(name, f.t, f.expr.pos);
					[expr, ret];
				case TBinop(OpAssign,l,r): 
					var cacheVarSet = toTExpr(TVar(cacheVar, l), l.t, l.pos);
					var r = toTExpr(TReturn(l), l.t, l.pos);

					if (cacheCall) [expr, cacheVarSet, r] else [expr, r];
				
				case x: 
					var cacheVarSet = toTExpr(TVar(cacheVar, expr), expr.t, expr.pos);
					var retExpr = toTExpr(TReturn(expr), expr.t, expr.pos);
					if (cacheCall) [cacheVarSet, retExpr] else [retExpr];
			}
		}

		var ex = if (exprs.length == 1) {
			var exs = convertReturnExpr(exprs[0]);
			if (exs.length > 1) {
				var u = if (cacheCall) [cacheVarNonLocal, cacheVarCheckAndRet] else [];
				toTExpr(TBlock( u.concat(exs) ), exs[exs.length-1].t, base.expr.pos);
			} else {
				exs[0];
			}

		} else {
			exprs = exprs.copy();

			var ret = exprs.pop();
			var u = if (cacheCall) [cacheVarNonLocal, cacheVarCheckAndRet] else [];
			var block = u.concat(exprs).concat(convertReturnExpr(ret));

			toTExpr(TBlock(block), block[block.length-1].t, base.expr.pos);
		}

		var fExpr = toTExpr(TFunction({ args : [], t : ex.t, expr : ex }), TFun([],ex.t), ex.pos);
		var fVar = toTVar(name, fExpr.t, false);
		
		var f = addNonLocalsToFunc(fExpr);
		
		var assign = toTExpr(TVar(fVar, f), ex.t, ex.pos);

		var substitute = toTExpr(TCall(toTExpr(TLocal(fVar),fExpr.t, ex.pos), []), ex.t, ex.pos);

		return if (cacheCall) liftExpr(substitute,  [cacheVarInit, assign])
			else liftExpr(substitute,  [assign]);
	}
	
	static var boolType = Context.typeof(macro true);
	static var voidType = Context.typeof(macro while (true) {});
	
	static function transformFunction (f:TFunc, e :AdjustedExpr, isValue:Bool) {
		
		var newExpr = f.expr;
		
		var assigns = [];

		for (a in f.args) {
			if (a.value != null) {

				var aLocal = toTExpr(TLocal(a.v), a.v.t, f.expr.pos);

				var aNull= toTExpr(TConst(TNull), a.v.t, f.expr.pos);

				var aCmp = toTExpr(TBinop(Binop.OpEq, aLocal, aNull), boolType, f.expr.pos);

				var aAssign = toTExpr(TBinop(Binop.OpAssign, aLocal, toTExpr(TConst(a.value), a.v.t, f.expr.pos)), a.v.t, f.expr.pos);

				var aIf = toTExpr(TIf(aCmp, aAssign, null), voidType, f.expr.pos);

				assigns.push(aIf);
			}
		}
		
		var body = switch [newExpr.expr, assigns] {
			case [TBlock([]),[]]:
				f.expr;
			case [TBlock([]),_]:
				toTExpr(TBlock(assigns), assigns[assigns.length-1].t, f.expr.pos);
			case [TBlock(exprs),_]:
				toTExpr(TBlock(assigns.concat(exprs)), exprs[exprs.length-1].t, f.expr.pos);
			case [_, []]:
				f.expr;
			case [_, _]:
				toTExpr(TBlock(assigns.concat([f.expr])), f.expr.t, f.expr.pos);
		}

		var e1 = toExpr(transformExpr(body, false, e.nextId));
		
		var fn = toTExpr(TFunction({ expr : e1, args : f.args, t : f.t}), e.expr.t, e.expr.pos);
		
		var fn = addNonLocalsToFunc(fn);

		return if (isValue) {
			var newName = e.nextId();
			var newVar = { id : 0, name : newName, t : f.t, capture : false, extra : null };
			var newLocal = toTExpr(TLocal(newVar), fn.t,fn.pos);
			var def = toTExpr(TVar(newVar,fn), fn.t, fn.pos);
			liftExpr( newLocal, false, e.nextId, [def]);
		} else {
			liftExpr(fn);
		}
	}

	static function transform1 (e:AdjustedExpr):AdjustedExpr
	{
		if (e == null) {
			throw "assert";
		}

		return switch [e.isValue, e.expr.expr] 
		{
			case [isValue, TBlock([x])]:
				transformExpr(x,isValue, e.nextId);

			case [_, x = TBlock([])]:
				liftExpr(toTExpr(TConst(TNull), e.expr.t, e.expr.pos));

			case [false, TBlock(exprs)]: 
				transformExprsToBlock(exprs, e.expr.t, false, e.expr.pos, e.nextId);

			case [true, TBlock(exprs)]:// transform block to function and call it

				var name = e.nextId();

				var exprs = exprs.copy();

				var ret = exprs.pop();

				var retEx = toTExpr(TReturn(ret), e.expr.t, e.expr.pos);

				var block = exprs.concat([retEx]);

				var myBlock = transformExprsToBlock(block, retEx.t, false, e.expr.pos, e.nextId);

				var fn = toTExpr(TFunction({ args:[], t: retEx.t, expr : myBlock.expr}), e.expr.t, e.expr.pos);

				var tVar = {id:0, name : name, t : retEx.t, capture : false, extra : null};

				var f = addNonLocalsToFunc(fn);

				var fnAssign = toTExpr(TVar(tVar, f), e.expr.t, e.expr.pos);

				var substitute = toTExpr(TCall(toTExpr(TLocal(tVar), e.expr.t, e.expr.pos), []), e.expr.t, e.expr.pos);

				liftExpr(substitute, [fnAssign]);

			case [false, TFunction(f)]:
				
				transformFunction(f, e, false);
				
			case [true, TFunction(f)]:
				transformFunction(f, e, true);
				
			case [_, TVar(v, e1)]:
				
				var b = [];

				var newExpr = if (e1 == null) {
					null;
				} else {
					var f = transformExpr(e1, true, e.nextId);
					b = b.concat(f.blocks);
					f.expr;
				}

				liftExpr(toTExpr(TVar(v, newExpr), e.expr.t, e.expr.pos), false, e.nextId, b);

			case [_, TFor(v, e1, e2)]:

				var e1New = transformExpr(e1, true, e.nextId, []);
				
				var e2New = toExpr(transformExpr(e2, false, e.nextId, []));

				var newExpr = toTExpr(TFor(v, e1New.expr, e2New), e.expr.t, e.expr.pos);

				liftExpr(newExpr, e1New.blocks);

			case [_,TReturn(x)] if (x == null): 
				e;
			
			case [_,TReturn({ expr : TFunction(f)})]:
				var n = e.nextId();
				
				var e1 = toExpr(transformExpr(f.expr,false, e.nextId));
					
				var f = toTExpr(TFunction({ expr : e1, t : f.t, args : f.args}), f.t, e.expr.pos);

				var f1 = addNonLocalsToFunc(f);

				var varN = { name : n, capture : false, extra : null, t : f1.t, id : 0};

				var f1Assign = toTExpr(TVar(varN, f1), f1.t, f1.pos);

				var varLocal = toTExpr(TLocal(varN), f1.t, f1.pos);

				liftExpr(toTExpr(TReturn(varLocal), varLocal.t, e.expr.pos), true, e.nextId, [f1Assign]);
			
			case [_,TReturn(x)]:
				var x1 = transformExpr(x,true, e.nextId, []);

				var res = if (x1.blocks.length > 0) {
					var f = exprsToFunc(x1.blocks.concat([x1.expr]), e.nextId(), e);
					liftExpr({ expr : TReturn(f.expr), pos : e.expr.pos, t : e.expr.t}, true, e.nextId, f.blocks);
				} else {
					liftExpr({ expr : TReturn(x1.expr), pos : e.expr.pos, t : e.expr.t}, true, e.nextId, []);
				}
				res;
			
			case [_,TParenthesis(e1)]:
				var newE1 = transformExpr(e1,true,e.nextId);
				var newP = { expr : TParenthesis(newE1.expr), pos : e.expr.pos, t : e.expr.t};
				liftExpr(newP, true, e.nextId, newE1.blocks);

			case [true, TIf(econd, eif, eelse)]:

				var econd1 = transformExpr(econd, true, e.nextId);
				
				var eif1 = transformExpr(eif, true, e.nextId);

				var eelse1 = if (eelse != null) {
					transformExpr(eelse, true, e.nextId);
				} else {
					null;
				}

				var blocks = [];
				var eif2 = if (eif1.blocks.length > 0) {
					
					function regular () {
						var fname = e.nextId();
						var f = exprsToFunc(eif1.blocks.concat([eif1.expr]), fname,e);
						
						blocks = blocks.concat(f.blocks);
						return f.expr;
					}

					if (eif1.blocks.length == 1) {
						switch (eif1.blocks[0].expr) {
							case TVar(_, { expr : TFunction( f) }):
								blocks.push(eif1.blocks[0]);
								eif1.expr;
							case _:regular();
						}
					} else regular();
					
					
				} else {
					eif1.expr;
				}
				var eelse2 = if (eelse1 != null && eelse1.blocks.length > 0) {
					function regular () {
						var fname = e.nextId();
						var f = exprsToFunc(eelse1.blocks.concat([eelse1.expr]), fname,e);
						blocks = blocks.concat(f.blocks);
						return f.expr;
					}

					if (eelse1.blocks.length == 1) {
						switch (eelse1.blocks[0].expr) {
							case TVar(v, { expr : TFunction( f) }):
								blocks.push(eelse1.blocks[0]);
								eelse1.expr;
							case _:
								regular();
						}
					} else {
						regular();
					}
				} else if (eelse1 != null) {
					eelse1.expr;
				} else {
					null;
				}

				var blocks = econd1.blocks.concat(blocks);
				if (blocks.length == 0) {
					var newIf = toTExpr(TIf(econd1.expr, eif2, eelse2), e.expr.t, e.expr.pos);

					var meta = { name : ":ternaryIf", pos : e.expr.pos, params:null};
					var ternary = toTExpr(TMeta(meta, newIf), e.expr.t, e.expr.pos);

					liftExpr(ternary, blocks);		
				} else {
					var newIf = toTExpr(TIf(econd1.expr, eif2, eelse2), e.expr.t, e.expr.pos);
					var f = exprsToFunc(blocks.concat([newIf]), e.nextId(), e);
					liftExpr(f.expr, f.blocks);		
				}
			
			case [false, TIf(econd, eif, eelse)]:

				var econd1 = transformExpr(econd, true, e.nextId);
				var eif1 = toExpr(transformExpr(eif, false, e.nextId));
				
				var eelse1 = if (eelse != null) {
					toExpr(transformExpr(eelse, false, e.nextId));
				} else {
					null;
				}

				var newIf = toTExpr(TIf(econd1.expr, eif1, eelse1), e.expr.t, e.expr.pos);
				liftExpr(newIf, false, e.nextId, econd1.blocks);
			
			case [_,TWhile({ expr : TParenthesis(u), t : t}, e1, flag)]:
				var newE = toTExpr(TWhile(u, e1, flag), t, e.expr.pos);
				forwardTransform(newE, e);
			
			case [false, TWhile(econd, e1, true)]:

				var econd1 = transformExpr(econd, true, e.nextId);
				var e11 = toExpr(transformExpr(e1, false, e.nextId));
				var newWhile = toTExpr(TWhile(econd1.expr, e11, true), e.expr.t, e.expr.pos);
				
				liftExpr(newWhile, false, e.nextId, econd1.blocks);
			
			case [true, TWhile(econd, e1, true)]:

				var econd1 = transformExpr(econd, true, e.nextId);

				var e11 = toExpr(transformExpr(e1, false, e.nextId));

				var newWhile = toTExpr(TWhile(econd1.expr, e11, true), e.expr.t, e.expr.pos);

				var newRet = toTExpr(TConst(TNull), e.expr.t, e.expr.pos);

				var f = exprsToFunc(econd1.blocks.concat([newWhile, newRet]), e.nextId(), e);
				liftExpr(f.expr, true, e.nextId, f.blocks);

			case [true, TSwitch(e1, cases,edef)]:
				
				var caseFunctions = [];

				function caseToIf (c:{values:Array<TypedExpr>, expr:TypedExpr}, ?eelse:TypedExpr) {

					var valReversed = c.values.copy();
					valReversed.reverse();

					var cond = null;

					for (v in valReversed) {
						var cond1 = toTExpr(TBinop(OpEq, e1, v), boolType, v.pos);
						if (cond == null) {
							cond =  cond1;
						} else {
							cond = toTExpr(TBinop(OpBoolOr, cond, cond1), boolType, v.pos);
						}
					}

					var name = e.nextId();
					var func = exprsToFunc([c.expr], name,e);
					caseFunctions = caseFunctions.concat(func.blocks);
					var call = func.expr;

					var eif = toTExpr(TIf(cond, call, eelse), e.expr.t, c.expr.pos);
					
					return eif;
				}
				
				var edef = if (edef != null && edef.expr == null) toTExpr(TBlock([]), e.expr.t, edef.pos) else edef;

				var res = null;
				var revCases = cases.copy();
				revCases.reverse();
				for (c in revCases) {
					if (res == null) {
						res = caseToIf(c, edef);
					} else {
						res = caseToIf(c, res);
					}
				}
				
				var res = if (res == null || res.expr == null) edef else res;

				var res = toTExpr(TBlock(caseFunctions.concat([res])), res.t, res.pos);

				forwardTransform(res, e);
				
			case [false, TSwitch(e1, cases,edef)]:
				
				function caseToIf (c:{values:Array<TypedExpr>, expr:TypedExpr}, ?eelse:TypedExpr) 
				{
					var valReversed = c.values.copy();
					valReversed.reverse();

					var cond = null;

					for (v in valReversed) {
						var cond1 = toTExpr(TBinop(OpEq, e1, v), boolType, v.pos);
						if (cond == null) {
							cond =  cond1;
						} else {
							cond = toTExpr(TBinop(OpBoolOr, cond, cond1), boolType, v.pos);
						}
					}
					var eif = { expr : TIf(cond, c.expr, eelse), pos : c.expr.pos, t: e.expr.t };
					
					return eif;
				}

				
				var revCases = cases.copy();
				revCases.reverse();

				var edef = if (edef != null && edef.expr == null) toTExpr(TBlock([]), e.expr.t, edef.pos) else edef;

				var res = null;
				for (c in revCases) {
					if (res == null) {
						res = caseToIf(c, edef);
					} else {
						res = caseToIf(c, res);
					}
				}
				
				var res = if (res == null || res.expr == null) edef else res;

				forwardTransform(res, e);
			
			case [_, TWhile(econd, e1, false)]:
				
				var notExpr = { expr : TUnop(OpNot, false, econd), pos : econd.pos, t : econd.t};
				var breakExpr = { expr : TBreak, pos : econd.pos, t : voidType}
				var ifExpr = { expr : TIf(notExpr, breakExpr, null), pos : econd.pos, t : voidType};

				var newE1 = switch (e1.expr) {
					case TBlock(exprs):
						{ expr : TBlock(exprs.concat([ifExpr])), pos : e.expr.pos, t : e.expr.t};
					case _: 
						{ expr : TBlock([e1].concat([ifExpr])), pos : e.expr.pos, t : e.expr.t};
				}
				var trueExpr = { expr : TConst(TBool(true)), pos : e.expr.pos, t: econd.t};
				var newExpr = { expr : TWhile(trueExpr, newE1, true), pos : e.expr.pos, t : e.expr.t};
				forwardTransform(newExpr, e);

			case [true, y = TUnop(OpIncrement, false, e1)]:
				
				var e1_ = transformExpr(e1, true, e.nextId);

				var plus = { expr : TBinop(OpAdd, e1_.expr, { expr : TConst(TInt(1)), t : e1.t, pos : e1.pos}), t : e1.t, pos : e1.pos};
				var assign = { expr : TBinop(OpAssign, e1_.expr, plus), pos : e1.pos, t : e1.t};
				
				if (true || e1_.blocks.length > 0) {
					var blocks = e1_.blocks.concat([assign]);
					var f = exprsToFunc(blocks, e.nextId(),e);
					liftExpr(f.expr, true, e.nextId, f.blocks);
				} else {
					liftExpr(assign, e1_.blocks);
				}
			
			case [false, TUnop(OpIncrement, false, e1)]:
				
				var e1_ = transformExpr(e1, true, e.nextId);

				var plus = { expr : TBinop(OpAdd, e1_.expr, { expr : TConst(TInt(1)), t : e1.t, pos : e1.pos}), t : e1.t, pos : e1.pos};
				var assign = { expr : TBinop(OpAssign, e1_.expr, plus), pos : e1.pos, t : e1.t};
				
				liftExpr(assign, e1_.blocks);
			
			case [isValue, TUnop(OpIncrement, true, e1)]:
				var one = { expr : TConst(TInt(1)), pos : e.expr.pos, t : e.expr.t };
				
				mkOpAssignOp(e, e1, OpAdd, one, isValue, true);

			case [_, TUnop(OpDecrement,false, e1)]:
				var plus = { expr : TBinop(Binop.OpSub, e1, { expr : TConst(TInt(1)), t : e1.t, pos : e1.pos}), t : e1.t, pos : e1.pos};
				var assign = { expr : TBinop(OpAssign, e1, plus), pos : e1.pos, t : e1.t};
				
				forwardTransform(assign,e);
			case [isValue, TUnop(OpDecrement,true, e1)]:
				var one = { expr : TConst(TInt(1)), pos : e.expr.pos, t : e.expr.t };
				
				mkOpAssignOp(e, e1, OpSub, one, isValue, true);

				// var id = e.nextId();
				// var resVar = { name : id, id : 0, extra : null, capture : false, t : e.expr.t };
				// var resLocal = { expr : TLocal(resVar), pos : e.expr.pos, t : e.expr.t};
				// var one = { expr : TConst(TInt(1)), pos : e.expr.pos, t : e.expr.t };
				// var minus = { expr : TBinop(OpSub, e1, one), pos : e.expr.pos, t: e.expr.t}

				// var varExpr = { expr : TVar(resVar, e1), pos : e.expr.pos, t : e.expr.t};
				// var assignExpr = { expr : TBinop(OpAssign,e1, minus), pos : e.expr.pos, t : e.expr.t};

				// var block = [varExpr, assignExpr, resLocal];
				// var blockExpr = { expr : TBlock(block), pos : e.expr.pos, t : e.expr.t};

				// forwardTransform(blockExpr,e);
			
			case [_, TUnop(op,false, e1)]:
				var e2 = transformExpr(e1, true, e.nextId);

				var newE = { expr : TUnop(op, false, e2.expr), pos : e.expr.pos, t : e.expr.t };
				liftExpr(newE,e2.blocks);
			
			case [true, TBinop(OpAssign,left,right)]:
				var ex = e.expr;
				var right1 = transformExpr(right, true, e.nextId);
				var left1 = transformExpr(left, true, e.nextId);

				var newEx = { expr : TBinop(OpAssign, left1.expr, right1.expr), t : e.expr.t, pos : e.expr.pos};

				var blocks = left1.blocks.concat(right1.blocks).concat([newEx]);

				var f = exprsToFunc(blocks, e.nextId(),e);
				liftExpr(f.expr, true, e.nextId, f.blocks);

			case [false, TBinop(OpAssign,left,right)]:
				var left1 = transformExpr(left, true, e.nextId);
				var right1 = transformExpr(right, true, e.nextId);

				var newEx = { expr : TBinop(OpAssign, left1.expr, right1.expr), pos : e.expr.pos, t : e.expr.t };

				liftExpr(newEx, false, e.nextId, left1.blocks.concat(right1.blocks));

			case [true, TBinop( OpAssignOp(x),left,right)]:
				var right1 = transformExpr(right, true, e.nextId);
				var one = right1.expr;
				
				var res = mkOpAssignOp(e, left, x, one, true, false);
				
				liftExpr(res.expr, true, e.nextId, right1.blocks.concat(res.blocks));
				// TODO fix this
				// var left1 = transformExpr(left, true, e.nextId);
				// var right1 = transformExpr(right, true, e.nextId);

				// var opExpr = { expr : TBinop(x, left1.expr, right1.expr), pos : e.expr.pos, t : e.expr.t };

				// var newEx = { expr : TBinop(OpAssign, left1.expr, opExpr), pos : e.expr.pos, t : e.expr.t };

				// var blocks = left1.blocks.concat(right1.blocks).concat([newEx]);

				// var f = exprsToFunc(blocks, e.nextId(),e);
				// liftExpr(f.expr, true, e.nextId, f.blocks);

			case [false, TBinop( OpAssignOp(x),left,right)]:
				// TODO fix this
				var left1 = transformExpr(left, true, e.nextId);
				var right1 = transformExpr(right, true, e.nextId);

				var opExpr = e.expr.withExpr( TBinop(x, left1.expr, right1.expr) ); 
 				var newEx =  e.expr.withExpr( TBinop(OpAssign, left1.expr, opExpr) );

				liftExpr(newEx, false, e.nextId, left1.blocks.concat(right1.blocks));
			
			case [true, TBinop(op,left,right)]:
				var ex = e.expr;
				var right1 = transformExpr(right, true, e.nextId);
				var left1 = transformExpr(left, true, e.nextId);

				var newEx = e.expr.withExpr( TBinop(op, left1.expr, right1.expr) );

				if (left1.blocks.length > 0 || right1.blocks.length > 0) {
					var blocks = left1.blocks.concat(right1.blocks);
					liftExpr(newEx, false, e.nextId, blocks);
				} else {
					liftExpr(newEx, false, e.nextId,[]);
				}
			
			case [_, TBinop( op,left,right)]:
				var right1 = transformExpr(right, true, e.nextId);
				var left1 = transformExpr(left, true, e.nextId);

				var ex = e.expr.withExpr( TBinop(op, left1.expr, right1.expr) );
				liftExpr(ex, false, e.nextId, left1.blocks.concat(right1.blocks));
			
			case [true, TThrow(x)]:
				var block = TBlock([e.expr, e.expr.withExpr( TConst(TNull) )]);

				var blockExpr = e.expr.withExpr( block );
				forwardTransform(blockExpr, e);				
			case [false, TThrow(x)]:
				var x = transformExpr(x, true, e.nextId);
				var ex = e.expr.withExpr( TThrow(x.expr) );
				liftExpr(ex, false, e.nextId, x.blocks);

			case [_, TNew(c, tp,params)]:
				
				var params1 = [for (p in params) transformExpr(p, true, e.nextId)];

				var blocks = [for (p in params1) for (b in p.blocks) b];

				var params2 = [for (p in params1) p.expr];

				var ex = e.expr.withExpr( TNew(c, tp, params2) );
				liftExpr(ex, false, e.nextId, blocks);
			
			case [_, TCall(x = { expr : TLocal({ name : "__python_for__"})},params)]:
			 	
			 	var e1 = transformExpr(params[0], false, e.nextId, []);
			 	
			 	var newCall = e.expr.withExpr( TCall(x, [e1.expr]) );

			 	liftExpr(newCall, []);
			
			case [_, TCall(e1,params)]:

				var e1 = transformExpr(e1, true, e.nextId);
				
				var params1 = [for (p in params) transformExpr(p, true, e.nextId)];

				var blocks = e1.blocks.concat([for (p in params1) for (b in p.blocks) b]);

				var params2 = [for (p in params1) p.expr];

				var ex = e.expr.withExpr( TCall(e1.expr, params2) );
				liftExpr(ex, false, e.nextId, blocks);
			
			case [true, TArray( e1, e2)]:
				var e1 = transformExpr(e1, true, e.nextId);
				var e2 = transformExpr(e2, true, e.nextId);

				var ex = e.expr.withExpr( TArray(e1.expr, e2.expr) );

				liftExpr(ex, e1.blocks.concat(e2.blocks));
			
			case [false, TTry( etry,catches)]:

				var try1 = transformExpr(etry, false, e.nextId);
				var catches1 = [for (c in catches) transformExpr(c.expr, false, e.nextId)];

				var blocks = try1.blocks.concat([for (c in catches1) for (b in c.blocks) b]);

				var newCatches = [for (i in 0...catches.length) { expr : catches1[i].expr, v : catches[i].v }];

				var ex = { expr : TTry(try1.expr, newCatches), pos : e.expr.pos, t : e.expr.t};
				
				liftExpr(ex, false, e.nextId, try1.blocks.concat(blocks));

			case [true, TTry( etry,catches)]:
				
				var pos = e.expr.pos;

				var id = e.nextId();

				var tempVar = { name : id, capture : false, extra : null, id : 0, t : e.expr.t };

				var tempVarDef = { expr : TVar(tempVar, null), pos : e.expr.pos, t : e.expr.t};

				var tempLocal = { expr : TLocal(tempVar), pos : e.expr.pos, t : e.expr.t };

				function mkTempVarAssign (right:TypedExpr) {
					return { expr : TBinop(OpAssign, tempLocal, right), t : e.expr.t, pos : e.expr.pos};
				}

				var etry1 = mkTempVarAssign(etry);

				var catches1 = [for (c in catches) { v : c.v, expr : mkTempVarAssign(c.expr) }];

				var newTry = { expr : TTry(etry1, catches1), pos : pos,t : e.expr.t };

				var block = [tempVarDef, newTry, tempLocal];

				var newBlock = { expr : TBlock(block) , t : e.expr.t, pos : e.expr.pos };

				forwardTransform(newBlock, e);			
			
			case [_, TObjectDecl( fields)]:
				var newFields = [for (f in fields) { name : f.name, ex: transformExpr(f.expr, true, e.nextId, [])}];

				var newFields1 = [for (f in newFields) { name : f.name, expr : f.ex.expr}];

				var blocks = [];
				for (f in newFields) {
					blocks = blocks.concat(f.ex.blocks);
				}

				var ex = { expr : TObjectDecl(newFields1), pos : e.expr.pos, t : e.expr.t };

				liftExpr(ex, blocks);

			case [_, TArrayDecl(values)]:
				var newExprs = [for (v in values) transformExpr(v, true, e.nextId, [])];

				var blocks = [for (v in newExprs) for (b in v.blocks) b];

				var vals = [for (v in newExprs) v.expr];

				var newE = { expr : TArrayDecl(vals), pos : e.expr.pos, t : e.expr.t};

				liftExpr(newE, blocks);
			
			case [_, TCast(ex, t)]:
				var ex1 = transformExpr(ex, true, e.nextId, []);

				liftExpr({ expr : TCast(ex1.expr, t), t : e.expr.t, pos : e.expr.pos}, ex1.blocks);

			case [_, TField( ex, f)]:
				var ex1 = transformExpr(ex, true, e.nextId, []);
	
				liftExpr({ expr : TField(ex1.expr, f), pos : e.expr.pos, t : e.expr.t}, ex1.blocks);
				
			case [flag, TMeta(m, e1)]:
				
				var ex1 = transformExpr(e1, flag, e.nextId, []);

				liftExpr({ expr : TMeta(m, ex1.expr), pos : e.expr.pos, t : e.expr.t}, ex1.blocks);

			case _ : 
				liftExpr(e.expr);
		}
	}

	static function mkOpAssignOp(e:AdjustedExpr, e1:TypedExpr, op:Binop, one:TypedExpr, isValue:Bool, post:Bool) 
	{
		var e1_ = transformExpr(e1, true, e.nextId);

		function handleAsLocal (tempLocal:TypedExpr) {
			var ex = e.expr;

			var resVar = { name : e.nextId(), id : 0, extra : null, capture : false, t : ex.t };
			
			var resLocal = e.expr.withExpr( TLocal(resVar) );
			
			var plus = ex.withExpr( TBinop(op, tempLocal, one) );

			var varExpr = ex.withExpr( TVar(resVar, tempLocal) );

			var assignExpr = ex.withExpr( TBinop(OpAssign,e1_.expr, plus) );

			var blocks = if (post) [varExpr, assignExpr, resLocal] else [assignExpr, tempLocal];

			var block = e1_.blocks.concat(blocks);
			
			return if (isValue) {
				var f = exprsToFunc(block, e.nextId(), e);
				liftExpr(f.expr, true, e.nextId, f.blocks);
			} else {
				var block = e1_.blocks.concat([assignExpr]);	
				transformExprsToBlock(block, ex.t, false, ex.pos, e.nextId);
				
			}
		}

		return switch (e1_.expr.expr) {
			case TArray({ expr : TLocal(_)},{ expr : TLocal(_)}):
				handleAsLocal(e1_.expr);
			case TArray(e1,e2):
				var id = e.nextId();

				var tempVarL = { name : id, id : 0, extra : null, capture : false, t : e1.t };
				var tempLocalL = e1.withExpr( TLocal(tempVarL) );
				var tempVarL = e1.withExpr( TVar(tempVarL, e1) );

				var id = e.nextId();

				var tempVarR = { name : id, id : 0, extra : null, capture : false, t : e2.t };
				var tempLocalR = e2.withExpr( TLocal(tempVarR) );
				var tempVarR = e2.withExpr( TVar(tempVarR, e2) );

				var id = e.nextId();

				var tempVar = { name : id, id : 0, extra : null, capture : false, t : e1_.expr.t };
				var tempLocal = e1_.expr.withExpr( TLocal(tempVar) );
				var tempVarExpr = e1_.expr.withExpr( TArray(tempLocalL, tempLocalR) );
				var tempVar = e1_.expr.withExpr( TVar(tempVar, tempVarExpr));

				var id = e.nextId();

				var plus = e.expr.withExpr( TBinop(op, tempLocal, one) );
				
				var assignExpr = e.expr.withExpr( TBinop(OpAssign,tempVarExpr, plus) );

				var block = e1_.blocks.concat([tempVarL, tempVarR, tempVar, assignExpr, if (post) tempLocal else tempVarExpr]);
				
				if (isValue) {
					var f = exprsToFunc(block, e.nextId(), e);
					liftExpr(f.expr, true, e.nextId, f.blocks);
				} else {
					transformExprsToBlock(block, e.expr.t, false, e.expr.pos, e.nextId);
				}

			case TField({ expr : TLocal(_)},fa):
				handleAsLocal(e1_.expr);

			case TField(e1,fa):

				var tempVarL = { name : e.nextId(), id : 0, extra : null, capture : false, t : e1.t };
				
				var tempLocalL = e1.withExpr( TLocal(tempVarL) );
				
				var tempVarL = e1.withExpr( TVar(tempVarL, e1) );


				var tempVar = { name : e.nextId(), id : 0, extra : null, capture : false, t : e1_.expr.t };
				var tempLocal = e1_.expr.with( TLocal(tempVar) );
				var tempVarExpr = e1_.expr.withExpr( TField(tempLocalL, fa) );
				var tempVar =     e1_.expr.withExpr( TVar(tempVar, tempVarExpr) );

				var plus = e.expr.withExpr( TBinop(op, tempLocal, one) );

				var assignExpr = e.expr.withExpr( TBinop(OpAssign,tempVarExpr, plus) );

				var block = e1_.blocks.concat([tempVarL, tempVar, assignExpr, if (post) tempLocal else tempVarExpr]);
				
				if (isValue) {
					var f = exprsToFunc(block, e.nextId(), e);
					liftExpr(f.expr, true, e.nextId, f.blocks);
				} else {
					transformExprsToBlock(block, e.expr.t, false, e.expr.pos, e.nextId);
				}
			case TLocal(v):
				handleAsLocal(e1_.expr);
			case _ : throw "assert";

		}
	}
}