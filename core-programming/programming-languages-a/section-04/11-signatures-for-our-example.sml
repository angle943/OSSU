(* 

A FIRST SIGNATURE

With what we know so far, this signature makes sense:
- gcd and reduce not visible outside the module

signature RATIONAL_A = 
sig
datatype rational = Whole of int | Frac of int*int
exception BadFrac
val make_frac : int * int -> rational
val add : rational * rational -> rational
val toString : rational -> string
end

structure Rational1 :> RATIONAL_A



THE PROBLEM

By revealing the datatype definition, we let clients violate our invariants
by directly creating values of type Rational1.rational
- At best a comment saying "must use Rational1.make_frac"

signature RATIONAL_A =
sig
datatype rational = Whole of int | Frac of int*int
...

Any of these would lead to ex eptions, infinite loops, or wrong results, which is why the module's
code would never return them:
- Rational1.Frac(1,0)
- Rational1.Frac(3,~2)
- Rational1.Frac(9,6)


SO HIDE MORE

Key idea: an ADT must hide the concrete type definition so clients cannot
create invariant-violating values of the type directly

Alas this attempt doesn't work because the signature now uses a type rational that is not known to exist:

signature RATIONAL_WRONG =
sig
exception BadFrac
val make_frac : int * int -> rational
val add : rational * rational -> rational
val toString : rational -> string
end

structure Rational1 :> RATIONAL_WRONG = ...



ABSTRACT TYPES

So ML has a feature for exactly this situation:

In a signature:

    type foo

means the type exists, but clients do not know its definition


signature RATIONAL_B = 
sig
type rational
exception BadFrac
val make_frac : int * int -> rational
val add : rational * rational -> rational
val toString : rational -> string
end

structure Rational1 :> RATIONAL_B = ...

THIS WORKS! AND IS A REALLY BIG DEAL

Nothing a client can do to violate invariants and properties:
- only way to make first rational is Rational1.make_frac
- after that can use only Rational1.make_frac, Rational1.add, and Rational1.toString
- Hides constructors and patterns - don't even know whether or not Rational1.rational is a datatype
- but clients can still pass around fractions in any way



TWO KEY RESTRICTIONS

So we have two powerful ways to use signatures for hiding:

1. Deny bindings exist (val-bindings, fun-bindings, constructors)

2. Make types abstract (so clients cannot create values of them or access
  their pieces directly)

(Later we will see a signature can also make a bindgin's type more specific
 than it is within the module, but this is less important)


A CUTE TWIST

In our example, exposing the Whole constructor is no problem

In SML we can expose it as a function since the datatype binding in the module does create such a function
- Still hiding the rest of the datatype
- still does not allow using Whole as a pattern


signature RATIONAL_C =
sig
type rational
exception BadFrac
val Whole : int -> rational
val make_frac : int * int -> rational
val add : rational * rational -> rational
val toString : rational -> string
end

 *)