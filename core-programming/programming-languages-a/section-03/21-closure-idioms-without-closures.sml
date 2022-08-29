(* 

HIGHER-ORDER PROGRAMMING

- Higher-order programming, eg, with map and filter, is great

- Language support for closures makes it very pleasant

- Without closures, we can still do it more manually / clumsily
-- In OOP (eg Java) with one-method interfaces
-- In procedural (e.g. C) with explicit environment arguments

- Working through this:
-- Shows connection between language and features
-- Can help you understand closures and objects

 *)


 (* 
 
 OUTLINE

 This segment:
 - Just the code we will "port" to Java and/or C
 - Not using standard library to provide fuller comparison

 Next Segments:
 - The code in Java and/or C
 - What works well and what is painful
 
  *)

datatype 'a mylist = Cons of 'a * ('a mylist) | Empty

fun map f xs =
    case xs of
        Empty => Empty
        | Cons(x,xs) => Cons(f x, map f xs)

fun filter f xs =
    case xs of
        Empty => Empty
        | Cons(x,xs) => if f x then Cons(x,filter f xs) else filter f xs

fun length xs =
    case xs of
        Empty => 0
        | Cons (_,xs) => 1 + length xs


val doubleAll = map (fn x => x * 2)

fun countNs (xs, n : int) = length (filter (fn x => x=n) xs)