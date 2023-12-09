---
title: Elementary proofs in computability theory
categories: [ Science ]
---


---
> *(1)*. Proving that $f : \mathbb{N} \times \Sigma^{+}$ is $\Sigma$-p.r
> where 

$$f(x, \alpha) = \begin{cases} x^2 & x +  | \alpha | ~ ~ \text{even}  \newline 0 & x + |\alpha | ~ ~ \text{odd} \end{cases}$$

Let 

$$
\begin{align}
S_1 &= \{ (x, \alpha) \in \mathbb{N} \times \Sigma^{+} : x + |\alpha | \text{ is
even} \} \newline
S_2 &= \{ (x, \alpha) \in \mathbb{N} \times \Sigma^{+} : x + |\alpha | \text{ is
odd} \}
\end{align}
$$

Evidently, $S_1 \cap S_2 = \emptyset$ and $S_1 \cup S_2 = D_f$ . Since the
predicate $P = \lambda x[x \text{ is even}]$ is $\Sigma$-p.r. we know
$\chi_{S_1}^{\mathbb{N}\times \Sigma^{+}}$ and $\chi_{S_2}^{\mathbb{N}\times \Sigma^{+}}$ are both $\Sigma$-p.r. sets. We define $f_1 = \lambda[x^2]$ and $f_2 = \lambda x\alpha[0]$. It is straightforward to observe that 

$$
\begin{align}
   f_1 &= \lambda xy[x^y] \circ \big[ p_1^{1, 1}, \lambda \alpha[~|\alpha|~] \circ
   p_2^{1, 1} \big] \newline 
   f_2 &= C_0^{1, 1}
\end{align}
$$

This is sufficient to show $f_1, f_2$ are $\Sigma$-p.r., which combined with the
fact that $S_1, S_2$ are $\Sigma$-p.r. ensures that $f_1|_{S_1}, f_2|_{S_2}$ are
both $\Sigma$-p.r. Since $f = f_1|_{S_1} \cup f_2\mid_{S_2}$ we conclude that $f$ is $\Sigma$-p.r. $\blacksquare$

---

> *(2)* Prove that $S \subseteq \omega \times \Sigma^{*m}$ with $S$ finite
> implies $S$ is $\Sigma$-p.r. for the case $n = m = 1$.

Let $S' = \{ (x, \alpha)\}$ for two arbitrary $x \in \omega, \alpha \in
\Sigma^{*}$. It is trivial to observe that $S'$ is $\Sigma$-p.r. Simply note
that 

$$
\chi_{S'}^{\omega \times \Sigma^{*}} = \lambda y\beta[x = y \land \alpha =\beta]
= \lambda y\beta [x = y] \land \lambda y\beta[\alpha = \beta]
$$

This proves that any one-element subset of $\omega \times \Sigma^{*}$ is $\Sigma$-p.r.

Now, observe that $S = \bigcup_{P \in P_1(S)}P$ where $P_1(S)$ is the partition
of $S$ into subsets of one element. This follows trivially from the definition
of partition. Since each $P$ is a one-element subset of $\omega \times \Sigma^{*}$, each $P$ is $\Sigma$-p.r. Then their union $S$ is $\Sigma$-p.r. $\blacksquare$

---


