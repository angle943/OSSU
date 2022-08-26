(* 

For homework 2:
- do not use the # char
- do not need to write down any explicit types

These are related
- type-checker can use patterns to figure out the types
- With just #foo or #1 it cannot determine "what other fields"

 *)

 fun sum_triple1 (x, y, z) = x + y + z;

 fun full_name1 {first=x, middle=y, last=z} = x ^ " " ^ y ^ " " ^ z;

 fun sum_triple2 (triple : int*int*int) = #1 triple + #2 triple + #3 triple;

 fun full_name2 (r: {first:string, middle:string, last:string}) = 
    #first r ^ " " ^ #middle r ^ " " ^ #last r;

 (* fun sum_triple2 (triple) = #1 triple + #2 triple + #3 triple; CANOT DO THIS *)


(* These functions are polymorphic: type of y can be anhything  *)

fun partial_sum (x, y, z) = x + z;

fun partial_name {first=x, middle=y, last=z} = x ^ " " ^ z;