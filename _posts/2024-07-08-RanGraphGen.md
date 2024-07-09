---
title: Random graph generation 
categories: [ Science ]
---

The generation of connected random graphs is non-trivial and important to many
applications. In particular, it is not easy to sample a connected random graph
from the space $\mathcal{G}$ of all connected graphs with uniformity; i.e.
without a bias for graphs of a special kind. This entry contains two algorithms
for sampling random connected graphs. Though these algorithms do not overcome a
special kind of bias, their complexity is reasonable.

--- 

Before proceeding, quick definitions.

-   Let $\mathcal{T}_n$ the set of all trees of $n$ vertices,
    $\mathcal{G}_n$ the set of all graphs with $n$ vertices. We shall
    assume the vertices of these graphs are labeled $1, \ldots, n$.

-   For any $T \in \mathcal{T}_n$, we define $\mathcal{U}_T := \left\\{ G
            \in \mathcal{G}_n : T \subseteq G  \right\\}$ and refer to it
    as *the universe* of $T$. Thus, the universe of $T \in \mathcal{T}_n$ is 
    the set of graphs spanned by $T$.

-   Let $\Lambda(n) = \\{ \\{ x, y \\} : x, y \in \\{ 1, \ldots, n\\}    \\}$, the set of all 
    possible edges in a graph of $n$ vertices.

---

### Prüfer sequence 

The Prüfer sequence of $T \in \mathcal{T}_n$ is a word over the alphabet
$\Sigma = \\{0, \ldots, n - 1\\}$ of length $n - 2$. Prüfer proved that
there is a bijection between $\mathcal{T}_n$ and $\Sigma^{n-2}$, which on its
turn provided an alternative proof of the fact that there are $n^{n-2}$
distinct trees of $n$ vertices. 

The algorithms hereby presented generate random trees by generating random
Prüfer sequences. It is easy to construct algorithmically the tree
corresponding to a Prüfer sequence, and thus a random tree is obtained.

Let $T_2$ denote the unique tree of two vertices. Let $L$ be the label-set,
i.e. the set of natural numbers which label the vertices of our graphs. Then, a
recursive algorithm for constructing the corresponding to a Prüfer sequence $p
= p_1\ldots p_{n-2}$ over a label set $L$ is the following:

$$
\\begin{align*}
&\\textbf{ begin } \\textbf{f}(p, L) \\\\
&\\quad\\quad\\textbf{if } |p| = 0 \\textbf{ do} \\\\ 
&\\quad\\quad\\quad \\quad  \\textbf{return } T_2 \\text{ with labels in } L\\\\ 
&\\quad\\quad\\textbf{else} \\\\ 
&\\quad\\quad\\quad\\quad k := \\min_j \\{ j \\notin p\\} \\\\ 
&\\quad\\quad\\quad\\quad L' := L - \\{k\\}\\\\
&\\quad\\quad\\quad\\quad p' := p_2\\ldots p_{n-2} \\\\ 
&\\quad\\quad\\quad\\quad T := \\textbf{f}(p', L') \\\\ 
&\\quad\\quad\\quad\\quad V(T) := V(T) \\cup \\{k\\} \\\\ 
&\\quad\\quad\\quad\\quad E(T) := E(T) \\cup \\{\\{k, p_1\\}\\} \\\\ 
&\\quad\\quad\\quad\\quad \\textbf{return } T\\\\ 
&\\quad\\quad\\textbf{fi} \\\\ 
&\\textbf{end}
\\end{align*}
$$

