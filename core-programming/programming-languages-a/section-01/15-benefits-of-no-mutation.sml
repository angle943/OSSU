(* 

    in ML, we create aliases all the time without thinking about it
    because its impossible to tell where there is aliasing
    - Example: tl is constant time, does not copy rest of the list
    - so don't worry and focus on your algo.

    In languages with mutable data (eg Java), programmers are
    obsessed with aliasing and object identity
    - They have to be so that subsequent assignments affect the right parts of the program
    - often curcial to make copies in just the right places
 *)