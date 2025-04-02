---
title: What is a while statement?
categories: [Science, Personal]
---

> Denotational semantics attempts to give a mathematical meaning to programs.
> One can  then reason about programs independently of their implementation,
> language, and execution environment. This entry shows how an important theorem
> solved a fundamental issue of denotational semantics: to provide a
> mathematical description of a `while` statement. It then uses  this theorem in
> an example to show how the mathematical meaning of a `while` statement
> corresponds to its intuitive interpretation.

Intuitively speaking, the semantics of a **while** statement should satisfy an
equation of the following form: 

$$
[\textbf{while } b \textbf{ do } c] \sigma = \textbf{if } [b]\sigma \textbf{then } [\textbf{while } b \textbf{ do } c]([c]σ) \textbf{ else } σ
$$

where $[\cdot]: \Sigma \to \Sigma$ is the semantic function and $\sigma \in \Sigma$
is a state.


The definition satisfies our intuitive understanding of a **while** statement. 
However, it is not syntax directed, which means the equation may not determine
the meaning of **while** uniquely.

The problem of giving a syntax-directed definition of **while** is interesting and
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

Since

$$
[\textbf{while } b \textbf{ do } c] \sigma = \textbf{if } [b]\sigma \textbf{then } [\textbf{while } b \textbf{ do } c]([c]σ) \textbf{ else } σ
$$

is a recursive definition, $\textbf{while } b \textbf{ do } c$ is a fixed point
of $F : (\Sigma \to
\Sigma_\bot) \to (\Sigma \to \Sigma_{\bot})$ defined as:

$$
F\Big(f(\sigma)\Big) = \textbf{if } [b] \sigma \textbf{ then }
f_{\bot}( [c] \sigma) \textbf{ else } \sigma
$$

where $f_{\bot}$ is the extension of $f$ (i.e. $f_\bot(x) = x$ if $x \neq \bot$,
and $f(\bot)=\bot$). It can be proven that $F$ is continuous. The least fixed-point theorem ensures
that the least-fixed point of $F$ exists and is $\Psi_{\Sigma \to \Sigma_{\bot}}(F)$,
and then 

$$
[\textbf{while } b \textbf{ do } c ] = \Psi_{\Sigma \to
\Sigma_{\bot}} F
$$

Thus, given $b, c$,  $\textbf{while } b \textbf{ do } c$ has a well-defined mathematical semantic. As a trivial
example, when $b$ is $\textbf{true}$ and $c$ is $\textbf{skip}$, $F$ is the
identity function on $\Sigma \to \Sigma_\bot$, whose least fixed-point is the
function mapping every state into $\bot$. But mapping every state into $\bot$ is
precisely the expected meaning of $\textbf{while true do skip}$.

A less trivial example is the summation to a variable $y$ of all numbers from $1$ t o a given $x$. In Python, this would look like this:

```python
while x != 0:
      y = y + x
      x = x - 1
```


Clearly, the procedure terminates iff $\sigma ~ x \geq 0$. In formal terms, this
procedure is
$$
  \mathcal{W} := \textbf{while } \sigma ~ x \neq 0 \textbf{ do } x := x - 1; y := y + x
$$

Using the least fixed-point theorem:

$$
  [ \mathcal{W} ] = \bigsqcup_{i \in \mathbb{N}} F^i ~ \bot_{\Sigma \mapsto \Sigma_\bot }
$$

with 

$$
  F ~ f ~ \sigma = \begin{cases}
    f_{\bot}\Big([ x := x - 1, y:= y + x ]\sigma \Big) & 
     \sigma x \neq 0 \\\\
    \sigma  & c.c.
  \end{cases}
$$

Then,

