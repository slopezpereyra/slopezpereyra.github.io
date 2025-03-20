---
title: What is a while statement?
categories: [Science, Personal]
---

Intuitively speaking, the semantics of a `while` statement should satisfy an
equation of the following form:

``` 
[[while b do c]]σ = if [[b]]σ then ([[while b do c]])([[c]]σ) else σ
```

where $\sigma$ is a state and $\llangle \cdot \rrangle$ is the semantic
function. That the definition makes sense is easy to appreciate. However, it is
not syntax directed, which means the equation may not determine the meaning of
`while` uniquely.

The problem of giving a syntax-directed definition of `while` is interesting and
provides a beautiful illustration of the importance of the *least fixed-point
theorem*. The theorem states that if $D$ is a domain (in the poset sense) and $f
: D \mapsto D$ is continuous, then 

$$
x = \bigsqcup_{n=0}^\infty f^n ( \bot )
$$

is the least fixed-point of $f$. The theorem is not hard to prove. If we define 

$$
\Psi_D (f) = \sup_{n=0}^\infty f^n (\bot)
$$

then we may formulate the theorem as follows: $\Psi$ maps continuous functions
from $D$ to $D$ into their least fixed-points. 

We may know reconsider the definition given before:


``` 
[[while b do c]]σ = if [[b]]σ then ([[while b do c]])([[c]]σ) else σ
```

and observe that `wile b do c` is a fixed point of the function $F : (\Sigma \to
\Sigma_\bot) \to (\Sigma \to \Sigma_bot)$ defined as:

$$
F\Big(f(\sigma)\Big) = \textbf{if } \llangle b \rrangle \sigma \textbf{ then }
f_{\Bot}(\llangle c \rrangle \sigma) \textbf{ else } \sigma
$$

It can be proven that $F$ is continuous. The least fixed-point theorem ensures
that $F$ the least-fixed point of $F$ is $\Psi_{\Sigma \to \Sigma_{\bot}}(F)$,
and then 

$$
\llangle \textbf{while } b \textbf{ do } c \rrangle = \Psi_{\Sigma \to
\Sigma_{\bot}} F
$$

Thus, $\textbf{while}$ has a well-defined mathematical semantic. As a trivial
example, when $b$ is $\textbf{true}$ and $c$ is $\textbf{skip}$, $F$ is the
identity function on $\Sigma \to \Sigma_\bot$, whose least fixed-point is the
function mapping every state into $\bot$. But mapping every state into $\bot$ is
precisely the expected meaning of $\textbf{while true do skip}$.








