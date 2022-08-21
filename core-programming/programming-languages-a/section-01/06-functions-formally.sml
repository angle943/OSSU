(* 
FUncitons:

Syntax: fun x0 (x1 : t1 , ... , xn : tn) = e

Evaluation: A function is a value!
 - adds x0 to dynamic env so later expressions can call it
 - function-call semantics will also allow recursion

 Type-checking:
 - adds binding x0 : (t1 * ... * tn) -> t if:
 - can type-check body e to have type t in the static environment containing:
 - - "Enclosing" static environment (earlier bindings)
 - - x1 : t1, ..., xN : tn (arguments with their types)
 - - x0 : (t1 * ... * tn) -> t (for recursion)


Function Calls:

Syntax: e0 (e1,...,en)

Type-checking:
- If:
- - e0 has some type (t1 * ... * tn) -> t
- - e1 has type t1, ..., en has type tn
- Then:
- - e0(e1,...en) has type t

Evluation:

1. (Under current dynamic environment,) evaluate e0 to a function fun x0 (x1 : t1, ..., xn : tn) = e
- since call type-checked, result will be a function

2. (under current dynamic environment,) evaluate arguments to values v1, ..., vn

3. Result is evaluation of e in an environment extended to map x1 to v1,..., xn to vn
- "an environment" is actually the environment where the function was defined, and includes x0 for recursion

 *)