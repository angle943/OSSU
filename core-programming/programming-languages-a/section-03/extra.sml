(* 1 *)
fun compose_opt f g x = case g x of
                            NONE => NONE
                            | SOME x' => case f x' of
                                            NONE => NONE
                                            | SOME x'' => SOME x''

(* 2 *)
fun do_until f p x = case p x of
                            true => do_until f p (f x)
                            | false => x

(* 3 *)
fun factorial n = 
    let
        fun nonzero(x,_) = x <> 0
        fun multiply(count,product) = (count-1, count*product)
    in
      #2 (do_until multiply nonzero (n,1))
    end

(* 4 *)
fun fixed_point f x =
    let
        fun does_not_equal x' = f x' <> x
    in
        do_until f does_not_equal x
    end

(* 5 *)
fun map2 f (a1,a2) = (f a1, f a2)

(* 6 *)
fun app_all f g x = 
    let 
        fun aux (xs, acc) =
            case xs of
                [] => acc
                | x::xs => aux (xs, acc@(f x))
    in
        aux (g x, [])
    end

(* 7 *)
fun foldr f init xs =
    let
        val rxs = List.rev
        fun aux(acc,xs) =
            case xs of
                [] => acc
                | x::xs => aux (f (x,acc), xs)
    in
        aux(init,xs)
    end


(* 8 *)
fun partition f xs =
    let 
        fun aux (xs, ts, fs) =
            case xs of
                [] => (ts, fs)
                | x::xs => if f x
                            then aux (xs,ts@[x],fs)
                            else aux (xs,ts,fs@[x])
    in
        aux(xs,[],[])
    end


(* 9 *)
fun unfold f x =
    let
        fun aux (n, acc) =
            case f n of
                NONE => acc
                | SOME (a,b) => aux (b, acc@[a])
    in
        aux (x,[])
    end

(* 10 *)
fun factorial2 n = List.foldl (fn (n,prod) => n*prod) 1 (unfold (fn a => if a=1 then NONE else SOME(a,a-1) ) n)

(* 11 *)
fun map f = List.foldr (fn (x, acc) => (f x) :: acc) []

(* 12 *)
fun filter f = List.foldr (fn (x,acc) => if (f x) then x::acc else acc) []

(* 13 *)