(* 1 *)
val only_capitals = List.filter (fn s => (Char.isUpper o String.sub) (s,0))

(* val test1 = only_capitals ["A","B","C"] = ["A","B","C"]
val test1b = only_capitals ["Abe","Bel","Ca"] = ["Abe","Bel","Ca"]
val test1c = only_capitals ["aba","BoB","cP"] = ["BoB"]
val test1d = only_capitals [] = [] *)

(* 2 *)
val longest_string1 = List.foldl (fn (s,longest) => if (String.size s) > (String.size longest)
                                                    then s else longest) ""

(* val test2 = longest_string1 ["A","bc","C"] = "bc"
val test2b = longest_string1 [] = ""
val test2c = longest_string1 ["a", "bc", "cd"] = "bc" *)

(* 3 *)
val longest_string2 = List.foldl (fn (s,longest) => if (String.size s) >= (String.size longest)
                                                    then s else longest) ""

(* val test2 = longest_string2 ["A","bc","C"] = "bc"
val test2b = longest_string2 [] = ""
val test2c = longest_string2 ["a", "bc", "cd"] = "cd" *)

(* 4 *)
fun longest_string_helper f = List.foldl 
                                (fn (s, longest) => if f(String.size s, String.size longest)
                                                    then s else longest)
                                ""

val longest_string3 = longest_string_helper (fn (a,b) => a > b)
val longest_string4 = longest_string_helper (fn (a,b) => a >= b)

(* val test3 = longest_string3 ["A","bc","C"] = "bc"
val test3b = longest_string3 [] = ""
val test3c = longest_string3 ["a", "bc", "cd"] = "bc"
val test4 = longest_string4 ["A","bc","C"] = "bc"
val test4b = longest_string4 [] = ""
val test4c = longest_string4 ["a", "bc", "cd"] = "cd" *)


(* 5 *)
val longest_capitalized =  longest_string1 o only_capitals

(* val test5 = longest_capitalized ["A","bc","C"] = "A"
val test5b = longest_capitalized ["HAHAHA", "ahahahahhaha", "aHaHaHAA", "abd"] = "HAHAHA" *)


(* 6 *)
val rev_string = String.implode o List.rev o String.explode

(* val test6 = rev_string "abc" = "cba" *)

exception NoAnswer

(* 7 *)
fun first_answer f =
	let fun callback xs = case xs of [] => raise NoAnswer
									| x::xs => case (f x) of NONE => callback xs
															| SOME v => v
	in callback end

(* val test7 = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3,4,5] = 4
val test7b = (first_answer (fn x => if x > 3 then SOME x else NONE) [1,2] handle NoAnswer => 100) = 100 *)


(* 8 *)
fun all_answers f =
	let 
		fun aux (xs, acc) =
			case xs of
				[] => SOME acc
				| x::xs => case (f x) of
								NONE => NONE
								| SOME v => aux(xs, acc@v)
	in (fn xs => aux (xs, [])) end

(* val test8 = all_answers (fn x => if x = 1 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE
val test8b = all_answers (fn x => if x = 1 then SOME [x] else NONE) [1,2,3,4,5,6,7] = NONE
val test8c = all_answers (fn x => if x >= 1 then SOME [x] else NONE) [2,3,4] = SOME [2,3,4]
val test8d = all_answers (fn x => if x >= 1 then SOME [x] else NONE) [] = SOME [] *)

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end



(* 9a *)
val count_wildcards = g (fn _ => 1) (fn _ => 0)

(* val test9a = count_wildcards Wildcard = 1 *)


(* 9b *)
val count_wild_and_variable_lengths = g (fn _ => 1) (fn s => String.size s)

(* val test9b = count_wild_and_variable_lengths (Variable("a")) = 1 *)

(* 9c *)
fun count_some_var (str, p) = g (fn _ => 0) (fn s => if s=str then 1 else 0) p

(* val test9c = count_some_var ("x", Variable("x")) = 1 *)

(* 10 *)
fun check_pat p =
	let
		fun getStrList p =
			case p of
				Variable x => [x]
				| TupleP ps => List.foldl (fn (p,acc) => (getStrList p)@acc) [] ps
				| ConstructorP(_,p) => getStrList p
				| _ => []
		
		fun hasNoRepeats xs =
			case xs of
				[] => true
				| x::xs => let val xExists = List.exists (fn y => x=y) xs in if xExists then false else hasNoRepeats xs end
	in
		(hasNoRepeats o getStrList) p
	end

(* val test10 = check_pat (Variable("x")) = true *)	


(* 11 *)
(* (valu * pattern) -> (string * value) list option *)
fun match (v, p) =
	case (v,p) of
		(_,Wildcard) => SOME []
		| (_,Variable s) => SOME [(s,v)]
		| (Unit,UnitP) => SOME []
		| (Const z2, ConstP z1) => if z1 = z2 then SOME [] else NONE
		| (Tuple vs,TupleP ps) => all_answers match (ListPair.zipEq (vs,ps) handle UnequalLength => [(Const 1,UnitP)])
		| (Constructor(s2,v),ConstructorP (s1,p)) => if s1=s2 then match(v,p) else NONE
		| _ => NONE

(* val test11 = match (Const(1), UnitP) = NONE
val test11a = match (Const 1,Wildcard) = SOME []
val test11b = match () *)


(* 12 *)
fun first_match v ps = (SOME (first_answer (fn p => match(v,p)) ps)) handle NoAnswer => NONE

(* val test12 = first_match Unit [UnitP] = SOME []
val test12b = first_match Unit [ConstP 3] = NONE *)


(**** for the challenge problem only ****)

exception WrongTyp
datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)

