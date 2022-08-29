(* 

IMPLEMENTING AN ADT

As our last idiom, closures can implement "abstract data types"
- Can put multiple functions in a record
- The functions can share the same private data
- Private data can be mutable or immutable
- Feels a lot like objects, emphasizing that OOP and functional
  programming have some deep similarities


See code for an implementation of immutable integer sets with operations
insert, member, and size

The actual code is advanced/clevery/tricker, but has no new features
- Combine lexical scope, datatypes, records, closures, etc
- client use is not so tricky

 *)

 datatype set = S of {
    insert : int -> set,
    member : int -> bool,
    size   : unit -> int
 }


val empty_set =
    let
        fun make_set xs = (* xs is a private field *)
            let
                fun contains i = List.exists (fn j => i=j) xs
            in
                S {
                    insert = fn i => if contains i then make_set xs else make_set (i::xs),
                    member = contains,
                    size = fn () => length xs
                }
            end
    in
        make_set []
    end

(* example client *)
fun use_sets () =
    let val S s1 = empty_set
        val S s2 = (#insert s1) 34
        val S s3 = (#insert s2) 34
        val S s4 = #insert s3 19
    in
        if (#member s4) 42
        then 99
        else if (#member s4) 19
        then 17 + (#size s3) ()
        else 0
    end

val result = use_sets()