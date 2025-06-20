---
title: A brief note on unsolvable problems
categories: [Science, Philosophy]
---

The warped spirit of theoretically-minded computer scientists inclines them to
rejoice in evil notions such as programs running with their own source code as
input. It is obvious to any sane, kind-hearted individual that this is the kind
of question which Christ did not want us to ask. (Another example: which is the
function whose derivative is itself? And here comes number $e$!)

> As a note, the execution of a program with its own source code as input is
> behind the construction of another, even more perverse question: can one build
> a program that takes no input and outputs its own source code? I wrote
> extensively about these programs, termed [ *quines*
> ](https://slopezpereyra.github.io/2025-06-11-Quines/), whose relationship with
> programs executed with its own source code as input is given by Kleene's
> recursion theorem.

It turns out that executing a program with its own source code as input is at
the heart of a famous undecidable problem. Take 

$$
K := \\{ x : \varphi_x(x) \text{ converges} \\} = \\{ x : x \in W_x\\}
$$

The set $K$ is computably enumerable, since it is the domain of $\varphi(x)$ the
universal function. Alternatively, $K$ is the domain of

$$
\psi(x) = \begin{cases} x & \varphi_x(x) \text{ converges} \\\\ \bot &
\text{otherwise} \end{cases}
$$

which is clearly computable: simply run the $x$th program and return $x$ when
(and if) it converges.

It is nice to have $K$ computably enumerable, but is it decidable? Informally,
can we computably determine whether a program halts when executed with itself as
input? Formally, does $K$ have a computable characteristic function $\chi_K$?

Well, if $K$ had a computable characteristic function $\chi_K$, then 

$$
f(x) = \begin{cases} \varphi_x(x) + 1 & x \in K \\\\ 0 &
\text{otherwise} \end{cases}
$$

would be computable. This would entail $f = \varphi_k$ for some (and in fact
infinitely many) $k \in \mathbb{N}$. But then $f(k) = \varphi_k(k)$, which
entails $\varphi_k(k) + 1 = \varphi_k(k)$ which is absurd. $\therefore $ $K$ is
not computable.

This problem relates to a more general undecidable problem. Consider the set of
tuples $(x, y)$ such that $y$ halts on input $x$. In other words, consider 

$$
K_0 = \\{ (x, y) : x \in W_y\\}
$$

Again, the set is computably enumerable because the universal function
$\varphi(y, x)$  is computable. However, note that $x \in K$ if and only if $(x,
x) \in K_0$. So if $K_0$ had a characteristic function, so would $K$, which
contradicts our previous result.

$\therefore$ The halting problem (the problem of computably deciding whether an
arbitrary program halts on arbitrary input) is undecidable.

Informally, we have shown something rather obvious: the problem of deciding
whether an arbitrary program halts on some arbitrary input requires being able
to solve the problem of deciding whether a program halts with itself as input.
It is easy to comprehend that the first is a sub-problem of the latter. This is
formally termed *many-one reduction*, where we would say the set $K$ is
*many-one reducible* to the set $K_0$, or $K \leq_m K_0$.

> We say $A$ is many-one reducable to $B$ iff there is a computable function $f$
> s.t. $x \in A$ iff $f(x) \in B$. Alternatively, $f(A) \subseteq B$
> and $f(\overline{A}) \subseteq \overline{B}$. We write $A \leq_m B$. 
> We say $A$ is one-reducible if $f$ is $1:1$.

This relationship is a transitive relation which induces a partial ordering of
interesting sets, where one can prove that a given set is undecidable by showing
that a preceeding set is undecidable. For instance, consider the set 

$$
\mathcal{T} = \\{ x : \varphi_x \text{ is total} \\}
$$

To decide if a function is total, one must decide whether it converges on
arbitrary input. In particular, one must decide whether it converges with itself
as input, which leads us back to our original problem. In particular, it is
intuitively clear that $K \leq_m \mathcal{T}$. To provide a formal proof of
this, we may simply define 

$$
\psi(x, y) = \begin{cases} 1 & x \in K \\\\ \bot &\text{otherwise} \end{cases}
$$

The function reads: if $\varphi_x(x)$ converges, then for any $y$ simply output
$1$. It is clearly computable. The $S_n^m$ theorem guarantees that there is a
one-to-one computable function $f$ s.t. $\varphi_{f(x)}(y) = \psi(x, y)$.

Clearly, if $x \in K$ then $\varphi_{f(x)}(y) = 1$ for all $y$ and hence the
function is total, i.e. $\varphi_{f(x)}(y) \in \mathcal{T}$. Conversely, if $x
\notin K$ we have $\varphi_{f(x)}(y) = \bot \notin \mathcal{T}$. This suffices
to show $K \leq_1 \mathcal{T}$.

Therefore, the undecidability of $K$ entails the undecidability of
$\mathcal{T}$. The set of *total* computable functions is not decidable.



































































