(* 

SIGNATURES

A signature is a type for a module
- what bindings does it have and what are their types

can define a signature and ascribe it to modules - example:

 *)

signature MATHLIB =
sig
val fact : int -> int
val half_pi : real
val doubler : int -> int
end

structure MyMathLib :> MATHLIB =
struct
fun fact x = x
val half_pi = Math.pi / 2.0
fun doubler x = x * 2
end

(* 

IN GENERAL

Signatures:

    signature SIGNAME =
    sig types-for-bidnings end

- can include variables, types, datatypes, and exceptions defined in module

Ascribing a sigature to a module:

    structure MyModule :> SIGNAME =
    struct bindings end

- Module will not type-check unless it matches the signature,
  meaning it has all the bindings at the right types

- Note: SML has other forms of ascription; we will stick with these [opaque signatures]


HIDING THINGS

Real value of signatures is to hide bindings and type definitions
- So far, just documenting and checking the types

Hiding implementation details is the most important strategy for writing correct, robust, reusable software

So first remind ourselves that functions already do well for some forms of hiding...


HIDING WITH FUNCTIONS

These three functions are totally equivalent: no client can tell which we are using (so we can change our choice later):

    fun double x = x*2
    fun double x = x+x
    val y = 2
    fun double x = x*y

Defining helper functions locally is also powerful
- can change/remove functions later and know it affects no other code

Would be convenient to have "private" top-level functions too
- so two functions could easily share a helper function
- ML does this via signatures that omit bindings...


EXAMPLE

outside the module, MyMathLib.doubler is simply unbound
- so cannot be used (directly)
- fairly powerful, very simple idea

 *)

signature MATHLIB =
sig
val fact : int -> int
val half_pi : real
end

structure MyMathLib :> MATHLIB =
struct
fun fact x = x
val half_pi = Math.pi / 2.0
fun doubler x = x * 2
end