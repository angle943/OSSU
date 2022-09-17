# THE OOP TRADE-OFF
#
# Any method that makes calls to overridable methods can have its behavior changed
# in subclasses even if it is not overridden
# - Maybe on purpose, maybe by mistake
# - Observable behavior includes calls-to-verridable methods
#
# So harder to reason about "the code you're looking at"
# - can avoid by disallowing overriding
# - - "private" or "final" methods
#
# So easier for subclasses to affect behavior without copying code
# - Provided method in superclass is not modified later.