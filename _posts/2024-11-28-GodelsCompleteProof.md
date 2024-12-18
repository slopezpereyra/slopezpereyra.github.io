---
title: A proof of Godel's completeness theorem 
categories: [ Science ]
---

> **Gödel's completeness theorem**. Let $T = (\Sigma, \tau)$ a first order 
theory. Then, for any $\varphi \in S^\tau$, $T \vDash \varphi$ implies $T \vdash
\varphi$.


Assume there is a $\varphi_0 \in S^\tau$ such that $T \vDash \varphi_0$
and yet $T \not\vdash  \varphi_0$. We define $\dashv\vdash$ as the
equivalence relation s.t. $\varphi \dashv\vdash \psi$ if and only if
$T \vdash (\varphi \iff \psi)$, and the Lindenbaum algebra in the usual
way:

$$\mathcal{A}_T = \left( S^\tau / \dashv\vdash , \textbf{s}, \textbf{i}, ^c, 0, 1 \right)$$

For any sentence $\varphi$, let $[\varphi]$ denote
$\varphi / \dashv\vdash$. Evidently, from our assumption follows

$$[\varphi] \neq 1, ~ ~ ~ [\neg \varphi_0] \neq 0$$

Let $\overrightarrow{\gamma}$ denote the infinituple containing all
formulas with at most one free variable. In each
$\gamma_j =_d \gamma_j(w_j)$, $w_j$ denotes the variable such that
$\\{ w_j \right\\} \subseteq \mathcal{F}(\gamma_j)$.

The infimum lemma for Lindenbaum algebras guarantees that, for any
formula $\psi \in F^\tau$,
$\text{inf}\\{ \left[ \psi(t) \right] : t \in T_c^\tau  \\}  = \left[ \forall v \psi(v) \right]$.
In particular,

$$\text{inf}\\{ \left[ \gamma_j(t) \right] : t \in T_c^\tau  \\} = [ \forall w_j \gamma_j(w_j) ]$$

Furthermore, for any Boolean algebra $\mathcal{B}$, with
$x \neq 0_\mathcal{B}$ an arbitrary element of $B$, Rasiowa and
Sikorski's theorem ensures the following: for any subsets
$A_1, A_2, \ldots$ of $B$ all of which haven an infimum, there is a
prime filter $F$ satisfying:

-   $x \in P$

-   If $A_i \subseteq F$, then the infimum of $A_i$ is in $F$.

Applying this theorem to the Lindenbaum algebra, we know there is a
prime filter $\mathcal{U}$ such that:

-   $\left[ \neg \varphi_0 \right] \in \mathcal{U}$

-   For each $j \in \mathbb{N}$, if
    $\\{ [\gamma_j(t)] : t \in T_c^\tau \\} \subseteq \mathcal{U}$,
    then $[ \forall w_j ~ \gamma_j(w_j) ] \in \mathcal{U}$

Let us define $\bowtie$ a binary relation over $T^\tau_c$ as follows:

$$t \bowtie  s \text{ if and only if } [(t \equiv s)] \in \mathcal{U}$$

We accept without proof that $\bowtie$ is an equivalence relation. We
also accept without proof two very simple properties:

-   For any $\varphi =_d \varphi(v_1,\ldots,v_n)\in F^\tau$, if
    $t_i \bowtie s_i$ with $1 \leq i \leq n$, then
    $[ \varphi(t_1,\ldots, t_n) ] \in \mathcal{U}$ if and only if
    $[\varphi(s_1,\ldots, s_n)] \in \mathcal{U}$

-   For any $f \in \mathcal{F}_n$, if $t_i \bowtie s_i$ with
    $1 \leq i \leq n$, then
    $f(t_1,\ldots, t_n) \bowtie f(s_1,\ldots, s_n)$

Let us define too a self-referential model of type $\tau$, which we
denote with $\textbf{A}$, as follows:

-   Its universe is $T^\tau_c / \bowtie$

-   $c^\textbf{A} = c /\bowtie$ for each $c \in \mathcal{C}$

-   $f^\textbf{A}(t_1 / \bowtie , \ldots, t_n /\bowtie ) = f(t_1,\ldots, t_n)  / \bowtie$,
    for each $f \in \mathcal{F}_n, t_1,\ldots, t_n \in T_c^\tau$

-   $r^\textbf{A} = \\{ (t_1 / \bowtie , \ldots, t_n / \bowtie ) : [ r(t_1,\ldots, t_n) ] \in \mathcal{U}  \\}$,
    for each $r \in \mathcal{R}_n, t_1,\ldots,t_n \in T_c^\tau$

Accept without proof the following property, which we denote with
$\star$ from now onwards:

$$t^\textbf{A}[t_1 / \bowtie , \ldots, t_n /\bowtie ] = t(t_1,\ldots, t_n) / \bowtie$$

We will prove by induction that for any
$\varphi =_d \varphi(v_1,\ldots,v_n) \in F^\tau$, and any
$t_1,\ldots, t_n \in T^\tau_c$,

$$\textbf{A} \vDash \varphi\left[ t_1 / \bowtie , \ldots, t_n / \bowtie  \right] \text{ if and only if } \left[ \varphi(t_1,\ldots,t_n) \right] \in \mathcal{U}$$


