(* 
Building Lists

- the empty list is a value:

[]

- in general, a list of values is a value; elements separated by commas:

[v1,v2,...,vn]

- if e1 evaluates to v and e2 evaluates to a list [v1,...,vn],
then e1::e2 evaluates to [v,...vn]

e1::e2 (pronounced "cons")

 *)

(* 

Accessing Lists

- "null e" evaluates to true iff e evaluates to []

- If e evaluates to [v1,v2,...,vn] then "hd e" evaluates to v1
- - (raise exception if e evaluates to [])

- If e evaluates to [v1,v2,...,vn] then "tl e" evaluates to [v2,...,vn]
- - raise exception if e evaluates to []
- - notice result is a list

 *)


 (* 
 
 Type-checking list operations

- SML uses type 'a list to indicate any type ("quote a" or "alpha")

- for e1::e2 to type-check, we need a t such that e1 has type t and e2 has type t list. Then the result
- type is t list

- null : 'a list -> bool
- hd : 'a list -> 'a
- tl : 'a list -> 'a list

  *)