# MIXINS
#
# A mixin is (just) a collection of methods
# - Less than a class: no instances of it
#
# Languages with mixins (eg Ruby modules) typically lets a class have one superclass
# but include a number of mixins
#
# Semantics: including a mixin makes its method part of the class
# - Extending or overriding in the order mixins are included in the class definition
# - More powerful than helper methods because mixin methods can access methods (and instance variables)
#   on self not defined in the mixin

module Doubler
  def double
    self + self
  end
end

class Pt
  attr_accessor :x, :y
  include Doubler
  def + other
    ans = Pt.new
    ans.x = self.x + other.x
    ans.y = self.y + other.y
    ans
  end
end

class String
  include Doubler
end

# LOOKUP RULES
#
# Mixins change our lookup rules slightly:
#
# When looking for receiver obj's method m, look in obj's class,
# then mixins that class includes (later includes shadow), then obj's superclass, then the superclass'
# mixins, etc
#
# As for instance variables, the mixin methods are included in the same object
# - so usually bad style for mixin methods to use instance variables since a name
#   clas would be like our CowboyArtist pocket problem (but sometimes unavoidable?)


# THE TWO BIG ONES
#
# The most popular/useful mixins in Ruby:
#
# - Comparable: Defines <, >, ==, !=, >=, <= in terms of <=> (spaceship operator)
# - Enumerable: Defines many iterators (eg map, find) in terms of each
#
# Great examples of using mixins:
# - classes including them get a bunch of methods for just a little work
# - classes do not "spend" their "one superclass" for this
# - Do not need the complexity of multiple inheritance
#
# See the code for some examples
class Name
  attr_accessor :first, :middle, :last
  include Comparable

  def initialize(first,last,middle="")
    @first = first
    @last = last
    @middle = middle
  end

  def <=> other
    l = @last <=> other.last
    return l if l != 0
    f = @first <=> other.first
    return f if f != 0
    @middle <=> other.middle
  end
end

class MyRange
  include Enumerable
  def initialize(low,high)
    @low = low
    @high = high
  end
  def each
    i=@low
    while i <= @high
      yield i
      i=i+1
    end
  end
end


# REPLACEMENT FOR MULTIPLE INHERITANCE?
#
# A mixin works pretty well for ColorPt3D:
# - Color a reasonable mixin except for using an instance variable
#
# module Color
#   attr_accessor :color
# end
#
# A mixin works awkwardly-at-best for ArtistCowboy:
# - Natural for Artist and Cowboy to be Person subclasses
# - Could move methods of one to a mixin, but it is odd style and still does not get you two pockets
#
# module ArtistM...
# class Artist < Person
#   include ArtistM
#
# class ArtistCowboy < Cowboy
#   include ArtistM