---
title: Elementary proofs in computability theory
categories: [ Science, Personal ]
---

--- 

*Prime numbers and enumerable sets*. Let $\Sigma \neq \emptyset$ be an alphabet
with a total order $\leq$. Let $S \subseteq \omega^{n} \times \Sigma^{*m}$ a
$\Sigma$-mixed set of arbitrary dimensions. Notice that for any $n$-tuple $(x_1,
\ldots, x_n)$, with $x_i \in \omega$, we can find a corresponding $\varphi \in
\mathbb{N}$ s.t. 

$$
\varphi = 2^{x_1}3^{x_2} \ldots pr(n)^{x_n}
$$

In other words, $(x_1, \ldots, x_n)$ corresponds to the exponents of the $n$
prime factors of a unique natural number. At the same time, the $m$-tuple
$(\alpha_1, \ldots, \alpha_m)$ corresponds to a unique $\psi \in \mathbb{N}$
s.t. 

$$
\psi = 2^{y_1}3^{y_2}\ldots pr(m)^{y_m}
$$

where $\alpha_j = *^{\leq}(y_j)$. In other words, $(\alpha_1, \ldots, \alpha_m)$
corresponds to a unique natural number whose $m$ prime factors have exponents
given by the position of each word in the language.

Both of these relations come from the uniqueness of prime factorizations.
They provide a way to enumerate $\Sigma$-mixed sets. In
particular, if $S$ is $\Sigma$-total we enumerate it mapping each $x \in \omega$
to $\big((x)_1, \ldots, (x)_n, *^{\leq}((x)_{n+1}), *^{\leq}((x)_m)\big)$. If
$S$ is not $\Sigma$-total, then one can still enumerate it assuming that it is
$\Sigma$-computable. Indeed, one maps $x$ to the corresponding $(n+m)$-tuple
described above if the tuple is in $S$, and leaves the procedure undefined (or
without halt) otherwise. This can be expressed as follows:

> Because $\Sigma$-total sets are enumerable (as pointed out above), any
> $\Sigma$-mixed set that is $\Sigma$-computable is enumerable (via restriction
> of the $\Sigma$-total enumeration).

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
$\Sigma$-p.r. we have $F$ is $\Sigma$-p.r. $\blacksquare$

--- 

$(6)$ Let $C = \\{z^2 : z \in \omega\\}$ and $f \mapsto \omega$ given by $f(x) =
\sqrt{x}$ for all $x \in C$. Show $f$ is $\Sigma$-p.r.

Let $f' : \omega \to \omega$ be the integer root function, so that by definition 

$$
f'(x) = \min_t  \lambda x[t^2 \leq x \land (t+1)^2 > x]
$$

Observe that the predicate which defines $f'$ is $\Sigma$-p.r., since it is
simply

$$
\lambda xy[y \leq x \land Suc \circ p_2^{2, 0} > x ]
$$

Furthermore, $f'(x) \leq x$ and hence, since $f'$ is the bounded minimization of a
$\Sigma$-p.r. predicate, $f'$ is $\Sigma$-p.r. 

Lastly, it is easy to observe that $f = f'_{C}$. Consider that

$$
\chi_C^{\omega} = \lambda x[ (\exists t \in \omega)_{t\leq x}~ t^2 = x ]
$$

The predicate $\lambda xy[x^2=y] = \lambda xy[x = y] \circ \Big[ \lambda xy[x^y]
\circ [p_1^{2, 0}, C_2^{2, 0}], p_2^{2, 0}\Big]$ is evidently $\Sigma$-p.r. Then
$\chi_C^{\omega}$ is $\Sigma$-p.r. and then $f = f'\mid_C$ is $\Sigma$-p.r.
$\blacksquare$

--- 

$(7)$ Prove that $\lambda \alpha[\sqrt{\alpha}]$ is $\Sigma$-p.r.

Evidently, $\lambda \alpha[\sqrt{\alpha}] = M^{\leq}(P)$ for 

$$
P= \lambda \alpha[(\exists \beta \in \Sigma^{*})_{|\beta|\leq |\alpha|} ~
\beta^2 = \alpha]
$$

The domain of $M^{\leq}(P)$ is the set of chains that are squared of some other
chains while the domain of $P$ is simply $\Sigma^{*}$---i.e. $P$ is
$\Sigma$-total.

Now, $P$ is evidently $\Sigma$-p.r. since it is the composition of
the general quantifier with the bounding variable determined by $p_1^{0, 1}$ (we
do not prove this). Furthermore,

