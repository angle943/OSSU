fun n_times (f,n,x) =
    if n=0
    then x
    else f (n_times(f,n-1,x));

(* Bad style since its unneccessary *)
fun nth_tail(n,xs) = n_times((fn x => tl x),n,xs);

fun nth_tail(n,xs) = n_times(tl,n,xs);


(* 

A style point

Compare:

if x then true else false

with

(fn x => f x)

So don't do unnecessary function wrapping


 *)

(* reverses a list *)
 List.rev;

fun rev xs = List.rev xs;

val rev = List.rev;