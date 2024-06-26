---
title: Backtracking examples
categories: [ Science ]
---

## Hamiltonian cycles

A classic computational problem consists of determining whether a Hamiltonian
cycle exists for a given graph. It is well-known that this problem can be solved
using backtracking, and in fact the problem of designing a backtracking
algorithm for this purpose is somewhat paradigmatic. It is correct to infer from
this that the problem is not particularly challenging. However, it does provide
an excellent opportunity to show what backtracking is and how it can be
implemented in a nice problem (graph theory is always *nice*).

### Formal preliminaries

*Definitions.* 

*(1)* Let $G = (V, E)$ a graph and $G_{n} := (V - \\\{ n \\\}, E), n \in
\mathbb{N}$. 

*(2)* Assuming a graph $G$ has been defined, $N_{i} := \\\{ v \in V : (i, v) \in E \\\}$ is
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

*Proposition.*  Let $k_0 \in N_0$ an arbitrary zero-neighbor. Then $G$ has a
pseudo Hamiltonian cycle  if and only if $\bigvee_{k \in N_{0}, k \neq k_0}
H'(G_{0}, k_0, k)$. 

This proposition is trivial. Informally, since $0 \to k_0$ is a path for any zero-neighbor
$k_0$, any path $k_0 \to \ldots \to k$ from $k_0$ to another
zero-neighbor describes the pseudo-Hamiltonian cycle $0 \to k_0 \to \ldots \to
k$.

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

From the *Proposition* follows that, for any arbitrary zero-neighbor $k_0$,

$$
f'(G) = \bigvee_{k \in N_{0}, k \neq k_{0}} H'(G_{k_{0}}, k_{0}, k)
$$

is the function that determines whether there is a pseudo Hamiltonian cycle for
graph $G$. 

With $H'$ properly defined, $f'$ solves the simpler problem of finding pseudo
Hamiltonian cycles. Since the only difference between a pseudo
Hamiltonian cycle and a Hamiltonian cycle is that, in the latter, all nodes have
been traversed, we must simply impose this condition to the clause of $H'$ that
returns true (this is, to $a = b$). Since each time we traverse a node we remove
it from $V$ (where $G = (V, E$)), a Hamiltonian cycle will be a pseudo
Hamiltonian cycle with $G_{\text{last}} = \emptyset$, where $G_{\text{last}}$ is
the graph argument of the recursive call that falls in the clause $a = b$.

A bit more formally, let $X(G)$ be a predicate function s.t. $X(G) = 1$ if $V =
\emptyset$, $0$ otherwise. Then we define

$$
H(G, a, b) = \begin{cases}
1 \land X(G)& a=b \newline 
0 & b \not\in V \newline 
\bigvee_{k \in N_{a}} H(G_{a}, k, b) & otherwise
\end{cases}
$$

The same reasoning we used before implies

$$
f(G) = \bigvee_{k \in N_{0}k \neq k_{0}} H(G_{k_{0}}, k_{0}, k)
$$

determines whether there is a proper Hamiltonian cycle for graph $G$.

##### C implementation

