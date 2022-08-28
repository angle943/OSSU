(* 

ANOTHER FAMOUS FUNCTION: FOLD

fold (and synonyms/lcose relatives reduce, inject, etc.) is
another very famous iterator over recursive structures

Accumulates an answer by repeatedly applying f to answer so far

- fold(f,acc,[x1,x2,x3,x4]) computes to
  f(f(f(f(acc,x1),x2),x3),x4)

fun fold (f,acc,xs) =
    case xs of
        [] => acc
        | x::xs => fold(f, f(acc,x), xs)


This version "folds left"; another version "folds right"
Whether the direction matters depends on f (often not)

val fold = fn : ('a * 'b -> 'a) * 'a * 'b list -> 'a

 *)


 (*  *)


 (* 
 
 WHY ITERATORS AGAIN?

 These "iterator-like" functions are not built into the language
 - just a programming pattern
 - though many languages have built-in support, which often
   allows stopping early without resorting to exceptions

This pattern separates recursive traversals from data processing
- Can reuse same traversal for different data processing
- Can reuse same data processing for different data structures
- In both cases, using common vocabulary concisely communicates intent
 
  *)

fun fold (f,acc,xs) =
    case xs of
        [] => acc
        | x::xs => fold(f, f(acc,x), xs)

(* adds all ints in the list *)
fun f1 xs = fold ((fn (x,y) => x+y), 0, xs)


(* checks if all numbers in the list are non-negative *)
fun f2 xs = fold ((fn (x,y) => x andalso y >=0), true, xs)

(* counts all ints >=lo & <= hi *)
fun f3 (xs,lo,hi) =
    fold ((fn (x,y) => x + (if y>=lo andalso y<=hi then 1 else 0)), 0, xs)

(* checks if all strings are shorter than s  *)
fun f4 (xs, s) =
    let
      val i = String.size s
    in
      fold((fn (x,y) => x andalso String.size y < i), true, xs)
    end

(* checks if g(x) for all x in xs is true *)
fun f5 (g, xs) = fold((fn(x,y) => x andalso g y), true, xs)

fun f4Again (xs, s) =
    let
        val i = String.size s
    in
        f5((fn x => String.size x < i), xs)
    end


(* 

ITERATORS MADE BETTER

Functions like map, filter, and fold are much more powerful thanks to closures and lexical scope

Function passed in can use any "private" data in its environment

Iterator "doesn't even know the data is there" or what type it has


 *)