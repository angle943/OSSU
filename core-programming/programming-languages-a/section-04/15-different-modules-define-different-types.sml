(* 

CANT MIX-AND-MATCH MODULE BINDINGS

Modules with the same signatures still define different types

So things like this do not type-check:
- Rational1.toString(Rational2.make_frac(9,6))
- Rational3.toString(Rational2.make_frac(9,6))

This is a crucial feature for type system and module properties:
- Different modules have different internal invariants!
- In fact, they have different type definitions
-- Rational1.rational looks like Rational2.rational, but clients and the type-checker do not know that
-- Rational3.rational is int*int not a datatype


 *)