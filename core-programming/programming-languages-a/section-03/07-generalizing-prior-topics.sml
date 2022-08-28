(* 

Generalizing

Our examples of first-class functions so far have all:
- taken one function as an argument to another function
- processed a number or a list

But first-class functions are useful anywhere for any kind of data
- can pass several functions as args
- can put functions in data structures (tuples, lists, etc)
- can return functions as results
- can write higher-order functions that traverse your own data structures

Useful whenever you want to abstract over "what to compute with"
- no new language features

 *)

fun double_or_triple f =
    if f 7
    then fn x => 2 * x
    else fn x => 3 * x;

val double = double_or_triple (fn x => x - 3 = 4);
val nine = (double_or_triple (fn x => x = 42)) 3;

(* 

RETURNING FUNCTIONS

type double_or_triple is

(int -> bool) -> (int -> int)

But the REPL prints (int -> bool) -> int -> int
because it never prints unnecessary parentheses and

t1 -> t2 -> t3 -> t4 means
t1 -> (t2 -> (t3 ->t4))

 *)


 (* 
 
 OTHER DATA STRUCTURES

 Higher order functions are not just for numbers and lists

 They work great for common recursive traversals over your own
 data structures (datatype bindings) too

 Example of a higher-order predicate:

 - are all constants in an arithmetic expression even numbers?

 - use a more general function of type

   (int -> bool) * exp -> bool

 - and call it with (fn x => x mod 2 = 0)
 
 
  *)

datatype exp = Constant of int
                | Negate of exp
                | Add of exp * exp
                | Multiply of exp * exp;

(* given an exp, is every constant in it an even number? *)

fun true_of_all_constants(f,e) =
    case e of
        Constant i => f i
        | Negate e1 => true_of_all_constants(f, e1)
        | Add(e1,e2) => true_of_all_constants(f,e1)
                        andalso true_of_all_constants(f,e2)
        | Multiply(e1,e2) => true_of_all_constants(f,e1)
                            andalso true_of_all_constants(f,e2);

fun all_even e = true_of_all_constants((fn x => x mod 2 = 0), e);