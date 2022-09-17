class Point
  attr_accessor :x, :y

  def initialize(x,y)
    @x = x
    @y = y
  end

  def distFromOrigin
    Math.sqrt(@x * @x + @y * @y)
  end
  def distFromOrigin2
    Math.sqrt(x * x + y * y)
  end
end

class ThreeDPoint < Point
  attr_accessor :z

  def initialize(x, y,z)
    super(x,y)
    @z = z
  end

  def distFromOrigin
    d = super
    Math.sqrt(d*d + @z * z)
  end

  def distFromOrigin2
    d = super
    Math.sqrt(d*d + z*z)
  end
end

# SO FAR...
#
# With examples so far, objects are not so different from closures
# - Multiple methods rather than just "call me"
# - Explicit instance variables rather than environment where function is defined
# - Inheritance avoids helper functions or code copying
# - "Simple" overriding just replaces methods
#
# But there is one big difference:
#
# Overriding can make a method define in the superclass call a method in the subclass
#
# - The essential difference of OOP, studied carefully next lecture

class PolarPoint < Point
  # by not calling super constructor, no x and y instance vars
  # In Java/C#/Smalltalk, would just have unused x,y fields
  def initialize(r,theta)
    @r = r
    @theta = theta
  end
  def x
    @r * Math.cos(@theta)
  end
  def y
    @r * Math.sin(@theta)
  end
  def x= a
    b = y # avoidds multiple calls to y method
    @theta = Math.atan(b / a)
    @r = Math.sqrt(a*a + b*b)
    self
  end
  def y= b
    a = x # avoid multiple calls to x method
    @theta = Math.atan(b / a)
    @r = Math.sqrt(a*a + b*b)
    self
  end
  def distFromOrigin # must override
    @r
  end
  # inherited distFromOrigin2 already works!!
end

# EXAMPLE: Equivalent except constructor
#
# - Also need to define x= and y= (see cod efile)
# - Key punchline: distFromOrigin2 defined in Point, "already works"
# - Why: calls to self are resolved in terms of the object's class