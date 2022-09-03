(* 

KEY IDEA

Collect all the facts needed for type-checking

These facts constrain the type of the function

This segment:
- examples with type variables
- happens when constraints do not require particular types
    (but some types may still need to be the same as each other)

See the code file and/or the reading notes

 *)

(* 
    'a list -> int
 *)
fun length xs =
    case xs of
        [] => 0
        | x::xs' => 1 + (length xs')

(* 
    'a * 'a * 'b -> 'a * 'a * 'b
 *)
fun f (x,y,z) =
    if true
    then (x,y,z)
    else (y,x,z)

(* 
    ('b -> 'c) * ('a -> 'b) -> 'a -> 'c
 *)
fun compose (f,g) = fn x => f (g x)