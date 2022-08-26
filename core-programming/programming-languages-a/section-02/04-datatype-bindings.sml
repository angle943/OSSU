(* 

DATATYPE Bindings

datatype mytype = TwoInts of int * int
                | Str of string
                | Pizza

- Adds a new type mytype to the environment
- adds constructors to the environment: TwoInts, Str, and Pizza
- a constructor is (among other things), a function that makes values of the new type:
- - TwoInts : int * int -> mytype
- - Str : string -> mytype
- - Pizza : mytype

 *)

datatype mytype = TwoInts of int * int
                    | Str of string
                    | Pizza

val a = Str "hi";
val b = Str;
val c = Pizza;
val d = TwoInts(1+2,3+4);
val e = a;
val f = TwoInts;


(* 

- any value of type mytype is made from one of the constructors
- the value contains:
- - a "tag" for "which constructor" (e.g., TwoInts)
- - The corresponding data (e.g. (7,9))


 *)



(* 

There are two aspects to accessing a datatype value
1. Check what variant it is (what constructor made it)
2. Extract the data (if that variant has any)

Notice how our other one-of types used functions for this:
- null and isSome check variants
- hd, tl, and valOf extract data (raise exception on wrong variant)

ML could have done the same for datatype bindings
- For ex: functions like "isStr" and "getStrData"
- Instead it did something better

 *)