(* 

Learn some deep truths about "what is really going on"
- Using much more syntactic sugar than we realized

- - Every val-binding and function-binding uses pattern-matching
- - Every function in ML takes exactly one argument

First need to extend our definition of pattern-matching


Each-of types

So far we have used pattern-matching for one-of types because we needed a 
way to access the values

Pattern matching also works for records and tuples:
- The pattern (x1,...,xn) matches the tuple value (v1,...,vn)
- The pattern {f1=x1,...,fn=xn} matches the record value {f1=v1,...,fn=vn} and (fields can be reordered)

 *)



(* 

Example. This is poor style, but based on what we learned so far, the only way to use patterns

 *)

 fun sum_triple_poor_style triple =
    case triple of
        (x, y, z) => x + y + z;

fun full_name_poor_style r =
    case r of
        {first=x, middle=y, last=z} => x ^ " " ^ y ^ " " ^ z;


(* 

Val-binding patterns

- New feature: A val-binding can use a pattern, not just a variable
- - Turns out variables are just one kind of pattern, so we just told you a half-truth in lecture 1)

val p = e;

- Great for getting (all) pieces out of an each-of type
- - can also get only parts out (not shown here)

- Usually poor style to put a constructor pattern in a val-binding
- - Tests for the one variant and raises an exception if a different one is there (like hd, tl, and valOf)

 *)

 (* 
 
Better Example

  *)

fun sum_triple triple =
    let val (x, y, z) = triple
    in
        x + y + z
    end;

fun full_name r =
    let val {first=x, middle=y, last=z} = r
    in
        x ^ " " ^ y ^ " " ^ z
    end;


(* 

    BEST EXAMPLE

a function argument can also be a pattern
- match against the argument in a function call

fun f p = e;

 *)


fun sum_triple (x, y, z) = x + y + z;

fun full_name {first=x, middle=y, last=z} = x ^ " " ^ y ^ " " ^ z;

val a = {first="Justin", middle="Jung", last="Kim"};
val b = {first="Justin", middle="Jung", middle2="Hyun", last="Kim"};

full_name a;
(* full_name b; DOESNT WORK *)


(* 

For homework 2, do not use the # character. Do not need to write down any explicit types

 *)

(* 

THE TRUTHS ABOUT FUNCTIONS

In ML, every function takes exactly one argument
- zero arguments is the unit pattern () matching the unit value ()

What we call multi-argument functions are just functions taking
one tuple argument, implemented with a tuple pattern in the function binding
- Elegant and flexible language design

Enables cute and useful things you cacnnot do in Java, e.g:

fun rotate_left (x, y, z) = (y, z, x);
fun rotate_right t = rotate_left(rotate-left t))

 *)