(* 

THE KEY POINT

Higher-rder functions are often so "generic" and "reusable" that they have polymorphic
types, ie, types with type variables

but there are higher-order functions that are not polymorphic

And there are non-higher-order (first-order) functions that are polymorphic

Always a good idea to understand the type of a function,
especially a higher-order function

 *)


 (*  *)

 (* 
 
 TYPES

 fun n_times (f,n,x) =
    if n=0
    then x
    else f (n_times(f,n-1,x));

val n_times : ('a -> 'a) * int * 'a -> 'a
- Simpler but less useful: (int -> int) * int * int -> int

Two of our examples instantiated 'a with int
one of our examples instantiated 'a with int list
This polymorphism makes n_times more useful

Type is inferred based on how arguments are used (later lecture)
- Describes which types mus be exactly something (eg int) and
  which can be anything but the same (eg 'a)
 
  *)

  fun double x = x+x;

(* higher-order function that is not polymorphic *)
fun times_until_zero (f,x) =
    if x=0 then 0 else 1 + times_until_zero(f, f x);

(* polymorphic but not higher-order *)
fun len xs =
    case xs of
        [] => 0
        | _::xs' => 1 + len xs';