(* 

LAST TOPIC OF SECTION

More careful look at what "two pieces of code are equivalent" means

- Fundamental software-engineering idea
- Made easier with
-- Abstraction (hiding things)
-- fewer side effects

Not about anyh "new ways to code something up"



EQUIVALENCE

Must reason about "are these equivalent" all the time
- the more precisely you think about it the better

- Code maintenance: Can i simplify this code?

- Backward compatibility: Can i add new features without changing how any old features work?

- Optimization: Can I make this code faster?

- Abstraction: Can an external client tell I made this change?

To focus discussion: when can we say two functions are equivalent, even without looking at all calls to them?
- may not know all the calls (eg we are editing a library)


A DEFINITION

Two functions are evquivalent if they have the same "observable behavior" no matter how they are used
anywhere in any program

Given equivalent arguments, they:
- Produce equivalent results
- have the same (non-)termination behavior
- mutate (non-local) memory in the same way
- do the same input/output
- raise the same exceptions

Notice it is much easier to be equivlanet if:
- There are fewer possible args, eg with a type system and abstraction
- we avoid side-effects: mutation, input/output, and exceptions


EXAMPLE

Since looking up variables in ML has no side effects, these two functions are equivalent:

fun f x = x + x

val y = 2
fun f x = y * 2

But these next two are not equivalent in general: it depends on what is passed for f
- are equivalent if argument for f has no side-effects

fun g (f,x) = (f x) + (f x)

val y = 2
fun g (f,x) = y * (f x)


- Example: g (fn i => (print "hi" ; i), 7)
- Great reason for "pure functional programming"


ANOTHER EXAMPLE

These are equivalent only if functions bound to g and h do not
raise exceptions or have side effects (printing, updating state, etc)
- Again: pure functions make more things equivalent


fun f x =
    let
        val y = g x
        val z = h x
    in
        (y,z)
    end


fun f x =
    let
        val z = h x
        val y = g x
    in
        (y,z)
    end

- Example: g divides by 0 and h mutates a top-level reference
- Example: g writes to a reference that h reads from

 *)