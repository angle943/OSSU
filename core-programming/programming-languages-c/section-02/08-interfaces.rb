# STATICALLY-TYPED OOP
#
# Now contrast multiple inheritance and mixins with Java/C#-style interfaces
#
# Important distinction, but interfaces are about static typing, which Ruby does not have
#
# So will use Java [pseudo]code after quick introduction to static typing for class-based OOP...
# - sound typing for OOP prevents "method missing" errors


# CLASSES AS TYPES
#
# In Java/C#/etc each lass is also a type
#
# Methods have types for arguments and result
#
# class A {
#   Object m1(Example e, String s) {...}
#   Integer m2(A foo, Boolean b, Integer i) {...}
# }
#
# If C is a (transitive) subclass of D, then C is a subtype of D
# - Type-checking allows subtype anywhere supertype allowed
# - So can pass instance of C to a method expecting isntance of D


# INTERFACES ARE TYPES
#
# interface Example {
#   void m1(int x, int y);
#   Object m2(Example x, String y);
# }
#
# An interface is not a class; it is only a type
# - does not contain method definitions, only their signatures (types)
#   - unlike mixins
# - Cannot use new on an interface
#   - like mixins


# IMPLEMENTING INTERFACES
#
# A class can explicitly implement any number of interfaces
# - For class to type-check, it must implement every method in the interface with the right type
#   - more on allowing subtypes later!
# - Multiple interfaces no problem; just implement everything
#
# If a class type-checks, it is a subtype of the interface
#
# class A implements Example {
#   public void m1(int x, int y) {...}
#   public Object m2(Example e, String s) {...}
# }
# class B implements Example {
#   public void m1(int pizza, int beer) {...}
#   public Object m2(Example e, String s) {...}
# }

# MULTIPLE INTERFACES
#
# Intefaces provide no methods or fields
# - So no question of method/field duplication when implementing multiple intefaces, unlike multiple inheritance
#
# What interfaces are for:
# - "Caller can give any instance of any class implementing I"
#   - So callee can call methods in I regardless of class
# - So much more flexible type system
#
# Interfaces have little use in a dynamically typed language
# - Dynamic typing already much more flexible, with trade-offs we studied