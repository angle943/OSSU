fun is_older (d1 : int * int * int, d2 : int * int * int) =
    if #1 d1 < #1 d2
    then true
    else if #1 d1 > #1 d2
    then false
    else
        if #2 d1 < #2 d2
        then true
        else if #2 d1 > #2 d2
        then false
        else
            #3 d1 < #3 d2;

fun number_in_month (dates : (int * int * int) list, month : int) =
    if null dates
    then 0
    else if (#2 (hd dates)) = month
    then 1 + number_in_month (tl dates, month)
    else number_in_month (tl dates, month);

fun number_in_months (dates: (int * int * int) list, months : int list) =
    if null months
    then 0
    else number_in_month (dates, hd months) + number_in_months (dates, tl months);

fun dates_in_month (dates : (int * int * int) list, month : int) =
    if null dates
    then []
    else if #2 (hd dates) = month
    then (hd dates) :: dates_in_month (tl dates, month)
    else dates_in_month (tl dates, month);

fun dates_in_months (dates : (int * int * int) list, months : int list) =
    if null months
    then []
    else dates_in_month (dates, hd months) @ dates_in_months (dates, tl months);

fun get_nth ( xs : string list, n : int) =
    if n = 1
    then hd xs
    else get_nth ( tl xs , n - 1);

fun date_to_string ( date : (int * int * int) ) =
    let
        val months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    in
        get_nth (months, #2 date) ^ " " ^ Int.toString (#3 date) ^ ", " ^ Int.toString (#1 date)
    end;

fun number_before_reaching_sum ( sum : int, xs : int list  ) =
    if (hd xs) >= sum
    then 0
    else if (hd (tl xs)) >= sum - (hd xs)
    then 1
    else 1 + number_before_reaching_sum (sum - (hd xs), tl xs);

fun what_month ( day : int) =
    let
        val days_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    in
        number_before_reaching_sum( day , days_in_months ) + 1
    end;

fun month_range (day1 : int, day2 : int) =
    if day2 < day1
    then []
    else if day1 = day2
    then [what_month(day1)]
    else
        what_month(day1) :: month_range(day1+1, day2);

fun oldest (ds : (int * int * int) list) =
    if null ds
    then NONE
    else
        let
            fun oldest_nonempty (ds : (int * int * int) list) =
                if null (tl ds)
                then hd ds
                else
                    let
                        val tl_oldest = oldest_nonempty(tl ds)
                    in
                        if is_older(hd ds, tl_oldest)
                        then hd ds
                        else tl_oldest
                    end
        in
            SOME ( oldest_nonempty(ds) )
        end;

fun remove_duplicates ( xs : int list ) =
    if null xs
    then []
    else
        let
            fun remove_dupe_helper (n : int, xs : int list) =
                if null xs
                then []
                else if n = (hd xs)
                then remove_dupe_helper (n, tl xs)
                else (hd xs) :: remove_dupe_helper (n, tl xs)
        in
            (hd xs) :: remove_duplicates( remove_dupe_helper(hd xs, tl xs) )
        end;

fun number_in_months_challenge (dates: (int * int * int) list, months : int list) =
    let
        val months_without_dupes = remove_duplicates(months)
    in
        number_in_months(dates, months_without_dupes)
    end;

fun dates_in_months_challenge (dates : (int * int * int) list, months : int list) =
    let
        val months_without_dupes = remove_duplicates(months)
    in
        dates_in_months(dates, months_without_dupes)
    end;

fun reasonable_date (date : int * int * int) =
    let
        val year = #1 date
        val month = #2 date
        val day = #3 date
        val is_leap_year = year mod 400 = 0 orelse (year mod 4 = 0 andalso year mod 100 <> 0)
    in
        if year <= 0
        then false
        else if month < 1 orelse month > 12
        then false
        else if day < 1 orelse day > 31
        then false
        else if (month = 4 orelse month = 6 orelse month = 9 orelse month = 11) andalso day > 30
        then false
        else if month = 2 andalso day > 29
        then false
        else if month = 2 andalso not is_leap_year andalso day > 28
        then false
        else true
    end;