(* challenge *)
(* 
	(string * string * typ) list) * (pattern list) -> typ option
 *)
fun ps_has_ConstP ps =
	case ps of
		[] => false
		| p::ps => case p of ConstP _ => true | _ => ps_has_ConstP (ps)

(* val testA1 = ps_has_ConstP [] = false
val testA2 = ps_has_ConstP [ConstP 2] = true
val testA3 = ps_has_ConstP [Wildcard, ConstP 3] = true
val testA4 = ps_has_ConstP [Wildcard, UnitP] = false *)

fun check_if_valid_ConstP ps =
	case ps of
		[] => true
		| p::ps => case p of
						UnitP => false
						| TupleP _ => false
						| ConstructorP _ => false
						| _ => check_if_valid_ConstP ps

(* val testB1 = check_if_valid_ConstP [] = true
val testB2 = check_if_valid_ConstP [ConstP 2] = true
val testB3 = check_if_valid_ConstP [ConstP 3, Wildcard, Variable "a"] = true
val testB4 = check_if_valid_ConstP [UnitP] = false	 *)

fun ps_has_TupleP ps =
	case ps of
		[] => false
		| p::ps => case p of TupleP _ => true | _ => ps_has_TupleP ps

(* val testC1 = ps_has_TupleP [] = false
val testC2 = ps_has_TupleP [TupleP [Wildcard]] = true
val testC3 = ps_has_TupleP [Wildcard, TupleP [Wildcard]] = true
val testC4 = ps_has_TupleP [Wildcard, Variable "a"] = false *)

fun check_if_all_tuples_have_same_size ps =
	let 
		fun aux (ps, acc) =
			case ps of
				[] => true
				| p::ps => case p of
							TupleP ts => (case acc of
											NONE => aux (ps, SOME (List.length ts))
											| SOME l => if List.length ts <> l then false else aux (ps, acc))
							| _ => aux (ps, acc)
	in
		aux (ps, NONE)
	end

(* val testD1 = check_if_all_tuples_have_same_size [] = true
val testD2 = check_if_all_tuples_have_same_size [TupleP [Wildcard]] = true
val testD3 = check_if_all_tuples_have_same_size [TupleP [Wildcard], TupleP [Variable "a"], Wildcard] = true
val testD4 = check_if_all_tuples_have_same_size [TupleP [Wildcard], TupleP [Variable "a", Wildcard], Wildcard] = false *)

fun check_if_tuples_have_no_conflicting_type ps =
	case ps of
		[] => true
		| p::ps => case p of
						UnitP => false
						| ConstP _ => false
						| ConstructorP _ => false
						| _ => check_if_tuples_have_no_conflicting_type ps

(* val testE1 = check_if_tuples_have_no_conflicting_type [] = true
val testE2 = check_if_tuples_have_no_conflicting_type [Wildcard, Variable "a"] = true
val testE3 = check_if_tuples_have_no_conflicting_type [ConstructorP("SOME", Wildcard)] = false *)

fun check_if_valid_tupleP ps = (check_if_all_tuples_have_same_size ps) andalso (check_if_tuples_have_no_conflicting_type ps)

fun filter_in_tuples ps =
	case ps of
		[] => []
		| p::ps => case p of
					TupleP ts => (TupleP ts)::filter_in_tuples(ps)
					| _ => filter_in_tuples(ps)

(* val testF1 = filter_in_tuples [] = []
val testF2 = filter_in_tuples [Wildcard, TupleP [Wildcard]] = [TupleP [Wildcard]] *)

fun getTuplePSize ts =
	case ts of
		[] => 0
		| (TupleP xs)::_ => List.length xs
        | _ => raise WrongTyp

fun getIthPatternInTuple (t, i) =
	case t of TupleP xs => List.nth(xs, i) | _ => raise WrongTyp

