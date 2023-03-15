---
title: Research notes: TMS
---

For simplicity, we will deal with the hypothetical situation in which a single ISI was used for paired stimulations. All of our results generalize to different ISI.

### Definitions

Let $k$ be the number of experimental subjects in some subject group, to each of whom $n$ paired stimulations and $m$ test stimulations were elicited.


Let $\textbf{P}^{n \times k}, \textbf{T}^{m\times k}$ be matrices representing the paired and test potentials evoked across each of the $k$ subjects; explicitely,

$$
    \begin{equation}
    \textbf{P} := \begin{bmatrix}x_{11} & x_{12}& \cdots & x_{1k} \\
    x_{21} & x_{22}& \cdots & x_{2k} \\
    & & ... & \\
    x_{n1} & x_{n2}& \cdots & x_{nk} 
    \end{bmatrix} \\ 

    \textbf{T}:= \begin{bmatrix}t_{11} & t_{12}& ... & t_{1k} \\
    t_{21} & t_{22}& \cdots & t_{2k} \\
    & & ... & \\
    t_{m1} & t_{m2}& \cdots & t_{mk} 
    \end{bmatrix}
    \end{equation}
$$

Let $\mu_t := \begin{bmatrix} \mu_1, \mu_2, \ldots, \mu_k \end{bmatrix}^\top$ be a vector where $\mu_i$ is the average test potential for the $i$th subject. In other words,

$$
\begin{equation}
    \mu_i = \frac{1}{m}\sum_{j=1}^m t_{ji}
\end{equation}
$$


**Remark**. Evoked potentials of both paired and test pulses conform to a Gamma distribution, as discussed in the appendix (?). This means it is always assumed $\forall x \in \textbf{P}, \forall t\in \textbf{T}|x, t \in \mathbb{R}^+$.

#### The $\rho$ and $\delta$ features


Let $x \in \textbf{P}_{\star i}$ be a single paired-stimulation MEP in the $i$th experimental subject, and $\textbf{t} = \textbf{T}_{\star i}$ the vector containing all test MEPs of that subject. Then we define two pulse-specific relative amplitude measures,

$$
\begin{equation}
    \rho(x) := \frac{mx}{\sum_{i=1}^mt_j}
\end{equation}
$$ 
$$
\begin{equation}
    \delta(x) := \frac{x}{m}\sum_{j=1}^m\frac{1}{t_j}
\end{equation}
$$

**Remark**. $\forall x \in \mathbb{R}^+|\delta(x) \geq \rho(x)$. (For a proof of this property, consult the appendix.)


The $\rho$ function is not an entirely new contribution. The traditional group level relative amplitude measure is conceived as the average, across all subjects in a group, of the average paired response divided by the average test response of each subject. If we let $S_i$ be the average relative amplitude of the $i$th subject, then $S_i$ has ben traditionally defined as

$$
\begin{equation}
    S_i=\frac{\frac{1}{n}\sum_{j=1}^n x_{ji}}{\frac{1}{m}\sum_{j=1}^m t_{ji}} = \frac{\rho(x_{1i})+\cdots + \rho(x_{ni})}{n}
\end{equation}
$$

as it is easy to see from decomposing the sum in the numerator. In other words, the traditionally used measure of relative amplitude, at the subject level, has always been the average $\rho$ in a subject. 



### The weighted variants $\rho_w, \delta_w$

As stated earlier, action potentials evoked by trasncranial magnetic stimulation follow a Gamma distribution; one that closely resembles an exponential distribution (see \textbf{Statistics} section). A valid form of data augmentation that also attempts to deal with the presence of outliers is to weight the averages involved in $\rho, \delta$ using inverse-variance weights. The attempt is to allow for potentials that lay at the tail of the distribution to contribute in a way proportional to their probability. 

If we let $\rho_w, \delta_w$ be the weighted versions of $\rho, \delta$, then we have 

$$
\begin{align}
    \rho_w(x) &:= \frac{xm\sum_{j=1}^m w_j}{\sum_{j=1}^m t_j w_j} \\
    \delta_w(x) &:= \frac{\frac{x}{m}\sum_{j=1}^m\frac{w_j}{t_j}}{\sum_{j=1}^m w_j}
\end{align}
$$

where $\textbf{w}$ is some appropriate weight vector. Since the purpose of $\textbf{w}$ is to reduce the contribution of outliers to the overall measure of relative amplitude, it is to be expected that the distribution of $\textbf{w}$ closely resembles that of evoked potentials.


### Appendix

#### Proofs

**Theorem**: $\forall x \in \mathbb{R}^+|\delta(x) \geq \rho(x)$

We will be very explicit here, since the purpose of this is note-taking. Recall that

$$
\begin{align} \delta(x) &= \frac{x}{m}\sum^m\frac{1}{t_j} \\ \rho(x) &= \frac{xm}{\sum^m t_j} \end{align}
$$

Let $S_1^m = \sum^m\frac{1}{t_j}, S_2^m= \sum^m t_j$. We operate under the assumption that $t_i \in \mathbb{R}^+$. It is the case that

$$
\begin{align} \frac{x}{m}\sum^m\frac{1}{t_j} &\geq \frac{xm}{\sum^m t_j} \\
\iff S_2^mS_1^m &\geq m^2
\end{align}
$$

This holds for $m=1$, since $\frac{1}{t_1}+t_1 \geq 1 \iff 1+t_1^2 \geq t_1$. So we may assume $S^k_1 S^k_2 \geq k^2$ . We may only show now that


$$
\begin{equation}
S^{k+1}_1 S^{k+1}_2 \geq (k+1)^2
\end{equation}
$$

$$
\begin{align} 
S^{k+1}_1 S^{k+1}_2 &\geq (k+1)^2 \\
(S_1^k+\frac{1}{t_{t+1}})(S_2^k+t_{k+1}) &\geq k^2+2k+1 \\
S^k_1S^k_2+ t_{k+1}S_1^k + \frac{1}{t_{k+1}}S^k_2+1 &\geq k^2+2k+1 \\
S^k_1S^k_2+ t_{k+1}S_1^k + \frac{1}{t_{k+1}}S^k_2 &\geq k^2+2k
\end{align}
$$

We know $S^k_1S^k_2 \geq k^2$ and then it suffices to show $t_{k+1}S_1^k + \frac{S^k_2}{t_{k+1}}\geq 2k$. To prove this, simply observe that

\begin{align}
\frac{1}{t_{k+1}}\sum_{j=1}^mt_j+t_{k+1}\sum_{j=1}^m\frac{1}{t_{j}} &\geq 2k \\
\iff\frac{1}{t_{k+1}}(t_1+t_2+...+t_k)+t_{k+1}(\frac{1}{t_1}+\frac{1}{t_2}+...+\frac{1}{t_k}) &\geq 2k \\
\iff \Big(\frac{t_1}{t_{k+1}}+\frac{t_2}{t_{k+1}}+...+\frac{t_k}{t_{k+1}}\Big)+\Big(\frac{t_{k+1}}{t_1}+\frac{t_{k+1}}{t_2}+...+\frac{t_{k+1}}{t_k}\Big) &\geq 2k \\
\iff \overbrace{a+\frac{1}{a}+b+\frac{1}{b}+... + n+\frac{1}{n}}^{\text{$2k$ terms} } &\geq 2k
\end{align}

We have $\min f=2$  for $f(x)=x+\frac{1}{x}$ for $x \in \mathbb{R}^+$. Then $\min(a+\frac{1}{a}+...+n+\frac{1}{n})=2k$ for $a,..., n \in \mathbb{R}^+$, which concludes the demonstration.


