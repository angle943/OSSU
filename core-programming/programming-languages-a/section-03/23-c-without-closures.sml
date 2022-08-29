(* 

NOW C

Closures and OOP objects can have "parts" that do not show up in their types

In C, a function pointer is only a code pointer
- So without extra thought, functions taking function-pointer args
  will not be as useful as functions taking closures

A common technique:
- Always define function pointers and higher-order functions to take an extra, 
  explicit environment argument
- But without generixcsc, no good choice for type of list elements or the environment
-- Use void* and various type casts...

 *)

 (* 
 
 typedef struct List list_t;
 struct List {
    void * head;
    list_t * tail;
 };

 list_t * makelist (void * x, list_t * xs) {
    list_t * ans = (list_t)
 }
 
  *)