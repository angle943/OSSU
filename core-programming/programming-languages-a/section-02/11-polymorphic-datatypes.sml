(* 

Finish the story

Claimed built-in options and lists are not needed/special
- other than special syntax for list constructors

But these datatype bindings are polymorphic type constructors
- int list and string list and int list list are all types, not list
- Functions might or might not be polymorphic
- - val sum_list : int list -> int
- - val append : 'a list * 'a list -> 'a list

Good language design: can define new polymorphic datatypes

Semi-optional: do not need to understand this for homework 2

 *)

 (* 
 
 Defining Polymorphic datatypes

 - syntax: put one or more type variables before datatype name
 
  *)

datatype 'a option = NONE | SOME of 'a;

datatype 'a mylist = Empty | Cons of 'a * 'a mylist;

datatype ('a,'b) tree =
Node of 'a * ('a,'b) tree * ('a,'b) tree
| Leaf of 'b;

(* 

- can use these type variables in constructor definitions

- binding then introduces a new type constructor, not a type
- - must say int mylist or string mylist or 'a mylist
- - not "plain" mylist

 *)

fun append (xs, ys) =
    case xs of
        [] => ys
        | x::xs' => x :: append(xs', ys);


datatype ('a, 'b) tree = Node of 'a * ('a,'b) tree * ('a,'b) tree
                        | Leaf of 'b;


(* type is (int,int) tree -> int *)
fun sum_tree tr =
    case tr of
        Leaf i => i
        | Node(i,lft,rgt) => i + sum_tree lft + sum_tree rgt;

(* type is ('a,int) tree -> int *)
fun sum_leaves tr =
    case tr of
        Leaf i => i
        | Node(i,lft,rgt) => sum_leaves lft + sum_leaves rgt;

(* type is ('a,'b) tree -> int *)
fun num_leaves tr =
    case tr of
        Leaf i => 1
        | Node(i.lft,rgt) => num_leaves lft + num_leaves rgt;