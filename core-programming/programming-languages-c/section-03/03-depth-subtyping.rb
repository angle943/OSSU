# MORE RECORD SUBTYPING?
#
# Warning: I am misleading you
#
# Subtyping rules so far let us drop fields but not change their types
#
# Example: a circle has a center field holding another record:
#
# For this to type-check, we need:
#
# {center; {x:real, y:real, z:real}, r:real} <: {center:{x:real,y:real},r:real}
#
# No way to get this yet: we can drop center, drop r, or permute order, but cannot "reach into a field type" to do subtyping
#
# So why not add another subtyping rule... "Depth" subtyping:
#
# If ta <: tb, then {f1:t1,....,f:ta,...,fn:tn} <: {f1:t1,...,f:tb,...,fn:tn}
#
# Dept subtyping (along with width on the field's type) lets our example type-check


# STOP
#
# It is nice and all that our new subtyping rule lets our example type-check
#
# But it is not worth it if it breaks soundness
# - also allows programs that can access missing record fields
#
# Unfortunately, it breaks soundness
#
#
# MUTATION STRIKES AGAIN
#
# fun setToOrigin (c: {center: {x:real,y:real},r:real}) =
#   c.center = {x-0.0,y=0.0}
#
# val sphere:{center: {x:real,y:real,z:real},r:real} =
#   {center={x=3.0,y=4.0,z=0.0},r=1.0}
#
# val _ = setToOrigin(sphere)
# val _ = sphere.center.z (* kaboom! (no z field) *)


# MORAL OF THE STORY
#
# - in a language with records/objects with getters and SETTERS, depth subtyping is unsound
#   - subtyping cannot change the type of fields
#
# If fields are immutable, then depth subtyping is sound!
# - yet another benefit of outawing mutation!
# - Choose two of three: setters, depth subtyping, soundness
#
# Remember: subtyping is not a matter of opinion