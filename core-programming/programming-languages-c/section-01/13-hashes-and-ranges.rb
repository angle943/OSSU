# MORE COLLECTIONS
#
# Hashes like arrays but:
# - Keys can be anything; strings and symbols common
# - No natural ordering like numeric indices
# - Different syntax to make them
# Like a dynamic record with anything for field names
# - often pass a hash rather than many arguments
#
# Ranges like arrays of contiguous numbers but:
# - More efficiently represented, so large ranges fine
#
# Good style to:
# - use ranges when you can
# - use hashes when non-numeric keys better represent data

h1 = {} # Hash.new
h1["a"] = "Found A"
h1[false] = "Found false"
print h1.keys
print h1.values

h2 = {"SML" =>1, "Racket"=>2, "Ruby"=>3}
print h2.size

h2.each {|k,v| print k; print ": "; puts v}

print (1..100).inject {|acc,elt| acc + elt}

# SIMILAR METHODS
#
# Arrays, hashes, and ranges all have some methods other don't
# - EG keys and values
#
# But also have many of the same methods, particularly iterators
# - Great for duck typing
# - Example:
# def foo a
#   a.count {|x| x*x < 50}
# end
# foo [3,5,7,9]
# foo (3..9)
# Once again separating "how to iterate" from "what to do"