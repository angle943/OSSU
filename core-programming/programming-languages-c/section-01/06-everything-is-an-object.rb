

# PURE OOP
#
# Ruby is fully committed to OOP:
# - Every value is a reference to an object
#
# Simpler, smaller semantics
#
# Can call methods on anything
# - May just get a dynamic "undefined method" error
#
# Almost everything is a method call
# - Example: 3 + 4

puts 3 + 4
puts 3.+(4)
puts 3.abs
puts -5.abs
puts 3.nonzero?
puts 0.nonzero?
x = if 3 > 4 then 5 else -5 end
puts x
puts nil.nil?
puts "hi".nil?

# ALL CODE IS METHODS
#
# All methods you define are part of a class
#
# Top-level methods (in file or REPL) just added to Object class
#
# Subclassing discussion coming later, but:
# - since all classes you define are subclasses of Object, all
#   inherit the top-level methods
# - So you can call these methods anywhere in the program
# - Unless a class overrides (roughly-not-exactly, shadows) it by defining a method with the same name


# Reflection and exploratory programming
#
# All objects also have methods like:
# - methods
# - class
#
# Can use at run-time to query "what an object can do" and respond accordingly
# - Called reflection
#
# Also useful in the REPL to explore what methods are available
# - May be quicker than consulting full documentation
#
# Another example of "just objects and method calls"