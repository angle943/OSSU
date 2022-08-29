type student_id = int;
type grade = int; (* must be in 0 to 100 range *)
type final_grade = { id : student_id, grade : grade option };
datatype pass_fail = pass | fail;

(* 1 *)
fun pass_or_fail ({grade : grade option, id : 'a}) =
    case grade of
        NONE => fail
        | SOME i => if i>= 75 then pass else fail;

(* pass_or_fail { id= "123", grade= NONE};
pass_or_fail { id= "124", grade= SOME 59};
pass_or_fail { id= "124", grade= SOME 99};
pass_or_fail { id= "124", grade= SOME 75}; *)


(* 2 *)
fun has_passed ({grade : grade option, id: 'a}) =
    let
        val passOrFail = pass_or_fail({grade=grade, id=id})
    in
        if passOrFail = pass then true else false
    end;

(* has_passed { id= "123", grade= NONE};
has_passed { id= "124", grade= SOME 59};
has_passed { id= "124", grade= SOME 99};
has_passed { id= "124", grade= SOME 75}; *)



(* 3 *)
fun number_passed (finalGrades) =
    let
        fun aux (finalGrades, acc) =
            case finalGrades of
                [] => acc
                | fg::finalGrades' => if has_passed fg then aux (finalGrades', acc + 1)
                                    else aux (finalGrades', acc)
    in
        aux (finalGrades, 0)
    end;

(* number_passed [{ id= "123", grade= NONE},
{ id= "124", grade= SOME 59},
{ id= "124", grade= SOME 99},
{ id= "124", grade= SOME 75}]; *)


(* 4 *)
fun number_misgraded xs =
    case xs of
        [] => 0
        | (pass, fg)::xs' => if has_passed(fg) then number_misgraded(xs') else 1 + number_misgraded(xs')
        | (fail, fg)::xs' => if has_passed(fg) then 1 + number_misgraded(xs') else number_misgraded(xs');

(* number_misgraded [(pass, { id= "123", grade= NONE}),
(pass, { id= "124", grade= SOME 59}),
(pass, { id= "124", grade= SOME 99}),
(pass, { id= "124", grade= SOME 75})]; *)


(* 5 *)
datatype 'a tree = leaf 
                 | node of { value : 'a, left : 'a tree, right : 'a tree };
datatype flag = leave_me_alone | prune_me;

fun tree_height (t) =
    case t of
        leaf => 0
        | node {value = _, left = l, right = r} => 1 + Int.max(tree_height l, tree_height r);


(* val tree1 = node {value= 1,
                left= node {
                    value= 2,
                    left= leaf,
                    right= node {
                        value= 3,
                        left= leaf,
                        right= leaf
                    }
                },
                right= node{
                    value= 4,
                    left= node {
                        value= 5,
                        left= leaf,
                        right= node {
                            value= 6,
                            left= leaf,
                            right= leaf
                        }
                    },
                    right= leaf
                }}; *)

(* tree_height tree1; *)


(* 6 *)
fun sum_tree (t) =
    case t of
        leaf => 0
        | node {value = v, left = l, right = r} => v + sum_tree(l) + sum_tree(r);

(* sum_tree tree1; *)


(* 7 *)
fun gardener t =
    case t of
        leaf => leaf
        | node {value = leave_me_alone, left = l, right = r} => node {value = leave_me_alone,
                                                                        left = gardener(l),
                                                                        right = gardener(r)}
        | node {value = prune_me, left = l, right = r} => leaf;

(* val tree2 = node {value= leave_me_alone,
                left= node {
                    value= leave_me_alone,
                    left= leaf,
                    right= node {
                        value= prune_me,
                        left= leaf,
                        right= leaf
                    }
                },
                right= node{
                    value= prune_me,
                    left= node {
                        value= leave_me_alone,
                        left= leaf,
                        right= node {
                            value= leave_me_alone,
                            left= leaf,
                            right= leaf
                        }
                    },
                    right= leaf
                }}; *)

(* gardener tree2; *)

(* 8 *)
fun null_impl xs =
    case xs of
        [] => true
       | _ => false;

fun length_impl xs =
    case xs of
        [] => 0
        | _::xs' => 1 + length_impl xs';

fun at_impl (xs1, xs2) =
    case xs1 of
        [] => xs2
        | x1::xs1' => x1 :: at_impl(xs1', xs2);

fun hd_impl xs =
    case xs of
        [] => raise Empty
        | x::_ => x;

fun tl_impl xs =
    case xs of
        [] => raise Empty
        | _::xs' => xs';

fun last_impl xs =
    case xs of
        [] => raise Empty
        | x::[] => x
        | x::xs' => last_impl xs';

fun getItem_impl xs =
    case xs of
        [] => NONE
        | x::xs' => SOME(x, xs');

fun nth_impl (xs, i) =
    let
        val length = length_impl xs
    in
        if i < 0 orelse i >= length
        then raise Subscript
        else if i = 0
        then hd xs
        else nth_impl(tl_impl xs, i - 1)
    end;

fun take_impl (xs, i) =
    let
        val length = length_impl xs
    in
        if i < 0 orelse i >= length
        then raise Subscript
        else if i = 0
        then [hd xs]
        else hd xs :: take_impl(tl xs, i - 1)
    end;

fun drop (xs, i) =
    let
        val length = length_impl xs
    in
        if i < 0 orelse i >= length
        then raise Subscript
        else if i = 0
        then xs
        else drop(tl xs, i - 1)
    end

fun rev xs =
    case xs of
        [] => []
        | x::xs' => rev(xs') @ [x]

fun concat xs =
    case xs of
        [] => []
        | x::xs' => x @ concat xs'

fun revAppend(l1, l2) =
    (rev l1) @ l2

fun map (f, xs) =
    case xs of
        [] => []
        | x::xs' => (f x) :: map (f, xs')

fun mapPartial (f, xs) =
    case xs of
        [] => []
        | x::xs' => if isSome (f x) then (valOf (f x))::mapPartial(f,xs') else mapPartial(f,xs')

fun find (f, xs) =
    case xs of
        [] => NONE
        | x::xs' => if (f x) then SOME (x) else find (f, xs')

