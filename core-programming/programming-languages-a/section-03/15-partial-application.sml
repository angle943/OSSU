(* 

TOO FEW ARGUMENTS

- Previously used currying to simulate multiple arguments

- But if caller provides "too few" arguments, we get back a closure "waiting for the remaining args"
-- Called partial application
-- convenient and useful
-- can be done with any curried function

- No new semantics here: a pleasant idiom

 *)

 fun sorted3 x y z = z >= y andalso y >= x

 fun fold f acc xs =
    case xs of
        []          => acc
        | x::xs'    => fold f (f(acc,x)) xs'

(* 

If a curried function is applied to "too few" args, that
returns, which is often useful.
A powerful idiom (no new semantics)

 *)

val is_nonnegative = sorted3 0 0

val sum = fold (fn (x,y) => x+y) 0

(* In fact, not doing this is often a hrder-to-notice version of
   unnecesary function wrapping, as in these inferior versions
 *)

fun is_nonnegative_inferior x = sorted3 0 0 x

fun sum_inferior xs = fold (fn (x,y) => x+y) 0 xs

(* another example *)

fun range i j = if i > j then [] else i :: range (i+1) j

(* range 3 6 -> [3,4,5,6] *)

val countup = range 1

(* countup 6 -> [1,2,3,4,5,6] *)

fun countup_inferior x = range 1 x

(* 

Common style is to curry higher-order functions with function arguments
First to enable conveient partial application

 *)

fun exists predicate xs =
    case xs of
        [] => false
        | x::xs' => predicate x orelse exists predicate xs'

val no = exists (fn x => x=7) [4,11,23]

val hasZero = exists (fn x => x=0) (* int list -> bool *)

val incrementAll = List.map (fn x => x + 1) (* int list -> int list *)

(* library functions foldl, List.filter, etc, also curried: *)

val removeZeros = List.filter (fn x => x <> 0)

(* 

But if you get a strange message about "value restriction",
put back in the actually-necessary wrapping or an explicit
non-polymorphic type

 *)

(* 
doesn't work for reasons we won't explain here (more later)
Only an issue will polymorphic functions

 *)

 (* val pairWithOne = List.map (fn x => (x,1)) *)



 (* 
 
 THE VALUE RESCTRICTION APPEARS :(

If you use partial application to create a polymorphic function, it may not work due to the value restriction

- Warning about "type vars not generalized"
-- And won't let you call the function

- This should surprise you; you did nothing wrong but still must change your code

- see the code for workarounds

- can discuss a bit more when discussing type inference
 
  *)

(* DOES NOT WORK *)
 (* val pairWithOne = List.map (fn x => (x,1)) *)

(* workarounds: *)
fun pairWithOne xs = List.map (fn x => (x,1)) xs

val pairWithOne : string list -> (string * int) list = List.map (fn x => (x,1))

(* this function works fine because result is not polymorphic *)
val incrementAndPairWithOne = List.map (fn x => (x+1,1))