fun alternate (xs : int list) =
    let
        fun alternate(xs : int list, i : int) =
            if null xs
            then 0
            else if i mod 2 = 0
            then (hd xs) + alternate(tl xs, i + 1)
            else ~(hd xs) + alternate(tl xs, i + 1)
    in
        alternate(xs, 0)
    end;

(* alternate [1,2,3,4] *)

fun min_max (xs : int list) =
    let 
        fun min_max (xs : int list, min : int, max : int) =
            if null xs
            then (min, max)
            else if (hd xs) > max
            then min_max(tl xs, min, hd xs)
            else if (hd xs) < min
            then min_max(tl xs, hd xs, max)
            else min_max(tl xs, min, max)
    in
        min_max(tl xs, hd xs, hd xs)
    end;

(* min_max [5,3,6,2,3,1,9,2,10,32,1,3,5,2,3]; *)

fun cumsum (xs : int list) =
    let
        fun cumsum (xs : int list, sum : int) =
            if null xs
            then []
            else ((hd xs) + sum) :: cumsum(tl xs, sum + hd xs)
    in
        cumsum(xs, 0)
    end;

(* cumsum [1,4,20] *)

fun greetings (s : string option) =
    if isSome s
    then "Hello there, " ^ valOf s
    else "Hello there, you";

(* greetings(NONE);
greetings(SOME "Justin"); *)