For the full `C` implementation, visit the [GitHub
repo](https://github.com/slopezpereyra/hamiltonianCycle). I made heavy use of
custom structs with pointers only to practice memory management. The functions
of interest for us can be understood without reading the full code, if only one
considers that a `graph` is represented as a pair of values `V` and `adj_l`,
where `V` is the number of vertices (`0, 1, ...., V - 1`) and `adj_l` is an
array of pointers to `list`s:

```c
struct _graph {
    int V;
    list *adj_l; // pointer to a list (which is a pointer to _node).
};

typedef struct _graph * graph;
```

Then we implement our backtracking idea as follows.

```c
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

### Graph coloring problem

The graph coloring problem consists of assigning one out of $m$ colors to each
vertex in a graph s.t. no vertex has the same color than a neighboring vertex.
Again, a neighbor of vertex $v$ is defined as any vertex $w$ such that $(v, w)
\in E$. The reader may observe that I like the word neighbor more than the word 
adjacency. 

The general form of this problem consists in arranging a set of a discrete
points so that each transition from one point to another implies a change of
state. 

Let $G = (V, E)$ a graph and $v_s \in V$ a starting vertex. The algorithm will
simply traverse each vertex of the graph, starting at $v_s$, and attempt to
color it with the first candidate color; this is, the first color s.t. no
neighbor is of that color. If at any point the algorithm finds itself in
violation of the problem's constraint, it backtracks.

The mathematical form of the algorithm is the following. Let $v_1, \ldots, v_n$
the vertices in a graph $G = (V, E)$, $c_1, \ldots, c_m$ be the colors to choose
from. Let $\mathcal{S} : \mathbb{N} \to \\{0, 1\\}$ be a predicate s.t.
$\mathcal{S}(G) = 1$ if $G$ has no two neighbors with the same color. Lastly,
let $\mathcal{C}(i, j, G)$ be a function that maps a graph $G$ to an identical
graph $G'$, except that $v'_i$ is colored with color $c_j$.


$$
f(i, G) = \begin{cases} 
    0 & \neg \mathcal{S}(G)\newline
    1 & i = 0\newline 
    \bigvee_{j = 1}^{m} f(i - 1, \mathcal{C}(i, j, G)) &\text{otherwise}
\end{cases}
$$

Evidently, $f(n, G)$ determines the solution to the problem.

The C implementation defines a graph  as an abstract type with two fields.
One is a `_set` field, which is a list of integers implemented with pointers
that cannot contain the same element twice. The other is a `tupleSet` field,
which is essentially the same except that instead of holding integers it holds
integer pairs by means of an abstract type `_edge`. This follows the
mathematical definition of $G = (V, E)$, a set of vertices and a set of
two-tuples. 

```c 
// For reference, the specifications:


// Node in a set of elements
struct _node{
    int elem;
    int color;
    struct _node * next;
};

// Node in a set of tuples
struct _edge{
    int a;
    int b;
    struct _edge * next;
};

typedef struct _node * node;
typedef struct _node * set;
typedef struct _edge * edge;
typedef struct _edge * tupleSet;


// Constructors
set emptySet();
tupleSet emptyTupleSet();

// Operators
set add(set s, int elem);
node findLastNode(set V);
tupleSet addEdge(tupleSet e, int a, int b);
void dumpTupleSet(tupleSet e);
void dumpSet(set e);
```

The implementation was:

```c
struct graph{
    set G;
    tupleSet E;
};

// Wrapper: returns the ith vertex of a graph.
node getVertex(struct graph g, int i){
    node p = g.G;
    for (int j = 0; j < i; j++){
        p = p -> next;
    }return(p);
}

// Determine if the constraint of the problem is violated;
// i.e. if any same-colored neighbors exist in the graph.
bool constraintBroken(struct graph g){
    for (edge p = g.E; p != NULL; p = p->next) {
        node a = getVertex(g, p -> a);
        node b = getVertex(g, p -> b);
        if (a -> color == -1 || b -> color == -1){
            continue;
        }
        if (a -> color == b -> color){
            return(true);
        }
    }
    return(false);
}

// Colors the ith vertex of g with an integer color.
struct graph colorVertex(struct graph g, int vertex, int color){
    node v = getVertex(g, vertex);
    v -> color = color;
    return(g);
}

// Recursive solution using backtracking.
bool colorGraph(struct graph g, int at, int m){

    if (constraintBroken(g) || m < 0){
        return(false);
    }
    if (at < 0 ){
        dumpSet(g.G);
        return(true);
    }

    bool result = false;
    
    for (int i = m; i >= 0; i--){
       result = result || colorGraph( colorVertex(g, at, i), at - 1, m);
       if (result) { return(true); }
    }
    return(false);
}

// Example.
int main(){

    set s = emptySet();
    s = add(s, 0);
    s = add(s, 1);
    s = add(s, 2);
    s = add(s, 3);
    s = add(s, 4);

    tupleSet e = emptyTupleSet();
    e = addEdge(e, 0, 1);
    e = addEdge(e, 0, 2);
    e = addEdge(e, 1, 2);
    e = addEdge(e, 2, 3);
    e = addEdge(e, 3, 4);
    dumpTupleSet(e);

    printf("Starting coloring process...\n");
    struct graph g; g.G = s; g.E = e;
    colorGraph(g, 4, 5);

}

```

The solution found was the following coloring:

```c 
(0, 1), (0, 2), (1, 2), (2, 3), (3, 4),
Starting coloring process...
Vertex 0 with color 3
Vertex 1 with color 4
Vertex 2 with color 5
Vertex 3 with color 4
Vertex 4 with color 5```
```

### $n$-queens

Another paradigmatic problem susceptible to backtracking is placing $n$ queens
in an $n^2$ chessboard in such a way that no queen attacks another. The
formalization of this problem is simpler than that of the previous one. 

We will represent our chessboard with a Boolean matrix $B \in \\{0, 1\\}^{n \times
n}$ be a boolean matrix. Let $\mathcal{P} : \\{0, 1\\}^{n \times n} \times
\mathbb{N}^2 \to \\{0, 1\\}^{n \times n}$ be the *placing* function. This function
is defined s.t. $\mathcal{P}(B, i, j)$ maps to a boolean matrix $B'$ identical
to $B$, except that $B'_{ij} = 1$. By 'setting' the $(i, j)$ coordinate to $1$,
we represent that a queen has been placed at such coordinate.

Assume as well that $\mathcal{C} : \\{0, 1\\}^{n \times n} \times \mathbb{N}^2 \to
\\{0, 1\\}$ is a predicate function defined as follows: $\mathcal{C}(B, i, j) = 1$
if and only if a queen can be placed at $i, j$ in such a way that it attacks no
    other queen. We call this the *candidate* function, since it decides whether
    a particular square in a matrix is a candidate solution.


Lastly, let us define two other predicate functions: $\mathcal{S} : \\{0, 1\\}^{n \times n} \to \\{0,
1\\}$ that maps to $1$ if and only if there is some $i, j$ pair s.t.
$\mathcal{C} (B, i, j) = 1$; and $\mathcal{X}(B)$, that maps to $1$ if and only
if there are $n$ occurrences of $1$ in $B$. Quite clearly,

$$
\mathcal{S}(B) = \bigvee_{i=0}^{n-1} \Big( \bigvee_{j=0}^{n-1} \mathcal{C}(B, i, j)\Big)
$$

For practical purposes, we define the local solution set $\Omega_B$ associated
to a matrix $B$ as follows  $\Omega_B:= \\{(i, j) \in \mathbb{N}^2 :
\mathcal{C}(B, i, j) = 1\\}$. Now, let $f : \\{0, 1\\}^{n \times n} \to \\{0, 1\\}$ a
function and $B$ a square boolean matrix over $\\{0, 1\\}$ of $n^2$ dimension and
with all values set to zero. Then our backtracking algorithm will use the
following recursion:

$$
f(B) = \begin{cases}1 & \mathcal{X}(B) = 1 \newline   
\bigvee_{(i, j) \in \Omega_B} f\big( \mathcal{P} (B, i, j) \big ) \Big) &\mathcal{S}(B) = 1 \newline 
0 & \mathcal{S}(B) = 0   \end{cases}
$$

