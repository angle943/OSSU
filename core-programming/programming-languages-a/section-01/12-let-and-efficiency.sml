fun countup(to : int) =
    let
        fun count (from: int) =
            if from = to
            then [to]
            else from :: count(from+1)
    in
        count(1)
    end

fun bad_max (xs : int list) =
    if null xs
    then 0
    else if null (tl xs)
    then hd xs
    else if hd xs > bad_max(tl xs)
    then hd xs
    else bad_max(tl xs);


fun good_max (xs : int list) =
    if null xs
    then 0
    else if null (tl xs)
    then hd xs
    else
        let
            val next_call = good_max(tl xs)
        in
            if hd xs > next_call
            then hd xs
            else next_call
        end;
