(* 

    Boolean Operations

    e1 andalso e2

    - Type-checking: e1 and e2 must have type bool
    - Evaluation: if result of e1 is false then false else result of e2

    e1 orelse e2

    not e1

    - "Short-circuiting" evaluation means andalso and orelse are not functions,
    - but not is just a pre-defined function

 *)



 (* 
 
    Comparisons

    For comparing int values:
        = <> > < >= <=

    - > < >= <= can be used with real, but not 1 int and 1 real

    - = <> can be used with any "equality type" but not with real

  *)