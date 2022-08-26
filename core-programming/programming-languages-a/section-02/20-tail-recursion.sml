fun fact n = if n=0 then 1 else n*fact(n-1);

val x = fact 3;

(* REVISED *)

fun fact n =
    let fun aux(n, acc) =
        if n=0
        then acc
        else aux(n-1, acc*n)
    in
        aux(n,1)
    end;

val x = fact 3;

(* 

An optimizaation

It is unnecessary to keep around a stack-frame just so it can get a callee's result and return it
without any further evaluation

ML recognizes these tail calls in the compiler and treats them differently:
- Pop the caller before the call, allowing callee to reuse the same stack space
- along with other optimizations, as efficient as a loop

Reasonable to assume all functional-language implementations do tail-call optimization

 *)