If $\varphi \in F_0^\tau$, one of the following cases holds:

1.  $\varphi = (s \equiv t)$ with $s, t \in T^\tau$

2.  $\varphi = r(w_1,\ldots, w_m)$ with
    $r \in \mathcal{R}_m, w_1,\ldots, w_m \in T^\tau$

Proving that the property holds for each of these cases is trivial. So assume
the property holds for $\varphi \in F_k^\tau$, $k \in \mathbb{N}$, and consider
$\varphi \in F_{k+1}^\tau - F_k^\tau$. If $\varphi = (\varphi_1 \lor
\varphi_2)$, we have $\varphi_i =_d \varphi_i(v_1,\ldots, v_n)$ for $i = 1, 2$,
and then

$$\begin{aligned}
    \textbf{A} \vDash \varphi\left[ t_1 / \bowtie ,\ldots, t_n / \bowtie  \right]  
&\iff \textbf{A} \vDash \varphi_1[\overrightarrow{t / \bowtie }] \text{ and } \textbf{A} \vDash \varphi_2 \left[ \overrightarrow{t / \bowtie } \right]  \\\\ 
&\iff \left[ \varphi_1(\overrightarrow{ t / \bowtie }) \right] \in \mathcal{U} \text{ and } \left[ \varphi_2(\overrightarrow{t / \bowtie }) \right]  \in  \mathcal{U} \\\\ 
&\iff \left[ \varphi_1 (\overrightarrow{t / \bowtie }) \right] \textbf{ s } \left[ \varphi_2(\overrightarrow{t / \bowtie }) \right] \in  \mathcal{U} \\\\ 
&\iff \left[ \varphi_1 (\overrightarrow{t / \bowtie }) \lor \varphi_2(\overrightarrow{t / \bowtie })\right] \in \mathcal{U} \\\\ 
&\iff \left[ \varphi(\overrightarrow{t / \bowtie }) \right] \in \mathcal{U}\end{aligned}$$

QED. The proof for the other connective symbols are similar. Now
consider the case $\varphi = \forall v \varphi_1$. By declarational
convention, we have $\varphi_1 =_d \varphi_1(v_1,\ldots, v_n, v)$, with
$v \neq v_j$ for all $1 \leq j \leq n$. Then

$$\begin{aligned}
    \textbf{A} \vDash \varphi\left[ \overrightarrow{t / \bowtie } \right] 
&\iff A \vDash \varphi_1 \left[ t_1 / \bowtie ,\ldots, t_n / \bowtie , t / \bowtie  \right] \text{ for all } t \in T^\tau_c \\\\ 
&\iff \left[ \varphi_1(t_1,\ldots, t_n, t) \right] \in \mathcal{U} \text{ for all } t \in T_c^\tau\\\\ 
&\iff \left[ \forall v \varphi_1(t_1, \ldots, t_n, v) \right] \in \mathcal{U} \\\\ 
&\iff\left[ \varphi(t_1,\ldots, t_n) \right] \in \mathcal{U}\end{aligned}$$

In the case $\varphi = \exists v \varphi_1$, we again have
$\varphi_1 =_d \varphi_1(v_1,\ldots, v_n, v)$, with $v \neq v_j$ for all
$1 \leq j \leq n$. Then

$$\begin{aligned}
    \textbf{A} \vDash \varphi\left[ \overrightarrow{t / \bowtie } \right] 
&\iff \textbf{A} \vDash \varphi_1\left[ t_1 / \bowtie , \ldots, t_n / \bowtie , t \right] \text{ for some } t \in  T_c^\tau \\\\ 
&\iff \left[ \varphi(t_1,\ldots, t_n, t) \right] \in \mathcal{U} \text{ for some } t \in  T_c^\tau \\\\ 
&\iff \left( \left[ \varphi_1(t_1,\ldots, t_n, t) \right]  \right)^c \not\in \mathcal{U} \text{ for some } t \in T_c^\tau \\\\ 
&\iff \left[ \neg \varphi_1(t_1,\ldots, t_n, t) \right] \not\in \mathcal{U} \text{ for some } t \in T_c^\tau \\\\ 
&\iff\left[ \forall v \neg \varphi_1(t_1, \ldots, t_n, v) \right] \not\in \mathcal{U} \\\\ 
&\iff\left(\left[ \forall v \neg \varphi_1(t_1, \ldots, t_n, v) \right]\right)^c \in \mathcal{U} \\\\ 
&\iff \left[ \neg \forall v \neg \varphi_1 (t_1, \ldots, t_n, v) \right] \in \mathcal{U} \\\\ 
&\iff\left[ \exists v \varphi_1(t_1,\ldots, t_n, v) \right] \in \mathcal{U} \\\\ 
&\iff \left[ \varphi(t_1,\ldots, t_n) \right] \in \mathcal{U}\end{aligned}$$

This concludes the proof of the property. However, since
$\left[ \neg \varphi_0
\right] \in \mathcal{U}$, the property ensures that
$\textbf{A} \vDash \neg
\varphi_0$. However, this contradicts the fact that
$T \vDash \varphi_0$. The contradiction arises from assuming $\varphi_0$
is such that $T \vDash \varphi_0$ but $T \not\vdash \varphi_0$.

 

$\therefore$ Godel's completeness theorem is true.

