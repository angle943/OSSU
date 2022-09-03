(* 

MORE INTERESTING EXAMPLE

Given a signature with an abstract type, different structures can:
- Have that signature
- but implement the abstract type differently

Such structures might or might not be equivalent

Example:
- type rational = int * int
- Does not have signature RATIONAL_A
- Equivalent to both previous examples under RATIONAL_B or RATIONAL_C

 *)

 structure Rational3 :> RATIONAL_B (* or C *)=
 struct
    type rational = int * int
    exception BadFrac

    fun make_fract (x,y) =
        if y = 0
        then raise BadFrace
        else if y < 0
        then (~x,~y)
        else (x,y)