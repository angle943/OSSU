# NOW FUNCTIONS
#
# Already know a caller can use subtyping for arguments passed
# - Or on the result
#
# More interesting: When is one function type a subtype of another?
#
# - Important for higher-order functions: if a function expects an argument of type t1 -> t2, can
#   you pass a t3 -> t4 instead?
#
# - Coming next: important for understanding methods
#   - an object type is a lot like a record type where "method positions" are immutable and have function types
#
# Nothing goes wrong: If ta <: tb, then t -> ta <: t -> tb
# - a function can return "more than it needs to"
# - Jargon: "Return types are covariant"
#
# If tb <: ta, then ta -> t <: tb -> t
# - A function can assume "less than it needs to " about arguments
# - Jargon: "Argument types are contravariant"
#
#
# CONCLUSION
#
# If t3 <: t1 and t2 <: t4, then t1 -> t2 <: t3 -> t4
# - Function subtyping contravariant in argument(s) and covariant in results
#
# Also essential for understanding subtyping and methods in OOP
#
# The most unintuitive concept in this course
# - smart people often forget and convince themselves that covariant arguments are okay
# - these smart people are always mistaken
# - at times, you or your boss or your friend may do this
# - remember: a guy with a PhD in PL jumped out and down insisting that function/method subtyping is always
#   contravariant in its argument -- covariant is unsound