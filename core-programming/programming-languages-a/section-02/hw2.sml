(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)


fun all_except_option (str, xs) =
    let
        fun xs_has_str (xs) =
            case xs of
                [] => false
                | x::xs' => if same_string(str,x) then true else xs_has_str(xs')
        fun aux_assuming_it_has (xs) =
            case xs of
                [] => []
                | x::xs' => if same_string(str,x) then aux_assuming_it_has(xs')
                            else x::aux_assuming_it_has(xs')
    in
        if xs_has_str xs
        then SOME (aux_assuming_it_has(xs))
        else NONE
    end;


fun all_except_option (str, xs) =
    let
        fun aux (xs, itHadStr, acc) =
            case xs of
                [] => if itHadStr then SOME acc else NONE
                | x::xs' => if same_string(str,x)
                            then aux (xs', true, acc)
                            else aux (xs', itHadStr, acc @ [x])
    in
        aux (xs, false, [])
    end;

fun get_substitutions1 (xs, s) =
    case xs of
        [] => []
        | x::xs' => case all_except_option(s,x) of
                        NONE => get_substitutions1(xs',s)
                        | SOME y => y @ get_substitutions1(xs',s)

fun get_substitutions2 (xs, s) =
    let
        fun aux (xs, acc) =
            case xs of
                [] => acc
                | x::xs' => case all_except_option(s, x) of
                                NONE => aux(xs', acc)
                                | SOME y => aux(xs', acc @ y)
    in
        aux (xs, [])
    end;

fun similar_names (xs, {first=firstName, middle=middleName, last=lastName}) =
    let
        val substitutions = get_substitutions2(xs, firstName)
        val allFirstNames = firstName :: substitutions
        fun aux names =
            case names of
                [] => []
                | n::names' => {first=n, middle=middleName, last=lastName}::aux(names')
    in
        aux(allFirstNames)
    end;



(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove
exception IllegalSum

(* put your solutions for problem 2 here *)

fun card_color c =
    case c of
        (Clubs,_) => Black
        | (Spades,_) => Black
        | _ => Red;

fun card_value c =
    case c of
        (_,Num x) => x
        | (_,Ace) => 11
        | _ => 10;

fun remove_card (cs, c, e) =
    let
        fun aux (cs, acc, hadCard) =
            case cs of
                [] => if hadCard then acc else raise e
                | x::xs => if x = c andalso not hadCard then aux (xs, acc, true) else aux (xs, acc @ [x], hadCard)
    in
        aux (cs, [], false)
    end;

fun all_same_color cs =
    case cs of
        [] => true
        | c1::[] => true
        | c1::c2::cs' => if card_color (c1) = card_color (c2) then all_same_color(c2::cs') else false;

fun sum_cards cs =
    let 
        fun aux (cs, acc) =
            case cs of
                [] => acc
                | c::cs' => aux(cs', acc + card_value(c))
    in
        aux (cs, 0)
    end;

fun score (cs, goal) =
    let
        val sumCards = sum_cards cs
        val isAllSameColor = all_same_color cs
        val prelimScore = if sumCards > goal then 3 * (sumCards - goal) else (goal - sumCards)
        val finalScore = if isAllSameColor then prelimScore div 2 else prelimScore
    in
        finalScore
    end;

fun officiate (cs, ms, goal) =
    let
        fun play_moves (cardLists, moves, heldCards) =
            case moves of
                [] => score(heldCards, goal)
                | Draw::ms => (case cardLists of
                                [] => score(heldCards, goal)
                                | c::cs => let
                                                val newHeldCards = heldCards@[c]
                                                val sum = sum_cards(newHeldCards)
                                            in
                                                if sum > goal then score(newHeldCards, goal)
                                                else play_moves(cs, ms, newHeldCards)
                                            end)
                | (Discard c)::ms => play_moves(cardLists, ms, remove_card(heldCards, c, IllegalMove))
    in
        play_moves (cs, ms, [])
    end;

fun count_aces (cs) =
    case cs of
        [] => 0
        | (_,Ace)::cs' => 1 + count_aces cs'
        | _::cs' => count_aces cs';

fun possible_sums cs =
    let
        val regularSum = sum_cards cs
        val numOfAces = count_aces cs
        fun aux (n, scores) =
            case n of
                0  => regularSum::scores
                | n' => aux (n' - 1, (regularSum - 10 * n')::scores)
    in
        aux (numOfAces, [])
    end;

fun get_smallest_number ns =
    case ns of
        [] => raise IllegalSum
        | n::[] => n
        | n::ns' => Int.min(n, get_smallest_number(ns'));

fun get_prelim_score (sumCards, goal) =
    if sumCards > goal then 3 * (sumCards - goal) else (goal - sumCards);

fun get_prelim_scores (sums, goal) =
    case sums of
        [] => []
        | s::sums' => get_prelim_score(s, goal) :: get_prelim_scores(sums', goal);

fun get_final_scores (scores, isAllSameColor) =
    case scores of
        [] => []
        | s::scores' => if isAllSameColor then (s div 2)::get_final_scores(scores', isAllSameColor)
                        else s::get_final_scores(scores', isAllSameColor);

fun score_challenge (cs, goal) =
    let
        val possibleSums = possible_sums cs
        val isAllSameColor = all_same_color cs
        val prelimScores = get_prelim_scores (possibleSums, goal)
        val finalScores = get_final_scores (prelimScores, isAllSameColor)
    in
        get_smallest_number finalScores
    end;

 fun officiate_challenge (cs, ms, goal) =
    let
        fun play_moves (cardLists, moves, heldCards) =
            case moves of
                [] => score_challenge(heldCards, goal)
                | Draw::ms => (case cardLists of
                                [] => score_challenge(heldCards, goal)
                                | c::cs => let
                                                val newHeldCards = heldCards@[c]
                                                val allSums = possible_sums(newHeldCards)
                                                val smallestSum = get_smallest_number(allSums)
                                            in
                                                if
                                                    smallestSum > goal
                                                then
                                                    score_challenge(newHeldCards, goal)
                                                else
                                                    play_moves(cs, ms, newHeldCards)
                                            end)
                | (Discard c)::ms => play_moves(cardLists, ms, remove_card(heldCards, c, IllegalMove))
    in
        play_moves (cs, ms, [])
    end;

fun held_cards_sub_1_sums (cs) =
    let
        fun aux (newCards, usedCards, acc) =
            case newCards of
                [] => acc
                | c1::newCards' => aux (newCards', c1::usedCards, (sum_cards (usedCards@newCards'), c1)::acc)
    in
        aux (cs, [], [])
    end;
            
fun careful_player (cs, goal) =
    let
        fun aux (cs, heldCards, moves) =
            case cs of
                [] =>   let
                            val sumCards = sum_cards heldCards
                            val goalIsMoreThan10 = goal > 10 + sumCards
                        in
                            if goalIsMoreThan10 then moves@[Draw] else moves
                        end
                | c1::cs' => let
                                val newHeldCards = heldCards@[c1]
                                val sumCards = sum_cards heldCards
                                val newSumCards = sum_cards newHeldCards
                                val goalIsMoreThan10 = goal > 10 + sumCards
                                val c1Value = card_value c1;
                            in
                                if goalIsMoreThan10 then aux (cs', newHeldCards, moves@[Draw])
                                else if sumCards = goal then moves
                                else if newSumCards = goal then moves@[Draw]
                                else 
                                    let
                                        val heldCardsSub1SumsAndCard = held_cards_sub_1_sums(heldCards)
                                        fun checkAddingC1 (sums) =
                                            case sums of
                                                [] => moves
                                                | (s1,c)::sums' => if s1 + c1Value = goal
                                                                    then moves@[Discard c, Draw]
                                                                    else checkAddingC1(sums')
                                    in
                                        checkAddingC1 (heldCardsSub1SumsAndCard)
                                    end
                            end
    in
        aux(cs, [], [])
    end;
