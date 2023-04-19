---
title: A simple MLE algorithm using gradient ascent 
categories: [ Science ]
---


This is a simple maximum-likelihood estimation algorithm for the normal
distribution. I chose $\mathcal{N}$ because it is the most commonly known
distribution. Of course, the maximum-likelihood estimators of its parameters are
the sample mean and the sample variance (this can be proven analytically).
However, I am interested in implement a numerical approach. 

The purpose of showing a numerical method for MLE is simple. I would have loved
to see one when I was first studying mathematical statistics. Hopefully, some
lost cyber-wanderer will find the example detailed here illuminating with
regards to how MLE *algorithms* work. 

Since the idea is to provide an algorithmic appreciation of the method, I will
only briefly sketch the theory of MLE, which I assume the reader knows.

### Maximum-likelihood estimation

Maximum-likelihood estimation consists in taking a vector $\textbf{x}$ of data
as a fixed constant and the parameters of a distribution as variables. These
parameters are denoted with the letter $\theta$. Observe that $\theta$
represents an $n$-tuple of parameters —not a unique one. In the case of the
normal distribution, $\theta \mapsto (\mu, \sigma)$.

The idea is to observe the joint-probability of $\textbf{x}$ for different
values in the domain of $\theta$. Whatever $\hat{\theta}$ maximizes this
joint-probability is by definition the maximum-likelihood estimator of the true
parameters $\theta$.

If $f_X$ is the PDF of the identically distributed random variables in
$\textbf{x}$, then the joint-probability (also called likelihood) of
$\textbf{x}$ is 

$$
\begin{align*}
    \mathcal{L}(\theta; \textbf{x}) = \prod_{j=1}^{n} f_X(x_j; θ)
.\end{align*}
$$

A key mathematical observation is that whatever $\hat{\theta}$ maximizes the
function above is also the maximizer of $\ln \mathcal{L}$. In other words, 

$$
\begin{align*}
    \underset{\theta}{\operatorname{\argmax}} \mathcal{L} = \underset{\theta}{\operatorname{\argmax}} \ln \mathcal{L}
\end{align*}
$$

We will let $\ln \mathcal{L} := \ell$. Now let us observe the case where $f_X$
is the PDF of the normal distribution.


### The normal distribution case

We have the log-likelihood of $\theta$ given an observation $x$ to be 

$$
\begin{align*}
    \ell(\theta; x) &= -\frac{1}{2\sigma^2}\left( x - \mu\right)^2 - \ln(\sigma) -
    \frac{1}{2}\ln(2\pi) \newline 
    &=-\frac{1}{2\sigma^2}\left( x - \mu\right)^2 - \frac{1}{2}\ln(\sigma^2) - \frac{1}{2}\ln(2\pi) \newline 
\end{align*}
$$

So 

$$
\begin{align*}
    \ell (\theta; \textbf{x}) &= \sum_{j=1}^n \left(-\frac{1}{2\sigma^2}\left(
    x_j - \mu\right)^2 - \frac{1}{2}\ln(\sigma^2) - \frac{1}{2}\ln(2\pi)\right) \newline 
        &= \left(-\frac{1}{2\sigma^2} - \frac{1}{2}\ln(\sigma^2) -
        \frac{1}{2}\ln(2\pi)\right)n + \sum_{j=1}^n (x_j- \mu)^2 \newline 
        &= -\frac{n}{2}\ln 2\pi -\frac{n}{2} 
    \ln \sigma^2 - \frac{1}{2\sigma^2} \sum_{j = 1}^n (x_j - \mu)^2
.\end{align*}
$$

This is the function that we need to maximize in terms of $\theta$. Since the
first term is independent of the distribution parameters, minimization will
pertain only to  

$$
\begin{align*}
    f(\sigma, \mu; \vec{x}) = -\frac{n}{2}\ln \sigma^2 -
    \frac{1}{2\sigma^2}\sum_{j=1}^n(x_j - \mu)^2
.\end{align*}
$$

To maximize it, we will use gradient ascent. This is, we will compute the
gradient of $f$ and take infinitesimal steps towards the direction of steepest
ascent (which is the gradient itself). As a convergence criteria, we will use
the magnitude (or norm) of the gradient. The point of this criteria is that as
we shift $\theta$ towards a maximum, the gradient itself becomes ever smaller in
magnitude. 

Now we must observe that 

$$
\begin{align*}
    \frac{\partial f}{\partial \sigma} &= -n\frac{\partial 
    }{\partial \sigma} \ln \sigma - \frac{1}{2}\sum_{j=1}^n (x_j - \mu)^2 \frac{\partial
    }{\partial \sigma} \sigma^{-2} \newline 
    &= -\frac{n}{\sigma} - \frac{1}{2}\sum_{j=1}^n (x_j - \mu)^2
    \left( -\frac{2}{\sigma^3} \right)
    \newline 
    &= -\frac{n}{\sigma} + \frac{\Sigma}{\sigma^3}
.\end{align*}
$$

At the same time, 

$$
\begin{align*}
    \frac{\partial f}{\partial \mu} &= \frac{1}{\sigma^2} \left( \sum_{j=1}^n x_j
    - n\mu\right)
.\end{align*}
$$

This gives us everything we need to build our algorithm.

### A Julia implementation 

```julia 
using LinearAlgebra # To use the norm() function.

function N(x::Number, μ, σ)
    """Probability density of x ~ 𝓝(μ, σ)."""
    1 / sqrt(2pi) * exp(-0.5 * ((x - μ)/σ)^2)
end

function L(y::Vector, μ, σ)
    """The likelihood function"""
    fₓ(x) = N(x, μ, σ)
    prod(fₓ, y)
end

function pder_μ(μ::Number, σ::Number, x::Vector)
    """Partial derivative of L with respect to μ"""
    1/(σ^2) * (sum(x) - length(x) * μ)
end

function pder_σ(μ::Number, σ::Number, x::Vector)
    """Partial derivative of L with respect to σ"""
    -length(x)/σ + sum((x .- μ).^2)/σ^3
end

# The following two functions are to allow for syntactic sugar.

function pder_σ(θ::Vector, x::Vector)
    pder_σ(θ[1], θ[2], x)
end

function pder_μ(θ::Vector, x::Vector)
    pder_μ(θ[1], θ[2], x)
end

# The gradient ascent algorithm.

function grad_ascent(data, μ₀, σ₀, tol=0.01, lr=0.01)
    """Performs gradient ascent over the likelihood function given a vector of
    data. μ₀, σ₀ are initial parameters (can be random numbers)."""
    θ = [μ₀, σ₀] while true 
        ∇ℓ = [pder_μ(θ, data), pder_σ(θ, data)]
        θ = θ .+ ∇ℓ .* lr
        if norm(∇ℓ) < tol 
            break 
        end
    end
    return θ
end

# Example run

# Simulate data from a normal distribution with μ = 5, σ = 3.
data = 5 .+ 3 .* randn(100)

# Perform MLE. Initial parameters are arbitrarilly set to -10 and 3.
res = grad_ascent(data, -10, 3)

# The returned estimated parameters were 4.34 and 2.98.

```



