class A
  attr_accessor :x
  def m1
    @x = 4
  end
  def m2
    m1
    @x > 4
  end
  def m3
    @x = 4
    @x > 4
  end
  def m4
    self.x = 4
    @x > 4
  end
end

class B < A
  def initialize
    @x = 100
  end

  def m1
    @x = 500
  end

  def x= a
    @a = a
  end
end

puts B.new.m4