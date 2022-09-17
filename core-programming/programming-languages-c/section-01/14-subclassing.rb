# NEXT MAJOR TOPIC
#
# Subclasses, inheritance, and overriding
# - The essence of OOP
# - Not unlike you may have seen in Java/C#/C++/Python, but worth
#   studying from PL perspective and in a more dynamic language
#
# SUBCLASSING
#
# A class definition has a superclass (Object if not specified)
#
#   class ColorPoint < Point ...
#
# The superclass affects the class definition:
# - Class inherits all method definitions from superclass
# - But class can override method definitions as desired
#
# Unlike Java/C#/C++:
# - No such thing as "inheriting fields" since all objects create instance variables
#   by assigning to them
# - Subclassing has nothing to do with a (non-existent) type system: can still (try to)
#   call any method on any object

class Point
  attr_accessor :x, :y # defines methods x,y,x=,y=

  def initialize(x,y)
    @x = x
    @y = y
  end

  def distFromOrigin
    Math.sqrt(@x*@x + @y*@y) #uses instance variables
  end

  def distFromOrigin2
    Math.sqrt(x * x + y * y) # uses getter methods
  end
end

class ColorPoint < Point
  attr_accessor :color

  def initialize(x,y,c="clear")
    super(x,y) #keyword super calls same method in superclass
    @color = c
  end
end

p = Point.new(0,0)
cp = ColorPoint.new(0,0,"red")
cp.x
cp.color
# p.color
p.class
cp.class
cp.class.superclass.superclass

cp.is_a? Point #true
cp.instance_of? Point #false

# Using these methods is usually non-OOP style
# - Disallows other things that "act like a duck"
# - Nonetheless semantics is that an instance of ColorPoint "is a " Point
#   but is not an "instance of" Point
# - [ Java note: instanceof is like Ruby's is_a? ]