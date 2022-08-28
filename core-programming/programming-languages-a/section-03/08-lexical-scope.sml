(* 

VERY IMPORTANT CONCEPT

- We know function bodies can use any bindings in scope

- But now that functions can be passed around: In scope where?

Where the function was defined (not where it was called)

- This semantics is called lexical scope

- There are lots of good reasons for this semantics (why)
- - Discussed after explaining what the semantics is (what)
- - Later in course: implementing it (how)

- Must "get this" for homework, exams, and competent programming

 *)

 (* 1 *) val x = 1;
            (* x maps to 1 *)
 (* 2 *) fun f y = x + y;
            (* f maps to a function that adds 1 to its argument *)
 (* 3 *) val x = 2;
            (* x maps to 2 *)
 (* 4 *) val y = 3;
            (* x maps to 2, y maps to 3 *)
 (* 5 *) val z = f (x + y);
            (* f 5 => 6 *)

(* 

CLOSURES

How can functions be evaluated in old environments that aren't around anymore?
- The language implementation keeps them around as necessary

Can define the semantics of functions as follows:

- A function value has two parts
- - the code
- - the environment that was current when the function was defined

- This is a "pair" but unlike ML pairs, you cannot access the pieces
- All you can do is call this "pair"
- This pair is called a "Function Closure"
- A call evaluates the code part in the environment part (extended with the function argument)

 *)

(* 1 *) val x = 1;
(* 2 *) fun f y = x + y;
(* 3 *) val x = 2;
(* 4 *) val y = 3;
(* 5 *) val z = f (x + y);

(* 

Line 2 creates a closure and binds f to it:
- Code: "take y and have body x+y"
- Environment: "x map to 1"
- - Plus whatever else is in scope, including f for recursion

Line 5 calls the closure defined in line 2 with 5
- So body evaluated in environment "x maps to 1" extended with "y maps to 5"

 *)


 (* 
 
 COMING UP:

 Now you know the rule: lexical scope

 Next steps (rest of section):

 - Silly examples to demonstrate how the rule works with higher-order functions

 - Why the other natural rule, "dynamic scope", is a bad idea

 - Power idioms with higher-order functions that use this rule
 -- passing functions to iterators like filter
 -- several more idioms
 
  *)