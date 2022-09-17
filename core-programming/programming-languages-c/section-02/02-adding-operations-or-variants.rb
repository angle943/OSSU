# EXTENSIBILITY
#
# For implementing our grid so far, SML / Racket style usually by column and Ruby Java style usually by row
#
# But beyond just style, this decision affects (what (unexpected?) software extensions need not change old code
#
# Functions [see ML code]:
#   - Easy to add a new operation, eg noNegConstants
#   - adding a new variant, eg Mult requires modifying old functions, but ML type-checker gives
#    a to-do list if original code avoided wildcard patterns
#
# Objects [see Ruby Code]:
#   - easy to add a new variant, eg Mult
#   - adding a new operation, eg noNegConstants requires modifying old classes, but [optional:]
#     Java type-checker gives a to-do list if original code avoided default methods
#
# THE OTHER WAY IS POSSIBLE
#
# Functions allow new operations and objects allow new variants without modifying
# existing code even if they didn't plan for it
# - Natural result of the decomposition
#
# Optional:
# - Functions can support new variants and somewhat awkwardly "if they plan ahead"
#   - not explain here: can use type constructors to make datatypes extensible
#     and have operations take function arguments to give results for the extensions
#
# - Objects can support new operations somewhat awkwardly "if they plan ahead"
#   - not explained here: the popular visitor pattern uses the double-dispatch pattern to allow
#     new operations "on the side"


# THOUGHTS ON EXTENSIBILITY
#
# Making software extensible is valuable and hard
# - If you know you want new operations, use FP
# - if you know you want new variants, use OOP
# - if both? Languages like Scala try; its a hard problem
# - Reality: the future is often hard to predict!
#
# Extensibility is a double-edged sword
# - code more reusable without being changed later
# - but makes original code more difficult to reason about locally or change later (could break extensions)
# - Often language mechanisms to make code less extensible (ML modules hide datatypes;
#   Java's final prevents subclassing/overriding)