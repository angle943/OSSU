(* int list -> bool *)
fun nondecreasing_clumsy xs = 
    case xs of
        [] => true
        | x::xs' => case xs' of
                        [] => true
                        | x'::xs'' => if x' < x then false else nondecreasing_clumsy xs';


fun nondecreasing xs =
    case xs of
        [] => true
        | _::[] => true
        | head::(neck::rest) => head <= neck andalso nondecreasing(neck::rest);

datatype sgn = P | N | Z;

(* int * int -> sgn *)
fun multsign (x1, x2) =
    let fun sign x = if x = 0 then Z else if x > 0 then P else N
    in
        case (sign x1, sign x2) of
            (Z,_) => Z
            | (_,Z) => Z
            | (P,P) => P
            | (N,N) => P
            (* | _ => N *)
            | (P,N) => N
            | (N,P) => N
    end

fun len xs =
    case xs of
        [] => 0
        | _::xs' => 1 + len xs';

(* 

Style

Nested patterns can lead to very elegant, concise code
- Avoid nested case expressions if nested patterns are simpler
  and avoid unneccessary branches or let-expressions
- a common idiom is matching against a tuple of datatypes to compare them

Wildcards are good style: use them instead of variables when you do not need the data

 *)