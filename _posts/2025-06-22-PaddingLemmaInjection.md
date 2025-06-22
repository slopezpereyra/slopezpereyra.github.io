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

Notwithstanding, the padding lemma has many interesting applicatoins. In
particular, it can be used to prove the *Injective Extension Theorem* (I call it
this way, most books boringly call it theorem number $x$ or $y$). The theorem
ensures that for any partial computable function $f$ there is an injective,
partial computable function $g$ that computes the same as $f$. More formally:

> For any $\varphi_x$, there is an injective, partial computable function $g$
> such that $\varphi_x = \varphi_{g(x)}$.

The proof is actually straightforward via Church thesis. Take program $x$ and
add to it a superfluous instruction that depends on $x$ (e.g. adding $x$ times a
$\textbf{skip}$ instruction at the end). Clearly, said procedure is injective:
for any input program $x$, a unique program is produced that is syntactically
but not semantically different from $x$.

Let $p(x, y)$ denote a (computable) program that, given a code $x$ of a
program, produces a padded version of $ x $—in a manner that depends on $x$—and subsequently runs the resulting program on input $y$. By
construction, $p(x, y)$ is semantically equivalent to executing the program
encoded by $x$ on input $y$; that is, it preserves the computational behavior of
$x$.

Since $p$ is computable, there exists an index $e \in \mathbb{N}$ such
that the partial computable function $\varphi_e(x, y)$ corresponds to the
behavior of $p(x, y)$. By the $S^m_n$ theorem, there exists a total
computable function $s(e, x)$, which is injective in $x$, such that

$$
\varphi_{s(e, x)}(y) = \varphi_e(x, y)
$$

for all $x, y \in \mathbb{N}$. Fixing $g(x) = s(e, x)$, we obtain an
injective computable function $g$ such that $\varphi_{g(x)}(y) =
\varphi_x(y)$ for all $y$. In other words, $g(x)$ encodes a program
that is semantically equivalent to the one encoded by $x$, while also being
injective in $x$.

This result has a more general form. Suppose that $\\{ psi_x \\}_{x \in \omega}$
is any sequence of partial computable functoins, and $g$ is a computable
function such that $\varphi_x = \psi_{g(x)}$. Then there is an injective
computable function $g'(x)$ such that $\varphi_x = psi_{g'(x)}$. Using this
with the canonical sequence $\varphi_1, \varphi_2, \ldots$, where $g(x) = Id$ is
computable and s.t. $\varphi_x = \varphi_{g(x)}$, ensures the existence of some
injective $g'$ s.t. $\varphi_x = \varphi_{g'(x)}$.

In short, any partial computable function $f$ has an injective equivalent.
