---
title: Lagrange interpolation 
categories: [Science]
---

Polynomial interpolation consists of finding a polynomial $p(x)$ such that, for any set of 
distinct values $x_0, \ldots, x_n \in \mathbb{R}$ and a given function $f$, $p(x_i) = f(x_i)$. Lagrange's interpolation form makes use of an interesting polynomial; namely, 

$$ 
\lambda_k(x) = \prod_{i=0, i\neq k}^n \frac{x - x_i}{x_k - x_i}
$$

It is straightforward to observe two properties about $\lambda$; namely, that its degree is at most 
$n$, and that $\lambda_k(x_j) = \delta_{kj}$. From these two properties, a series of interesting facts 
can be deduced via the fundamental theorem of calculus. Namely, that for all $x \in \mathbb{R}$:

- $\sum_{i=0}^{n} \lambda_k(x) = 1$
- $\sum_{i=0}^{n}x_k \lambda_k(x) = x$
- $\sum_{i=0}^{n}x_k^m \lambda_k(x) = x^m$

We will prove the first of these properties; the other's are proved in analogous fashion.

> Take $p(x) = \sum_{i=0}^n \lambda_k(x) - 1$. Since $\lambda_k(x_j) = \delta_{kj}$, it follows 
that $p(x_j) = 0$ for $0 \leq j \leq n$. Then $p$ has $n+1$ roots. But since the degree of $p$ is 
at most $n$, the fundamental theorem of calculus ensures that $p = 0$. From this follows that 
$\sum_{i=0}^n \lambda_k(x) = 1$ for all $x$.

The second property is of particular interest, insofar as it ensures that