fun getIthPatternsInTupleList (ps, i) =
	case ps of
		[] => []
		| p::ps => getIthPatternInTuple(p, i) :: getIthPatternsInTupleList(ps,i)


fun optionListHasNone (xs) =
	case xs of
		[] => false
		| x::xs => case x of
					NONE => true
					| SOME _ => optionListHasNone xs

fun takeOptionValsOut xs = List.map valOf xs

fun ps_has_unitP ps =
	case ps of
		[] => false
		| p::ps => case p of UnitP => true | _ => ps_has_unitP ps

fun check_if_valid_unitP ps =
	case ps of
		[] => true
		| p::ps => case p of
						Variable _ => false
						| ConstP _ => false
						| TupleP _ => false
						| ConstructorP _ => false
						| _ => check_if_valid_unitP ps

fun ps_has_ConstructorP ps =
	case ps of
		[] => false
		| p::ps => case p of ConstructorP _ => true | _ => ps_has_ConstructorP ps

fun check_if_constructors_have_no_conflicting_type ps =
	case ps of
		[] => true
		| p::ps => case p of
						UnitP => false
						| ConstP _ => false
						| TupleP _ => false
						| _ => check_if_constructors_have_no_conflicting_type ps

fun filter_in_constructors ps =
	case ps of
		[] => []
		| p::ps => case p of
					ConstructorP t => (ConstructorP t)::filter_in_constructors(ps)
					| _ => filter_in_constructors(ps)

fun ps_has_constructor_names_not_in_vs (ps, vs) =
	case ps of
		[] => false
		| p::ps => case p of
					ConstructorP(s,_) => (case (List.find (fn (x,_,_) => s=x) vs) of
											NONE => true
											| SOME _  => ps_has_constructor_names_not_in_vs (ps, vs))
					| _ => raise WrongTyp

fun ps_has_more_than_one_datatype (ps, vs, acc) =
	case ps of
		[] => false
		| p::ps => case p of
					ConstructorP(s,_) => (case (List.find (fn (x,_,_) => s=x) vs) of
											NONE => raise WrongTyp
											| SOME (_,dt,_) => (case acc of 
																	NONE => ps_has_more_than_one_datatype(ps,vs,SOME dt)
																	| SOME predt => if predt <> dt then true
																					else ps_has_more_than_one_datatype(ps,vs,acc)))
					| _ => raise WrongTyp

fun ps_get_first_datatype (ps, vs) =
	case ps of
		[] => raise WrongTyp
		| p::ps => case p of
					ConstructorP(s,_) => (case (List.find (fn (x,_,_) => s=x) vs) of
											NONE => raise WrongTyp
											| SOME (_,dt,_) => dt)
					| _ => raise WrongTyp

fun p_and_t_are_compatible (p,t) =
	case p of
		Wildcard => true
		| Variable s => (case t of
							UnitT => false
							| _ => true)
		| UnitP => (case t of
						UnitT => true
						| _ => false)
		| ConstP z => (case t of
							UnitT => false
							| TupleT _ => false
							| Datatype _ => false
							| _ => true)
		| TupleP ps => (case t of
							UnitT => false
							| IntT => false
							| Datatype _ => false
							| Anything => true
							| TupleT ts => List.all p_and_t_are_compatible (ListPair.zip (ps,ts)))
		| ConstructorP _ => (case t of
									Anything => true
									| UnitT => false
									| IntT => false
									| TupleT _ => false
									| Datatype _ => true)


fun all_constructorP_patterns_are_valid (ps, vs) =
	case ps of
		[] => true
		| p::ps => case p of
					ConstructorP(s,p) => (case (List.find (fn (x,_,_) => s=x) vs) of
											NONE => raise WrongTyp
											| SOME (_,_,tp) => if p_and_t_are_compatible (p, tp)
																then all_constructorP_patterns_are_valid(ps,vs)
																else false)
					| _ => raise WrongTyp

