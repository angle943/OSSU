class A
  def initialize a
    @arr = a
  end
  def get i
    @arr[i]
  end
  def sum
    @arr.inject(0) {|acc,x| acc + x}
  end
end

class B < A
  def initialize a
    super
    @ans = false
  end
  def sum
    if !@ans
      @ans = @arr.inject(0) {|acc,x| acc + x}
    end
    @ans
  end
end