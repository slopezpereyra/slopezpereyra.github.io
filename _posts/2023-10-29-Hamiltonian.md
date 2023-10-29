---
title: Hamilton cycles ~ A backtracking algorithm
categories: [ Science ]
---

A classic computational problem consists of determining whether a Hamiltonian
cycle exists for a given graph. It is well-known that this problem can be solved
using backtracking, and in fact the problem of designing a backtracking
algorithm for this purpose is standard in computer science universities around
the world. It is correct to infer from this that the problem is not particularly
challenging. However, it provides an excellent opportunity to *show* what
*backtracking* is with a nice example case (graph theory is always *nice*).

### Formal preliminaries

--- 
*Definitions.* 

*(1)* Let $G = (V, E)$ a graph and $G_{n} := (V - \{ n \}, E), n \in
\mathbb{N}$. Importantly, $G_{n}$ does not remove the occurrences of $n$ in the
tuples of $E$ but only removes $n$ from $V$. 

*(2)* Assuming a defined graph $G$, $N_{i} := \{ v \in V : (i, v) \in E \}$ is
the set of *neighbors* of the $i$th vertex. The prominent case are the
*zero-neighbors* $N_0$, insofar as they are the set of candidate decisions in
the first step of the algorithm.

*(3)* We let $H'(G, a, b)$ be a predicate function that determines whether there
is a path from $a$ to $b$ in graph $G$. 

We begin with a simpler problem; namely, whether there is any path that returns
to the zero vertex. We do not impose the condition that this path is Hamiltonian
yet. To emphasize that we are working on a simplified problem, any function
defined will have a prime symbol $(\cdot)'$.

*(4)* We call any path that starting at the zero vertex returns to the zero
vertex a *pseudo Hamiltonian cycle*. 

---

*Proposition.*  $G$ has a pseudo Hamiltonian cycle  if and only if $\bigvee_{k
\in N_{0}} H'(G, 0, k)$. 

*Backtracking.* We ensure backtracking occurs by defining $H$ recursively with
two trivial base cases. Namely,

$$
H'(G, a, b) = \begin{cases}
1 & a=b \newline 
0 & b \not\in V \newline 
\bigvee_{k \in N_{a}} H'(G_{a}, k, b) & otherwise
\end{cases}
$$

This definition implements backtracking in the following manner. Firstly, it
breaks the problem of finding a path from $a$ to $b$ into that of finding a
path from the neighbors of $a$ to $b$ (excluding $a$ from the candidate space).
If the path exists, the function will eventually arrive to the base case $a = b$
and make the whole disjunctive expression true. If the path does not exist, the
$b \not\in V$ clause is reached. (Draw a graph and call $H'$ manually on it to
see why this is true.) 

A slightly modified version of the *Proposition* given above gives

$$
f'(G) = \bigvee_{k \in N_{0}k \neq k_{0}} H'(G_{k_{0}}, k_{0}, k)
$$

as the function that determines whether there is a pseudo Hamiltonian cycle for
graph $G$. With $H'$ being properly defined, this solves the simpler problem of
finding pseudo Hamiltonian cycles. Since the only difference between a pseudo
Hamiltonian cycle and a Hamiltonian cycle is that, in the latter, all nodes have
been traversed, we must simply impose this condition to the clause of $H'$ that
returns true (this is, to $a = b$). Since each time to traverse a node we remove
it from $V$ (where $G = (V, E$)), a Hamiltonian cycle will be a pseudo
Hamiltonian cycle where $V$ has been transformed into the empty set.

Then, let $X(G)$ be a predicate function s.t. $X(G) = 1$ if $V = \emptyset$, $0$
otherwise. Then let

$$
H(G, a, b) = \begin{cases}
1 \land X(G)& a=b \newline 
0 & b \not\in V \newline 
\bigvee_{k \in N_{a}} H'(G_{a}, k, b) & otherwise
\end{cases}
$$

The same reasoning we used before implies

$$
f(G) = \bigvee_{k \in N_{0}k \neq k_{0}} H(G_{k_{0}}, k_{0}, k)
$$

determines whether there is a proper Hamiltonian cycle for graph $G$.

### A C implementation

For the full `C` implementation, visit the [GitHub
repo](https://github.com/slopezpereyra/hamiltonianCycle). I made heavy use of
custom structs with pointers only to practice memory management. The functions
of interest for us can be understood without reading the full code, if only one
considers that a `graph` is represented as a pair of values `V` and `adj_l`,
where `V` is the number of vertices (`0, 1, ...., V - 1`) and `adj_l` is an
array of pointers to `list`s:

```C
struct _graph {
    int V;
    list *adj_l; // pointer to a list (which is a pointer to _node).
};

typedef struct _graph * graph;
```

Then we implement our backtracking idea as follows.

```C
// Recursive function that determines whether a (pseudo or
// propper) Hamiltonian cycle exists.
//
// Represents H or H' depending on whether `hamiltonian` is 
// true. 
bool pathExists(graph g, int from, int to, bool hamiltonian){
    if (from == to){
        if (!hamiltonian) { return true; }
        return (countTraversedNodes(g) == ( g -> V ) - 1);
    } 
    if (getNode(g, to) == NULL) { return(false); }

    node node_from = getNode(g, from), node_to = getNode(g, to);
    bool exists = false;
    for (node vertex = node_to; vertex != NULL; vertex = vertex -> next){
        graph copy = cloneGraphWithoutNode(g, to);
        exists = exists || pathExists(copy, from, vertex -> value, hamiltonian);
        destroyGraph(copy); // clean memory from copy once it is done;
    }
    if (exists) {  printf("%d <-- ", to);}
    return(exists);
}

// Determines whether Hamilton cycle exists for graph g.
bool hamCycle(graph g){

    list firstNeighbor = (g -> adj_l)[0];
    if (firstNeighbor == NULL || firstNeighbor -> next == NULL) { return false; }
    // Exclude 'root' from path finding
    (g -> adj_l)[0] = NULL;
    for (node zn = firstNeighbor -> next; zn != NULL; zn = zn -> next){
        if (pathExists(g, zn -> value, firstNeighbor -> value, true)){
            return(true);
            destroyGraph(g);
        }

    }
    destroyGraph(g);
    return(false);
}
```

