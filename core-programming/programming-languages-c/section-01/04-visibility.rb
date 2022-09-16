
# WHO CAN ACCESS WHAT
# /
# We know "hiding things" is essential for modularity and abstraction
# /
# OOP languages generally have various ways to hide (or not)
# instance variables, methods, classes, etc
# - Ruby is no exception
# /
# Some basic Ruby rules here as an example...

# OBJECT STATE IS PRIVATE
# /
# In Ruby, object state is alway sprivate
# - Only an object's methods can access its instance variables
# - Not even another instance of the same class
# - So can write @foo, but not e.@foo
# /
# To make object-state publicly visible, define "getters" / "setters"
# - Better/shorter style coming next
#
# def get_foo
#   @foo
# end
# def set_foo x
#   @foo = x
# end

# CONVENTIONS AND SUGAR
# /
# Actually, for field @foo the convention is to name the methods:
#
# def foo
#   @foo
# end
# def foo= x
#   @foo = x
# end
# /
# Cute sugar: when using a method ending in =, can have space before the =
#   e.foo = 42
# /
# Because defining getters/setters is so common, there is a
# shorthand for it in class definitions
# - Define just getters: attr_reader :foo, :bar, ...
# - Define getters and setters: attr_accessor : foo, :bar, ...
# /
# Despite sugar: getters/setters are just methods


# WHY PRIVATE OBJECT STATE
# /
# This is "more OOP" than public instance variables
# /
# Can later change class implementation without changing clients
# - Like we did with ML modules that hid representation
# - And like we will soon do with subclasses
# /
# Can have methods that "seem like" setters even if they are not
#
# def celsius_temp= x
#   @kelvin_temp = x + 273.15
# end
#
# Can have an unrelated class that implements the same methods and use it with same clients
# - See later discussion of "duck typing"


# METHOD VISIBILITY
#
# Three visibilities for methods in Ruby:
# - private: only available to object itself
# - protected: available only to code in the class or subclasses
# - public: available to all code
#
# Methods are public by default
# - Multiple ways to change a method's visibility
# - here is one way...

class Foo
  # by default methods public
  # ...

  protected
#   now methods will be protected until next visibility keyword

  public
#  ...
  private
#  ...
end


# ONE DETAIL
#
# If m is private, then you can only call it via m or m(args)
# - as usual, this is shorthand for self.m ...
# - but for private methods, only the shorthand is allowed