fun repeat (a : int list * int list) =
    if null (#1 a)
    then []
    else if 0 = hd (#2 a)
    then repeat((tl (#1 a), tl (#2 a)))
    else hd (#1 a) :: repeat ((#1 a, (hd (#2 a) - 1) :: (tl (#2 a))));

(* repeat ([1,2,3], [4,0,3]) *)

fun addOpt (tup : int option * int option) =
    if (isSome (#1 tup) andalso isSome (#2 tup))
    then SOME (valOf (#1 tup) + valOf (#2 tup))
    else NONE;

(* addOpt((SOME 1, SOME 2));
addOpt((SOME 1, NONE));
addOpt((NONE, NONE)); *)

fun addAllOpt (xs : int option list) =
    let
        fun addAllOpt(xs : int option list, sumOpt : int option) =
            if null xs
            then sumOpt
            else if isSome (hd xs) andalso isSome sumOpt
            then addAllOpt(tl xs, SOME (valOf sumOpt + valOf (hd xs)))
            else if isSome (hd xs)
            then addAllOpt(tl xs, hd xs)
            else addAllOpt(tl xs, sumOpt)
    in
        addAllOpt(xs, NONE)
    end;

(* addAllOpt ([SOME 1, NONE, SOME 3]);
addAllOpt ([NONE, NONE, NONE]); *)

fun any (bs : bool list) =
    if null bs
    then false
    else (hd bs) orelse any (tl bs);

(* any([]);
any([true]);
any([false]);
any([false,false,false]);
any([false,false,true,false]); *)

fun all (bs : bool list) =
    if null bs
    then true
    else (hd bs) andalso all (tl bs);

(* all([]);
all([true]);
all([false]);
all([false,true,false]);
all([true,true,true,true]); *)

fun zip ( x : int list * int list) =
    if null (#1 x) orelse null (#2 x)
    then []
    else (hd (#1 x), hd (#2 x)) :: zip ((tl (#1 x), tl (#2 x)));

(* zip ([1,2,3], [4, 6]); *)

fun len ( xs : int list) =
    if null xs
    then 0
    else 1 + len (tl xs);

fun zipRecycle ( x : int list * int list) =
    let
        val l1 = #1 x
        val l2 = #2 x
        val l1Length = len l1
        val l2Length = len l2
        val maxLength = if l1Length > l2Length then l1Length else l2Length
        fun zipRecycle (l11 : int list, l22 : int list, i : int) =
            if i = maxLength
            then []
            else if null l11
            then zipRecycle(l1, l22, i)
            else if null l22
            then zipRecycle(l11, l2, i)
            else (hd l11, hd l22) :: zipRecycle(tl l11, tl l22, i + 1)
    in
        zipRecycle(l1, l2, 0)
    end;

(* zipRecycle ([1,2,3], [1, 2, 3, 4, 5, 6, 7]); *)

fun zipOpt ( x : int list * int list) =
    let
        val l1 = #1 x
        val l2 = #2 x
        val l1Length = len l1
        val l2Length = len l2
    in
        if l1Length <> l2Length
        then NONE
        else SOME (zip (x))
    end;

(* zipOpt ([1,2,3], [1, 2, 3, 4, 5, 6, 7]);
zipOpt ([1,2,3], [4,5,6]); *)

fun lookup ( x : (string * int) list * string ) =
    let
        val xs = #1 x
        val search = #2 x
    in
        if null xs
        then NONE
        else if #1 (hd xs) = search
        then SOME (#2 (hd xs))
        else lookup (tl xs, search)
    end;

(* lookup ([("a", 1), ("b", 2), ("c", 3)], "d"); *)

fun splitup (xs : int list) =
    let
        fun splitup (xs : int list, pos: int list, neg: int list) =
            if null xs
            then (pos, neg)
            else if (hd xs) >= 0
            then splitup(tl xs, pos@[hd xs], neg)
            else splitup(tl xs, pos, neg@[hd xs])
    in
        splitup (xs, [], [])
    end;

(* splitup ([1, 2, 3, ~1, ~2, ~4, 4, ~5 ,10, ~100]) *)

fun splitAt (a : int list, b : int) =
        let
        fun splitup (xs : int list, right: int list, left: int list) =
            if null xs
            then (right, left)
            else if (hd xs) >= b
            then splitup(tl xs, right@[hd xs], left)
            else splitup(tl xs, right, left@[hd xs])
    in
        splitup (a, [], [])
    end;

(* splitAt ([1, 2, 3, ~1, ~2, ~4, 4, ~5 ,10, ~100], 5) *)

fun isSorted (xs : int list) =
    if null xs
    then true
    else if null (tl xs)
    then true
    else if hd xs > hd (tl xs)
    then false
    else isSorted (tl xs);

(* isSorted [];
isSorted [1];
isSorted [1,2,3];
isSorted([1,2,5,3,4]); *)

fun isAnySorted (xs : int list) =
    if null xs orelse null (tl xs)
    then true
    else
        let
            fun isSortedDesc (xs : int list) =
                if null xs orelse null (tl xs)
                then true
                else if hd xs < hd (tl xs)
                then false
                else isSortedDesc (tl xs);
        in
            if (hd xs) < hd (tl xs)
            then isSorted(xs)
            else isSortedDesc(xs)
        end;

(* isAnySorted([1,2,3,4]);
isAnySorted([4,3,2,1]);
isAnySorted([1,4,2,3]);
isAnySorted([5,4,2,3]); *)

fun sortedMerge (xs : int list, ys : int list) =
    if null xs andalso null ys
    then []
    else if null xs
    then ys
    else if null ys
    then xs
    else if hd xs < hd ys
    then hd xs :: sortedMerge (tl xs, ys)
    else hd ys :: sortedMerge (xs, tl ys);

(* sortedMerge([1,4,7], [5,8,9]); *)

fun qsort (xs : int list) =
    if null xs
    then []
    else if null (tl xs)
    then [hd xs]
    else
        let
            val twoLists = splitAt(tl xs , hd xs)
        in
            qsort(#2 twoLists) @ [hd xs] @ qsort(#1 twoLists)
        end;

(* qsort ([1, 5,2,3,7,2,3,10]); *)

fun divide (xs : int list) =
    let
        fun divide (xs : int list, l1 : int list, l2 : int list) =
            if null xs
            then (l1, l2)
            else if null (tl xs)
            then (l1 @ [hd xs], l2)
            else divide (tl (tl xs), l1 @ [hd xs], l2 @ [hd (tl xs)]);
    in
        divide(xs, [], [])
    end;

(* divide ([1,2,3,4,5,6,7]) *)

(* fun not_so_quick_sort (xs : int list) =
    if null xs
    then []
    else if null (tl xs)
    then [hd xs]
    else
        let
            val twoLists = divide(xs)
        in
            sortedMerge(not_so_quick_sort (#1 twoLists), not_so_quick_sort (#2 twoLists))
        end; *)


(* not_so_quick_sort [8, 2, 3, 4, 1, 5, 2, 4, 91, 32, 1]; *)

fun fullDivide (k : int , n : int) =
    let
        fun divideOnce (dividend : int, nTimes : int) =
            if dividend mod k = 0
            then divideOnce(dividend div k, nTimes + 1)
            else (nTimes, dividend)
    in
        divideOnce(n, 0)
    end;

(* fullDivide(2, 40);
fullDivide(3, 10); *)

fun factorize (n : int) =
    let
        fun factorizeOnce (num : int, den : int) =
            if num = 1
            then []
            else
                let 
                    val result = fullDivide(den, num)
                    val numOfTimesDivided = #1 result
                    val remainder = #2 result 
                in
                    if 0 = numOfTimesDivided
                    then factorizeOnce(num, den + 1)
                    else (den, numOfTimesDivided) :: factorizeOnce(remainder, den + 1)           end
    in
        factorizeOnce(n, 2)
    end;

(* factorize(20);
factorize(36);
factorize(1); *)

fun multiply (xs) =
    let
        fun pow (x,y) =
            if y = 1 then x else x * pow(x,y-1)
    in
        case xs of
            [] => 1
            | (x,y)::xs' => pow(x,y) * multiply(xs')
    end;

(* multiply [(2,2), (5,1)];
multiply [(2,2), (3,2)]; *)

fun all_products (xs) =
    let
        val num = multiply xs
        fun try x =
            if x = num then [num]
            else if num mod x = 0 then x :: try(x + 1)
            else try(x+1)
    in
        try(1)
    end;

all_products([(2,2),(5,1)]);