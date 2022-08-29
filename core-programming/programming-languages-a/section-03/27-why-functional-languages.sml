(* 

FUNCTIONAL PROGRAMMING

Why spend 60-80% of course using functional languages:
- Mutation is discouraged
- Higher-order functions are very convenient
- One-of types via constructs like datatypes

Because:
1. These features are invaluable for correct, elegant, efficient software (great way to think about computation)
2. Functional languages have always been ahead of their time
3. Functional langauges well-suited to where computing is going

 *)

 (* 
 
 AHEAD OF THEIR TIME

 All these were dismissed as "beautiful, worthless, slow things PL professors make you learn"

 - Garbage collection (Java didn't exist in 1995, PL courses did)
 - Generics (List<T> in Java, C#), much more like SML than C++
 - XML for universal data representation (like Racket/Scheme/LISP/...)
 - Higher-order functions (Ruby, Javascript, C#,...)
 - Type inference (C#, Scala, ...)
 - Recursion (a big fight in 1960 about this - I'm told)
 - ...
 
  *)


(* 

THE FUTURE MAY RESEMBLE THE PAST

Somehow nobody notices we are right... 20 years later

- "To conquer" vs "to assimilate"
- Societal progress takes time and muddles "taking credit"
- Maybe pattern-matching, currying, hygienic macros, etc will be next

 *)


 (* 
 
 Recent-ish Surge, Part 1

 Other popular functional PLs
 - Clojure, Erlang, F#, Haskell, OCaml, Scala
 
  *)

  (* 
  
  Recent-ish Surge, Part 2

  Popular adoption of concepts:
  - C#, LINQ (closures, type inference,...)
  - Java 8 (closures)
  - MapReduce / Hadoop
  -- Avoiding side-effects essential for fault-tolerance here

   *)

   (* 
   
   WHY A SURGE?

   My best guess:

   - Concise, elegant, productive programming

   - Javascript, Python, Ruby helped break the Java/C/C++ hegemony

   - Avoiding mutation is the easiest way to make concurrent and parallel programming easier
   -- In general, to handle sharing in complex systems

   - Sure, functional programming is still a small niche, but there is so much
     software in the world today even niches have room
   
    *)