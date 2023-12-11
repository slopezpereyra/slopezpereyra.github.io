---
title: Elementary proofs in computability theory
categories: [ Science, Personal ]
---


---
$\textit{(1)}$ Prove that $f : \mathbb{N} \times \Sigma^{+}$ is $\Sigma$-p.r
where 

$$f(x, \alpha) = \begin{cases} x^2 & x +  | \alpha | ~ ~ \text{even}  \newline 0 & x + |\alpha | ~ ~ \text{odd} \end{cases}$$

Let 

$$\begin{align} S_1 &:= \{ (x, \alpha) \in \mathbb{N} \times \Sigma^{+} : x + |\alpha | \text{ is even} \} \newline S_2 &:= \{ (x, \alpha) \in \mathbb{N} \times \Sigma^{+} : x + |\alpha | \text{ is odd} \}\end{align}$$

Evidently, $S_1 \cap S_2 = \emptyset$ and $S_1 \cup S_2 = D_f$ . Since the
predicate $P = \lambda x[x \text{ is even}]$ is $\Sigma$-p.r. we know
$\chi_{S_1}^{\mathbb{N}\times \Sigma^{+}}$ and $\chi_{S_2}^{\mathbb{N}\times \Sigma^{+}}$ are both $\Sigma$-p.r. sets. We define $f_1 = \lambda[x^2]$ and $f_2 = \lambda x\alpha[0]$. It is straightforward to observe that 

$$\begin{align} f_1 &= \lambda xy[x^y] \circ \big[ p_1^{1, 1}, \lambda \alpha[~|\alpha|~] \circ p_2^{1, 1} \big] \newline f_2 &= C_0^{1, 1} \end{align}$$

This is sufficient to show $f_1, f_2$ are $\Sigma$-p.r., which combined with the
fact that $S_1, S_2$ are $\Sigma$-p.r. implies that $f_1|_{S_1}, f_2|_{S_2}$ are
both $\Sigma$-p.r. Since $f = f_1|_{S_1} \cup f_2\mid_{S_2}$ we conclude that
$f$ is $\Sigma$-p.r. $\blacksquare$

---

$\textit{(2)}$ Prove that $S \subseteq \omega \times \Sigma^{*m}$ with $S$ finite
 implies $S$ is $\Sigma$-p.r. for the case $n = m = 1$.

Let $S' = \{ (x, \alpha)\}$ for two arbitrary $x \in \omega, \alpha \in
\Sigma^{*}$. It is trivial to observe that $S'$ is $\Sigma$-p.r. Simply note
that 

