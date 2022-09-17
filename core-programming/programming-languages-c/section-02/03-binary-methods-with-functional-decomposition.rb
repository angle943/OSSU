# BINARY OPERATIONS
#
# Situation is more complicated if an operation is defined over multiple arguments that can have
# different variants
# - Can arise in original program or after extension
#
# Function decomposition deals with this much more simply...
#
# EXAMPLE
#
# To show the issue:
# - Include variants String and Rational
# - (Re)define Add to work on any pair of Int, String, Rational
#   - concatenation if either argument a String, else math
#
# Now just defining the addition operation is a different 2D grid