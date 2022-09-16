
# NOW
#
# Put together much of what we have learned to define and use a small
# class for rational numbers
# - Called MyRational because Ruby 1.9 has great built-in support for fractions
#   using a class Rational
#
# Will also use several new and useful expression forms
# - Ruby is too big to show everything; see the documentation
#
# Way our class works: Kepps fractions in reduced form with a positive denominator
# - Like an ML-module example earlier in course

class MyRational

  def initialize(num,den=1)
    if den == 0
      raise "MyRational received an inappropriate argument"
    elsif den < 0
      @num = - num
      @den = - den
    else
      @num = num
      @den = den
    end
    reduce # i.e. self.reduce() but private
  end

  def to_s
    ans = @num.to_s
    if @den != 1
      ans += "/"
      ans += @den.to_s
    end
    ans
  end

  def to_s2
    dens = ""
    dens = "/" + @den.to_s if @den != 1
    @num.to_s + dens
  end

  def to_s3
    "#{@num}#{if @den==1 then "" else "/" + @den.to_s end}"
  end

  def add! r # bang signifies it will mutate self in-place (convention)
    a = r.num # Only works b/c of protected methods below
    b = r.den # Only works b/c of protected methods below
    c = @num
    d = @den
    @num = (a * d) + (b * c)
    @den = b * d
    reduce
    self
  end

#  A functional additiona, so we can write r1.+ r2 to make a new rational
# and built-in syntactic sugar will work: can write r1 + r2
  def + r
    ans = MyRational.new(@num,@den)
    ans.add! r
    ans
  end

  protected
#  There is a very common sugar for this (attr_reader)
# The better way:
# attr_reader :num, :den
# protected :num, :den
# we do not want these methods public,
# but we cannot make them private becuse of the add! method above
  def num
    @num
  end
  def den
    @den
  end

  private
  def gcd(x,y)
    if x == y
      x
    elsif x < y
      gcd(x,y-x)
    else
      gcd(y,x)
    end
  end

  def reduce
    if @num == 0
      @den = 1
    else
      d = gcd(@num.abs, @den)
      @num = @num / d
      @den = @den / d
    end
  end
end

# top -level method (just part of Object class) for testing
def use_rationals
  r1 = MyRational.new(3,4)
  r2 = r1 + r1 + MyRational.new(-5,2)
  puts r2.to_s
  (r2.add! r1).add! (MyRational.new(1,-4))
  puts r2.to_s
  puts r2.to_s2
  puts r2.to_s3
end

use_rationals