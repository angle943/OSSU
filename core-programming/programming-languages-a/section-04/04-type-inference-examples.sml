(* 

KEY IDEA

Collect all the facts needed for type-checking

These facts constrain the type of the function

This segment:
- Two examples without type variables
- and one example that does not type-check

See the code file and/or the reading notes

 *)

(* 
    (int * int) -> int
*)
fun f x =
    let val (y,z) = x in
        (abs y) + z
    end

(* 
    int list -> int
 *)
fun sum xs =
    case xs of
        [] => 0
        | x::xs' => x + (sum xs')

(* 
    doesn't work because sum_wrong takes in a list and x can't be a list
 *)
fun sum_wrong xs =
    case xs of
        [] => 0
        | x::xs' => x + (sum_wrong x)