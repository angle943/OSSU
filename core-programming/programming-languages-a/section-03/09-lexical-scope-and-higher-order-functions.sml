(* 

THE RULE STAYS THE SAME

A function body is evaluated in the environment where the function was defined (created)
- Extended with the function argument

Nothing changes to this rule when we take and return functions
- But "the environment" may involve nested let-expressions, not just the top-level sequence of bindings.

Makes first-class functions much more powerful
- even if it may seem counterintuitive at first.

 *)

 val x = 1

 fun f y =
    let
        val x = y+1
    in
        fn z => x + y + z
    end

val x = 3

val g = f 4
(* g = z => z + 9 *)

val y = 5

val z = g 6

(* z = 15 *)



(* Second Example *)

fun f g =
    let
        val x = 3
    in
        g 2
    end;

val x = 4;

fun h y = x + y; 
(* h(y) = 4 + y *)

val z = f h;
(* z = f(h) = h(2) = 6 *)