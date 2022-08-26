(* 

DATATYPE BINDINSG

datatype t = C1 of t1 | C2 of t2 | ... | Cn of tn

Adds type t and constructors Ci of type ti -> t
- Ci v is a value, ie the result "includes the tag"

Omit "of t" for constructors that are just tags, no underlying data
- such a Ci is a value of type t

Given an expression of type t, use case expressions to:
- see which variant (tag) it has
- extract underlying data once you know which variant



case e of p1 => e1 | p2 => e2 | ... | pn => en

- as usual, can use a case expressions anywhere an expression goes
- - does not need to be whole function body, but often is

- evaluate e to a value, call it v

- if pi is the first pattern to match v, then result is evaluation of ei in environment "extended by the match"

- pattern Ci (x1,...,xn) matches value Ci(v1,...vn) and extends the environment with x1 to v1...xn to vn
- - for "no data" constructors, pattern Ci matches to value Ci

 *)