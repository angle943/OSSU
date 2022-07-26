(* 1 *)
val only_capitals = List.filter (fn s => (Char.isUpper o String.sub) (s,0))

(* 2 *)
val longest_string1 = List.foldl (fn (s,longest) => if (String.size s) > (String.size longest)
                                                    then s else longest) ""

(* 3 *)
val longest_string2 = List.foldl (fn (s,longest) => if (String.size s) >= (String.size longest)
                                                    then s else longest) ""

(* 4 *)
fun longest_string_helper f = List.foldl 
                                (fn (s, longest) => if f(String.size s, String.size longest)
                                                    then s else longest)
                                ""

val longest_string3 = longest_string_helper (fn (a,b) => a > b)
val longest_string4 = longest_string_helper (fn (a,b) => a >= b)

(* 5 *)
val longest_capitalized =  longest_string1 o only_capitals

(* 6 *)
val rev_string = String.implode o List.rev o String.explode

exception NoAnswer

(* 7 *)
fun first_answer f =
	let fun callback xs = case xs of [] => raise NoAnswer
									| x::xs => case (f x) of NONE => callback xs
															| SOME v => v
	in callback end

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

(* 9b *)
val count_wild_and_variable_lengths = g (fn _ => 1) (fn s => String.size s)

(* 9c *)
fun count_some_var (str, p) = g (fn _ => 0) (fn s => if s=str then 1 else 0) p

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

(* 11 *)
fun match (v, p) =
	case (v,p) of
		(_,Wildcard) => SOME []
		| (_,Variable s) => SOME [(s,v)]
		| (Unit,UnitP) => SOME []
		| (Const z2, ConstP z1) => if z1 = z2 then SOME [] else NONE
		| (Tuple vs,TupleP ps) => all_answers match (ListPair.zipEq (vs,ps) handle UnequalLength => [(Const 1,UnitP)])
		| (Constructor(s2,v),ConstructorP (s1,p)) => if s1=s2 then match(v,p) else NONE
		| _ => NONE

(* 12 *)
fun first_match v ps = (SOME (first_answer (fn p => match(v,p)) ps)) handle NoAnswer => NONE

(* CHALLENGE *)
exception WrongTyp
datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)

(* challenge *)
fun ps_has_ConstP ps =
	case ps of
		[] => false
		| p::ps => case p of ConstP _ => true | _ => ps_has_ConstP (ps)


fun check_if_valid_ConstP ps =
	case ps of
		[] => true
		| p::ps => case p of
						UnitP => false
						| TupleP _ => false
						| ConstructorP _ => false
						| _ => check_if_valid_ConstP ps

fun ps_has_TupleP ps =
	case ps of
		[] => false
		| p::ps => case p of TupleP _ => true | _ => ps_has_TupleP ps

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

fun check_if_tuples_have_no_conflicting_type ps =
	case ps of
		[] => true
		| p::ps => case p of
						UnitP => false
						| ConstP _ => false
						| ConstructorP _ => false
						| _ => check_if_tuples_have_no_conflicting_type ps

fun check_if_valid_tupleP ps = (check_if_all_tuples_have_same_size ps) andalso (check_if_tuples_have_no_conflicting_type ps)

fun filter_in_tuples ps =
	case ps of
		[] => []
		| p::ps => case p of
					TupleP ts => (TupleP ts)::filter_in_tuples(ps)
					| _ => filter_in_tuples(ps)

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

