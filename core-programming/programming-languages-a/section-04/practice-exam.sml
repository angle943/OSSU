fun null2 xs = ((fn z => false) (hd xs)) handle List.Empty => true

fun null3 xs = xs = []

val result = null3 []
val result2 = null3 [SOME 2]