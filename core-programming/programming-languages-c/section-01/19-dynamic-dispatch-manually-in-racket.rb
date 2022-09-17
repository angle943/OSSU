# MANUAL DYNAMIC DISPATCH
#
# Now; Write Racket code with little more than pairs and functions that acts like objects with dynamic dispatch
#
# Why do this?
# - Racket actually has classes and objects available)
#
# - Demonstrates how one language's semantics is an idiom in another language
# - Understand dynamic dispatch better by coding it up
# - - Rougly how an interpreter/compiler might
#
# Analogy: Earlier optional material encoding higher-order functions using objects and explicit environments
#
#
# OUR APPROACH
#
# Many ways to do it; our code does this:
# - An 'boject' has a list of field pairs and a list of method pairs
#  (struct obj (fields methods))
# - Field-list element example:
# - (mcons 'x 17)
# - Method-list element example:
#   (cons 'get-x (lambda (self args) ...))
#
# Notes:
# - Lists sufficient but not efficient
# - Not class-based: object has a list of methods, not a class that has a list of methods [could do it that way instead]
# - Key trick is lambdas taking an extra self argument
# - All "regular" arguments put in a list args for simplicity
#
#
#
# WHY NOT ML?
#
# We were wise not to try this in ML!
#
# ML's type system does not have subtyping for declaring a polar-point type that is also a point type
# - workarounds possible (eg one type for all objects)
# - still no good type for those self arguments to functions
# - - Need quite sophisticated type systems to support dynamic dispatch fi it is not built into the language
#
# In fairness, languages, with subtyping but not generics make it analogously awkward to write generic code