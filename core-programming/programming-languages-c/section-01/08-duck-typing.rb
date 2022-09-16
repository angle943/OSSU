
# DUCK TYPING
#
# "If it walks like a duk and quacks like a duck, it's a duck"
#  - or don't worry that it may not be a duck
#
# When writing a method you might think, "I need a Foo argument"
# but really you need an object with enough methods similar to Foo's method that your method works
# - Embracing duck typing is always making method calls rather than assuming/testing the class of arguments
#
# Plus: More code reuse; very OOP approach
# - What messages an object receive is "all that matters"
#
# Minus: almost nothing is equivalent:
# - x+x verses x*2 verses 2*x
# - Callers may assume a lot about how callees are implemented
#
# DUCK TYPING EXAMPLE
#
# def mirror_update pt
#   pt.x = pt.x * (-1)
# end
#
# Natural thought: "Takes a Point object (definition not shown here), negates the x value"
# - makes sense, though a Point instance method more OOP
#
# Closer look: "Takes anything with getter and setter methods for @x instance variable and multiplies the x field by -1"
#
# Duck typing: "Takes anything with method x= and x where result of x has a * method that can take -1.
#   Sends result of calling x the * message with -1 and sends that result to x="
#
# Plus: Maybe mirror_update is useful for classes we did not anticipate
#
# Minus: If someone does use (abuse?) duck typing here, then we cannot change the implementation of mirror_update
# - For example, to - pt.x
#
# Better (?) example: can pass this method a number, a string, or a MyRational
#
# def double x
#   x + x
# end