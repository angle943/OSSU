(* 

MODULES

For larger programs, one "top-level" sequence of bindings is poor
- Especially because a binding can use all earlier (non-shadowed) bindings

So ML has structures to define modules

structure MyModule = struct bindings end

Inside a module, can use earlier bindings as usual
- Can have any kind of bindings (val, datatype, exception,...)

Outside a module, refer to earlier modules' bindings via
ModuleName.bindingName
- Just like List.foldl and String.toUpper; now you can define your own modules

 *)

structure MyMathLib = 
struct

fun fact x = if x=0 then 1 else x * fact (x - 1)

val half_pi = Math.pi / 2.0

 fun doubler y = y + y

 end

 val pi = MyMathLib.half_pi + MyMathLib.half_pi

 val twenty_eight = MyMathLib.doubler 14

 (* 
 
 NAMESPACE MANAGEMENT

 So far, this is just namespace management
 - giving hierarchy to names to avoid shadowing
 - allows different modules to reuse names, eg map
 - very important, but not very interesting


OPTIONAL: OPEN

Can use open ModuleName to get "direct" access to a module's bindings
- Never necessary; just a convenience; often bad style
- OFten better to create local val-bindings for just the bindings you use a lot, eg val map = List.map
-- but it doesn't work for patterns
-- and open can be useful, et for testing code
 
  *)