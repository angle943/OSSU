(* 

MORAL OF TAIL RECURSION

Where reasonably elegant, feasible, and important, rewriting functions to be tail-recursive
can be much more efficient.
- Tail-recursive: recursive calls are tail-calls

There is a methodology that can often guide this transformation:
- create a helper function that takes an accumulator
- old base case becomes initial accumulator
- new base case becomes the final accumulator


 *)

 fun sum xs =
    case xs of
        [] => 0
        | x::xs' => x + sum xs';

fun sum xs =
    let fun aux (xs, acc) =
            case xs of
                [] => acc
                | x::xs' => aux(xs',acc+x)
    in
        aux(xs,0)
    end;

fun rev xs =
    case xs of
        [] => []
        | x::xs' => (rev xs') @ [x];

fun rev xs =
    let fun aux (xs, acc) =
            case xs of
                [] => acc
                | x::xs' => aux (xs', x::acc)
    in
        aux(xs,[])
    end;