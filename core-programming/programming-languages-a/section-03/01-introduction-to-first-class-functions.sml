(* 

WHAT IS FUNCTIONAL PROGRAMMING?

"Functional programming" can mean a few different things:

1. Avoiding mutation in most/all cases (done and ongoing)

2. Using functions as values (this section)

...
- Style encouraging recursion and recursive data structures
- Style closer to mathematical definitions
- Programming idioms using laziness (later topic, briefly)
- Anything not OOP or C? (not a good definition)

Not sure a definition of "functional language" exists beyond "makes
functional programming easy / the default / required"
- no clear yes/no for a particular language

 *)

 (*  *)


 (* 
 
 FIRST-CLASS FUNCTIONS

 - First-class functions: CCan use them wherever we use values
 -- Functions are values too
 -- Arguments, results, parts of tuples, bound to variables, carried by datatype constructors or exceptions,...

 fun double x = 2*x
 fun incr x = x+1
 val a_tuple = (double, incr, double(incr 7));

 - Most common use is an argument / result of another function
 -- Other function is called a higher-order function
 -- Powerful way to factor out common functionality
 
  *)

fun double x = 2 * x;
fun incr x = x + 1;
val a_tuple = (double, incr, double(incr 7));
val eighteen = (#1 a_tuple) 9;


(* 

FUNCTION CLOSURES

- Function Closure: Functions can use bindings from outside the function definition (in scope where function is defined)
-- Makes first-class functions much more powerful
-- Will get to this feature in a bit, after simpler examples

- Distinction between terms first-class functions and function closures is not universally understood
-- Important conceptual disinction even if terms get muddled

 *)