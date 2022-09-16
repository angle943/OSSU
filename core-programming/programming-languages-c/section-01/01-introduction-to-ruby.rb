

# RUBY: OUR FOCUS
#
# - Pure object-oriented: all values are objects (even numbers)
# - Class-based: Every object has a class that determines behavior
# - - like java, unlike Javascript
# - - mixins (neither Java interfaces nor C++ multiple inheritances)
# - Dynamically typed
# - Convenient reflection: Run-time inspection of objects
# - Very dynamic: can change classes during execution
# - Blocks and libraries encourage lots of closure idioms
# - Syntax, scoping rules, semantics of a "scripting language"
# - - Variables "sprint to life" on use
# - - Very flexible arrays


# RUBY: NOT OUR FOCUS
# -
# - Lots of support for string manipulation and regular expressions
# - Popular for server-side web applications:
# - - Ruby on Rails
# - Often many ways to do the same thing
# - - More of a "why not add that too?" approach


# WHERE RUBY FITS
# /
# /
#                dynamically typed         statically typed
# Functional         Racket                      SML
# OOP                Ruby                      Java, etc
# /
# /
# Note: Racket also has classes and objects when you want them
# - In Ruby everything uses them (at least implicitly)
# /
# Historical Note: Smalltalk also a dynamically typed, class-based, pure OOP language with blocks and convenient
# reflection
# - Smaller just-as-powerful language
# - Ruby less simple, more "modern and useful"
# /
# Dynamically typed OOP helps identify OOP's essence by not having to discuss types


# A NOTE ON THE HOMEWORK
# Next homework is about understanding and extending
# an existing program in an unfamiliar language
# /
# - good practice
# - Quite different feel than previous homeworks
# - Read code: determine what you do and do not (!) need to understand
# Home requires the Tk graphics library to be installed such that the provided Ruby code can use it

class Hello

  def my_first_method
    puts "hello, World!"
  end

end

x = Hello.new
x.my_first_method