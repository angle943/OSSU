(* 

Review:

- types: int bool unit t1 *...*tn t list t1*...*tn -> t
- - types "nest" (each t above can be itself a compound type)

- Variables, environments, and basic expressions

- functions
- - build: fun x0 (x1:t1,...,xn:tn) = e
- - use: e0 (e1,...,en)

- Tuples:
- - Build: (e1,...,en)
- - Use: #1 e, #2 e, ...

- Lists:
- - Build: [] e1::e2
- - Use: null e  hd e  hl e

 *)



 (* 
 
 Let-expressions:

 Syntax:
 -  let b1 b2 ... bn in e end
 - - Eeach bi is any binding and e is any expression

 Type-Checking:
 - type-check each bi and e in a static environment that includes the previous bindings.
 - type of whole let-expression is the type of e

 Evaluation:
 - Evaluate each bi and e in a dynamic environment that includes the previous bindings.
 - result of whole let-expression is result of evaluating e.

  *)

  fun silly1 (z : int) =
    let
        val x = if z > 0 then z else 34
        val y = x + z + 9
    in
        if x > y then x * 2 else y * y
    end;

fun silly2 () =
    let
        val x = 1
    in
        (let val x = 2 in x + 1 end) + (let val y = x+2 in y+1 end)
    end;


(*

WHATS NEW

- scope: where a binding is in the environment.


 *)