$$|\min_{\beta} P(\alpha)\mid \leq |\alpha|$$

Then $\lambda \alpha [\sqrt{\alpha}]$ is $\Sigma$-p.r.

---

$(8)$ Prove that $\omega^2 \times \Sigma^{*}$ is $\Sigma$-enumerable under von
Neumann's paradigm.

Our programm will do the following. Given an input $x \in \omega$, which we
presume corresponds to $N1$ at the start of the program, it will compute $(x)_1,
(x)_2$ and $*^{\leq}((x)_3)$. It will store each of these values in $N1, N2$ and
$P1$, respectively. Since the set we are required to enumerate is
$\Sigma$-total, no restriction is imposed. To prove that a program can perform
these operations, it suffices to show that the functions $(x)_i$ and $*^{\leq}$
are $\Sigma$-computable. This is what we set to do.

*(1)* Recall that $pr(i)$ is $\Sigma$-p.r. and hence $\Sigma$-r. It follows that
it is also $\Sigma$-computable and has an associated macro $[V1 \leftarrow
PR(V2)]$. It is also not difficult to show that $\lambda xyz[x.y > z]$ is
$\Sigma$-p.r. and has an associated macro $[IF ~ V2 \times V3 > V1 ~ GOTO A1]$.
Now consider the following (macro) program.

$$ 
\begin{align*} 
    &V2 \leftarrow Pr(V2)\\
    A1 ~ : ~ &[if ~ not ~ V2 \mid V1 ~ GOTO ~ A2] \\
    &V5 \leftarrow V5 + 1 \\ 
    &[V1 \leftarrow Q(V1, V2)]\\ 
    & GOTO ~ A1 \\
    A2 : ~ &V1 \leftarrow V5
\end{align*}
$$

where $Q(V1, V2)$ computes the quotient of $V1/V2$. This program computes the
exponent of the $i$th prime in the prime decomposition of $x$, where $V1$ is the
input $x$ and $V2$ the input $i$.

> Note 1. Consider $P = \lambda xy\Big[(\exists q \in \omega)_{q \leq y} ~ \big[ (\exist r \in \omega \big)_{r \leq q} ~ x.q + r  = y \big] \Big]$. The minimum $q$ satisfying the property above is the quotient of $y/x$. This is $\Sigma$-r as will be proven in the sub-proof section of this problem. Then it is correct to assume there is a macro associated to this operation.

> Note 2. An example of how the program works. Assume inputs $42, 2$. Then the
> (1) lets $V2 \leftarrow Pr(2)$ so $V2 = 3$. Since $3 \mid 42$ it lets $V5 = 1$
> and $V1 = 14$. Since $3 \not\mid 14$ it goes to $A2$ and the output of the
> program is $1$. Indeed, $42 = 2\times 3 \times 7$.

Let $[V1 \leftarrow PrExp(V2, V3)]$ denote the macro of the program above. 

(2) We know $*^{\leq}$ is $\Sigma$-p.r. and hence $\Sigma$-.r. Since $\lambda
xi[(x)_i]$ is $\Sigma$-r the composition $\lambda x[*^{\leq}(x)] \circ \lambda
xi[(x)_i]$ is $\Sigma$-r and has an associated macro, which we will term
$[M1 \leftarrow *^{\leq} (PrExp(V2, V3))]$. 

(3) This is all we needed to produce a program that enumerates $\omega^{2}
\times \Sigma^{*}$. The program is the following:

$$
\begin{align*}
    &N3 \leftarrow N3 + 1 \\ 
    &N4 \leftarrow N1\\
    &[N1 \leftarrow PrExp(N4, N3)]\\ 
    &N3 \leftarrow N3 + 1 \\ 
    &[N2 \leftarrow PrExp(N4, N3)]\\ 
    &N3 \leftarrow N3 + 1 \\ 
    &[P1 \leftarrow *^{\leq}(PrExp(N4, N3))]\\
\end{align*}
$$

> Subproof. Let $Q = \lambda xqy[ (\exists r \in \omega)_{r \leq q} ~ x.q+r =
> y]$. Evidently, $Q' = \lambda xqry[x.q+r = y]$ is $\Sigma$-p.r. Then $Q$ is
> $\Sigma$-p.r. and hence $\Sigma$-r. Since $P$ is a nesting of $Q$ with
> quantification over $q$, it is $\Sigma$-r and hence the macro exists.

--- 

(9) Prove that if $S \subseteq \Sigma^{*}$ is $\Sigma$-enumerable, then 

$$
T = \{\alpha \in \}
$$











