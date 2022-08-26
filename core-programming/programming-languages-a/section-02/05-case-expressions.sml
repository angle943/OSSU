datatype mytype = TwoInts of int * int
                    | Str of string
                    | Pizza

(* mytype -> int *)
fun f (x : mytype) =
    case x of
        Pizza => 3
        | TwoInts(i1, i2) => i1+i2
        | Str s => String.size s;

f (Pizza);
f (Str "hi");
f (TwoInts(1,2));

(* 

CASE

ML combines the two aspects of accessing a one-of value with a case expression and pattern-matching
- Pattern-matching much more general/powerful (soon!)


- a multi-branch conditional to pick branch based on variant
- extracts data and binds to variables local to that branch
- type-checking: all branches must have same type
- evaluation: evaluates between case ... of and the right branch



Patterns

In general the syntax is:

case e0 of
    p1 => e1
    | p2 => e2
    ...
    | pn => en

For today, each "pattern" is a constructor name followed by the right number of variables
- Syntactically most patterns (all today) look like expressions
- but patterns are not expressions
- - we do not evaluate them
- - we see if the result of e0 matches them




WHY THIS WAY IS BETTER

0. you can use pattern-matching to write your own testing and data-extractions functions if you must
- but do not do that on your homework

1. You cannot forget a case (inexhaustive pattern-match warning)
2. you cannot duplicate a case (a type-checking error)
3. You will not forget to test the variant correctly and get an exception (like hd [])
4. pattern-matching can be generalized and made more powerful, leading to elegant and concise code

 *)