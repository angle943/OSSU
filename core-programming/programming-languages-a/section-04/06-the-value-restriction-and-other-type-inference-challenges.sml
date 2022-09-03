(* 

TWO MORE TOPICS

ML type-inference story so far is too lenient
- Value restriction limits where polymorphic types can occur
- See why and then what

ML is in a "sweet spot"
- Type inference more difficult without polymorphism
- Type inference more difficult with subtyping

Important to "finish the story" but these topics are:
- a bit more advanced
- a bit less elegant
- will not be on the exam



THE PROBLEM

As presented so far, the ML type system is unsound!
- allows putting a value of type t1 (eg int) where we expect a value of type t2 (eg string)

A combination of polymorphism and mutation is to blame:

 *)

val r = ref NONE (*   val r : 'a option ref   *)
val _ = r := SOME "hi"

val i = 1 + valOf (!r)

(* 

Assignment type-checks because (infix) := has type

'a ref * 'a -> unit, so instantiate with string

Dereference type-checks because ! has type

'a ref -> 'a, so instantiate with int


WHAT TO DO

To restore soundness, we need a stricter type system that rejects at least one of these three lines

val r = ref NONE
val _ = r:= SOME "hi"
val i = 1 + valOf (!r)

And cannot make special rules for reference types because type-checker cannot know the defn of
all type synonyms
- Module system coming up

type 'a foo = 'a ref
val f = ref
val r = f NONE


THE FIX

value restriction: a variable-binding can have a polymorphic type only if the expression is a variable or value
- Function calls like ref NONE are neither

Else get a warning and unconstrained types are filled in with dummy types (basically unusable)

Not obvious this suffices to make type system sound, but it does



THE DOWNSIDE

As we saw pr4viously, the value restriction can cause problems
when it is unneccessary because we are not using mutation

val pairWithOne = List.map (fn x => (x,1))
(* does not get type 'a list -> ('a*int) list *)

The type-checker does not know List.map is not making mutable reference

Saw workarounds in previous segment on partial application
- Common one: wrap in a function binding

fun pairWithOne xs = List.map (fn x => (x,1)) xs

'a list -> ('a*int) list



A LOCAL OPTIMUM

Despite the value restriction, ML type inference is elegant and fairly easy to understand

More difficult without polymorphism
- What type should length-of-list have?

More difficult with subtyping
- suppose pairs are supertypes of wider tuples
- then val (y,z) = x constrains x to have at least two fields, not exactly two fields
- Depending on details, languages can support this, but types often more difficult to infer and understand

- Will study subtyping later, but not with type inference

 *)