To be clear, $f$ is true if *some* satisfactory arrangement of $n$ queens was
found; but the case $\mathcal{X}(B) = 1$ is reached *for each* of such
arrangements, which may be many. In the implementation, adding a `print`
operation to the state corresopnding to $\mathcal{X}(B) = 1$ will result in the
display of every possible solution.

##### C implementation

There are only two differences in the implementation. First, $f$ is not a
predicate but a `void` function; it simply prints the solutions found, without
actually returning any value. Secondly, instead of using $0$ to represent no
queen and $1$ to represent a queen, we use $0$ to represent no queen, $8$ to
represent a queen, and $1$ to mark all positions in the board that are
controlled (or attacked) by some queen. This makes the implementation of some
functions simpler. For example, $\mathcal{S}$, or rather its C implementation
`canBeSolved`, returns false when all entries in the matrix are either $1$ or
$8$ (this is, either queens or squares controlled by queens).

For flexibility, we allow the user to define a position `(x, y)` where the first
queen is placed. The algorithm then finds an arrangement that satisfies our
constraint *and* with a queen at `(x, y)`.

```c
#include <stdio.h> 
#include <stdlib.h> 
#include <assert.h>
#include <stdbool.h>

// Struct with 8x8 array as only field.
struct _board {
    int matrix[8][8];
};

typedef struct _board * board;

/* Initializes an empty board 
 * with all entries equal to zero.
 */
board initBoard(){
    board b = (board) malloc(sizeof(struct _board));
    for (int i = 0; i < 8; i++){
        for (int j = 0; j < 8; j ++){
            (b -> matrix)[i][j] = 0;
        }
    }
    return b;
}

/* Determines whether a queen is placed at coordinate (x, y) of a 
 * board.
 */
int hasQueen(board b, int x, int y){
    return ( (b -> matrix)[x][y] == 8 );
}

/* Makes deep copy of a board.
 */
board copyBoard(board b){
    board clone = (board) malloc(sizeof(struct _board));
    *clone = *b;
    return(clone);
}

/* Sets coordinate (x, y) of a board to 1.
 */
void toggle(board b, int x, int y){
    assert(x < 8 && y < 8);
    if (hasQueen(b, x, y)) { return; }
    (b -> matrix)[x][y] = 1;
}

/* Sets coordinate (x, y) of a board to 8, where 8 represents a queen.
 */
void markForQueen(board b, int x, int y){
    assert(x < 8 && y < 8);
    (b -> matrix)[x][y] = 8;
}

/* Prints the matrix of a board.
 */
void dumpBoard(board b){
    for (int i = 0; i < 8; i++){
        for (int j = 0; j < 8; j ++){
            printf("%d  ", (b -> matrix)[j][i]);
        }printf("\n");
    }printf("\n");
}

/* Sets all entries in xth column to one.
 */
void toggleCol(board b, int x){
    assert(x < 8);
    for (int i = 0; i < 8; i++){
        toggle(b, x, i);
    }
}

/* Sets all entries in yth row to one.
 */
void toggleRow(board b, int y){
    assert(y < 8);
    for (int i = 0; i < 8; i++){
        toggle(b, i, y);
    }
}

/* Finds the diagonal that passes through (x, y) from left to right
 * and sets all its entries to 1.
 */
void toggleDiag(board b, int x, int y){
    assert(x < 8 && y < 8);
    int d = y - x, x_start, y_start;
    if (d >= 0){ y_start = d; x_start = 0; }
    else{ y_start = 0; x_start = d * (-1); }
    for (int i = 0; i < 8; i++){
        if (x_start > 7 || y_start > 7){
            break;
        }
        toggle(b, x_start, y_start);
        x_start += 1; y_start +=1;
    }
}

/* Finds the diagonal that passes through (x, y) from right to left
 * and sets all its entries to 1.
 */
void toggleDiagB(board b, int x, int y){
    int x_start, y_start;
    if (x + y >= 7){
        x_start = 7; y_start = x + y - 7;
    }else{
        x_start = y + x; y_start = 0;
    }
    for (int i = 0; i < 8; i++){
        if (x_start < 0 || y_start > 7){
            break;
        }
        toggle(b, x_start, y_start);
        x_start -= 1; y_start +=1;
    }
}

/* Sets (x, y) to 8; the entries of the row, column and diagonals passing
 * through (x, y) are all set to 1.
 */
void placeQueen(board b, int x, int y){
    assert(x < 8 && y < 8);
    toggleCol(b, x);
    toggleRow(b, y);
    toggleDiag(b, x, y);
    toggleDiagB(b, x, y);
    markForQueen(b, x, y);
}

/* Determines if there is place for another queen in a given board.
 */
bool canBeSolved(board b){
    for (int i = 0; i < 8; i++){
        for (int j = 0; j < 8; j ++){
            if((b -> matrix)[i][j] == 0){
                return(true);
            }
        }
    }
    return(false);
}

/* Determines the number of queens in a board.
 */
int queenCount(board b){
    int n = 0;
    for (int i = 0; i < 8; i++){
        for (int j = 0; j < 8; j ++){
            if((b -> matrix)[i][j] == 8){
                n += 1;
            }
        }
    }
    return(n);
}

/* Frees memory of a board and sets its pointer to null.
 */
void destroyBoard(board b){
    free(b);
    b = NULL;
}

/* Backtracking algorithm. Finds and prints all arrangements of eight queens in
 * an 8x8 board s.t. no queen attacks another.
 */
bool nQueen(board b, int x, int y){
    placeQueen(b, x, y);
    if (queenCount(b) == 8){
        dumpBoard(b);
        return(true);
    }
    if (!canBeSolved(b)){
        return(false);
    }

    bool solved = false;
    for (int i = 0; i < 8; i++){
        for (int j = 0; j < 8; j ++){
            if((b -> matrix)[i][j] == 0){
                board subBoard = copyBoard(b);
                solved = nQueen(subBoard, i, j);
                destroyBoard(subBoard);
                if (solved) { return(true); }
            }
        }
    }return(false);
}
```

These are the solutions for three different `(x, y)` arguments.

```c
1  1  8  1  1  1  1  1
1  1  1  1  8  1  1  1
1  8  1  1  1  1  1  1
1  1  1  1  1  1  1  8
8  1  1  1  1  1  1  1
1  1  1  1  1  1  8  1
1  1  1  8  1  1  1  1
1  1  1  1  1  8  1  1

8  1  1  1  1  1  1  1
1  1  1  1  1  8  1  1
1  1  1  1  1  1  1  8
1  1  8  1  1  1  1  1
1  1  1  1  1  1  8  1
1  1  1  8  1  1  1  1
1  8  1  1  1  1  1  1
1  1  1  1  8  1  1  1

1  1  1  8  1  1  1  1
1  1  1  1  1  8  1  1
8  1  1  1  1  1  1  1
1  1  1  1  8  1  1  1
1  8  1  1  1  1  1  1
1  1  1  1  1  1  1  8
1  1  8  1  1  1  1  1
1  1  1  1  1  1  8  1
```
