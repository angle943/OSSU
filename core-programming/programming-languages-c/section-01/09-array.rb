
# RUBY ARRAYS
#
# Lots of special syntax and many provided methods for the Array class
#
# Can hold any number of other objects, indexed by number
# - Get via a[i]
# - Set via a[i] = e
#
# Compared to arrays in many other languages
# - more flexible and dynamic
# - Fewer operations are errors
# - Less efficient
#
# The standard collection (like lists were in ML and Racket)

a = [2,3,7,9]
puts a[2]
puts a[0]
puts a[4]
puts a.size
puts a[-1]
puts a[-5]
a[1] = 6
puts a
a[6] = 14
puts a
puts a.size
a[3] = "hi"
puts a

b = a + [true,false]
puts b

c = [3,2,3] | [1,2,3]

triple = [false, "hi", a[0] + 4]

x = if a[1] < a[0] then 10 else 20 end

y = Array.new(x)

z = Array.new(x) { 0 }

a.push 5
a.push 7
a.pop
a.pop
a.push 11
a.shift
a.unshift 19

f = [2,4,6,8,10,12,14]

f[2,4]
f[2,4] = [1,1]

[1,3,4,12].each {|i| puts (i*i)}