fun typecheck_patterns (vs, ps) = 
	let
		val psHasUnitP = ps_has_unitP ps
		val psHasConstP = ps_has_ConstP ps
		val psHasTupleP = ps_has_TupleP ps
		val psHasConstructorP = ps_has_ConstructorP ps
	in
		if (psHasUnitP andalso check_if_valid_unitP ps)
		then SOME UnitT
		else if psHasUnitP then NONE
		else if (psHasConstP andalso check_if_valid_ConstP ps)
		then SOME IntT
		else if psHasConstP then NONE
		else if (psHasTupleP andalso check_if_valid_tupleP ps)
		then (let
				val tuplePs = filter_in_tuples ps
				val tuplePatternLength = getTuplePSize tuplePs
				fun getPatternsForEachIndex (i) =
					if i = tuplePatternLength
					then []
					else getIthPatternsInTupleList(tuplePs, i) :: getPatternsForEachIndex (i + 1)
				val patternsForEachIndex = getPatternsForEachIndex 0
				val typecheckResultsForEachIndex = List.map (fn ps => typecheck_patterns(vs,ps) ) patternsForEachIndex
			in
				if (optionListHasNone typecheckResultsForEachIndex)
				then NONE
				else SOME (TupleT (takeOptionValsOut typecheckResultsForEachIndex))
			end)
		else if psHasTupleP then NONE
		else if psHasConstructorP
		then (let
				val hasNoConflictingTypes = check_if_constructors_have_no_conflicting_type ps
				val constructorPs = filter_in_constructors ps
				val psHasConstructorNamesNotInVs = ps_has_constructor_names_not_in_vs (constructorPs,vs)
			in
				if (not hasNoConflictingTypes orelse psHasConstructorNamesNotInVs) then NONE
				else if (ps_has_more_than_one_datatype (constructorPs, vs, NONE)) then NONE
				else if (all_constructorP_patterns_are_valid (constructorPs, vs))
				then SOME (Datatype (ps_get_first_datatype (constructorPs,vs)))
				else NONE
			end
		)
		else SOME Anything
	end


val testc1 = typecheck_patterns (
	[],
	[
		ConstP 10,
		Variable "a"
	]
) = SOME IntT

val testc2 = typecheck_patterns (
	[("SOME", "option", Anything), ("NONE", "option", UnitT)],
	[
		ConstP 10,
		ConstructorP("SOME", Variable "x"),
		Variable "a"
	]
) = NONE

val testc3 = typecheck_patterns (
	[],
	[
		TupleP [Variable "a", ConstP 10, Wildcard],
		TupleP [Variable "b", Wildcard, ConstP 11],
		Wildcard
	]
) = SOME (TupleT [Anything, IntT, IntT])

val testc3b = typecheck_patterns (
	[],
	[
		TupleP [UnitP, UnitP, Wildcard],
		TupleP [Wildcard, Wildcard, UnitP],
		Wildcard
	]
) = SOME (TupleT [UnitT, UnitT, UnitT])

val testc4 = typecheck_patterns (
	[("Red","color",UnitT),("Green","color",UnitT),("Blue","color",UnitT)],
	[
		ConstructorP ("Red", UnitP),
		Wildcard
	]
) = SOME (Datatype "color")

val testc5 = typecheck_patterns (
	[("Sedan","auto", Datatype "color"),("Truck","auto",TupleT[IntT, Datatype "color"]),("SUV","auto",UnitT)],
	[
		ConstructorP ("Sedan", Variable "a"),
		ConstructorP ("Truck", TupleP [Variable "b", Wildcard]),
		Wildcard
	]
) = SOME (Datatype "auto")

val testc6 = typecheck_patterns (
	[("Empty","list",UnitT),("List","list",TupleT[Anything, Datatype "list"])],
	[
		ConstructorP ("Empty", UnitP),
		ConstructorP ("List", TupleP[ConstP 10, ConstructorP ("Empty", UnitP)]),
		Wildcard
	]
) = SOME (Datatype "list")

val testc7 = typecheck_patterns (
	[("Empty","list",UnitT),("List","list",TupleT[Anything, Datatype "list"])],
	[
		ConstructorP("Empty",UnitP),
		ConstructorP("List",TupleP[Variable "k", Wildcard])
	]
) = SOME (Datatype "list")

val testc8 = typecheck_patterns (
	[("Empty","list",UnitT),("List","list",TupleT[Anything, Datatype "list"])],
	[
		ConstructorP("Empty",UnitP),
		ConstructorP("List",TupleP[ConstructorP("Sedan", Variable "c"), Wildcard])
	]
) = SOME (Datatype "list")


val testc9 = typecheck_patterns (
	[],
	[
		TupleP [Variable "x", Variable "y"],
		TupleP [Wildcard, Wildcard]
	]
) = SOME (TupleT [Anything, Anything])

val testc10 = typecheck_patterns (
	[],
	[
		TupleP [Wildcard, Wildcard],
		TupleP [Wildcard, TupleP[Wildcard, Wildcard]]
	]
) = SOME (TupleT [Anything, TupleT [Anything, Anything]])

val test1 = typecheck_patterns(
[("Empty","list",UnitT),("List","list",TupleT[Anything, Datatype "list"])],
[ConstructorP("Empty",UnitP),ConstructorP("List",TupleP[ConstP 10, ConstructorP("Empty",UnitP)]), Wildcard]) = SOME(Datatype "list")

val test2 = typecheck_patterns(
[("Empty","list",UnitT),("List","list",TupleT[UnitT, Datatype "list"])],
[ConstructorP("Empty",UnitP),
ConstructorP("List",TupleP[ConstP 10, ConstructorP("Empty",UnitP)]), 
Wildcard]) = NONE