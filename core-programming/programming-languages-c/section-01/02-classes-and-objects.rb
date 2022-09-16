

# THE RULES OF CLASS-BASED OOP
# /
# In Ruby:
# 1. All values are references to objects
# 2. Objects communicate via method calls, also known as messages
# 3. Each object has its own (private) state
# 4. Every object is an instance of a class
# 5. An object's class determines the object's behavior
# - How it handles method calls
# - Class contains method definitions
# -
# - Java/C#/etc similar but do not follow (1) (eg numbers, null) and
# allow objects to have non-private state
# /
# /
# /
# DEFINING CLASSES AND METHODS
# /
# class Name
#   def method_name1 method_args1
#     expression1
#   end
#   def method_name2 method_args2
#     expression2
#   end
#   ...
# end
#/
# - Define a new class called with methods as defined
# - Methods returns its last expression
# - - Ruby also has explicit return statement
# - Syntax note: line breaks often required (else need more syntax), but indentation always only style

class A
  def m1
    34
  end

  def m2 (x,y)
    z = 7
    if x > y
      false
    else
      x + y * z
    end
  end

end

# a = A.new
# puts a.m1
# puts a.m2(3,4)

class B
  def m1
    4
  end

  def m3 x
    x.abs * 2 + self.m1
  end
end

# b = B.new
# puts b.m1
# puts b.m3(false)

# Creating and using an object
#
# - ClassName.new creates a new object whose class is ClassName
# - e.m evaluates e to an object and then calls its m method
# - - also known as "sends the m message"
# - - can also write e.m()
# - Methods can take arguments, called like e.m(e1,...,en)
# - - Parentheses optional in some places, but recommended


# VARIABLES
# /
# Methods can use local variables
# - Syntax: starts with letter
# - Scope is method body
# /
# No declaring them, just assign to them anywhere in method body (!)
# /
# Variables are mutable, x=e
# /
# Variables also allwed at "top-level" or in REPL
# /
# Contents of variables are always references to objects because all values are objects



# SELF
# /
# self is a special keyword/variable in Ruby
# /
# Refers to "the current object"
# - The object whose method is executing
# /
# So call another method on "same object" with self.m(...)
# - Syntactic sugar: can just write m(...)
# /
# Also can pass/return/store "the whole object" with just self
# /
# (Same as this in Java/C#/C++)

class C
  def m1
    print "hi "
    self
  end

  def m2
    print "bye"
    self
  end

  def m3
    print "\n"
    self
  end
end

c = C.new
c.m1.m2.m3