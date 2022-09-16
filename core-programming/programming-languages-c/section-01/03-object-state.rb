
# /

# OBJECTS HAVE STATE
# /
# An object's state persists
# - Can grow and change from time object is created
# /
# State only accessible from object's methods
# - can read, write, extend the state
# - Effects persist for next method call
# /
# State consists of instance variables (also known as fields)
# - Syntax: start with an @, eg @foo
# - "Spring into being" with assignment
# - - So misspellings silently add new state (!)
# - Using one not in state not an error: produces nil object


# ALIASING
# /
# Creating an object returns a reference to a new object
# - Different state from every other object
# /
# Variable assignment (eg x=y) creates an alias
# - Aliasing means same object means same state

class A
  def initialize(f=0)
    @foo = f
  end

  def m1
    @foo = 0
  end

  def m2 x
    @foo += x
    @bar = 0
  end

  def foo
    @foo
  end
end

# x = A.new
# y = A.new
# z = x
# x.m1
# print z.foo
# print y.foo
# z.m2 17
# x.m2 14
# print z.foo


# INITIALIZATION
# /
# A method named initialize is special
# - ica called on a new object before new returns
# arguments to new are passed on to initialize
# excellent for creating object invariants
# (like constructors in Java/C#/etc)
# /
# Usually good style to create instance variables in initialize
# - Just a convention
# - Unlike OOP languages that make "what fields an object has" a (fixed) part of the class definition
# - - In ruby, different instances of same class can have different instance variables


# CLASS VARIABLES
# /
# There is also state shared by the entire class
# /
# Shared by (and only accessible to) all instances of the class
# /
# Called class variables
# - Syntax: starts with an @@, eg @@foo
# /
# Less common, but sometimes useful
# - An helps explain via contrast that each object has its own instance variables

# CLASS CONSTANTS AND METHODS
# /
# Class constants
# - Syntax: start with capital letter, eg Foo
# - Should not be mutated
# - Visible outside class C as C::Foo (unlike class variables)
# /
# Class methods (cf Java/C# static methods)
# - Syntax (in some class C):
#     def self.method_name (args)
#       ...
#     end
# - Use (of class method in class C):
#     C.method_name(args)
# - Part of the class, not a particular instance of it

class C

  Dans_Age = 38

  def self.reset_bar
    @@bar = 0
  end

  def initialize(f=0)
    @foo = f
  end

  def m2 x
    @foo += x
    @@bar += 1
  end

  def foo
    @foo
  end

  def bar
    @@bar
  end
end

c1 = C.new
c2 = C.new
C.reset_bar
c1.m2 7
c2.m2 9
print c2.bar
print c1.foo
print c2.foo