(* 

TYPE CHECKING

(Static) type-checking can reject a program before it runs to
prevent the possbility of some errors
- A feature of statically typed languages

Dynamically typed languages do little (none?) such checking
- So might try to treat a number as a function at run-time

Will study relative advantages after some Racket
- Racket, Ruby (and Python, JS) dynamically typed

ML (and Java, C#, Scala, C, C++) is statically typed
- Every binding has one type, determined "at comiple-time"



IMPLICITLY TYPED

ML is statically typed
ML is implicitly typed: rarely need to write down types

fun f x = // infer val f : int -> int
    if x > 3
    then 42
    else x * 2

fun g x = // report type error
    if x > 3
    then true
    else x * 2


Statically typed: much more like Java than Javascript



TYPE INFERENCE

Type inference problem: Give every binding/expression a type
such that type-checking succeeds
- Fail iff no solution exists

In principle, could be a pass before the type-checker
- But often implemented together

Type inference can be easy, difficult, or impossible
- Easy: Accept all programs
- Easy: Reject all programs
- Subtle, elegant, and not magic: ML

 *)