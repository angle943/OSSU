(* Write a function that appends two string lists *)
fun append (xs, ys) =
    case xs of
        [] => ys
        | x::xs' => x :: append(xs', ys);

(* you expect string list | string list -> string list, but it yeilds

'a list * 'a list -> 'a list

but this is okay

 *)

 (* fun count twoLists =
    case twoLists of
        ([], []) => 0
        | ([], y::ys) => 1 + twoLists([], ys)
        | (x::xs, []) => 1 + twoLists(xs, [])
        | (x::xs, y::ys) => 2 + twoLists(xs, ys); *)


(* 

Equality types

You might also see type variables with a second "quote"
- Example: ''a list * ''a -> bool

These are "equality types" that arise from using the = operator
- the = operator works on lots of types: int, string, tuples containing all equality types
- but not all types: funtion types, real, ...

The rules for more general are exactly the same except you have to replace an equality-type
variable with a type that can be used with =
- A strange feature of ML because = is special

 *)


 fun same_thing(x,y) =
    if x=y then "yes" else "no";

fun is_three x =
    if x=3 then "yes" else "no";