$$
\begin{align*}
  F ~ \bot &= \sigma \mapsto \begin{cases}
    \sigma & \sigma ~ x = 0 \\\\ 
    \bot  & \sigma ~ x \neq 0
  \end{cases}, \\\\
    F(F \bot ) &= \sigma \mapsto \begin{cases}
    [ \sigma \mid x := 0 \mid y := \sigma ~ y + 1 ] & \sigma ~ x = 1\\\\ 
    \sigma & \sigma ~ x = 0 \\\\ 
    \bot  & \sigma ~ x \not\in \\{ 0, 1 \\} 
  \end{cases}
\end{align*}
$$

We then propose a general formula which adheres to the bases cases mentioned
above:

$$
\begin{equation*}
  F^k(\bot ) = \sigma \mapsto 
  \begin{cases}
    \left[ \sigma \mid x:=0 \mid y := \sigma ~ y + \sum_{i=0}^{\sigma ~ x} i \right] & 0 \leq \sigma ~ x < k \\\\
    \bot  & c.c.
  \end{cases}
\end{equation*}
$$

If we define
$$\widetilde{ \sigma }  := \left[\sigma \mid x := \sigma ~ x - 1 \mid y := \sigma ~ y + \sigma ~ x \right] $$

we have

$$
\begin{align*}
  F^{k+1} ~ \bot 
  &= \sigma \mapsto \begin{cases}
    F^k ~ \widetilde{ \sigma }  & \sigma ~ x \neq 0 \\\\ 
    \sigma & \sigma ~ x = 0
  \end{cases} \\\\
  &= \sigma \mapsto \begin{cases}
    \left[ \widetilde{ \sigma } \mid x := 0 \mid y := \widetilde{ \sigma } ~ y +
    \sum_{i=0}^{\widetilde{ \sigma } ~x }\right] & \sigma ~ x \neq 0 \land 0
    \leq \widetilde{ \sigma } ~ x < k \\\\ 
    \bot  & \sigma ~ x \neq 0 \land \neg(0 \leq \widetilde{ \sigma } ~ x < k) \\\\ 
    \sigma & \sigma ~ x = 0
  \end{cases} \\\\
  &= \sigma \mapsto \begin{cases}
  \left[ \sigma \mid x := 0 \mid y := (\sigma ~ y + \sigma ~ x) + \sum_{i = 0}^{\sigma ~ x - 1}  \right] & \sigma ~ x \neq 0 \land 1 \leq
\sigma ~ x < k + 1 \\\\ 
  \bot & \sigma ~ x \neq 0 \land \neg (1 \leq \sigma ~ x < k + 1) \\\\ 
  \sigma & \sigma ~ x = 0 
\end{cases}  \\\\ 
  &=\sigma \mapsto \begin{cases}
  \left[ \sigma \mid x :=0 \mid y := \sigma ~ y + \sum_{i=0}^{\sigma ~ x}
  i\right] & 1 \leq \sigma ~ x < k + 1  \\\\ 
  \sigma & \sigma ~ x = 0 \\\\ 
  \bot & \sigma ~ x < 0 \lor  \sigma ~ x \geq k + 1
\end{cases} \\\\ 
  &=\sigma \mapsto \begin{cases}
  \left[ \sigma \mid x :=0 \mid y := \sigma ~ y + \sum_{i=0}^{\sigma ~ x}
  i\right] & 0 \leq \sigma ~ x < k + 1  \\\\ 
  \bot & ~ c.c.
\end{cases}
\end{align*}
$$

*quod erat demonstrandum*. In other words,


$$
\begin{equation*}
  \bigsqcup_{k \in \mathbb{N}} F^k ~ \bot  = \sigma \mapsto 
  \begin{cases}
    \left[ \sigma \mid x:=0 \mid y := \sigma ~ y + \sum_{i=0}^{\sigma ~ x} i
    \right] & \sigma ~ x \geq 0 \\\\ 
    \bot & c.c.
  \end{cases}
\end{equation*}
$$

which exactly corresponds to the interpretation of the loop we gave in Python, 
and in fact of any loop which adds to variable all numbers from $1$ to $x$.







