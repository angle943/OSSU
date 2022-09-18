# WHAT ARE GENERICS GOOD FOR?
#
# Some good uses for parametric polymorphism
# - Types for functions that combine other functions:
#
# fun compose (g,h) = fn x => g (h x)
#
# - types for functions that operate over generic collections
#
# val length : 'a list -> int
# val map : ('a -> 'b) -> 'a list -> b' list
# val swap : ('a * 'b) -? ('b * a')
#
# Many other idioms
#
# General point: when types can be anything but multiple things need to be the same type
#
#
# GENERICS IN JAVA
#
# Java generics a bit clumsier syntactically and semantically, but can express the same ideas
# - Without closures, often need to use (one-method) objects
# - see also earlier optional lecture on closures in Java/C
#
# Simple example without higher-order functions (optional):

# SUBTYPING IS NOT GOOD FOR THIS
#
# Using subtyping for containers is much more painful for clients
# - Have to downcast items retrieved from containers
# - Downcasting has run-time cost
# - Downcasting can fail: no static check that container holds the type of data you expect
# - (only gets more painful with higher-order functions like map)
#
# classw LamePair {
#   Object x;
#   Object y;
#   LamePair(Object _x, Object _y) { x=_x; y=_y; }
#   LamePair swap() { return new LamePair(y,x); }
# }
#
# // error caught only at run-time:
# String s = (String)(new LamePair("hi",4).y);

# WHAT IS SUBTYPING GOOD FOR?
#
# Some good uses for subtype polymorphism:
#
# - Code that "needs a Foo" but fine to have "more than a Foo"
#
# - Geometry on points works fine for colored points
#
# - GUI widgets specialize the basic idea of "being on the screen" and "responding to user actions"


# AWKWARD IN ML
#
# ML does not have subtyping, so this simply does not type-check:
#
# fun distToOrigin ({x=x,y=y}) =
#   Math.sqrt(x*x+y*y)
#
# val five = distToOrigin {x=3.0,y=4.0,color="red"}
#
# Cumbersome workaround: have caller pass in getter functiosn:
#
# fun distToOrigin (getx, gety, v) =
#   Math.sqrt((getx v)*(getx v) + (gety v)*(gety v))
#
# - and clients still need different getters for points, color-points