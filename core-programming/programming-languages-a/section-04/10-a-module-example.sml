(* 

A LARGER EXAMPLE [mostly see the code]

Now consider a module that defines an Abstract Data Type (ADT)
- a type of data and operations on it

Our example: rational numbers supporting add and toString

structure Rational1 =
struct
datatype rational = Whole of int | Frac of int*int
exception BadFrac

fun make_frac (x,y) = ...
fun add (r1,r2) = ...
fun toString r = ...
end

 *)


structure Rational1 =
struct

(* Invariant 1: all denominators > 0
    Invariant 23: rationals kept in reduced form
 *)

    datatype rational = Whole of int | Frac of int*int
    exception BadFrac

(* gcd and reduce help keep fractions reduced, but clients dneed not know about them *)
(* they _assume_ their inputs are not negative *)

    fun gcd (x,y) =
        if x=y
        then x
        else if x < y
        then gcd(x,y-x)
        else gcd(y,x)

    fun reduce r =
        case r of
            Whole _ => r
            | Frac(x,y) =>
                if x = 0
                then Whole 0
                else let val d = gcd(abs x,y) in
                    if d=y
                    then Whole(x div d)
                    else Frac(x div d, y div d)
                end
    
    fun make_frac (x,y) =
        if y = 0
        then raise BadFrac
        else if y < 0
        then reduce(Frac(~x,~y))
        else reduce(Frac(x,y))

    fun add (r1,r2) =
        case (r1,r2) of
            (Whole(i),Whole(j))     => Whole(i+j)
            | (Whole(i),Frac(j,k))  => Frac(j+k*i,k)
            | (Frac(j,k),Whole(i))  => Frac(j+k*i,k)
            | (Frac(a,b),Frac(c,d)) => reduce (Frac(a*d+b*c,b*d))

    fun toString r =
        case r of
            Whole i => Int.toString i
            | Frac(a,b) => (Int.toString a) ^ "/" ^ (Int.toString b)
end

val x = Rational1.make_frac(9,6)
val y = Rational1.make_frac(~8,~2)
val result = Rational1.toString(Rational1.add(x,y))

(* 

LIBRARY SPEC AND INVARIANTS

Properties [externally visible guarantees, up to library writer]
- disallow denominators of 0
- return strings in reduced form ("4" not "4/1", "3/2" not "9/6")
- No infinite loops or exceptions

Invariants [part of the implementation, not the module's spec]
- All denominators are greater than 0
- All rational values returned from functions are reduced


MORE ON INVARIANTS

Our code maintains the invariants and relies on them

Maintain:
- make_frac disallows 0 denominator, removes negative denominator, and reduces result
- add assumes invariants on inputs, calls reduce if needed

Rely:
- gcd does not work with negative arguments, but no deonominator can be negative
- add uses math properties to avoid calling reduce
- toString assumes its argument is already reduced

 *)