Here is an illustration of the algorithm ran on $p = 17375$, $L =
\mathbb{N}_7$. The illustration is taken from [this
source](https://www.cs.tufts.edu/comp/150GT/documents/Prufer%20sequences%20-%20from%20[%20Gross,%20Yellen%20]%20%20Graph%20Theory%20and%20Its%20Applications,%203e.pdf).



<p align="center">
  <img src="../Images/prufergen.png" width="75%">
</p>


### Random graph generation

Let $T_w$ denote the graph corresponding to the Prüfer sequence $w$. Given a tree $T$ we 
define a special family of edges: 

$$ 
S_T = \\{e \in \Lambda(n) : e \notin E(T)\\} = \Lambda(n) - E(T)
$$

These are called the *spanning edges*, since these are the edges required to
span connected graphs from the spanning tree $T$. Observe that $\emptyset \in
S_T$ and is the set of edges required to span $T$ out of $T$.

Then, for any fixed $n$, we let the language $\left\\{ 1, \ldots, n
\right\\}^{n-2}$ be the index set of an indexed family of functions
$\mathcal{F}$ defined as:

$$\begin{align*}
    \mathcal{F}(w) : \mathcal{U}_{T_w} &\to S_T  \\\\
    \mathcal{F}(w)(G) &= E(G) - E(T_w)\end{align*}$$

> **$\mathcal{F}(w)$ is a bijection.**
>Let $S \in S_{T_w}$ for an arbitrary $T_w$. Define $G = (V(T), S \cup E(T_w)$. 
> Then $T_w \subseteq G$ and $G \in
>\mathcal{U}_{T_w}$. The intersection of $E(T_w)$ and $S_{T_w}$ is empty by
>definition. Then $S = E(G) - E(T_w)$. 
>
> $\therefore$ $\mathcal{F}(w)$ is
>surjective.
>
>Let $G, G' \in \mathcal{U}_{T_w}$ for an arbitrary $T_w$. Assume
>$\mathcal{F}(w)(G) = \mathcal{F}(w)(G')$. Assume $G \neq G'$. Since $T_w$
>spans both, all edges in $T_w$ are in $G, G'$ and their difference must lie in
>an edge outside of $T_w$. But all edges outside of $T_w$ are in
>$\mathcal{F}(w)(G)$ and $\mathcal{F}(w)(G')$ respectively, which are the
>same. This is a contradiction. $\therefore$ $G = G'$.
>
> $\therefore$ $\mathcal{F}(w)$ is injective.
> 
> $\therefore$ $\mathcal{F}(w)$ is bijective.

Let us summarize the relations we have established: 

> A Prüfer sequence maps to a
unique tree $T$, the tree maps to a universe of connected graphs
$\mathcal{U}_T$, and each graph in the universe corresponds to a set in $S_T$. 

In short, there is a nice generative path 

$$
\text{Prüfer sequence} \to \text{Tree} \to S \in S_T \to G \in \mathcal{U}_T
$$

which inspires effective procedures for random graph generation. The most 
obvious procedure is the following. Given an desired number of vertices $n$,


> *(1)* Generate randomly $p = p_1\ldots p_{n-2} \in \Sigma^{n-2}$.
>
> *(2)* Span the tree $T = (V, E)$ of the Prüfer sequence $p$.
>
> *(3)* Let $k \in_R \left\\{ 0, \ldots, \frac{ n(n-1) }{2} \right\\}$.
>
> *(4)* Let $\ell_1, \ldots, \ell_k \in_R S_T$, all
> distinct.
>
> *(5)* Let $E = E \cup \left\\{ \ell_1,\ldots, \ell_k \right\\}$

Because all trees of $n$ vertices correspond to a sequence, all trees can be
sampled. And all connected graphs can be derived from the set of all spanning
trees. Then this procedure generates all graphs in $\mathcal{G}_n$.

The question is whether it is equally likely to generate any two graphs
in $\mathcal{G}_n$. It is obvious that it is equally likely to generate
any tree. And the probability that a given graph is generated depends
entirely on the number of spanning trees it contains. Not all graphs
have the same number of spanning trees. $\therefore$ It is more likely
to generate a graph with many spanning trees than a graph with few
spanning trees.

--- 

The second effective procedure extends the input from only $n$, the number of
vertices, to $m$, the number of edges. Thus, it specifies the problem further
into the question of how to generate more or less dense graphs of $n$ vertices.
The effective procedure consists simply in generating $T_w$ and sampling $\ell
\in_R S_T$ repeatedly until $|E_T| = m$.


$$
\begin{align*}
    &\\textbf{Input: } n, m\\\\
    &T := (V, E) = \\textbf{genRandomTree}(n)\\\\
    &S_T := [\\Gamma^c(v_1), \\ldots, \\Gamma^c(v_n)]  \\\\
    &C := [ |S_T[1]|, \\ldots, |S_T|[n]|]  \\\\
    &V := [1, \\ldots, n]   \\\\
    &n' := n\\\\
    &\\textbf{while } |E(T)| < m \\textbf{ do } \\\\ 
    &\\qquad i := \\textbf{random}(1, n') \\\\ 
    &\\qquad v := V[i]\\\\
    &\\qquad \\textbf{if }  d(v) == n - 1  \\textbf{ do } \\\\ 
    &\\qquad \\qquad \\textbf{deleteAt}(V, i)\\\\ 
    &\\qquad\\qquad n' := n' - 1 \\\\ 
    &\\qquad\\textbf{else } \\\\ 
    &\\qquad\\qquad j = \\textbf{random}(1, C[v])\\\\
    &\\qquad\\qquad w := S_T[v][j] \\\\ 
    &\\qquad\\qquad E(T) := E(T) \\cup  \\left\\{ v, w \\right\\} \\\\
    &\\qquad\\qquad C[v] := C[v] - 1 \\\\ 
    &\\qquad\\qquad \\textbf{deleteAt}(S_T[v], j)  \\\\ 
    &\\qquad\\qquad\\textbf{deleteElement}(S_T[w], v)\\\\ 
    &\\qquad\\textbf{fi}\\\\
    &\\textbf{od}\\\\
    &\\textbf{return }
\end{align*}
$$

Generating a tree from a random Prüfer sequence is $O(n^2)$. Forming $S_T$ is
also $O(n^2)$. Within the while loop there are simply index manipulations, so
the complexity of the loop is $\varphi \times O(1) = \varphi$, with $\varphi$
the complexity of the number of iterations.

All iterations add an edge except those where a saturated vertex is
chosen. A saturated vertex may be chosen at most once. $\therefore$
There are $O(n)$ iterations where a saturated vertex is chosen. Since
the rest of the iterations add an edge, their number is fixed:
$m - (n-1)$, where $(n-1)$ is the number of edges in the spanned tree.
$\therefore$ There are exactly $m -n + 1$ edge-adding iterations.

$\therefore  \varphi = O(n) + O(m - n + 1) = O(n) + O(m) = O(m)$

$\therefore$ The complexity of the algorithm is
$O(n^2) + O(m) = O(n^2)$.

I showcase here random graphs with their source random trees as generated by
this algorithm. The left-most graph is the random tree which spanned the
right-most graph. The algorithm was implemented in C but the generated graphs
were plotted using the `networkx` Python package.

<p align="center">
  <img src="../Images/RandST1.png" width="45%">
  <img src="../Images/RandG1.png" width="45%">
</p>

<p align="center">
  <img src="../Images/RandST2.png" width="45%">
  <img src="../Images/Rand2.png" width="45%">
</p>