$$\chi_{S'}^{\omega \times \Sigma^{*}} = \lambda y\beta[x = y \land \alpha =\beta] = \lambda y\beta [x = y] \land \lambda y\beta[\alpha = \beta]$$

This proves that any one-element subset of $\omega \times \Sigma^{*}$ is $\Sigma$-p.r.

Now, observe that $S = \bigcup_{P \in P_1(S)}P$ where $P_1(S)$ is the partition
of $S$ into subsets of one element. This follows trivially from the definition
of partition. Since each $P$ is a one-element subset of $\omega \times \Sigma^{*}$, each $P$ is $\Sigma$-p.r. Then their union $S$ is $\Sigma$-p.r. $\blacksquare$

---
$\textit{(3)}$ Prove that $F := \lambda xyz\alpha\beta[ \bigvee_{t=3}^{t=z+5} (\alpha^{Pred(z).t} ~ \beta^{Pred(Pred(|\alpha|))})]$ is $\Sigma$-p.r, where $\bigvee$ denotes string concatenation.

We will observe that the component functions of 

$$f := \lambda zt \alpha \beta[\alpha^{Pred(z).t}\beta^{Pred(Pred(|\alpha|))}]$$ 

are $\Sigma$-p.r. First, note that

$$ \begin{align} f_1&:= \lambda zt[Pred(z).t] = \lambda zt[z.t]\circ [Pred \circ p_1^{2, 0}, p_2^{2, 0}]\newline f_2&:= \lambda \alpha[Pred(Pred(|\alpha|))] = Pred \circ Pred \circ \lambda \alpha[|\alpha|]\end{align}$$

are evidently $\Sigma$-p.r. Then

$$\begin{align} f_3 &:= \lambda zt \alpha [ \alpha^{Pred(z).t} ]  = \lambda \alpha x [\alpha^{x}] \circ [f_1 \circ [p_1^{2, 1}, p_2^{2, 1}], p_3^{2, 1}] \newline  f_4 &:=  \lambda \alpha \beta [\beta^{Pred(Pred(|\alpha|))}] = \lambda x\alpha[\alpha^x] \circ [f_2 \circ p_1^{0, 2}, p_2^{0,2}] \end{align}$$

Of course, $f_3, f_4$ are $\Sigma$-p.r. Now it is trivial to observe that 

$$f = \lambda \alpha \beta [\alpha \beta] \circ \Big[f_3 \circ [p_1^{2, 2}, p_2^{2, 2}, p_3^{2, 2}], f_4 \circ [p_3^{2, 2}, p_4^{2, 2}]\Big]$$

It follows that $f$ is $\Sigma$-p.r. Observe that 

$$D_f = \{(z, t, \alpha, \beta) \in \omega^{2} \times \Sigma^{*2} : z > 0 \land
|\alpha| > 1\}$$

which implies $f$ is not $\Sigma$-total. Nonetheless, it is simple to observe
that if 

$$G := \lambda xyz\alpha\beta[\bigvee_{t=x}^{t=y} f(z, t, \alpha, \beta)]$$

then $F = G(3, z+5, z, \alpha, \beta)$. Now, we do not need to prove that $z+5$
and $3$ are $\Sigma$-p.r., since the addition and the constant functions are
elementary cases. And since $G$ is $\Sigma$-p.r., because $f$ is $\Sigma$-p.r.,
then $F$ is $\Sigma$-p.r.

-------

$(4)$ Show that $F = \lambda xy[\text{gcd}(x, y)]$ is $\Sigma$-p.r.

This problem is useful to strengthen our grasp of the conditions for a
predicate minimization to be $\Sigma$-p.r. Indeed, one may observe that 

$$F(x, y) = d \iff d = \min_t \Big( t \mid x \land t \mid y \land \big( (\forall k \in \omega)_{k\leq t} (k \not\mid x \lor k \not\mid y) \lor k \mid t \big)\Big)$$

In other words, $F$ is the minimization of the predicate above. Let $P$ denote such predicate. It is easy to see that

$$P =\lambda xytz \Big[t \mid x \land t \mid y \land (\forall k \in \omega)_{k\leq z} (k\not\mid x \lor k \not\mid y \lor k\mid t)\Big] \circ \Big[p_1^{3, 0}, p_2^{3, 0}, p_{3}^{3, 0}, p_3^{3, 0}\Big]$$

which is evidently $\Sigma$-p.r. From this follows that $M(P) = F$ is
$\Sigma$-r., but not that it is $\Sigma$-p.r. For this to be true, $M(P) = F$
must be bounded by some $\Sigma$-p.r. function. But it is simple to observe that
the $\gcd$ of two numbers is necessarily inferior or equal to the minimum of
them. Then $M(P) \leq \min(x, y)$, or to use the explicit form of $M$:

$$\min_t P(t, x, y) \leq \min(x, y)$$

Then, because $M$ is bounded by a p.r. function, $M$ is $\Sigma$-p.r.
$\blacksquare$

--- 

$(5)$ A similar, though a bit more sophisticated problem, is proving that
$\lambda xi[(x)_i]$ is $\Sigma$-p.r. 

> Recall that $(x)_i$ denotes the exponent of the $i$th prime in the prime
>properties decomposition of $x$.

Let the $\lambda$ above be $F$ and observe that $D_F = \mathbb{N}^2$. Now, let

$$
F'(x, i) = \begin{cases} 0 & i=0 \lor x = 0 \newline F(x, i) & \text{otherwise} \end{cases}
$$

It is clear that $F'$ is $\Sigma$-total with $D_{F'} = \omega^2$, and that $F =
F|_\mathbb{N^2}$. Let 

$$P:=\lambda txi[ pr(i)^{t} \mid x \land \neg pr(i)^{t+1} \mid x  ]$$

It is evident that $P(t, x, i) = 1$ iff $F'(x, i) = t$. It is evident that $P$
is $\Sigma$-p.r. because it is the following composition:

$$
\lambda xyz[x \mid z \land \neg y \mid z]\circ \Big[ \lambda xy[x^y] \circ
[pr_3^{3, 0}, pr_1^{3, 0}], \lambda xy[x^y] \circ [pr \circ p_3^{3, 0}, Suc
\circ p_1^{3, 0}], p_2^{3, 0} \Big]
$$

which is evidently $\Sigma$-p.r. Now, this implies $F = M(P)$ is $\Sigma$-r. To
prove that it is $\Sigma$-p.r. one can simply observe that 

$$\min_t P(t, x, i) \leq x$$

for all $x \in \omega$. To prove that $\min_t P(t, x, i)$ is bounded by $x$ w 
need to observe the following. By definition, the minimum $t$ satisfying $P$
satisfies $pr(i)^{t} \mid x$, which implies $pr(i)^{t} \leq x$. Now we
can prove that $t \leq pr(i)^t$.

> Let $a \in \mathbb{N}$ and $n \in \omega$. We want to prove $a^n \geq n$ holds.
>
> Observe that $a^0 = 1$ and $1 \geq 0$. Similarly, $a^1 = a$ and $a \geq 1$ by
> definition. Assume this holds for an arbitrary $k \in \omega$. Then observe
> that for $k \neq 0$, $a^{k+1} = a^ka$. Since $a^k>k$, then $a^k a > ka$. Since
> $a$ is natural, $ka\geq k+1$. Conversely, if $k = 0$, $a^{1} \geq 0 + 1$. This
> proves that for whatever $a \in \mathbb{N}, n \in \omega$, $a^n \geq n$.

From this follows $t \leq pr(i)^t \leq x$. Then we have proven that our bound is
correct. And since the bounding function is $p_1^{1, 0}$ (i.e. the $x$
argument), which is $\Sigma$-p.r., we have that 

$$F'(x, i) = \min_tP(t, x, i) \leq x$$

is $\Sigma$-p.r. Since $F = F'\mid_{\mathbb{N^2}}$ and $\mathbb{N^2}$ is
$\Sigma$-p.r. we have $F$ is $\Sigma$-p.r.




















