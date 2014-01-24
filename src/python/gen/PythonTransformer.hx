
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
				//trace(f.expr.toString(true));
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

				//trace(" locals: " + localAssigns);
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
					//trace(f.expr.toString(true));
				}
				
				e;
			case _ : throw "assert >> " + e.toString() + " << should be Function expr";
		}
		
	}

	static function createNonLocal (n:String, pos:Position) {
		var s = "nonlocal " + n; 
		var id = { expr : TLocal({ id : 0, name : "__python__", t : TDynamic(null), extra : null, capture : false }), pos : pos, t : TDynamic(null)};
		var id2 = { expr : TLocal({ id : 0, name : s, t : TDynamic(null), extra : null, capture : false }), pos : pos, t : TDynamic(null)};
		var e = { expr : TCall(id, [id2]), pos : pos, t : TDynamic(null)};
		return e;
	}

	static function toTVar (n:String, t:Type, capture:Bool = false) {
		if (capture == null) capture = false;
		return { id : 0, name : n, t : t, capture : capture, extra : null};
	}
	static function toTLocalExpr (n:String, t:Type, p:Position, capture:Bool = false):TypedExpr {
		return toTExpr(TLocal(toTVar(n, t, capture)), t, p);
	}

	static function toTReturnExpr (n:String, t:Type, p:Position, capture:Bool = false):TypedExpr {
		return toTExpr(TReturn(toTExpr(TLocal(toTVar(n, t, capture)), t, p)), t, p);
	}

	static function toTExpr (e:TypedExprDef, t:Type, pos:Position) {
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
		var cacheVarLocal = toTExpr(TLocal(cacheVar), ex1.t, ex1.pos);
		var cNull = toTExpr(TConst(TNull), ex1.t, ex1.pos);
		var cacheVarInit = toTExpr(TVar(cacheVar, cNull), ex1.t, ex1.pos);
		var cacheVarRet = toTExpr(TReturn(cacheVarLocal), ex1.t, ex1.pos);
		var cacheVarCheckNull = toTExpr(TBinop(OpNotEq, cacheVarLocal, cNull), ex1.t, ex1.pos);

		var cacheVarNonLocal = createNonLocal(cacheVarName, ex1.pos);
		var cacheVarCheckAndRet = toTExpr(TIf(cacheVarCheckNull, cacheVarRet, null), ex1.t, ex1.pos);

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
					

					var ret = toTReturnExpr(name, f.t, f.expr.pos);

					[expr, ret];
				case TBinop(OpAssign,l,r): 
					var cacheVarSet = toTExpr(TVar(cacheVar, l), l.t, l.pos);
					var r = { expr : TReturn(l), t : l.t, pos : l.pos};

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
				{ expr : TBlock( u.concat(exs) ), pos : base.expr.pos, t : exs[exs.length-1].t};
			} else {
				exs[0];
			}

		} else {
			exprs = exprs.copy();
			

			var ret = exprs.pop();
			var u = if (cacheCall) [cacheVarNonLocal, cacheVarCheckAndRet] else [];
			var block = u.concat(exprs).concat(convertReturnExpr(ret));


			{ expr : TBlock(block), pos : base.expr.pos, t : block[block.length-1].t };
		}

		var fExpr = toTExpr(TFunction({ args : [], t : ex.t, expr : ex }), TFun([],ex.t), ex.pos);
		var fVar = toTVar(name, fExpr.t, false);
		
		var f = addNonLocalsToFunc(fExpr);

		
		var assign = toTExpr(TVar(fVar, f), ex.t, ex.pos);

		var subs = toTExpr(TCall(toTExpr(TLocal(fVar),fExpr.t, ex.pos), []), ex.t, ex.pos);

		var substitute = subs;

		
		
		
		return if (cacheCall) liftExpr(substitute,  [cacheVarInit, assign])
			else liftExpr(substitute,  [assign]);
	}
	

	
	static function transformFunction (f:TFunc, e :AdjustedExpr, isValue:Bool) {
		//trace(Context.getTypedExpr(f.expr).toString());
		//var newExpr = switch (addNonLocalsToFunc(e.expr).expr) {
		//	case TFunction(f): f.expr;
		//	case _: throw "unexpected";
		//}
		var newExpr = f.expr;
		
		var assigns = [];
		for (a in f.args) {
			if (a.value != null) {

				var aLocal = { expr : TLocal(a.v), pos : f.expr.pos, t : a.v.t };
				//trace(Context.getTypedExpr(aLocal).toString());
				var aNull= { expr : TConst(TNull), pos : f.expr.pos, t : a.v.t };
				//trace(Context.getTypedExpr(aNull).toString());
				var boolType = Context.typeof(macro true);
				var voidType = Context.typeof(macro while (true) {});
				var aCmp = { expr : TBinop(Binop.OpEq, aLocal, aNull), pos : f.expr.pos, t : boolType};
				//trace(Context.getTypedExpr(aCmp).toString());
				var aAssign = { expr : TBinop(Binop.OpAssign, aLocal, { expr : TConst(a.value), t : a.v.t, pos : f.expr.pos}), pos : f.expr.pos , t: a.v.t};
				//trace(Context.getTypedExpr(aAssign).toString());
				var aIf = { expr : TIf(aCmp, aAssign, null), pos : f.expr.pos, t:voidType };
				//trace(Context.getTypedExpr(aIf).toString());
				assigns.push(aIf);
			}
		}
		
		var body = switch [newExpr.expr, assigns] {
			case [TBlock([]),[]]:
				f.expr;
			case [TBlock([]),_]:
				{ expr : TBlock(assigns), pos : f.expr.pos, t : assigns[assigns.length-1].t};
			case [TBlock(exprs),_]:
				{ expr : TBlock(assigns.concat(exprs)), pos : f.expr.pos, t : exprs[exprs.length-1].t};
			case [_, []]:
				f.expr;
			case [_, _]:
				{ expr : TBlock(assigns.concat([f.expr])), pos : f.expr.pos, t : f.expr.t};

		}
		//trace(Context.getTypedExpr(body).toString());
		// top level function = instance or static functions
		var e1 = toExpr(transformExpr(body, false, e.nextId));
		

		//trace(e1);
		//trace(Context.getTypedExpr(e1).toString());
		
		var fn = { expr : TFunction({ expr : e1, args : f.args, t : f.t}), pos : e.expr.pos, t : e.expr.t };
		
		fn = addNonLocalsToFunc(fn);

		
		

		return if (isValue) {
			var newName = e.nextId();
			

			var newVar = { id : 0, name : newName, t : f.t, capture : false, extra : null };
			var newLocal = { expr : TLocal(newVar), pos : fn.pos, t : fn.t };
			var def = { expr : TVar(newVar,fn), pos : fn.pos, t : fn.t};
			liftExpr( newLocal, false, e.nextId, [def]);
		} else {
			liftExpr(fn);
		}

	}

	static function transform1 (e:AdjustedExpr):AdjustedExpr
	{
		if (e == null) {
			trace("EEEEE:" + e);
		}

		
		//trace(e.expr.expr.getName());
		//trace(e.expr);
		

		switch (e.expr.expr) {
			case TConst(f):
				
			case _ : 
		}


		return switch [e.isValue, e.expr.expr] 
		{
			case [isValue, TBlock([x])]:
				//trace(ExprTools.toString(Context.getTypedExpr(x)));
				//trace("transform simple expr in block " + isValue);
				transformExpr(x,isValue, e.nextId);


			case [_, x = TBlock([])]:

				liftExpr({ expr : TConst(TNull), t : e.expr.t, pos : e.expr.pos});

			case [false, TBlock(exprs)]: 
				//trace("block with false: " + e.expr.toString(true));
				transformExprsToBlock(exprs, e.expr.t, false, e.expr.pos, e.nextId);
			

			case [true, TBlock(exprs)]:// transform block to function and call it

				//trace("block with true: " + e.expr.toString(true));

				var name = e.nextId();

				var exprs = exprs.copy();

				var ret = exprs.pop();

				var retEx = { expr : TReturn(ret), pos : e.expr.pos, t : e.expr.t};

				var block = exprs.concat([retEx]);

				

				var myBlock = transformExprsToBlock(block, retEx.t, false, e.expr.pos, e.nextId);

				

				var fn = { expr : TFunction({ args:[], t: retEx.t, expr : myBlock.expr}), pos : e.expr.pos, t: e.expr.t};

				var tVar = {id:0, name : name, t : retEx.t, capture : false, extra : null};

				

				var f = addNonLocalsToFunc(fn);
				

				var fnAssign = { expr: TVar(tVar, f), pos : e.expr.pos, t : e.expr.t};

				var substitute = { expr : TCall({ expr : TLocal(tVar), t : e.expr.t, pos : e.expr.pos}, []), pos : e.expr.pos, t : e.expr.t};

				//trace(f.toString(true));
				//trace(substitute.toString(true));
				//blockToFunc(exprs, e);
				liftExpr(substitute, [fnAssign]);
				

					//trace(ExprTools.toString(f.expr));
					//trace("exprsToFunc");
					
				
				//var f = exprsToFunc(block, e);
				
				//return liftExpr(f);



			case [false, TFunction(f)]:
				
				
				
				//trace("here2");
				transformFunction(f, e, false);
				
			case [true, TFunction(f)]:
				//trace("here1");
				//trace(f.expr.toString(true));
				//trace("here we go: " + Context.getTypedExpr(f.expr).toString());
				transformFunction(f, e, true);
				

				

			
			case [_, TVar(v, e1)]:
				
				var b = [];
				

				var newExpr = if (e1 == null) {
					null;
				} else {
					//trace("var decl : " + ExprTools.toString(v.expr));
					var f = transformExpr(e1, true, e.nextId);
					
					b = b.concat(f.blocks);
					
					f.expr;
				}

				liftExpr({ expr : TVar(v, newExpr), pos:e.expr.pos,t : e.expr.t}, false, e.nextId, b);
			

			case [_, TFor(v, e1, e2)]:
				// for to while

				var e1New = transformExpr(e1, true, e.nextId, []);
				var e2New = transformExpr(e2, false, e.nextId, []);

				var newExpr = { expr : TFor(v, e1New.expr, e2New.expr), pos : e.expr.pos, t : e.expr.t };

				liftExpr(newExpr, e1New.blocks.concat(e2New.blocks));



		//	case [_,TFor({ expr : EIn(e1={ expr : EConst(CIdent(id))}, e2)},body)]:
		//		
		//		var varDef = { expr : EVars([{ name : id, expr : macro _it.next(), type : null}]), pos : e1.pos};
//
//		//		var newExpr = macro @:pos(e.expr.pos) {
//		//			var _it = $e2;
//		//			while (_it.hasNext()) {
//		//				$varDef;
//		//				$body;
//		//			}
//		//		}
		//		forwardTransform(newExpr, e);

			case [_,TReturn(x)] if (x == null):e;
			
			case [_,TReturn({ expr : TFunction(f)})]:
				var n = e.nextId();
				
				var e1 = toExpr(transformExpr(f.expr,false, e.nextId));
					
				var f = { expr : TFunction({ expr : e1, t : f.t, args : f.args}), pos : e.expr.pos, t : f.t };

				var f1 = addNonLocalsToFunc(f);

				var varN = { name : n, capture : false, extra : null, t : f1.t, id : 0};

				var f1Assign = { expr : TVar(varN, f1), t : f1.t, pos : f1.pos};

				var varLocal = { expr : TLocal(varN), pos : f1.pos, t : f1.t };

				liftExpr({ expr : TReturn(varLocal), pos : e.expr.pos, t : varLocal.t}, true, e.nextId, [f1Assign]);				
			
			case [_,TReturn(x)]:
				//trace("transform treturn");
				//trace(TypedExprTools.toString(x));
				//trace(ExprTools.toString(Context.getTypedExpr(x)));
				var x1 = transformExpr(x,true, e.nextId, []);
				//trace("after transform treturn");

				

				

				var res = if (x1.blocks.length > 0) {
					var f = exprsToFunc(x1.blocks.concat([x1.expr]), e.nextId(), e);
					//trace(ExprTools.toString(f.expr));
					//trace("exprsToFunc");
					liftExpr({ expr : TReturn(f.expr), pos : e.expr.pos, t : e.expr.t}, true, e.nextId, f.blocks);
				} else {
					//trace("just expr");
					liftExpr({ expr : TReturn(x1.expr), pos : e.expr.pos, t : e.expr.t}, true, e.nextId, []);
				}
				res;
				

				// if (x1.blocks.length == 0) {
				// 	liftExpr({ expr : EReturn(x1.expr), pos : e.expr.pos});
				// } else {
				// 	trace("exprsToFunc2");
				// 	var z = exprsToFunc(x1.blocks.concat([x1.expr]), e);
				// 	trace("exprsToFunc2b");
				// 	var r = liftExpr({ expr : EReturn(z.expr), pos : e.expr.pos}, false, true, e.nextId, z.blocks);
				// 	trace("exprsToFunc2c");
				// 	r;
				// 	//liftExpr(macro $i{id}, false, false, e.nextId, x1);

				// }
	
			
			case [_,TParenthesis(e1)]:
				//trace("parens");
				//trace(e1);
				var newE1 = transformExpr(e1,true,e.nextId);
				//trace(newE1);
				var newP = { expr : TParenthesis(newE1.expr), pos : e.expr.pos, t : e.expr.t};
//
				liftExpr(newP, true, e.nextId, newE1.blocks);

			
			case [true, TIf(econd, eif, eelse)]:
				// eif in assignment
				//trace(ExprTools.toString(eif));
				var econd1 = transformExpr(econd, true, e.nextId);
				
				var eif1 = transformExpr(eif, true, e.nextId);

				//trace(eif1.expr.toString(true));

				var eelse1 = if (eelse != null) {
					transformExpr(eelse, true, e.nextId);
				} else {
					null;
				}

				var blocks = [];
				var eif2 = if (eif1.blocks.length > 0) {
					
					function regular () {
						var fname = e.nextId();
						//Lambda.iter(eif1.blocks, function (x) trace(haxe.macro.ExprTools.toString(x)));
						var f = exprsToFunc(eif1.blocks.concat([eif1.expr]), fname,e);
						
						blocks = blocks.concat(f.blocks);
						//trace(ExprTools.toString(f.expr));
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
						//trace(ExprTools.toString(f.expr));
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
				
				//trace(ExprTools.toString(Context.getTypedExpr(eif2)));
				//trace(ExprTools.toString(Context.getTypedExpr(eelse2)));
				//trace(ExprTools.toString(Context.getTypedExpr(econd1.expr)));
				
				//trace(ExprTools.toString(newIf));
				var blocks = econd1.blocks.concat(blocks);
				if (blocks.length == 0) {
					var newIf = { expr : TIf(econd1.expr, eif2, eelse2), pos : e.expr.pos, t : e.expr.t };
					// this is a ternary if 

					//trace(ExprTools.toString(Context.getTypedExpr(newIf)));
					

					var meta = { name : ":ternaryIf", pos : e.expr.pos, params:null};
					var ternary = { expr : TMeta(meta, newIf), pos : e.expr.pos, t : e.expr.t}


					//trace(ExprTools.toString(Context.getTypedExpr(ternary)));
					
					liftExpr(ternary, blocks);		
				} else {
					var newIf = { expr : TIf(econd1.expr, eif2, eelse2), pos : e.expr.pos, t : e.expr.t };
					var f = exprsToFunc(blocks.concat([newIf]), e.nextId(), e);
					liftExpr(f.expr, f.blocks);		
				}
				
				//liftExpr(newIf, true, true, e.nextId, econd1.blocks.concat(blocks));
				
			
			case [false, TIf(econd, eif, eelse)]:

				//trace(e.expr.toString(true));
				
				var econd1 = transformExpr(econd, true, e.nextId);
				//trace(ExprTools.toString(eif));
				var eif1 = toExpr(transformExpr(eif, false, e.nextId));
				
				var eelse1 = if (eelse != null) {
					//trace("EERRROR"+ExprTools.toString(eelse));

					toExpr(transformExpr(eelse, false, e.nextId));
				} else {
					null;
				}
				//trace(ExprTools.toString(eif1));

				var newIf = { expr : TIf(econd1.expr, eif1, eelse1), pos : e.expr.pos, t : e.expr.t };
				//trace(ExprTools.toString(newIf));
				liftExpr(newIf, false, e.nextId, econd1.blocks);
			
			case [_,TWhile({ expr : TParenthesis(u), t : t}, e1, flag)]:
				var newE = { expr : TWhile(u, e1, flag), pos : e.expr.pos, t : t };
				forwardTransform(newE, e);
			
			case [false, TWhile(econd, e1, true)]:
				var econd1 = transformExpr(econd, true, e.nextId);

				var e11 = toExpr(transformExpr(e1, false, e.nextId));

				var newWhile = { expr : TWhile(econd1.expr, e11, true), t : e.expr.t, pos: e.expr.pos };

				
				liftExpr(newWhile, false, e.nextId, econd1.blocks);
			
			case [true, TWhile(econd, e1, true)]:
				var econd1 = transformExpr(econd, true, e.nextId);

				var e11 = toExpr(transformExpr(e1, false, e.nextId));

				var newWhile = { expr : TWhile(econd1.expr, e11, true), t : e.expr.t, pos: e.expr.pos };

				var newRet = { expr : TConst(TNull), t : e.expr.t, pos : e.expr.pos };

				var f = exprsToFunc(econd1.blocks.concat([newWhile, newRet]), e.nextId(), e);
				liftExpr(f.expr, true, e.nextId, f.blocks);

				//liftExpr(newWhile, true, false, e.nextId, econd1.blocks);

			// todo
			//case [_,true, EWhile(econd, e1, true)]:
				// assignment while promote to function with null return
			/*
			*/
			
			case [true, TSwitch(e1, cases,edef)]:
				// transform eswitch into if/else
				//trace("tswitch");
				var boolType = Context.typeof(macro true);
				//trace(e.expr.toString(true));
				//return e;
				
				var caseFunctions = [];

				function caseToIf (c:{values:Array<TypedExpr>, expr:TypedExpr}, ?eelse:TypedExpr) {

					var eif = eelse;

					var valReversed = c.values.copy();
					valReversed.reverse();

					var cond = null;

					for (v in valReversed) {
						if (cond == null) {
							cond = { expr : TBinop(OpEq, e1, v), pos : v.pos, t : boolType};
						} else {
							var x = { expr : TBinop(OpEq, e1, v), pos : v.pos, t : boolType};
							cond = { expr : TBinop(OpBoolOr, cond, x), pos : v.pos, t : boolType};
						}
					}



					var name = e.nextId();
					var func = exprsToFunc([c.expr], name,e);
					caseFunctions = caseFunctions.concat(func.blocks);
					var call = func.expr;

					eif = { expr : TIf(cond, call, eelse), pos : c.expr.pos, t: e.expr.t };
					
					return eif;
					
				}


				var res = null;
				var revCases = cases.copy();
				revCases.reverse();

				if (edef != null && edef.expr == null) {
					edef = { expr : TBlock([]), pos : edef.pos, t : e.expr.t};
				}

				for (c in revCases) {
					if (res == null) {

						res = caseToIf(c, edef);
					} else {
						res = caseToIf(c, res);
					}
					//trace(ExprTools.toString(res));
				}
				
				if (res == null || res.expr == null) {

					throw "unexpected";
				}

				var resulting = { expr : TBlock(caseFunctions.concat([res])), t : res.t, pos : res.pos};
				//trace(res.toString(true));
				//trace(e.isValue);

				forwardTransform(resulting, e);
				
			case [false, TSwitch(e1, cases,edef)]:
				// transform eswitch into if/else
				//trace("tswitch2");
				var boolType = Context.typeof(macro true);
				//trace(e.expr.toString(true));
				//return e;
				
				

				function caseToIf (c:{values:Array<TypedExpr>, expr:TypedExpr}, ?eelse:TypedExpr) {

					var eif = eelse;

					var valReversed = c.values.copy();
					valReversed.reverse();

					var cond = null;

					for (v in valReversed) {
						if (cond == null) {
							cond = { expr : TBinop(OpEq, e1, v), pos : v.pos, t : boolType};
						} else {
							var x = { expr : TBinop(OpEq, e1, v), pos : v.pos, t : boolType};
							cond = { expr : TBinop(OpBoolOr, cond, x), pos : v.pos, t : boolType};
						}
					}



					
					

					eif = { expr : TIf(cond, c.expr, eelse), pos : c.expr.pos, t: e.expr.t };
					
					return eif;
					
				}


				var res = null;
				var revCases = cases.copy();
				revCases.reverse();

				if (edef != null && edef.expr == null) {
					edef = { expr : TBlock([]), pos : edef.pos, t : e.expr.t};
				}

				for (c in revCases) {
					if (res == null) {

						res = caseToIf(c, edef);
					} else {
						res = caseToIf(c, res);
					}
					//trace(ExprTools.toString(res));
				}
				
				if (res == null || res.expr == null) {
					//trace(TypedExprTools.toString(e.expr));
					//trace(cases);
					//throw "unexpected";
					res = { expr : TConst(TNull), pos : e.expr.pos, t : e.expr.t }
				}

				
				//trace(res.toString(true));
				//trace(e.isValue);

				forwardTransform(res, e);
				
			
			
			case [_, TWhile(econd, e1, false)]:
				
				
				
				var notExpr = { expr : TUnop(OpNot, false, econd), pos : econd.pos, t : econd.t};
				var breakExpr = { expr :TBreak, pos : econd.pos, t : Context.typeof(macro var x)}
				var ifExpr = { expr : TIf(notExpr, breakExpr, null), pos : econd.pos, t : Context.typeof(macro var x)};



				var newE1 = switch (e1.expr) {
					case TBlock(exprs):
						{ expr : TBlock(exprs.concat([ifExpr])), pos : e.expr.pos, t : e.expr.t};
					case _: 
						{ expr : TBlock([e1].concat([ifExpr])), pos : e.expr.pos, t : e.expr.t};
				}
				var trueExpr = { expr : TConst(TBool(true)), pos : e.expr.pos, t: econd.t};
				var newExpr = { expr : TWhile(trueExpr, newE1, true), pos : e.expr.pos, t : e.expr.t};
				//trace(ExprTools.toString(newExpr));
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
				

				var e1_ = transformExpr(e1, true, e.nextId);

				var id = e.nextId();

				var tempVar = { name : id, id : 0, extra : null, capture : false, t : e1_.expr.t };
				var tempLocal = { expr : TLocal(tempVar), pos : e1_.expr.pos, t : e1_.expr.t};
				var tempVarExpr = { expr : TVar(tempVar, e1_.expr), pos : e1_.expr.pos, t : e1_.expr.t};
				
				var id = e.nextId();

				var resVar = { name : id, id : 0, extra : null, capture : false, t : e.expr.t };
				
				var resLocal = { expr : TLocal(resVar), pos : e.expr.pos, t : e.expr.t};
				
				var one = { expr : TConst(TInt(1)), pos : e.expr.pos, t : e.expr.t };
				var plus = { expr : TBinop(OpAdd, tempLocal, one), pos : e.expr.pos, t: e.expr.t}

				var varExpr = { expr : TVar(resVar, tempLocal), pos : e.expr.pos, t : e.expr.t};
				var assignExpr = { expr : TBinop(OpAssign,e1_.expr, plus), pos : e.expr.pos, t : e.expr.t};

				var block = e1_.blocks.concat([tempVarExpr, varExpr, assignExpr, resLocal]);
				

				if (isValue) {
					var f = exprsToFunc(block, e.nextId(), e, true);

					//var blockExpr = { expr : TBlock([f.expr].concat(block), pos : e.expr.pos, t : e.expr.t};
					liftExpr(f.expr, true, e.nextId, f.blocks);
				} else {
					var f = exprsToFunc(block, e.nextId(), e, true);
					var blockExpr = { expr : TBlock(f.blocks.concat([f.expr])), pos : e.expr.pos, t : e.expr.t};
					

					forwardTransform(blockExpr,e);
				}

			
			case [_, TUnop(OpDecrement,false, e1)]:
				var plus = { expr : TBinop(Binop.OpSub, e1, { expr : TConst(TInt(1)), t : e1.t, pos : e1.pos}), t : e1.t, pos : e1.pos};
				var assign = { expr : TBinop(OpAssign, e1, plus), pos : e1.pos, t : e1.t};
				
				forwardTransform(assign,e);
			case [_, TUnop(OpDecrement,true, e1)]:
				
				var id = e.nextId();
				var resVar = { name : id, id : 0, extra : null, capture : false, t : e.expr.t };
				var resLocal = { expr : TLocal(resVar), pos : e.expr.pos, t : e.expr.t};
				var one = { expr : TConst(TInt(1)), pos : e.expr.pos, t : e.expr.t };
				var minus = { expr : TBinop(OpSub, e1, one), pos : e.expr.pos, t: e.expr.t}

				var varExpr = { expr : TVar(resVar, e1), pos : e.expr.pos, t : e.expr.t};
				var assignExpr = { expr : TBinop(OpAssign,e1, minus), pos : e.expr.pos, t : e.expr.t};

				var block = [varExpr, assignExpr, resLocal];
				var blockExpr = { expr : TBlock(block), pos : e.expr.pos, t : e.expr.t};


				forwardTransform(blockExpr,e);
			
			case [_, TUnop(op,false, e1)]:
				var e2 = transformExpr(e1, true, e.nextId);

				var newE = { expr : TUnop(op, false, e2.expr), pos : e.expr.pos, t : e.expr.t };
				liftExpr(newE,e2.blocks);
			
			
			case [true, TBinop(OpAssign,left,right)]:
				//trace(ExprTools.toString(e.expr));
				var ex = e.expr;
				var right1 = transformExpr(right, true, e.nextId);
				var left1 = transformExpr(left, true, e.nextId);

				var newEx = { expr : TBinop(OpAssign, left1.expr, right1.expr), t : e.expr.t, pos : e.expr.pos};
				//var newEx = macro @:pos(e.expr.pos) ${left1.expr} = ${right1.expr};

				var blocks = left1.blocks.concat(right1.blocks).concat([newEx]);

				// if (blocks.length == 0) {
				// 	liftExpr(newEx, false, e.nextId, blocks);
				// } else {
				var f = exprsToFunc(blocks, e.nextId(),e);
				liftExpr(f.expr, true, e.nextId, f.blocks);

				

			case [false, TBinop(OpAssign,left,right)]:
				var left1 = transformExpr(left, true, e.nextId);
				var right1 = transformExpr(right, true, e.nextId);

				var newEx = { expr : TBinop(OpAssign, left1.expr, right1.expr), pos : e.expr.pos, t : e.expr.t };

				liftExpr(newEx, false, e.nextId, left1.blocks.concat(right1.blocks));

			case [true, TBinop( OpAssignOp(x),left,right)]:
				
				var left1 = transformExpr(left, true, e.nextId);
				var right1 = transformExpr(right, true, e.nextId);

				var opExpr = { expr : TBinop(x, left1.expr, right1.expr), pos : e.expr.pos, t : e.expr.t };

				var newEx = { expr : TBinop(OpAssign, left1.expr, opExpr), pos : e.expr.pos, t : e.expr.t };

				var blocks = left1.blocks.concat(right1.blocks).concat([newEx]);

				var f = exprsToFunc(blocks, e.nextId(),e);
				liftExpr(f.expr, true, e.nextId, f.blocks);

				
			case [false, TBinop( OpAssignOp(x),left,right)]:
				
				var left1 = transformExpr(left, true, e.nextId);
				var right1 = transformExpr(right, true, e.nextId);

				var opExpr = { expr : TBinop(x, left1.expr, right1.expr), pos : e.expr.pos, t : e.expr.t };

				var newEx = { expr : TBinop(OpAssign, left1.expr, opExpr), pos : e.expr.pos, t : e.expr.t };

				liftExpr(newEx, false, e.nextId, left1.blocks.concat(right1.blocks));

			
			case [true, TBinop(op,left,right)]:
				//trace(ExprTools.toString(e.expr));
				var ex = e.expr;
				var right1 = transformExpr(right, true, e.nextId);
				var left1 = transformExpr(left, true, e.nextId);

				var newEx = { expr : TBinop(op, left1.expr, right1.expr), pos : e.expr.pos, t : e.expr.t };

				if (left1.blocks.length > 0 || right1.blocks.length > 0) {
					
					// NEW CODE					
					var blocks = left1.blocks.concat(right1.blocks);
					liftExpr(newEx, false, e.nextId, blocks);
					// OLD CODE
					//var blocks = left1.blocks.concat(right1.blocks).concat([newEx]);
					//exprsToFunc(blocks, e.nextId(),e);
				} else {
					liftExpr(newEx, false, e.nextId,[]);
				}
			
			case [_, TBinop( op,left,right)]:
				var right1 = transformExpr(right, true, e.nextId);
				var left1 = transformExpr(left, true, e.nextId);

				var ex = { expr : TBinop(op, left1.expr, right1.expr) , pos : e.expr.pos, t : e.expr.t };
				liftExpr(ex, false, e.nextId, left1.blocks.concat(right1.blocks));
				
			
			
			case [true, TThrow(x)]:

				var block = TBlock([e.expr, { expr : TConst(TNull), pos : e.expr.pos, t : e.expr.t}]);

				var blockExpr = { expr : block, t : e.expr.t, pos : e.expr.pos };
				forwardTransform(blockExpr, e);				
			case [false, TThrow(x)]:
				var x = transformExpr(x, true, e.nextId);
				var ex = { expr : TThrow(x.expr) , pos : e.expr.pos, t : e.expr.t };
				liftExpr(ex, false, e.nextId, x.blocks);
			/*

			//  case [_, ECall(e1={ expr : EConst(CIdent("trace"))},params)]:
			// TODO 
			// at this point we have to make sure that each operand of each parameter which is a nested binary plus expression
			// is surrounded with a Std.string otherwise we could run into some python trouble because python does not implicitly convert
			// parameters into Strings when doing concatenations.	
			// But this would only be a solution for the special trace case, it would be better to
			// have access to the expr type to make sure that implicit casts are applied in binary expression during printing.
			
			
			
			*/

			case [_, TNew(c, tp,params)]:
				//trace(ExprTools.toString(e.expr));
				
				var params1 = [for (p in params) transformExpr(p, true, e.nextId)];

				var blocks = [for (p in params1) for (b in p.blocks) b];

				var params2 = [for (p in params1) p.expr];

				var ex = { expr : TNew(c, tp, params2), pos : e.expr.pos, t : e.expr.t };
				liftExpr(ex, false, e.nextId, blocks);
			
			case [_, TCall(x = { expr : TLocal({ name : "__python_for__"})},params)]:
			 	
			 	var e1 = transformExpr(params[0], false, e.nextId, []);
			 	

			 	var newCall = { expr : TCall(x, [e1.expr]), pos : e.expr.pos, t : e.expr.t};

			 	liftExpr(newCall, []);
				
			// 	liftExpr(e, false, e.nextId, []);

			
			case [_, TCall(e1,params)]:
				//trace(ExprTools.toString(e.expr));
				var e1_ = transformExpr(e1, true, e.nextId);
				
				var params1 = [for (p in params) transformExpr(p, true, e.nextId)];

				var blocks = e1_.blocks.concat([for (p in params1) for (b in p.blocks) b]);

				var params2 = [for (p in params1) p.expr];

				var ex = { expr : TCall(e1_.expr, params2), pos : e.expr.pos, t : e.expr.t };
				liftExpr(ex, false, e.nextId, blocks);
			
			
			case [true, TArray( e1, e2)]:
				var e1_ = transformExpr(e1, true, e.nextId);
				var e2_ = transformExpr(e2, true, e.nextId);



				var ex = { expr : TArray(e1_.expr, e2_.expr), pos : e.expr.pos, t : e.expr.t };

				liftExpr(ex, e1_.blocks.concat(e2_.blocks));
			
			case [false, TTry( etry,catches)]:
				//trace("ETRY false");
				//trace(ExprTools.toString(Context.getTypedExpr(etry)));
				
				var try1 = transformExpr(etry, false, e.nextId);
				var catches1 = [for (c in catches) transformExpr(c.expr, false, e.nextId)];

				var blocks = try1.blocks.concat([for (c in catches1) for (b in c.blocks) b]);

				var newCatches = [for (i in 0...catches.length) { expr : catches1[i].expr, v : catches[i].v }];

				var ex = { expr : TTry(try1.expr, newCatches), pos : e.expr.pos, t : e.expr.t};
				
				liftExpr(ex, false, e.nextId, try1.blocks.concat(blocks));

			case [true, TTry( etry,catches)]:
				//trace("ETRY true");
				//trace(ExprTools.toString(Context.getTypedExpr(etry)));
				
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
				//trace("tobjectDecl");
				var newFields = [for (f in fields) { name : f.name, ex: transformExpr(f.expr, true, e.nextId, [])}];

				var newFields1 = [for (f in newFields) { name : f.name, expr : f.ex.expr}];

				//trace("mapped fields tobjectDecl");

				var blocks = [];
				for (f in newFields) {
					blocks = blocks.concat(f.ex.blocks);
				}

				var ex = { expr : TObjectDecl(newFields1), pos : e.expr.pos, t : e.expr.t };

				//trace("pre lift tobjectDecl");
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
				
				//trace(m.name);
				//trace(e1.expr.getName());
				//trace(TypedExprTools.toString(e1));
				//trace("after typed to string");
				
				//trace("pre transform");
				var ex1 = transformExpr(e1, flag, e.nextId, []);

				//trace("after transform");

				liftExpr({ expr : TMeta(m, ex1.expr), pos : e.expr.pos, t : e.expr.t}, ex1.blocks);

			case _ : 
				//trace("just lift");
				//trace(ExprTools.toString(e.expr));
				liftExpr(e.expr);
		}
	}
}

