fun map(f, xs) =
    case xs of
        [] => []
        | x::xs' => (f x)::map(f,xs');

val x1 = map((fn x => x + 1), [1,2,3,4,5]);
val x2 = map(hd, [[1,2,3],[2,3,4],[4,5,6]]);

(* 

val map : ('a -> 'b) * 'a list => 'b list

Map is, without doubt, in the "higher-order function hall of fame"
- The name is standard (for any data structure)
- You use it all the time once you know it: saves a little space,
  but more importantly, communicates what you are doing
- similar predefined function: List.map
-- but it uses currying (coming soon)

 *)

fun filter(f, xs) =
    case xs of
        [] => []
        | x::xs' => if (f x)
                    then x::(filter (f,xs')) 
                    else filter (f, xs');

fun is_even v =
    (v mod 2 = 0);

fun all_even xs = filter(is_even, xs);

fun all_even_snd xs = filter((fn (_,v) => is_even v), xs);

all_even [3,4,6,0,13];
all_even_snd [(3,2),(4,5),(8,3),(10,10)];

(* 

FILTER

val filter : ('a -> bool) * 'a list -> 'a list

Filter is also in the hall-of-fame
- so use it whenever your computation is a filter
- Similar predefined function: List.filter
- - but it uses currying (coming soon)

 *)