(* 

ML has (separate) mutation

Mutable data structures are okay in some situations
- When "update to state of world" is appropriate model
- but most language constructs truly immutable

ML does this with a separate construct: references

Introducing now because we will use them for next closure idiom

Do not use references on your homework
- you need practice with mutation-free programming
- They will lead to less elegant solutions

 *)

 (* 
 
 REFERENCES

 - New types: t ref where t is a type

 - New expressions:
 -- ref e to create a reference with initial contents e
 -- e1 := e2 to update contents
 -- !e to retrieve contents (not negation)
 
  *)

val x = ref 42
val y = ref 42
val z = x
val _ = x := 43;
val w = (!y) + (!z)  (* 85 *)

(* 

A variable bound to a reference (eg x) is still immutable: it will always refer to the same reference
But the contents of the reference may change via :=
and there may be aliases to the references, which matter a lot
reference are first-class values
Like a one-field mutable object, so := and ! don't specify the field
 *)