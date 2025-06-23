---
title: Dovetailing and one-one reducibility of $K_1$ to $K$
categories: Science
---

It is undecidable whether a program halts or not on arbitrary input. However, we
can produce a program $x$ that takes another program $y$ and, if $y$ halts on some
input, then $x$ will eventually halt. This can be done through a technique
called dovetailing and some encoding of natural numbers, the most typical of
which is Gödel's prime-based encoding. 

Let $(x)_i$ denothe the power of the $i$th prime factor in the decomposition of
$x \in \omega$. Let $\varphi_e$ an arbitrary partial computable function
computed by program $P_e$. The Turing program $P_e$ runs on discrete steps, so
we can conceive the following procedure:

- (1) Fix $x \leftarrow 1$, $ n \leftarrow (x)_1, t \leftarrow (x)_2$. 
- (2) If $P_e$ halts in $t$ steps from input $n$, halt and return $1$. 
- (3) Otherwise, set $x \leftarrow x + 1$ and go back to step $(2)$.

Producing $((x)_1, (x)_2)$ for $x = 1, 2, \ldots$ effectively produces all
tuples $(a, b) \in \omega^2$, so any possible combination of (input $\times$
number of steps) will eventually be produced. This technique is called
*dovetailing*, where we explore the input space of a program in breadth rather
than in depth, sequencing by computation steps.

The fact that such a program exists is interesting because it entails that
undecidability does *not* entail non-enumerability. In other words, one can
produce an enumeration of (say) all the programs that halt under some input,
though one could not decide beforehand whether any program would appear or not
in the enumeration.

The formal expression of the fact we have discussed may go as follows:

> There is a partial computable function $\pi_k^{c}(x)$ that takes $k$
> arguments and halts with output $c$ (independently of the arguments) if and
> only if $W_x \neq \emptyset$. Furthermore, if $W_x \neq \emptyset$, then
> $W_{\pi_k^c(x)} = \mathbb{N}$, and if $W_x = \emptyset$ then
> $W_{\pi_k^c(x)} = \emptyset$.

Here, $\pi^1_0$ would correspond to the procedure we gave before. Clearly, if
the domain of $x$ is empty (i.e. program $x$ never halts) then $\pi^1_0(x)$
never halts either and its domain is empty. If $x$ halts for some input, then
$\pi^1_0(x)$ (and in fact $\pi_k^c(x)$ for arbitrary $k, c$) will eventually
halt for any input, and therefore its domain is $\omega$.

It turns out that the existence of $\pi_k^c$ is quite useful in proving an
important result: that $K_1$, the set of programs that halt for some input, 
is one-one reducible to $K$ the set of programs that halt with themselves as
input. This is intuitively obvious, since deciding whether a program halts with itself as
input would suffice to decide whether it halts for some input at all. Proving
this, however, is not straightforward unless one considers $\pi^c_k$ (or
the effective procedure to which it corresponds). The proof uses the fact that

$$
    W_{\pi^c_k(x)} = \begin{cases}
        \mathbb{N} & x \in K_1 \\\\
        \emptyset & x \not\in K_1
    \end{cases}
$$

This entails that if $x \in K_1$, then $\pi^c_k(x) \in W_{\pi^c_k(x)}$, which
means that $\pi^c_k(x) \in K$. If $x \not\in K_1$, clearly $\pi^c_k(x) \not\in
W_{\pi^c_k(x)}$, since said domain is the empty set, and $\pi^c_k(x) \not\in K$.
The function $\pi^c_k$ can be effectively transformed to an injective function
using the padding lemma (see [ this entry ](https://slopezpereyra.github.io/2025-06-22-PaddingLemmaInjection/)). 
(Alternatively, the function $g_k(x) = \pi_k^x(x)$ is obviously injective). This
suffices to show that $K_1$ is one-one reducible to $K$.




