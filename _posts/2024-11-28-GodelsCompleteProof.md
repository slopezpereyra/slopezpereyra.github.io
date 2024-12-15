---
title: Sketch of a proof of Godel's completeness theorem 
categories: [ Science ]
---

> **Gödel's completeness theorem**. Let $T = (\Sigma, \tau)$ a first order 
theory. Then, for any $\varphi \in S^\tau$, $T \vDash \varphi$ implies $T \vdash
\varphi$.


**Proof**. We proceed by contradiction. Assume there is some $\varphi_0 \in
S^\tau$ such that $T \vDash \varphi_0$ and $T \not\vdash \varphi_0$. Let
$\vec{\gamma} \in F^{\tau \mathbb{N}}$ be an infinituple with all formulas with
at most one free variable. In particular, for each $j \in \mathbb{N}$, let
$w_j$ denote the variable satisfying $\{w_j\} \subseteq \mathcal{F}(\gamma_j)$,
and $\gamma_j =_d \gamma_j(w_j)$.

A theoretical result of Lindembaum algebras
guarantees that for all $j \in \mathbb{N}$, using $[\gamma_j]$ to denote the 
equivalence class of $\gamma_j$ over $\dashv\vdash$,

$$
\text{inf}\{[\gamma_j(t)] : t \in T_c^\tau\} = [\forall w_j\gamma_j(w_j)]
$$

Observe too that $[\varphi_0] \neq 1^T, [\neg \varphi_0] \neq 0^T$. Rasiova and
Sikorski's theorem ensures then that there is a prime filter $\mathcal{U}$ of
the Lindembaum algebra satisfying

- $[\neg \varphi_0] \in \mathcal{U}$
- For all $j \in \mathbb{N}$, if $\{[\gamma_j(t)] : t \in T_c^\tau\} \in \mathcal{U}$ , then 
necessarily $[\forall w_j \gamma_j(w_j)] \in \mathcal{U}$.

Since $\vec{\gamma}$ contains all formulas with at most one free variable, we 
can rewrite the second point as

- For all $\varphi =_d \varphi(v) \in F^\tau$, if $\{[\varphi(t)] : t \in T_c^\tau\} \in \mathcal{U}$ , then 
necessarily $[\forall v \varphi(v)] \in \mathcal{U}$.

Define over $T_c^\tau$ the binary relation $\infty$ as follows:

$$
t \infty s \text{ if and only if } [t \equiv s] \in \mathcal{U}
$$

We accept without proof that $\infty$ is an equivalence relation over
$T_c^\tau$. Define $\textbf{A}$ as the model of type $\tau$ satisfying the
following:

- Its universe is $T_c^\tau / \infty$
- For all $c \in \mathcal{C}$, $c^\textbf{A} = c / \infty$
- $f^{\textbf{A}}(t_1 / \infty, \ldots, t_n / \infty) = f(t_1,\ldots, t_n) / \infty$ 
- $r^\textbf{A} = \{(t_1 / \infty, \ldots, t_n / \infty) : [r(t_1, \ldots, t_n)] \in \mathcal{U}\}$

Consider the following proposition:

$$
\textbf{A} \vDash \varphi[t_1 / \infty, \ldots, t_n / \infty] \text { if and only if } [\varphi(t_1, \ldots, t_n)] \in \mathcal{U}
$$

It is mechanic to prove this theorem by induction, assuming the set of formulas is 
recursively defined. But the property above guarantees that any given sentence is 
true if and only if its equivalence class, in the Lindembaum algebra, is contained 
in the filter $\mathcal{U}$. And since $[\neg \varphi_0] \in \mathcal{U}$, we must 
have $\textbf{A} \vDash \neg \varphi_0$. However, this contradicts the assumption
that $T \vDash \varphi_0$.














