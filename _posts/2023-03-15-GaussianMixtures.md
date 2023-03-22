---
title: Gaussian Mixtures - Quick notes
categories: [ Science ]
---


**Def**. A *Gaussian Mixture* is a generative model that assumes the instances of a set
were generated from a mixture of several Gaussian distributions with unknown
parameters. 

It is intuitive to understand that instances generated from a Gaussian
distribution will form clusters.

-----

On its simplest variant, the model assumes that you know the number $k$ of
Gaussian distributions from which sprouted the instances of $X$. $X$ is assumed
to have been formed as follows.

- Every $x \in X$ is randomly chosen from $k$ clusters. The probability of
  choosing the $j_{\text{th}}$ cluster is defined by the cluster's weight
  $\Phi_j$. The cluster of an instance $x_i$ is denoted $z_i$.
- If $z_i = j$, then $x_i$ is randomly sampled from a Gaussian distribution with
  mean $\mu_j$ and a covariance matrix $\sum_j$. Formally,  $x_i \thicksim
  \mathcal{N}(\mu_j, \sum_j)$

--------

With those assumptions in mind, given a set $X$ we can estimate the
weights $\Phi_j$ of all $k$ clusters and the parameters $\mu_j, \sum_j$ of all
$k$ distributions. We typically find a fit, mixed Gaussian model of $X$
via *Expectation-Maximization (EM)*:

- Initialize random parameters
- **Expectation step**: Assign each instance to the cluster it is more probable
  to belong to.
- **Maximization step**: Update all clusters using all instances, with each
  instance weighed by the probability of belonging to that cluster. This
  probabilities are called *responsibilities* of the cluster for the instances.
  A cluster's will be more impacted by those instances it is more responsible
  for.
- Repeat the process from the expectation step until convergence.

As you can see, it is similar to *KMeans*. In fact, *EM* is a generalized form
of *KMeans* that not only finds the clusters but also their size, shape and
orientation. Another difference is that *EM* uses soft cluster assignments.
Predictions are made by assigning each instance to the cluster it is more likely
to belong to.
    
----

<center><img
src="https://drive.google.com/uc?id=1kios8laiVBPpx6Uz7rI7Bu6k6SS9wj3Y"
alt="drawing" width="600"/>
</center>

----

### The number of clusters

The appropriate number of clusters can be found finding the model that minimizes a *theoretical information criterion*. Usually, the *Bayesian information criterion* (BIC) or the *Akaike information criterion* (AIC) are used.

$$
\begin{align}
&BIC = \log (m)p - 2\log(\hat{L}) \newline
&AIC = 2p - 2\log(\hat{L}) 
\end{align}
$$

with $p, \hat{L}$ representing the number of parameters learned by the model and the maximized value of the *likelihood function* of the model, respectively. Notice that both criteria penalize models with many parameters $p$.

------------

The Bayesian approach is to maximize the posterior probability of a model $M$
given some data $X$. This means finding the model $M_i$ that is more likely
under $X$, or rather the model $M_i$ that maximizes 

$$
\begin{align}
P(M|X) = \frac{P(X|M)P(M)}{P(X)}
\end{align}
$$

In data science terms, this means finding a parameter vector $\hat{\theta}$
that maximizes the likelihood function $\mathcal{L}_n(\theta;X)$. Assuming our
variables are random and independent,

$$
\max_\theta \space \mathcal{L}_n(\theta;X) = \max_\theta \space
\prod_{k=1}^n \mathcal{L}_n(x_k; \theta)
$$ 

Now, let $\log \mathcal{L}_n(\theta) = \ell (\theta; X)$ be the
log-likelihood. The logarithm is a monotonic function and therefore the maximum
value of $\ell (\theta; X)$ is equal to the maximum value of
$\mathcal{L}_n(\theta)$. In other words,

$$\text{max}_\theta \space \ln \Big( \prod_{k=1}^n \mathcal{L}_n(x_k;\theta)
\Big) = \text{max}_\theta \space \sum_{k=1}^n \ell (x_k;\theta)
=\text{max}_\theta \space \ell (x_1;\theta) +\ell (x_2;\theta) \space + ... +
\ell (x_n;\theta)$$

Finding $\text{max}_\theta$ is far easier on this sum than on
the non-logarithmic factorial. We do it by taking the partial derivative of
the sum with respect to $\theta$ and finding the point in which it is $0$. 

Because $\text{max}_\theta$ does not change when we rescale the function, we
can dividte the previous sum by $n$ so as to formulate our result as the
expected probability of $X$ given $\theta$,

$$\frac{1}{n}\sum_{k=1}^n \ell (x_k;\theta) = \mathbb{E} \Big[\ell
(x_k;\theta)\Big]$$


-------------

With all this information in mind, reconsider the meaning of $BIC = \log (m)p -
2\log(\hat{L})$. You can see that the lowest possible values of BIC are those
with the more likely $\hat{\theta}$ and the lowest $p$. In other words, it
strives at the same time for likelihood and sparsity. At the same time, each
parameter contributes to the sum according to its contribution to the likelihood
of the model, and therefore parameters are weighted by their importance.

Therefore, $\text{BayesianGaussianMixture}$ serves not only to determine the
minimum number of clusters that are likely to exist, but also provides *feature
selection*. In $\text{sklearn}$, simply set the number of clusters
$\text{n\_components}$ to a value that you have good reason to believe is greater
than the optimal number of clusters. The algorithm will eliminate the
unnecessary clusters on its own.


### Considerations and takeaways

- When there are many dimensions or not a lot of data, *Gaussian Mixtures* are
  not so effective. A way to deal with high dimensionality is to impose
  constraints on the covariance matrices.
- *Gaussian Mixtures* consider all the data. Therefore, the presence of outliers
  may seriously bias their decisions. It is possible to fit the model once to
  detect outliers and, once they've been detected, removing them and fifting the
  model again.
- *Gaussian Mixtures* are excellent on clusters with ellipsoidal shapes, but
  very poorly with different shapes.
- $\text{BayesianGaussianMixture}$ provides feature selection because it uses
  the *Bayesian information criterion*. This criterion yields a good parameter
  vector that strives simultaneously for high likelihood and sparsity.
