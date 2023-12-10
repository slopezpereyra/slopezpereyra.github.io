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

$$\begin{align} f_3 &:= \lambda zt \alpha [ \alpha^{Pred(z).t} ]  = \lambda \alpha x [\alpha^{x}] \circ [f_1 \circ [p_1^{2, 1}, p_2^{2, 1}], p_3^{2, 1}] \\  f_4 &:=  \lambda \alpha \beta [\beta^{Pred(Pred(|\alpha|))}] = \lambda x\alpha[\alpha^x] \circ [f_2 \circ p_1^{0, 2}, p_2^{0,2}] \end{align}$$

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




