(* 

WHEN THINGS EVALUATE

Things we know:
- A function body is not evaluated until the function is called
- A function body is evaluated every time the function is called
- A variable binding evaluates its expression when the binding is
  evaluated, not every time the variable is used


With closures, this means we can avoid repeating computations
that do not depend on function arguments
- Not so worried about performance, but good example to emphasize
  the semantics of function

 *)

fun filter (f, xs) =
    case xs of
        [] => []
        | x::xs' => if f x then x::(filter(f,xs')) else filter(f,xs')


(* Recomputing String.size s for every element in xs *)
fun allShorterThan1 (xs,s) =
    filter (fn x => String.size x < (print "!"; String.size s), xs)

(* does e1, throws away and does e2 *)
(* e1 ; e2 *)


(* computes String.size s once *)
fun allShorterThan2 (xs,s) =
    let
      val i = (print "!"; String.size s)
    in
      filter(fn x => String.size x < i, xs)
    end


val _ = print "\nwithAllShorterThan1: "

val x1 = allShorterThan1(["1","333","22","4444"],"xxx")

val _ = print "\nwithAllShorterThan2: "

val x2 = allShorterThan2(["1","333","22","4444"],"xxx")