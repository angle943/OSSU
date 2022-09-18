# PICKING ON JAVA AND C#
#
# Arrays should work just like records in terms of depth subtyping
# - But in Java, if t1 <: t2, then t1[] <: t2[]
#
# WHY DID THEY DO THIS?
#
# More flexible type system allows more programs but prevents fewer errors
#   - seemed especially important before Java/C# had generics
#
# Good news: despite this "inappropriate" depth subtyping
# - e.color will never fail due to there being no color field
# - Array reads e1[e2] always return a (subtype of) t if e1 is a t[]
#
# Bad news; to get the good news
# - e1[e2]=e3 can fail even if e1 has type t[] and e3 has type t
# - array stores check the run-time class of e1's elements and do not allow storing a supertype
# - no type-system help to avoid such bugs / performance cost


# NULL
#
# Array stores probably the most suprising choice for flexibility over static checking
#
# But null is the most common one in practice:
# - null is not an object; it has no fields or methods
# - But Java and C# let it have any object type (backwards, huh?!)
# - So, in fact, we do not have the static guarantee that evaluating e in e.f or e.m(...)
#   produces an object that has an f or m
# - The "or null" caveat leads to run-time checks and errors, as you have surely noticed
#
# Sometimes null is convenient (like ML's option types)
# - But also having "cannot be null" types would be nice