(* 

FUNCTIONS AS ARGUMENTS

- We can pass one function as an argument to another function
-- Not a new feature, just never thought to do it before

fun f (g,...) = ... g (...) ...
fun h1 ... = ...
fun h2 ... = ...
... f(h1,...) ... f(h2,...) ...


- Elegant strategy for factoring out common code
- - Replace N similar functions with calls to 1 function where you pass in N different (short) functions as arguments

[See the code file for this segment]

 *)

fun increment_n_times_lame (n,x) = (* Silly: this computes (n+x) *)
    if n=0
    then x
    else 1 + increment_n_times_lame(n-1,x);

increment_n_times_lame(5,8);

fun double_n_times_lame (n,x) = (*   2^n * x   *)
    if n=0
    then x
    else 2 * double_n_times_lame(n-1, x);

double_n_times_lame(4,3);

fun nth_tail_lame (n, xs) =
    if n=0
    then xs
    else tl (nth_tail_lame(n-1, xs));

fun n_times (f,n,x) =
    if n=0
    then x
    else f (n_times(f, n-1,x));


fun increment x = x + 1;
fun double x = x * 2;

fun increment_n_times (n,x) =
    n_times(increment, n, x);

increment_n_times(5,8);

fun double_n_times (n,x) =
    n_times(double, n, x);

double_n_times(4,3);

fun nth_tail (n, xs) =
    n_times(tl, n, xs);

nth_tail(3, [1,2,3,4,5,6,7]);