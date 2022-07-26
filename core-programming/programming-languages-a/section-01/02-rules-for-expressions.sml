(*

Syntax:
    if e1 then e2 else e3
    where if, then, and else are keywords and
    e1, e2, e3 are subexpressions

Type-checking:
    first e1 must have type bool
    e2 and e3 can have any type (let's call it t), but they
    must have the same type t
    the type of the entire expression is also t

Evaluation rules:
    first evaluate e1 to a value, call it v1
    if it's true, evaluate e2 that that result is the whole expression's result
    else, evaluate e3 and that result is the whole expression's result

*)

(*

Syntax:
    e1 < e2
    where < is a keyword and e1 and e2 are subexpressions

Type-checking:
    e1 and e2 must be int (or some other number type if it exists in SML)

Evaluation rules:
    evaluate e1 to value (call it v1) and evaluate e2 to a value (call it v2).
    if v1 < v2, yield true, else false (call this v3). V3 is the result of this expression.

*)