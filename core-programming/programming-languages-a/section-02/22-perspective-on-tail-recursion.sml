(* 

Always tail-recursive?

There are certainly cases where recursive functions cannot be evaluated in a constant amount of space

Most obvious examples are functions that process trees

In these cases, the natural recursive approach is the way to go
- You ccould get one recursive call to be a tail call, but rarely worth the complication

Also beware the wrath of premature optimization
- favor clear, concise code
- but do use less space if inputs may be large

 *)


 (* 
 
 What is a tail-call?

 The "nothing left for caller to do" intuition usually suffices
 - if the result of f x is the immediate result for the enclosing function body, then f x is a tail call

 But we can define "tail position" recursively
 - then a "tail call" is a function call in "tail position"
 
  *)


  (* 
  
  PRECISE DEFINITION

  A tail call is a function call in tail position
  - if an expression is not in tail position, then no subexpressions are
  - in fun f p = e, the body e is in tail position
  - if if e1 then e2 else e3 is in tail position, then e2 and e3 are in tail position (but e1 is not). (similar for case expressions)
  - if let b1...bn in e end is in tail position, then e is in tail position
  - function-call args e1 e2 are not in tail positions
  
   *)