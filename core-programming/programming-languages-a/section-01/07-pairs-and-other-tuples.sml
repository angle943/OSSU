(* 

Pairs (2-tuples)

Syntax: (e1,e2)

Evaluation: Evaluate e1 to v1 and e2 to v2; result is (v1,v2)
- a pair of values is a value

Type-checking: if e1 has type ta and e2 has type tb, then the pair expression has type ta * tb
- a new kind of type

How to BUILD pairs and a way to ACCESS the pieces

Access:

syntax: #1 e and #2 e

Evaluation: evaluate e to a pair of values and return first or second piece.
- example: if e is a variable x, then look up x in environment

Type-checking: if e has type ta * tb, then #1 e has type ta and #2 e has type tb

 *)

(* (int * bool) -> (bool * int) *)
 fun swap (pr : int*bool) =
    (#2 pr, #1 pr);


(* (int * int) * (int * int) -> int *)
fun sum_two_pairs (pr1 : int * int, pr2 : int * int) =
    (#1 pr1) + (#2 pr1) + (#1 pr2) + (#2 pr2);

(* int * int -> int * int *)
fun div_mod (x : int, y : int) =
    (x div y, x mod y);

(* int * int -> int * int *)
fun sort_pair(pr : int * int) = 
    if (#1 pr) > (#2 pr)
    then (#2 pr, #1 pr)
    else pr;


swap(7, true);
swap(~4, false);
sort_pair(3,4);
val x = (4,3);
sort_pair x;


(* 

TUPLES

- (e1,e2,...,en)
- ta * tb * ... * tn
- #1 e, #2 e, #3 e, ...

Tuples can be nested however you want

val y = ((4, (5, 6)), (3, 6) )

 *)
