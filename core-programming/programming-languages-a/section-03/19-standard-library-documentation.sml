(* 

ONE LAST THING

This topic is not particularly related to the rest of the section, but we
made it a small part of Homework 3

ML, like many languges, has a standard library
- For things you could not implement on your own:
-- Ex: Opening a file, setting a timer
- For thigns so common, a standard definition is appropriate
-- Ex: List.map, string concatentation

You should get comfortable seeking out documentation and gaining
intuition on where to look
- Rather than always being told exactly what function do

 *)


 (* 
 
 WHERE TO LOOK

 http://www.standardml.org/Basis/manpages.html

 Organized into structures, which have signatures
 - Define our own structures and signatures next section

 HW3: find-and-use or read-about-and-use a few functions
 under STRING, Char, List, and ListPair

 To use a binding: StructureName.functionName
 - Examples: List.map, String.isSubstring
 
  *)


  (* 
  
  REPL Trick

  - I often forget the order of function arguments

  - While no substitute for full documentation, you can use the REPL for a quicck reminder
  -- Just type in the function name for its type
  -- Can also guess function names or print whole structure
  -- No special support: this is just what the REPL does

  - Some REPLs(for other languages) have special support for printing docs
  
   *)

structure X = List;
signature X = List;