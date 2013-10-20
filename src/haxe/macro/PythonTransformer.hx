
package haxe.macro;

using haxe.macro.ExprTools;

import haxe.macro.Expr;
import haxe.macro.Expr.Binop.OpAdd;
import haxe.macro.Expr.Binop.OpAssignOp;



typedef AdjustedExpr = {
	// the resulting Expr which should be valid for python generation
	expr: Expr,
	// blocks contains expressions which must be placed before expr.
	blocks : Array<Expr>,
	// returns the next free local identifier
	nextId: Void->String,
	// it is important to distinguish between expressions which must evaluate 
	// to a value and expressions which don't (statements) to generate valid python code.
	isValue:Bool

}

class PythonTransformer {

	// Public Interface, takes an Expression, adjust it, so that it can be easily generated to valid python code.

	public static function transform (e:Expr):Expr {
		
		return toExpr(transform1(liftExpr(e)));
	}



	static function toExpr (e:AdjustedExpr):Expr 
	{
		return if (e.blocks.length > 0) {
			switch (e.expr.expr) {
				case EBlock(exprs):
					{ expr : EBlock(e.blocks.concat(exprs)), pos : e.expr.pos };
				case _ : 
					{ expr : EBlock(e.blocks.concat([e.expr])), pos : e.expr.pos };
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

	static function forwardTransform (e:Expr, base:AdjustedExpr):AdjustedExpr 
	{
		return transform1(liftExpr(e, base.isValue, base.nextId, base.blocks.copy()));
	} 

	static function liftExpr (e:Expr,?isValue:Bool = false, ?nextId:Void->String, ?blocks:Array<Expr>):AdjustedExpr 
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


	static function transformExpr (e:Expr, ?isValue, ?next : Void->String, ?blocks:Array<Expr>):AdjustedExpr 
	{
		return transform1(liftExpr(e,isValue,next, blocks));
	}

	
	static function transformExprsToBlock (exprs:Array<Expr>, nested, pos:haxe.macro.Expr.Position, next:Void->String):AdjustedExpr	
	{
		if (exprs.length == 1) {
			return transformExpr(exprs[0], nested, next);
		}
		var res = [];
		
		for (e in exprs) {
			
			var f = transformExpr(e,nested, next);

			res = res.concat(f.blocks);
			res.push(f.expr);
		}
		return liftExpr({ expr : EBlock(res), pos : pos});
	}

	static function addNonLocalsToFunc (e:Expr) 
	{
		return switch (e.expr) {
			case EFunction(n,f):
				var first = true;
				var localVars = [for (a in f.args) a.name];
				var localAssigns = [];
				var nonLocals = [];
				f.expr.iter(function (e) {
					switch (e.expr) {
						case EBinop(OpAssign,{ expr : EConst(CIdent(a))},_): 
							if (first) {
								//trace("opAssign");
								localAssigns.push(a); 
							}
						case EBinop(OpAssignOp(_),{ expr : EConst(CIdent(a))},_): 
							if (first) {
								//trace("opAssign");
								localAssigns.push(a); 
							}

						case EVars(vars): 
							if (first) {
								localVars = localVars.concat([for (v in vars) v.name] );
							} 
						case EFunction(_,_):
							first = false;
						case _ :
					}
				});

				//trace(n + " locals: " + localAssigns);
				for (a in localAssigns) 
				{
					if (!Lambda.has(localVars, a)) {
						nonLocals.push(a);
					}
				}
				if (nonLocals.length > 0) {

					var newFunctionExprs = [for( n in nonLocals) {var s = "nonlocal " + n; macro untyped __python__($v{s});}].concat([f.expr]);

					f.expr = macro @:pos(f.expr.pos) $b{newFunctionExprs};
				}
				
				e;
			case _ : throw "assert >> " + e.toString() + " << should be Function expr";
		}
		
	}

	static function exprsToFunc (exprs:Array<Expr>, name:String, base:AdjustedExpr) 
	{
		
		if (exprs.length == 1) 
		{
			switch (exprs[0].expr) {
				case EFunction(name, f) if (name != null && f.args.length == 0): 
					
					var substitute = macro $i{name}();
					return liftExpr(substitute, [exprs[0]]);
					
				case _ : 
			}
		}

		function convertReturnExpr (expr:Expr):Array<Expr> 
		{
			return switch (expr.expr) 
			{
				case EFunction(name, f) if (name == null): throw "assert";
				case EFunction(name, f): [expr, macro return $i{name}];
				case EBinop(OpAssign,l,r): 
					var id = base.nextId();
					var e1 = { expr : EVars([{ name : id, type : null, expr : expr }]), pos : expr.pos};
					[e1, macro @:pos(expr.pos) return $i{id}];
				case x: [macro return $expr];

			}
		}

		//trace(name);
		var ex = if (exprs.length == 1) {
			var exs = convertReturnExpr(exprs[0]);
			if (exs.length > 1) {
				{ expr : EBlock(exs), pos : base.expr.pos};
			} else {
				exs[0];
			}

		} else {
			exprs = exprs.copy();
			

			var ret = exprs.pop();

			var block = exprs.concat(convertReturnExpr(ret));


			{ expr : EBlock(block), pos : base.expr.pos};
		}


		var f = addNonLocalsToFunc(macro function $name () ${ex});

		var substitute = macro $i{name}();

		
		
		
		return liftExpr(substitute,  [f]);
	}

	

	static function transform1 (e:AdjustedExpr):AdjustedExpr
	{
		if (e == null) {
			trace("EEEEE:" + e);
		}
		return switch [e.isValue, e.expr.expr] 
		{
			case [nested, EBlock([x])]:

				transformExpr(x,nested, e.nextId);


			case [_, EBlock([])]:
				liftExpr(macro null);

			case [false, EBlock(exprs)]: 
				transformExprsToBlock(exprs, false, e.expr.pos, e.nextId);
			

			case [true, EBlock(exprs)]:// transform block to function and call it
				var name = e.nextId();

				var exprs = exprs.copy();

				var ret = exprs.pop();

				var block = exprs.concat([macro return $ret]);



				var myBlock = transformExprsToBlock(block, false, e.expr.pos, e.nextId);

				//trace(ExprTools.toString(myBlock.expr));

				var f = addNonLocalsToFunc(macro function $name () ${myBlock.expr});

				var substitute = macro $i{name}();

				
				
				//blockToFunc(exprs, e);
				liftExpr(substitute, [f]);

			case [false, EFunction(n, f)]:
				// top level function = instance or static functions
				var e1 = toExpr(transformExpr(f.expr, false, e.nextId));
				
				var newName = if (n == null) e.nextId() else n;
				var f = { expr : EFunction(newName, { expr : e1, params : f.params, ret : f.ret, args : f.args}), pos : e.expr.pos };
				liftExpr(f);
			
			case [true, EFunction(name, f)]:
				//trace("here we go: " + name);
				

				var newExpr = switch (addNonLocalsToFunc(e.expr).expr) {
					case EFunction(name, f): f.expr;
					case _: throw "unexpected";
				}

				var newName = if (name == null) e.nextId() else name;
				//trace(newName);
				var e1 = toExpr(transformExpr(newExpr, false, e.nextId, []));



				var f = { expr : EFunction(newName, { expr : e1, args : f.args, params:f.params, ret:f.ret }), pos : e.expr.pos };
				
				
				liftExpr( macro $i{newName}, false, e.nextId, [f]);
				

			
			case [_, EVars(vars)]:
				
				var b = [];
				var newVars = [];

				for (v in vars) {
					var newExpr = if (v.expr == null) {
						null;
					} else {
						//trace("var decl : " + ExprTools.toString(v.expr));
						var f = transformExpr(v.expr, true, e.nextId);
						
						b = b.concat(f.blocks);
						
						f.expr;
					}
					newVars.push({ name : v.name, type : v.type, expr : newExpr});
				}

				liftExpr({ expr : EVars(newVars), pos:e.expr.pos}, false, e.nextId, b);

			case [_,EReturn(x)] if (x == null):e;
			case [_,EReturn({ expr : EFunction(name, f)})]:
				var n = if (name == null) e.nextId() else name;
				
				var e1 = toExpr(transformExpr(f.expr,true, e.nextId));
				
				var f1 = { expr : EFunction(n, { expr : e1, params : f.params, ret : f.ret, args : f.args}), pos : e.expr.pos };
				



				liftExpr({ expr : EReturn(macro $i{n}), pos : e.expr.pos}, true, e.nextId, [f1]);				
			case [_,EReturn(x)]:

				var x1 = transformExpr(x,true, e.nextId, []);


				

				

				var res = if (x1.blocks.length > 0) {
					var f = exprsToFunc(x1.blocks.concat([x1.expr]), e.nextId(), e);
					//trace(ExprTools.toString(f.expr));
					liftExpr({ expr : EReturn(f.expr), pos : e.expr.pos}, true, e.nextId, f.blocks);
				} else {
					liftExpr({ expr : EReturn(x1.expr), pos : e.expr.pos}, true, e.nextId, []);
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
			
			case [false,EParenthesis(e1)]:
				//trace(e1);
				var newE1 = transformExpr(e1,false,e.nextId);
				//trace(newE1);
				var newP = { expr : EParenthesis(newE1.expr), pos : e.expr.pos};

				liftExpr(newP, true, e.nextId, newE1.blocks);

			case [true,EParenthesis(e1)]:
				forwardTransform(e1, e);
				// trace(e1);
				// var newE1 = transformExpr(e1,true,false,e.nextId);
				// trace(newE1);
				// var newP = { expr : EParenthesis(newE1.expr), pos : e.expr.pos};

				// liftExpr(newP, false, true, e.nextId, newE1.blocks);

			case [true, EIf(econd, eif, eelse)]:
				// eif in assignment
				//trace(ExprTools.toString(eif));
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
						//Lambda.iter(eif1.blocks, function (x) trace(haxe.macro.ExprTools.toString(x)));
						var f = exprsToFunc(eif1.blocks.concat([eif1.expr]), fname,e);
						trace(ExprTools.toString(f.expr));
						blocks = blocks.concat(f.blocks);
						//trace(ExprTools.toString(f.expr));
						return f.expr;
					}

					if (eif1.blocks.length == 1) {
						switch (eif1.blocks[0].expr) {
							case EFunction(name, f):
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
							case EFunction(name, f):
								blocks.push(eelse1.blocks[0]);
								eelse1.expr;
							case _:regular();
						}
					} else regular();
				} else if (eelse1 != null) {

					eelse1.expr;
				} else {
					null;
				}
				
				//trace(ExprTools.toString(eif2));
				var newIf = { expr : EIf(econd1.expr, eif2, eelse2), pos : e.expr.pos };
				//trace(ExprTools.toString(newIf));
				
				var f = exprsToFunc(econd1.blocks.concat(blocks).concat([newIf]), e.nextId(), e);
				liftExpr(f.expr, true, e.nextId, f.blocks);
				//liftExpr(newIf, true, true, e.nextId, econd1.blocks.concat(blocks));
				

			case [false, EIf(econd, eif, eelse)]:

				
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

				var newIf = { expr : EIf(econd1.expr, eif1, eelse1), pos : e.expr.pos };
				//trace(ExprTools.toString(newIf));
				liftExpr(newIf, false, e.nextId, econd1.blocks);


			case [false, EWhile(econd, e1, true)]:
				var econd1 = transformExpr(econd, true, e.nextId);

				var e11 = toExpr(transformExpr(e1, false, e.nextId));

				var newWhile = macro while(${econd1.expr}) $e11;
				liftExpr(newWhile, false, e.nextId, econd1.blocks);

			case [true, EWhile(econd, e1, true)]:
				var econd1 = transformExpr(econd, true, e.nextId);

				var e11 = toExpr(transformExpr(e1, false, e.nextId));


				var newWhile = macro while(${econd1.expr}) $e11;
				var newRet = macro null;

				var f = exprsToFunc(econd1.blocks.concat([newWhile, newRet]), e.nextId(), e);
				liftExpr(f.expr, true, e.nextId, f.blocks);

				//liftExpr(newWhile, true, false, e.nextId, econd1.blocks);

			// todo
			//case [_,true, EWhile(econd, e1, true)]:
				// assignment while promote to function with null return


			case [_, ESwitch(e1, cases,edef)]:
				// transform eswitch into if/else
				//trace(e.expr.toString());
				function caseToIf (c:Case, ?eelse:Expr) {

					var eif = eelse;

					var valReversed = c.values.copy();
					valReversed.reverse();

					for (v in valReversed) {
						//trace(ExprTools.toString(v));
						eif = switch (v.expr) 
						{
							case ECall({expr:EConst(CIdent(x))}, params): // enum constructor with params

								var assigns = Lambda.array(Lambda.mapi(params, function (index, p) {
									return switch (p.expr) {
										case EConst(CIdent(name)):
											{ name : name, type : null, expr : macro untyped __python_array_get__($e1.params,$v{index})};
										case _ :
											throw "unexpected param expr " + haxe.macro.ExprTools.toString(p);
									}
								}));

								var assignExpr = { expr : EVars(assigns), pos : v.pos};
								
								var bodyExpr = if (c.guard != null) {
									if (eif == null) {
										macro if (${c.guard}) ${c.expr} else null;
									} else {
										macro if (${c.guard}) ${c.expr} else $eif;	
									}
								} else {
									//trace(ExprTools.toString(c.expr));
									c.expr;
								}
								if (eif != null) {
									macro if ($e1.tag == $v{x}) {
										// extract vars and test guard
										$assignExpr;
										$bodyExpr;
									} else $eif;
								} else {
									macro if ($e1.tag == $v{x}) {
										// extract vars and test guard
										$assignExpr;
										$bodyExpr;
									} else null;
								}
							case EConst(CIdent("true"|"false")): // enum constructor
								var cond = v;
								if (c.guard != null) {
									cond = macro $cond && ${c.guard}
								}
								if (eif == null) {
									macro if ($cond) ${c.expr} else null;
								} else {
									macro if ($cond) ${c.expr} else $eif;
								}
							case EConst(CIdent(x)): // enum constructor
								trace(ExprTools.toString(e1));
								var cond = macro $e1.tag == $v{x};
								if (c.guard != null) {
									cond = macro $cond && ${c.guard}
								}
								if (eif == null) {
									macro if ($cond) ${c.expr} else null;
								} else {
									macro if ($cond) ${c.expr} else $eif;
								}
								

							case EConst(_) | EField(_,_) : // constant value

								var cond = macro $e1 == $v;
								if (c.guard != null) {
									cond = macro $cond && ${c.guard}
								}
								if (eif == null) {
									macro if ($cond) ${c.expr} else null;
								} else {
									macro if ($cond) ${c.expr} else $eif;
								}
							

							case _:
								trace(v);
								throw "this kind of case expr is not yet implemented " + haxe.macro.ExprTools.toString(v);
						}

						
					}
					
					return eif;
					
				}


				var res = null;
				var revCases = cases.copy();
				revCases.reverse();

				if (edef != null && edef.expr == null) {
					edef = macro {};
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
				//trace(ExprTools.toString(res));
				forwardTransform(res, e);

			case [_, EWhile(econd, e1, false)]:
				//trace("transform do while");
				var newE1 = switch (e1.expr) {
					case EBlock(exprs):
						{ expr : EBlock(exprs.concat([macro @:pos(e1.pos) if (!$econd) break])), pos : e.expr.pos};
					case _: 
						{ expr : EBlock([e1].concat([macro @:pos(e1.pos) if (!$econd) break])), pos : e.expr.pos};
				}
				var newExpr = { expr : EWhile(macro true, newE1, true), pos : e.expr.pos};
				//trace(ExprTools.toString(newExpr));
				forwardTransform(newExpr, e);

			
			case [_, EUnop(OpIncrement, false, e1)]:
				
				forwardTransform(macro @:pos(e.expr.pos) $e1 = $e1 + 1,e);				
			case [_, EUnop(OpDecrement,false, e1)]:
				
				forwardTransform(macro @:pos(e.expr.pos) $e1 = $e1 - 1,e);
			
			case [_, EUnop(OpIncrement, true, e1)]:
				
				forwardTransform(macro @:pos(e.expr.pos) { var _hx_r = $e1; $e1 = $e1 + 1; _hx_r;},e);				
			case [_, EUnop(OpDecrement,true, e1)]:
				
				forwardTransform(macro @:pos(e.expr.pos) { var _hx_r = $e1; $e1 = $e1 - 1; _hx_r;},e);

			case [_, EUnop(op,false, e1)]:
				var e2 = transformExpr(e1, true, e.nextId);

				var newE = { expr : EUnop(op, false, e2.expr), pos : e.expr.pos };
				liftExpr(newE,e2.blocks);

			case [true, EBinop(OpAssign,left,right)]:
				//trace(ExprTools.toString(e.expr));
				var ex = e.expr;
				var right1 = transformExpr(right, true, e.nextId);
				var left1 = transformExpr(left, true, e.nextId);

				var newEx = macro @:pos(e.expr.pos) ${left1.expr} = ${right1.expr};

				var blocks = left1.blocks.concat(right1.blocks).concat([newEx]);

				exprsToFunc(blocks, e.nextId(),e);

				
				
			case [_, EBinop(OpAssign,left,right)]:
				var left1 = transformExpr(left, true, e.nextId);
				var right1 = transformExpr(right, true, e.nextId);
				var newEx = { expr : EBinop(OpAssign, left1.expr, right1.expr), pos : e.expr.pos };

				liftExpr(newEx, false, e.nextId, left1.blocks.concat(right1.blocks));				

			case [_, EBinop( OpAssignOp(x),left,right)]:
				//trace(ExprTools.toString(e.expr));
				forwardTransform({ expr : EBinop(OpAssign, left, { expr : EBinop(x, left, right), pos:e.expr.pos }), pos : e.expr.pos}, e);

			case [true, EBinop(op,left,right)]:
				//trace(ExprTools.toString(e.expr));
				var ex = e.expr;
				var right1 = transformExpr(right, true, e.nextId);
				var left1 = transformExpr(left, true, e.nextId);

				var newEx = { expr : EBinop(op, left1.expr, right1.expr), pos : e.expr.pos };

				if (left1.blocks.length > 0 || right1.blocks.length > 0) {
					var blocks = left1.blocks.concat(right1.blocks).concat([newEx]);

					exprsToFunc(blocks, e.nextId(),e);
				} else {
					liftExpr(newEx, false, e.nextId,[]);
				}

			case [_, EBinop( op,left,right)]:
				var right1 = transformExpr(right, true, e.nextId);
				var left1 = transformExpr(left, true, e.nextId);

				var ex = { expr : EBinop(op, left1.expr, right1.expr) , pos : e.expr.pos };
				liftExpr(ex, false, e.nextId, left1.blocks.concat(right1.blocks));

			case [false, ETry( etry,catches)]:
				var try1 = transformExpr(etry, false, e.nextId);
				var catches1 = [for (c in catches) transformExpr(c.expr, false, e.nextId)];

				var blocks = try1.blocks.concat([for (c in catches1) for (b in c.blocks) b]);

				var newCatches = [for (i in 0...catches.length) { expr : catches1[i].expr, type : catches[i].type, name : catches[i].name }];

				var ex = { expr : ETry(try1.expr, newCatches), pos : e.expr.pos};
				
				liftExpr(ex, false, e.nextId, try1.blocks.concat(blocks));
			case [true, EThrow(x)]:
				var block = macro @:pos(e.expr.pos) {
					throw $x;
					null;
				}
				forwardTransform(block, e);				
			

			//  case [_, ECall(e1={ expr : EConst(CIdent("trace"))},params)]:
			// TODO 
			// at this point we have to make sure that each operand of each parameter which is a nested binary plus expression
			// is surrounded with a Std.string otherwise we could run into some python trouble because python does not implicitly convert
			// parameters into Strings when doing concatenations.	
			// But this would only be a solution for the special trace case, it would be better to
			// have access to the expr type to make sure that implicit casts are applied in binary expression during printing.
			
			
			
			


				
			case [_, ECall(e1,params)]:
				//trace(ExprTools.toString(e.expr));
				var e1_ = transformExpr(e1, true, e.nextId);
				
				var params1 = [for (p in params) transformExpr(p, true, e.nextId)];

				var blocks = e1_.blocks.concat([for (p in params1) for (b in p.blocks) b]);

				var params2 = [for (p in params1) p.expr];

				var ex = { expr : ECall(e1_.expr, params2), pos : e.expr.pos };
				liftExpr(ex, false, e.nextId, blocks);
			

			case [true, EArray( e1, e2)]:
				var e1_ = transformExpr(e1, true, e.nextId);
				var e2_ = transformExpr(e2, true, e.nextId);

				var ex = { expr : EArray(e1_.expr, e2_.expr), pos : e.expr.pos };

				liftExpr(ex, e1_.blocks.concat(e2_.blocks));


			case [true, ETry( etry,catches)]:
				
				var pos = e.expr.pos;
				var etry1 = macro @:pos(pos) _hx_t = $etry;

				var id = e.nextId();

				var catches1 = [for (c in catches) { name : c.name, type :c.type, expr : macro @:pos(pos) $i{id} = ${c.expr} }];

				var newTry = { expr : ETry(etry1, catches1), pos : pos};


				var varExpr = { expr : EVars([{ name : id, expr : macro null, type : null}]), pos : pos};

				var block = macro @:pos(pos) {
					$varExpr;
					$newTry;
					$i{id};
				}

				forwardTransform(block, e);				
			case [true, EObjectDecl( fields)]:
				//trace("ANON:" + ExprTools.toString(e.expr));
				var newFields = [for (f in fields) { field : f.field, ex: transformExpr(f.expr, true, e.nextId, [])}];
				var newFields1 = [for (f in newFields) { field : f.field, expr : f.ex.expr}];

				var blocks = [];
				for (f in newFields) {
					blocks = blocks.concat(f.ex.blocks);
				}

				var ex = { expr : EObjectDecl(newFields1), pos : e.expr.pos };

				liftExpr(ex, false, e.nextId, blocks);

				//exprsToFunc(blocks.concat([ex]), e.nextId(), e);
			case [false, EObjectDecl( fields)]:
				var newFields = [for (f in fields) { field : f.field, ex: transformExpr(f.expr, true, e.nextId, [])}];
				var newFields1 = [for (f in newFields) { field : f.field, expr : f.ex.expr}];

				var blocks = [];
				for (f in newFields) {
					blocks = blocks.concat(f.ex.blocks);
				}

				var ex = { expr : EObjectDecl(newFields1), pos : e.expr.pos };

				liftExpr(ex, false, e.nextId, blocks);

			case [_, ECast(ex, t)]:
				var ex1 = transformExpr(ex, true, e.nextId, []);


				liftExpr({ expr : ECast(ex1.expr, t), pos : e.expr.pos}, ex1.blocks);

			case [_, EUntyped(ex)]:
				var ex1 = transformExpr(ex, true, e.nextId, []);


				liftExpr({ expr : EUntyped(ex1.expr), pos : e.expr.pos}, ex1.blocks);

			case [_, EField( ex, f)]:
				var ex1 = transformExpr(ex, true, e.nextId, []);


				liftExpr({ expr : EField(ex1.expr, f), pos : e.expr.pos}, ex1.blocks);
				


			case _ : liftExpr(e.expr);
		}
	}
}

