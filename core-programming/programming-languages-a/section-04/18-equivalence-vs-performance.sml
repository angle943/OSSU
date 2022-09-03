(* 

WHAT ABOUT PERFORMANCE?

According to our definition of equivalence, these two fuctions are equivalent, but we learned one is awfuL)
 - actually we studied this before pattern-matching

 fun max xs =
    xase xs of
        [] => raise Empty
        | x::[] => x
        | x::xs' =>
            if x > max xs'
            then x
            else max xs'


fun max xs =
    case xs of
        [] => raise Empty
    | x::[] => x
    | x::xs' =>
        let
            val y = max xs'
        in
            if x > y
            then x
            else y
        end


DIFFERENT DEFINITIONS FOR DIFFERENT JOBS

PL EQUIVALENCE: given same inputs, same outputs and effects
- Good: lets us replace bad max with good max
- Bad: ignores performance in the extreme

ASYMPTOTIC EQUIVALENCE: ignore constant factors
- Good: Focus on the algorithm and efficiency for large inputs
- Bad: Ignores "four times faster"

SYSTEMS EQUIVALENCE: Account for constant overheads, performance tune
- good: faster means different and better
- bad: Beware of overtuning on "wrong" (eg small) inputs;
  definition does not let you "swap in a different algorithm"


CLAIM: Computer scientists implicitly (?) use all three every (?) day


 *)