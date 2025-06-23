---
title: Why every partial computable function has an injective equivalent
categories: Science
---

The padding lemma states two things:

- That any partial computable function $\varphi_x$ has infinitely many indices.
- That for any $x$ we can computably find an infinite set $A_x$ of indices for
the same partial function $\varphi_x$.

This result does not seem particularly interesting. Take any program and add a
$\textbf{skip}$ instruction somewhere. That's a different program that computes
the same function as the original one. Repeat the process: new program, same
function. Etc.

Notwithstanding, the padding lemma has many interesting applications. In
particular, it is relevant to the *Injective Extension Theorem* (I call it this
way, most books boringly call it theorem number $x$ or $y$). The theorem ensures
that for any partial computable function $f$ there is an injective, partial
computable function $g$ that computes the same as $f$. More formally:

> For any $\varphi_x$, there is an injective, partial computable function $g$
> such that $\varphi_x = \varphi_{g(x)}$.

The proof is actually straightforward via Church's thesis. Take program $x$ and
add to it a superfluous instruction that depends on $x$ (e.g. adding $x$ times a
$\textbf{skip}$ instruction at the end). Then run $x$. Clearly, said procedure
is injective: for any input program $x$, a unique program is produced that is
syntactically but not semantically different from $x$. 
(This semantic equivalence is formally explained by the fact that $A_x$ is
semantically closed, and the procedure maps $x$ to a different program in
$A_x$).

Let us give a more formal intuition of the problem. Let $p(x, y)$ denote a
(computable) function that, given $x$, produces a padded
version of $x$—in a manner that depends on $x$—and subsequently runs the
resulting program on input $y$. By construction, $p(x, y)$ is semantically
equivalent to executing the program encoded by $x$ on input $y$; that is, it
preserves the computational behavior of $x$.

Since $p$ is computable, there exists an index $e$ such that the partial
computable function $\varphi_e(x, y)$ corresponds to the behavior of $p(x, y)$.
By the $S^m_n$ theorem, there exists a total computable function $s(e, x)$,
which is injective in $x$, such that

$$
\varphi_{s(e, x)}(y) = \varphi_e(x, y)
$$

Fixing $g(x) = s(e, x)$, we obtain an injective computable function $g$ such
that $\varphi_{g(x)}(y) = \varphi_x(y)$ for all $y$. In other words, $g(x)$
encodes a program that is semantically equivalent to the one encoded by $x$,
while also being injective in $x$. 

---

The fact that each computable function has an injective equivalent is in fact
part of a more general result. I will only briefly comment it.

> Suppose that $\psi_0, \psi_1, \ldots$ is any sequence of partial computable
> functions, and $g$ is a computable function such that $\varphi_x = \psi_{g(x)}$.
> Then there is an injective computable function $g'(x)$ such that 
$\varphi_x = \psi_{g'(x)}$. 

Informally, this theorem ensures that no matter what sequencing of partial
computable functions we have, there is always a computable injection which
allows us to deal with these functions in terms of the canonical sequence
$\varphi_1, \varphi_2, \ldots$. 

The *injective extension theorem* can be viewed as nothing but an application of
this last result when the sequence in question is in fact the canonical
sequence. In other words, take $\varphi_1, \varphi_2, \ldots$ and see that if
$g(x) = Id$ then $\varphi_x = \varphi_{g(x)}$. Therefore, there necessarily
exists some injective $g'$ s.t. $\varphi_x = \varphi_{g'(x)}$.

