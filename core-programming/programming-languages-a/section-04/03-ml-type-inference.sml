(* 

OVERVIEW

Will describe ML type inference via several examples
- General algorithm is a slightly more advanced topic
- Supporting nested functions also a bit more advanced

Enough to help you "do type inference in your head"
- and appreciate it is not magic



KEY STEPS

Determine types of bindings in order
- except for mutual recursion
- So you cannot use later bindings: will not type-check

For each val or fun binding:
- Analyze definition for all necessary facts (constraints)
- Example: if see x > 0, then x must have type int
- Type error if no way for all facts to hold (over-constrained)

Afterward, use type variables (eg 'a) for any unconstrained types
- Example: an unused arg can have any type

Finally, enforce the value restriction, discussed later



VERY SIMPLE EXAMPLE

Next segments will go much more step-by-step
- like the autmated algorithm does

 *)

 val x = 42 (* val x : int *)

 fun f (y, z, w) = 
    if y (* val y : bool *)
    then z + x (* val z : int *)
    else 0 (* both branches have same type *)
(* 
    (bool * int * 'a) -> int
 *)



 (* 
 
 RELATION TO POLYMORPHISM

 Central feature of ML type inference: it can infer types with type variables
 - great for code reuse and understanding functions

 But remember there are two orthogonal concepts
 - languages can have type inference without type variables
 - languages can have type variables without type inference
 
  *)