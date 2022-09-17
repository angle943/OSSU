# WHATS NEXT?
#
# Have used classes for OOP's essence: inheritance, overriding, dynamic dispatch
#
# Now, what if we want to have more than just 1 superclass
#
# Multiple inheritance: allow > 1 superclasses
# - Useful but has some problems (see C++)
#
# Ruby-style mixins: 1 superclass; > 1 method providers
# - Often a fine substitute for multiple inheritance and has fewer problems (see also Scala traits)
#
# Java/C#-style interfaces: allow > 1 types
# - mostly irrelevant in a dynamically typed language, but fewer problems


# MULTIPLE INHERITANCE
#
# If inheritance and overriding are so useful, why limit ourselves to one superclass?
# - Because the semantics is often awkward (this topic)
# - Because it makes static type-checking harder (not discussed)
# - Because it makes efficient implementation harder (not discussed)
#
# Is it useful? Sure!
# - Example: Make a ColorPt3D by inheriting from Pt3D and ColorPt (or maybe from Color)
# - Ex: Make a StudentAthlete by inheriting from Student and Athlete
# - With single inheritance, end up copying code or using non-OOP-style helper methods


# TREES, DAGS, AND DIAMONDS
#
# Note: The phrases subclass, superclass can be ambiguous
# - There are immediate subclasses, superclasses
# - And there are transitive subclasses, superclasses
#
# Single inheritance: the class hierarchy is a tree
# - Nodes are classes
# - Parent is immediate superclass
# - Any number of children allowed
#
# Multiple inheritance: the class Hierarchy is no longer a tree
# - Cycles still disallowed (a directed-acyclic graph)
# - If multiple paths show that X is a (transitive) superclass of Y, then we have diamonds


# WHAT COULD GO WRONG?
#
# If V and Z both define a method m, what does Y inherit? What does super mean?
# - Directed resends useful (eg Z::super)
#
# What if X defines a method m that Z but not V overrides?
# - Can handle like previous case, but sometimes undesirable (eg ColorPt3D wants Pt3D's overrides to "win")
#
# If X defines fields, should Y have one copy of them (f) or two (V::f and Z::f)?
# - turns out each behavior can be desirable (next slides)
# - So C++ has (at least) two forms of inheritance