fun filter (f, xs) =
    case xs of
        [] => []
        | x::xs' => if (f x) then x::filter(f, xs') else filter(f,xs')

fun partition (f, xs) =
    let
        fun aux (xs, pos, neg) =
            case xs of
                [] => (pos, neg)
                | x::xs' => if (f x) then aux (xs', pos @ [x], neg) else aux (xs', pos, neg @ [x])
    in
        aux(xs,[],[])
    end

fun foldl (f, acc, xs) =
    case xs of
        [] => acc
        | x::xs' => foldl (f, (f (x, acc)), xs')

fun foldr (f, acc, xs) =
    foldl (f, acc, rev xs)

fun exists (f, xs) =
    case xs of
        [] => false
        | x::xs' => if (f x) then true else exists (f, xs')

fun all (f, xs) =
    case xs of
        [] => true
        | x::xs' => if (f x) then all (f, xs') else false

fun tabulate (n, f) =
    if n < 0 then raise Size
    else if n = 0 then []
    else (f (n - 1))::tabulate(n-1, f)

fun getOpt (opt, a) =
    case opt of
        NONE => a
        | SOME x => x

fun isSome opt =
    case opt of
        NONE => false
        | _ => true

fun valOf opt =
    case opt of
        NONE => raise Option
        | SOME x => x

fun filter (f, a) =
    if (f a) then (SOME a) else NONE

fun join a =
    case a of
        NONE => NONE
        | SOME v => v

fun app (f, opt) =
    case opt of
        NONE => NONE
        | SOME v => f v

fun map (f, opt) =
    case opt of
        NONE => NONE
        | SOME v => SOME (f v)

fun mapPartial (f, opt) =
    case opt of
        NONE => NONE
        | SOME v => f v

fun compose (f, g, a) =
    case (g a) of
        NONE => NONE
        | SOME v => SOME (f v)

fun composePartial (f,g,a) =
    case (g a) of
        NONE => NONE
        | SOME v => f v

datatype nat = ZERO | SUCC of nat

(* 9 *)
fun is_positive n =
    case n of
        ZERO => false
        | _ => true

exception NEGATIVE

(* 10 *)
fun pred n =
    case n of
        ZERO => raise NEGATIVE
        | SUCC n' => n'

(* 11 *)
fun nat_to_int n =
    case n of
        ZERO => 0
        | SUCC n' => 1 + nat_to_int n'

(* val three = nat_to_int (SUCC (SUCC (SUCC (ZERO)))) *)

(* 12 *)
fun int_to_nat z =
    if z < 0 then raise NEGATIVE
    else if z = 0 then ZERO
    else SUCC (int_to_nat (z-1))

(* 13 *)
fun add (n1, n2) =
    case n1 of
        ZERO => n2
        | SUCC n1' => add (n1', SUCC n2)

(* 14 *)
fun sub (n1, n2) =
    case n2 of
        ZERO => n1
        | SUCC n2' => sub(pred n1, n2')

(* 15 *)
fun mult (n1, n2) =
    case n2 of
        ZERO => ZERO
        | SUCC ZERO => add(n1,n1)
        | SUCC n2' => add(n1,mult(n1,n2'))

(* 16 *)
fun less_than ntup =
    case ntup of
        (ZERO, ZERO) => false
        | (ZERO, _) => true
        | (SUCC n1, SUCC n2) => less_than(n1, n2)


datatype intSet = 
  Elems of int list (*list of integers, possibly with duplicates to be ignored*)
| Range of { from : int, to : int }  (* integers from one number to another *)
| Union of intSet * intSet (* union of the two sets *)
| Intersection of intSet * intSet (* intersection of the two sets *)


(* 17 *)


