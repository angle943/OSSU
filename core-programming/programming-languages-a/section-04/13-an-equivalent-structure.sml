(* 

EQUIVALENT IMPLEMENTATIONS

A key purpose of abstraction is to allow different implementations to be equivalent
- no client can tell which you are using
- so can improve/replace/choose implementations later
- easier to do if you start with more abstract signatures (reveal only what you must)

Now:
Another structure that can also have signature RATIONAL_A, RATIONAL_B, or RATIONAL_C
- But only equivalent under RATIONAL_B or RATIONAL_C

Next:
- A third equivalent structure implemented very differently


EQUIVALENT IMPLEMENTATIONS

- Structure Rational2 does not keep rationals in reduced form, instead reducing them "at last moment" in
  toString
  - Also make gcd and reduce local functions

- Not equivalent under RATIONAL_A
-- Rational1.toString(Rational1.Frac(9,6)) = "9/6"
-- Rational2.toString(Rational2.Frac(9,6)) = "3/2"

- Equivalent under RATIONAL_B or RATIONAL_C
-- Different Invariants, but same properties
-- Essential that type rational is abstract

 *)