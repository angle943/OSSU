(* 

MUTUAL RECURSION

Allow f to call g and g to call f

Useful? Yes
- Idiom we will show: implementing state machines

The problem: ML's bindings-in-order rule for environments
- Fix #1: Special new language construct
- Fix #2: Workaround using higher-order functions



NEW LANGUAGE FEATURES

Mutually recursive functions (the and keyword)


fun f1 p1 = e1
and f2 pe = e2
and f3 p3 = e3



Similarly, mutually recursive datatype bindings:

datatype t1 = ...
and t2 = ...
and t3 = ...

Everything in "mutual recursion bundle" type-checked together and can refer to each other



STATE-MACHINE EXAMPLE

Each "state of the computation" is a function
- "State transition" is "call another function" with "rest of input"
- Generalizes to any finite-state-machine example

fun state1 input_left = ...

and state2 input_left = ...

and ...


An example of mutual recursion: a little "state machine" for deciding
if a list of ints alternates between 1 and 2, not ending with a 1
 *)

fun match xs =
    let fun s_need_one xs =
        case xs of
            [] => true
            | 1::xs' => s_need_two xs'
            | _ => false
        and s_need_two xs =
            case xs of
                [] => false
                | 2::xs' => s_need_one xs'
                | _ => false
    in
        s_need_one xs
    end

datatype t1 = Foo of int | Bar of t2
and t2 = Baz of string | Quux of t1

fun no_zeros_or_empty_strings_t1 x =
    case x of
        Foo i => i <> 0
        | Bar y => no_zeros_or_empty_strings_t2 y
and no_zeros_or_empty_strings_t2 x =
    case x of
        Baz s => size s > 0
        | Quux y => no_zeros_or_empty_strings_t1 y

(* code above works fine. this version works without any new language support: *)
fun no_zeros_or_empty_strings_t1_alternate(f,x) =
    case x of
        Foo i => i <> 0
        | Bar y => f y

fun no_zeros_or_empty_strings_t2_alternate x =
    case x of
        Baz s => size s > 0
        | Quux y => no_zeros_or_empty_strings_t1_alternate(no_zeros_or_empty_strings_t2_alternate, y)


(* 

WORK-AROUND

Suppose we did not have support for mutually recursive functions
- or could not put functions next to each other

Can have the "later" function pass itself to the "earlier" one
- Yet another higher-order function idiom

fun earlier (f,x) = ... f y ...

... (* no need to be nearby *)

fun later x = ... earlier (later,y) ...

 *)