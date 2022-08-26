fun hd xs =
    case xs of
        [] => raise List.Empty
        | x::_ => x;

exception MyUndesirableCondition;

exception MyOtherException of int * int;

fun mydiv (x, y) =
    if y=0
    then raise MyUndesirableCondition
    else x div y;

(* int list * exn => int *)
fun maxlist (xs, ex) =
    case xs of
        [] => raise ex
        | x::[] => x
        | x::xs' => Int.max(x,maxlist(xs',ex));

val w = maxlist([3,4,5], MyUndesirableCondition);

val x = maxlist([3,4,5], MyUndesirableCondition)
    handle MyUndesirableCondition => 42;

(* 

    e1 handle ex => e2;

 *)

val z = maxlist ([], MyUndesirableCondition)
    handle MyUndesirableCondition => 123;


(* 

EXCEPTIONS

An exception binding introdu es a new kind of exception:

exception MyFirstException
exception MySecondException of int * int

The raise primitives raises (aka throws) an exception:

raise MyFirstException
raise (MySecondException(7,9))

A handle expression  an handle (aka catch) an exception
- if it doesn't match, exception continues to progagate

e1 handle MyFirstException => e2
e1 handle MySecondExeption(x,y) => e2

 *)