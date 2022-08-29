(* 

CALLBACKS

A common idiom: Library takes functions to apply later, when an event occurs - examples:
- When a key is pressed, mouse moves, data arrives
- When the program enters some state (eg turns in a game)

A library may accept multiple callbacks
- Different callbacks may need different private data with different types
- Fortunately, a function's type does not include the types of bindings in its environment
- (in OOP, objects and private fields are used similarly, eg Java Sing's event-listeners)


MUTABLE STATE

While its not absolutely necessary, mutable state is reasonably appropriate here
- We really do want the "callbacks registered" to change when a function to register a callback is called

 *)

 (* 
 
 EXAMPLE call-back library

 Library maintains mutable state for "what callbacks are there"
 and provides a function for accepting new ones
 - A real library would support removing them, etc
 - In example, callbacks have type int -> unit

 So the entire public library interface would be the function for registering new callbacks:

 val onKeyEvent : (int -> unit) -> unit

 (because cbs are executed for side-effect, they may also need mutable state)
 
  *)

  val cbs : (int -> unit) list ref = ref []

  fun onKeyEvent f = cbs := f :: (!cbs)

  fun onEvent i =
    let fun loop fs =
        case fs of
            [] => ()
            | f::fs' => (f i; loop fs')
        in loop (!cbs) end


(* 

CLIENTS

can only register an int -> unit, so if any other data is needed, must
be in closure's environment
- and if need to "remember" something, need mutable state

 *)

 val timesPressed = ref 0
 val _ = onKeyEvent (fn _ =>
                timesPressed := (!timesPressed) + 1)

fun printIfPressed i =
    onKeyEvent (fn j =>
        if i=j
        then print ("you pressed " ^ Int.toString i)
        else ())

val _ = printIfPressed 4
val _ = printIfPressed 11
val _ = printIfPressed 23
val _ = printIfPressed 4

val timPressed = !timesPressed
val _ = onEvent 11;
val timePresseds = !timesPressed