
# MORE STRANGENESS
#
# Callee does not give a name to the (potential) block argument
#
# Instead, just calls it with yield or yield (args)
# - Silly Example:
# def silly a
#   (yield a) + (yield 42)
# end
#
# x.silly(5){ |b| b*2}
#
# - See code for slightly less silly example
#
# Can ask block_given? but often just assume a block is given or that a block's presence is implied by other arguments

class Foo
  def initialize(max)
    @max = max
  end

  def silly
    yield(4,5) + yield(@max,@max)
  end

  def count base
    if base > @max
      raise "reached max"
    elsif yield base
      1
    else
      1 + (count(base+1) {|i| yield i})
    end
  end
end

f = Foo.new(1000)
puts f.silly {|a,b| 2*a - b} # 2*4 - 5 + 2*1000 - 1000
puts f.count(10) { |i| (i*i) == (34*i) }