fun n_times (f,n,x) =
    if n=0
    then x
    else f (n_times(f,n-1,x));

(* This triple dopesn't need to be in the top-level *)
fun triple x = 3*x;

fun triple_n_times (n,x) = n_times(triple,n,x);

(* This scopes triple to within the function only *)
fun triple_n_times (n,x) =
    let
      fun triple x = 3*x;
    in
      n_times(triple, n, x)
    end;

(* This scopes triple to within the arg, but looks weird *)
fun triple_n_times (n,x) =
    n_times(let fun triple x = 3*x in triple end,n,x);

(* ANONYMOUS FUNCTION USAGE *)
fun triple_n_times (n,x) =
    n_times((fn x => 3 * x), n, x);


(* 

USING ANONYMOUS FUNCTIONS

- Most common use: Argument to a higher-order function
-- Don't need a name just to pass a function

- BUT: cannot use an anonymous function for a recursive function
-- Because there is no name for making recursive calls
-- If not for recursion, fun bindings would be syntactic sugar for val bindings and anonymous functions

fun triple x = 3*x;
val triple = fn y => 3*y

 *)

 fun triple x = 3 * triple (x - 1);

(* This does not work *)
(* val triple2 = fn y => triple2 (y - 1); *)

(* Poor style *)
val triple_n_times = fn (n,x) => n_times((fn y => 3 * y), n, x);