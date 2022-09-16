
# CHANGING CLASSES
#
# Ruby programs (or the REPL) can add/change/replace methods while a program is running
#
# Breaks abstractions and makes programs very difficult to analyze,
# but it does have plausible uses
# - Simple example: add a useful helper method to a class you did not define
# - - Controversial in large programs, but may be useful
#
# For us: Helps re-enforce "the rules of OOP"
# - every object has a class
# - A class determines its instances' behavior

load './05-a-longer-example.rb'

x = MyRational.new(9,6)
puts x.to_s

# THE MORAL
#
# Dynamic features cause interesting semantic questions
#
# Example:
# - first create an instance of class C, eg, x = C.new
# - now replace method method m in C
# - Now call x.m
# Old method or new method? In Ruby, new method
#
# The point is Java/C#/C++ do not have to ask the question
# - May allow more optimized method-call implementations as a result