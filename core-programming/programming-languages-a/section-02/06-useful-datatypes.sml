datatype suit = Club | Diamond | Heart | Spade;
datatype rank = Jack | Queen | King | Ace | Num of int;

datatype id = StudentNum of int
                | Name of string * string option * string;



(* 

DONT DO THIS

{   student_num :   int,
    first       :   string,
    middle      :   string option,
    last        :   string   }

 *)


 (* 
 
 That said...

 if every person in your program has a name and maybe a student number, then each-of is the way to go.
 
  *)


  (* 
  
Expression Trees

- a more exciting (?) example of a datatype, using self-reference
  
   *)

datatype exp = Constant of int
                | Negate of exp
                | Add of exp * exp
                | Multiply of exp * exp;

val a = Add ( Constant (10+9), Negate (Constant 4));

fun eval (e : exp) =
    case e of
        Constant i => i
        | Negate e2 => ~ (eval e2)
        | Add (e1,e2) => (eval e1) + (eval e2)
        | Multiply (e1,e2) => (eval e1) * (eval e2);


fun number_of_adds (e : exp) =
    case e of
        Constant i => 0
        | Negate e1 => number_of_adds(e1)
        | Add (e1,e2) => 1 + number_of_adds(e1) + number_of_adds(e2)
        | Multiply (e1,e2) => number_of_adds(e1) + number_of_adds(e2);