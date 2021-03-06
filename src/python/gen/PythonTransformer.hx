
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

	// Public Interface, takes an Expression and transforms it, so that it can be generated to valid python code.

	public static function transform (e:TypedExpr):TypedExpr 
	{
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
		var blocks = if (blocks == null) [] else blocks;

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
	// quite dirty at the moment
	static function addNonLocalsToFunc (e:TypedExpr) 
	{
		return switch (e.expr) {
			case TFunction(f):
				// move default parameters into expr
							
				var first = true;
				var localVars = f.args.map(function (x) return x.v.name);
				var nonLocals = new Map();

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
									nonLocals.set(a, true);
								}
								maybeContinue(e2);
								
								
							case TBinop(OpAssignOp(_),{ expr : TLocal({ name : a})},e2): 
								if (!Lambda.has(lv, a)) {
									nonLocals.set(a, true);
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

				var keys = nonLocals.keys();
				if (keys.hasNext()) 
				{
					var nonLocalExprs = [for(k in keys) createNonLocal(k, f.expr.pos)];
					var newFunctionExprs = nonLocalExprs.concat([f.expr]);
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

	static function exprsToFunc (exprs:Array<TypedExpr>, name:String, base:AdjustedExpr) 
	{
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
					
					var r = l.withExpr(TReturn(l));

					[expr, r];
				
				case x: 
					
					var retExpr = expr.withExpr(TReturn(expr));
					[retExpr];
			}
		}

		var ex = if (exprs.length == 1) {
			var exs = convertReturnExpr(exprs[0]);
			if (exs.length > 1) {
				toTExpr(TBlock( exs ), exs[exs.length-1].t, base.expr.pos);
			} else {
				exs[0];
			}

		} else {
			exprs = exprs.copy();

			var ret = exprs.pop();
			
			var block = exprs.concat(convertReturnExpr(ret));

			toTExpr(TBlock(block), block[block.length-1].t, base.expr.pos);
		}

		var fExpr = toTExpr(TFunction({ args : [], t : ex.t, expr : ex }), TFun([],ex.t), ex.pos);
		var fVar = toTVar(name, fExpr.t, false);
		
		var f = addNonLocalsToFunc(fExpr);
		
		var assign = ex.withExpr(TVar(fVar, f));

		var substitute = toTExpr(TCall(toTExpr(TLocal(fVar),fExpr.t, ex.pos), []), ex.t, ex.pos);

		return liftExpr(substitute, [assign]);
	}
	
	static var boolType = Context.typeof(macro true);
	static var voidType = Context.typeof(macro while (true) {});
	
	static function transformFunction (f:TFunc, e :AdjustedExpr, isValue:Bool) 
	{
		
		var assigns = [];

		var fpos = f.expr.pos;

		for (a in f.args) {
			if (a.value != null) {

				var t = a.v.t;

				var aLocal = toTExpr(TLocal(a.v), t, fpos);

				var aNull= toTExpr(TConst(TNull), t, fpos);

				var aCmp = toTExpr(TBinop(Binop.OpEq, aLocal, aNull), boolType, fpos);

				var aAssign = toTExpr(TBinop(Binop.OpAssign, aLocal, toTExpr(TConst(a.value), t, fpos)), t, fpos);

				var aIf = toTExpr(TIf(aCmp, aAssign, null), voidType, fpos);

				assigns.push(aIf);
			}
		}
		
		var body = switch [f.expr.expr, assigns] {
			case [TBlock([]),[]]:
				f.expr;
			case [TBlock(exprs),_]:
				var exprs = assigns.concat(exprs);
				toTExpr(TBlock(exprs), exprs[exprs.length-1].t, fpos);
			case [_, []]:
				f.expr;
			case [_, _]:
				f.expr.withExpr(TBlock(assigns.concat([f.expr])));
		}

		var e1 = toExpr(transformExpr(body, false, e.nextId));
		
		var fn = e.expr.withExpr(TFunction({ expr : e1, args : f.args, t : f.t}));
		
		var fn = addNonLocalsToFunc(fn);

		return if (isValue) {
			var newName = e.nextId();
			var newVar = { id : 0, name : newName, t : f.t, capture : false, extra : null };
			var newLocal = fn.withExpr(TLocal(newVar));
			var def = fn.withExpr(TVar(newVar,fn));
			liftExpr( newLocal, false, e.nextId, [def]);
		} else {
			liftExpr(fn);
		}
	}

	static function transformVarExpr (e:AdjustedExpr, e1:TypedExpr, v:TVar) 
	{
		var b = [];
		var newExpr = if (e1 == null) {
			null;
		} else {
			var f = transformExpr(e1, true, e.nextId);
			b = b.concat(f.blocks);
			f.expr;
		}
		return liftExpr(toTExpr(TVar(v, newExpr), e.expr.t, e.expr.pos), false, e.nextId, b);
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
				liftExpr(e.expr.withExpr(TConst(TNull)));

			case [false, TBlock(exprs)]: 
				transformExprsToBlock(exprs, e.expr.t, false, e.expr.pos, e.nextId);

			case [true, TBlock(exprs)]:// transform block to function and call it

				var name = e.nextId();

				var exprs = exprs.copy();

				var ret = exprs.pop();

				var retEx = e.expr.withExpr(TReturn(ret));

				var block = exprs.concat([retEx]);

				var myBlock = transformExprsToBlock(block, retEx.t, false, e.expr.pos, e.nextId);

				var fn = e.expr.withExpr(TFunction({ args:[], t: retEx.t, expr : myBlock.expr}));

				var tVar = {id:0, name : name, t : retEx.t, capture : false, extra : null};

				var f = addNonLocalsToFunc(fn);

				var fnAssign = e.expr.withExpr(TVar(tVar, f));

				var substitute = e.expr.withExpr(TCall(e.expr.withExpr(TLocal(tVar)), []));

				liftExpr(substitute, [fnAssign]);

			case [false, TFunction(f)]:
				
				transformFunction(f, e, false);
				
			case [true, TFunction(f)]:
				transformFunction(f, e, true);
			
			// Catch nulls before checking for simple patterns			
			case [_, TVar(v, e1)] if (e1 == null):
				transformVarExpr(e, e1, v);


			case [false, TVar(v, e1 = { expr : TUnop(unop = OpIncrement | OpDecrement, postFix, ve = { expr : TLocal(_) | TField({expr:TConst(TThis)},_) }) })]:
				var one = e1.withExpr(TConst(TInt(1)));
				var op = unop.match(OpIncrement) ? OpAdd : OpSub;
				var inc = e1.withExpr(TBinop(op, ve, one));
				var incAssign = e1.withExpr(TBinop(OpAssign, ve, inc));
				var varAssign = e1.withExpr(TVar(v, ve));

				var block = if (postFix) [varAssign, incAssign] else [incAssign, varAssign];
				transformExprsToBlock(block, e.expr.t, false, e.expr.pos, e.nextId);
			
			case [_, TVar(v, e1)]:
				transformVarExpr(e, e1, v);
				
			case [_, TFor(v, e1, e2)]:

				var e1 = transformExpr(e1, true, e.nextId, []);
				
				var e2 = toExpr(transformExpr(e2, false, e.nextId, []));

				var newExpr = e.expr.withExpr(TFor(v, e1.expr, e2));

				liftExpr(newExpr, e1.blocks);

			case [_,TReturn(x)] if (x == null): 
				e;
			
			case [_,TReturn({ expr : TFunction(f)})]:
				var n = e.nextId();
				
				var e1 = toExpr(transformExpr(f.expr,false, e.nextId));
					
				var f = toTExpr(TFunction({ expr : e1, t : f.t, args : f.args}), f.t, e.expr.pos);

				var f1 = addNonLocalsToFunc(f);

				var varN = { name : n, capture : false, extra : null, t : f1.t, id : 0};

				var f1Assign = f1.withExpr(TVar(varN, f1));

				var varLocal = f1.withExpr(TLocal(varN));

				liftExpr(toTExpr(TReturn(varLocal), varLocal.t, e.expr.pos), true, e.nextId, [f1Assign]);
			
			case [_,TReturn(x)]:
				var x1 = transformExpr(x,true, e.nextId, []);

				var res = if (x1.blocks.length > 0) {
					var f = exprsToFunc(x1.blocks.concat([x1.expr]), e.nextId(), e);
					liftExpr(e.expr.withExpr(TReturn(f.expr)), true, e.nextId, f.blocks);
				} else {
					liftExpr(e.expr.withExpr(TReturn(x1.expr)), true, e.nextId, []);
				}
				res;
			
			case [_,TParenthesis(e1)]:
				var newE1 = transformExpr(e1,true,e.nextId);
				var newP = e.expr.withExpr(TParenthesis(newE1.expr));
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
					var newIf = e.expr.withExpr(TIf(econd1.expr, eif2, eelse2));

					var meta = { name : ":ternaryIf", pos : e.expr.pos, params:null};
					var ternary = e.expr.withExpr(TMeta(meta, newIf));

					liftExpr(ternary, blocks);		
				} else {
					var newIf = e.expr.withExpr(TIf(econd1.expr, eif2, eelse2));
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

				var newIf = e.expr.withExpr(TIf(econd1.expr, eif1, eelse1));
				liftExpr(newIf, false, e.nextId, econd1.blocks);
			
			case [_,TWhile({ expr : TParenthesis(u), t : t}, e1, flag)]:
				var newE = toTExpr(TWhile(u, e1, flag), t, e.expr.pos);
				forwardTransform(newE, e);
			
			case [false, TWhile(econd, ebody, true)]:

				var econd = transformExpr(econd, true, e.nextId);
				var ebody = toExpr(transformExpr(ebody, false, e.nextId));
				var ewhile = e.expr.withExpr(TWhile(econd.expr, ebody, true));

				
				liftExpr(ewhile, false, e.nextId, econd.blocks);
			
			case [true, TWhile(econd, ebody, true)]:

				var econd = transformExpr(econd, true, e.nextId);

				var ebody = toExpr(transformExpr(ebody, false, e.nextId));

				var ewhile = e.expr.withExpr( TWhile(econd.expr, ebody, true) );

				var eval = e.expr.withExpr(TConst(TNull));

				var f = exprsToFunc(econd.blocks.concat([ewhile, eval]), e.nextId(), e);
				liftExpr(f.expr, true, e.nextId, f.blocks);

			case [isValue, TSwitch(e1, cases,edef)]:
				transformSwitch(e, isValue, e1, cases, edef);

			case [_, TWhile(econd, e1, false)]:
				// convert do to while expression and forward the transformation
				var notExpr = econd.withExpr( TUnop(OpNot, false, econd) );
				
				var breakExpr = toTExpr(TBreak, voidType, econd.pos);

				var ifExpr = toTExpr( TIf(notExpr, breakExpr, null), voidType, econd.pos);

				var newE1 = switch (e1.expr) {
					case TBlock(exprs):
						econd.withExpr( TBlock(exprs.concat([ifExpr])) );
					case _: 
						econd.withExpr( TBlock([e1].concat([ifExpr])) );
				}
				var trueExpr = toTExpr( TConst(TBool(true)), econd.t, e.expr.pos);
				var newExpr = e.expr.withExpr( TWhile(trueExpr, newE1, true) );

				forwardTransform(newExpr, e);

			case [isValue, TUnop(OpIncrement, postfix, e1)]:
				var one = e.expr.withExpr(TConst(TInt(1)));
				transformOpAssignOp(e, e1, OpAdd, one, isValue, postfix);

			case [isValue, TUnop(OpDecrement,postfix, e1)]:
				var one = e.expr.withExpr(TConst(TInt(1)));
				transformOpAssignOp(e, e1, OpSub, one, isValue, postfix);

			case [_, TUnop(op,false, e1)]:
				// can only be OpNot, right?
				var e1 = transformExpr(e1, true, e.nextId);

				var r = e.expr.withExpr( TUnop(op, false, e1.expr) );
				liftExpr(r, e1.blocks);
			
			case [true, TBinop(OpAssign,left,right)]:
				var ex = e.expr;

				var right = transformExpr(right, true, e.nextId);
				var left = transformExpr(left, true, e.nextId);

				var r = e.expr.withExpr( TBinop(OpAssign, left.expr, right.expr) );

				var blocks = left.blocks.concat(right.blocks).concat([r]);

				var f = exprsToFunc(blocks, e.nextId(),e);
				liftExpr(f.expr, true, e.nextId, f.blocks);

			case [false, TBinop(OpAssign,left,right)]:
				var left = transformExpr(left, true, e.nextId);
				var right = transformExpr(right, true, e.nextId);

				var r = e.expr.withExpr( TBinop(OpAssign, left.expr, right.expr) );

				liftExpr(r, false, e.nextId, left.blocks.concat(right.blocks));

			case [isValue, TBinop( OpAssignOp(x),left,right)]:
				var right1 = transformExpr(right, true, e.nextId);
				var one = right1.expr;
				
				var res = transformOpAssignOp(e, left, x, one, isValue, false);
				
				liftExpr(res.expr, true, e.nextId, right1.blocks.concat(res.blocks));

			case [_, TBinop(op,left,right)]:
				
				var right = transformExpr(right, true, e.nextId);
				var left = transformExpr(left, true, e.nextId);

				var r = e.expr.withExpr( TBinop(op, left.expr, right.expr) );

				liftExpr(r, false, e.nextId, left.blocks.concat(right.blocks));
			
			case [true, TThrow(x)]:
				
				var block = TBlock([e.expr, e.expr.withExpr( TConst(TNull) )]);

				var r = e.expr.withExpr( block );

				forwardTransform(r, e);

			case [false, TThrow(x)]:
				var x = transformExpr(x, true, e.nextId);
				var r = e.expr.withExpr( TThrow(x.expr) );
				liftExpr(r, false, e.nextId, x.blocks);

			case [_, TNew(c, tp,params)]:
				
				var params = [for (p in params) transformExpr(p, true, e.nextId)];

				var blocks = [for (p in params) for (b in p.blocks) b];

				var params = [for (p in params) p.expr];

				var ex = e.expr.withExpr( TNew(c, tp, params) );
				liftExpr(ex, false, e.nextId, blocks);
			
			case [_, TCall(x = { expr : TLocal({ name : "__python_for__"})}, [param])]:
			 	
			 	var param = transformExpr(param, false, e.nextId, []);
			 	
			 	var newCall = e.expr.withExpr( TCall(x, [param.expr]) );

			 	liftExpr(newCall, []);
			
			case [_, TCall(e1,params)]:
				var e1 = transformExpr(e1, true, e.nextId);

				
				var params = [for (p in params) transformExpr(p, true, e.nextId)];

				var blocks = e1.blocks.concat([for (p in params) for (b in p.blocks) b]);

				var params = [for (p in params) p.expr];

				var ex = e.expr.withExpr( TCall(e1.expr, params) );
				
				liftExpr(ex, blocks);
			
			case [true, TArray( e1, e2)]:
				var e1 = transformExpr(e1, true, e.nextId);
				var e2 = transformExpr(e2, true, e.nextId);

				var r = e.expr.withExpr( TArray(e1.expr, e2.expr) );

				liftExpr(r, e1.blocks.concat(e2.blocks));
			
			case [false, TTry( etry,catches)]:

				var etry = transformExpr(etry, false, e.nextId);

				var catches = [for (c in catches) { e : transformExpr(c.expr, false, e.nextId), v : c.v}];

				var blocks = etry.blocks.concat([for (c in catches) for (b in c.e.blocks) b]);

				var catches = [for (c in catches) { expr : c.e.expr, v : c.v }];

				var r = e.expr.withExpr( TTry(etry.expr, catches) );
				
				liftExpr(r, false, e.nextId, etry.blocks.concat(blocks));

			case [true, TTry( etry,catches)]:
				
				var pos = e.expr.pos;

				var id = e.nextId();

				var tempVar = { name : id, capture : false, extra : null, id : 0, t : e.expr.t };

				var tempVarDef = e.expr.withExpr( TVar(tempVar, null) );

				var tempLocal = e.expr.withExpr( TLocal(tempVar) );

				function mkTempVarAssign (right:TypedExpr) {
					return e.expr.withExpr( TBinop(OpAssign, tempLocal, right) );
				}

				var etry = mkTempVarAssign(etry);

				var catches = [for (c in catches) { v : c.v, expr : mkTempVarAssign(c.expr) }];

				var newTry = e.expr.withExpr( TTry(etry, catches) );

				var block = [tempVarDef, newTry, tempLocal];

				var newBlock = e.expr.withExpr( TBlock(block) );

				forwardTransform(newBlock, e);			
			
			case [_, TObjectDecl( fields)]:
				var fields = [for (f in fields) { name : f.name, ex: transformExpr(f.expr, true, e.nextId, [])}];

				var blocks = [for (f in fields) for (b in f.ex.blocks) b];
				
				var fields = [for (f in fields) { name : f.name, expr : f.ex.expr}];

				var r = e.expr.withExpr( TObjectDecl(fields) );

				liftExpr(r, blocks);

			case [_, TArrayDecl(values)]:

				var values = [for (v in values) transformExpr(v, true, e.nextId, [])];

				var blocks = [for (v in values) for (b in v.blocks) b];

				var exprs = [for (v in values) v.expr];

				var r = e.expr.withExpr( TArrayDecl(exprs) );

				liftExpr(r, blocks);
			
			case [_, TCast(ex, t)]:
				var ex1 = transformExpr(ex, true, e.nextId, []);

				liftExpr(e.expr.withExpr( TCast(ex1.expr, t) ), ex1.blocks);

			case [_, TField( ex, f)]:
				var ex = transformExpr(ex, true, e.nextId, []);
				
				liftExpr( e.expr.withExpr( TField(ex.expr, f) ), ex.blocks);
				
			case [flag, TMeta(m, e1)]:
				
				var ex1 = transformExpr(e1, flag, e.nextId, []);

				liftExpr( e.expr.withExpr( TMeta(m, ex1.expr) ), ex1.blocks);

			case _ : 
				liftExpr(e.expr);
		}
	}

	static function transformOpAssignOp(e:AdjustedExpr, e1:TypedExpr, op:Binop, one:TypedExpr, isValue:Bool, post:Bool) 
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

		return switch (e1_.expr.expr) 
		{
			case TArray({ expr : TLocal(_)},{ expr : TLocal(_)})
			| TField({ expr : TLocal(_)},_)
			| TField({ expr : TConst(TThis)},_)
			| TLocal(_):
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
			
			case _ : throw "assert";

		}
	}
	
	static function transformSwitch (e:AdjustedExpr, isValue:Bool, e1:TypedExpr, cases:Array<{values:Array<TypedExpr>, expr:TypedExpr}>,edef:Null<TypedExpr>) 
	{
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

			var eif = if (isValue) {
				var name = e.nextId();
				var func = exprsToFunc([c.expr], name,e);
				caseFunctions = caseFunctions.concat(func.blocks);
				var call = func.expr;

				toTExpr(TIf(cond, call, eelse), e.expr.t, c.expr.pos);	
			} else {
				{ expr : TIf(cond, c.expr, eelse), pos : c.expr.pos, t: e.expr.t };
			}
			
			
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

		var res = if (isValue) toTExpr(TBlock(caseFunctions.concat([res])), res.t, res.pos) else res;

		return forwardTransform(res, e);
	}
}