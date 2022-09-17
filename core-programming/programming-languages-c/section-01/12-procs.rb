# BLOCKS ARE "SECOND CLASS"
#
# All a method can do with a block is yield to it
# - Cannot return it, store it in an object (eg for a callback), ...
# - but can also turn blocks into real closures
# - Closures are instances of class Proc
# - - Called with method call
#
# Blocks are "second-class"
# Procs are "first-class expressions"
#
# This is Ruby, so there are several ways to make Proc objects
# - One way: method lambda of Object takes a block and returns the corresponding Proc

a = [3,5,7,9]
b = a.map {|x| x + 1}
print b
i = b.count {|x| x >= 6 }
print i
print "\n"
c = a.map { |x| (lambda {|y| x >= y}) }
print c
print "\n"
print c[2].call 17
print c[2].call 7

j = c.count  {|x| x.call(5) }

# MORAL
#
# First-class ("can be passed/stored anywhere") makes closures more poweful than blocks
#
# But blocks are (a little) more convenient and cover most uses
#
# This helps us understand what first-class means
#
# Language design question: When is convenience worth making something less general and powerful?