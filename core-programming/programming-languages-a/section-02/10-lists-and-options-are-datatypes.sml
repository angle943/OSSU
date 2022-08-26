datatype my_int_list = Empty | Cons of int * my_int_list;

val x = Cons(4, Cons(23, Cons(2008, Empty)));

fun append_my_list (xs, ys) =
    case xs of
        Empty => ys
        | Cons(x, xs') => Cons (x, append_my_list(xs', ys));



(* 

    Options are datatypes

Options are just a predefined datatype binding
- NONE and SOME are constructors, not just functions
- so use pattern-matching not isSome and valOf

 *)

 fun inc_or_zero intoption =
    case intoption of
        NONE => 0
        | SOME i => i + 1;


(* 

    Lists are datatypes

Do not use hd, tl, or null either
- [] and :: are constructors too
- strange syntax, particularly infix

 *)

 fun sum_list xs =
    case xs of
        [] => 0
        | x::xs' => x + sum_list xs';

fun append (xs, ys) =
    case xs of
        [] => ys
        | x::xs' => x :: append (xs', ys);

(* 

Why pattern-matching

- Pattern-matching is better for options and lists for the same reasons as for all datatypes
- no missing cases, no exceptions for wrong variant, etc

- we just learned the other way first for pedagogy
- DO NOT USE ISSOME, VALOF, NULL, HD, TL ON HOMEWORK 2

- So why are null, tl, etc predefined?
-- for passing as args to other functions (next week)
- - because sometimes they are convenient
-- but not a big deal; you could define them yourself

 *)