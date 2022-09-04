Let A(x) be some property of x.

Show that:

`````
¬(∀x A(x)) is equivalent to ∃x[¬A(x)]
`````

Left to Right:

Suppose Left is true. Then it is not true that for all x, A(x) is true.
Then A(x) is false for at least one x. So there exists an x such
that A(x) is false, which is the Right.

Right to left:

Suppose Right is true. Then there exists at least one x such that
A(x) is false. Then A(x) is not true for all x, which is the left.



Show that:

```
¬(∃x A(x)) is equivalent to ∀x[¬A(x)]
```

Left to Right:

Suppose Left is true. Then it is not true that there exists an x such that
A(x) is true. That means that A(x) is false for all x, which is Right.

Right to Left:

Suppose R is true. Then for all x, A(x) is false. Then there does not 
exist an x such that A(x) is true, which is the Left.


```
∀x[A(x) ∨ B(x)] is not equivalent to ∀xA(x) ∨ ∀xB(x)
```

```
∀x[A(x) ∧ B(x)] is equivalent to ∀xA(x) ∧ ∀xB(x)
```

```
∃x[A(x) ∧ B(x)] is not equivalent to ∃xA(x) ∧ ∃xB(x)
```

```
∃x[A(x) ∨ B(x)] is equivalent to ∃xA(x) ∨ ∃xB(x)
```

```
∀ is "like" ∧
∃ is "like" ∨
```
