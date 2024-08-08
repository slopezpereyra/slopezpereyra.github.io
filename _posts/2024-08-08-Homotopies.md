---
title: Homotopies 
categories: [ Science ]
---

Let $(X, \mathcal{U}_X), (Y, \mathcal{U}_Y)$ two topological spaces. As
in most structures, we say these are homeomorphic if there is a
bijection $f : X
\mapsto Y$ s.t. $f$ and $f^{-1}$ are continuous maps. We must recall
that, in a topological context, a map is continuous iff for any
neighborhood $V$ around $f(x)$ there is a neighborhood $U$ around $x$
satisfying $f(U) \subseteq V$. Informally, all points \"around\" $x$ are
mapped to points \"around\" $f(x)$.

The intuitive idea is that two spaces are homeomorphic when one is a
deformation of the other that involves only stretching and bending
(tearing up or gluing together sections is forbidden). Naturally, if $f$
is a homeomorphism, then it induces a bijection between the set of path
components of $X$ and the set of path components of $Y$.

The notion of equivalence induced by homeomorphisms is stronger than one
might in principle desire. For instance, a disk in $\mathbb{R}^2$ and a
point $\\{ x \\}$ have the same number of path components and
could in some sense be deemed to have the same shape. However, they are
not homeomorphic, since there is no bijective map from the disk to
$\\{ x \\}$.

The \"weak\" notion of equivalence we are looking for is that of a
*homotopy*. Two functions $f, g : X \mapsto Y$ are homotopic if there is
a continuous map $h : X \times [0, 1] \mapsto Y$ s.t.

$$
\begin{aligned}
    \begin{cases}
        h(x, 0) &= f(x)\\\\
        h(x, 1) &= g(x)
    \end{cases}\end{aligned}
    $$

We say $h$ is a homotopy and we write $f \simeq g$ to say they are
homotopic.

The second paramter $t$, ranging from $0$ to $1$, induces a family of
maps that interpolate \"between\" $f$ and $g$. In other words, for each
$t \in [0, 1]$, $h(-, t) : X \to Y$ is a continuous mapping.

We can use the fact that for any
$f \in \mathbb{R}^n, g \in \mathbb{R}^m$, there is a homotopy given by
$h(x, t) = (1 - t)f(x) + t g(x)$ to provide any number of examples.

For example, below I plot the family of functions induced by the 
homotopy between a quadratic and a linear function, followed by the 
surface of the function multivariable $h(x, t)$. The surface plot 
shows how at $t = 0$ and $t=1$ the curve coincides with $f$ and $g$.

<p align="center">
  <img src="../Images/linear_quad_homotopy.gif">
</p>

<p align="center">
  <img src="../Images/surface_homotopy.png">
</p>

Just because, here is a plot of the family induced by the homotopy 
between an exponential function and a polynomial of degree $4$.

<p align="center">
  <img src="../Images/poly_with_exp.png">
</p>

--- 

As a bonus, I provide the code to generate and plot homotopies 
between two arbitrary functions in Julia.

```julia 

function homotopy(f::Function, g::Function, x, t)
    h(x, t) = (1 - t)f(x) + t * g(x)
    return h(x, t)
end

function plot_homotopy(f, g, a, b, step, fname)
    x = a:step:b
    h(x, t) = homotopy(f, g, x, t)
    y_f = [f(xi) for xi in x]
    y_g = [g(xi) for xi in x]
    # Create the plot and save as a GIF
    anim = @animate for t in 0:0.1:1 
        y_h = [h(xi, t) for xi in x]
        plot(x, y_f, label=L"f(x)", ylim=(-5, 20), linewidth=2, color = :purple)
        plot!(x, y_g, label=L"g(x)", linewidth = 2, color=:purple)
        plot!(x, y_h, label=L"h(x, t)", title="Homotopy with " * L"t = 0, 0.1, ..., 1", color=:green)
    end
    gif(anim, fname*".gif", fps = 5)
end

function plot_homotopy_3d(f, g, a, b, step, fname)
    x = a:step:b
    t = 0:0.1:1
    h(x, t) = homotopy(f, g, x, t)
    # Compute the z values for the homotopy function
    z = [h(xi, ti) for xi in x, ti in t]
    p = surface(z, xlabel=L"t/10", ylabel=L"x", zlabel=L"h(x, t)")
    savefig(p, fname*".png")
    open("example.html", "w") do io
        PlotlyBase.to_html(io, p)
    end  
end

# Example 

plot_homotopy_3d(x -> x^4 + 2*x^3 - 3*x^2 - x + 1, 
            y -> exp(y), 
              -10, 10, 0.1, "poly_with_exp")


```

---

Our weak notion of equivalence thus emerges, considering maps
$f : X \mapsto Y$ that admit continuous inverses up to homotopy. In
particular, if $X, Y$ are topological spaces, we say they are homotopy
equivalent if $f, g$ are continuous and

$$f\\circ g \\simeq \\mathbb{I}_Y ~ ~ ~ ~ ~ ~ g \\circ f \\simeq \\mathbb{I}_X$$

In other words, to spaces are homotopy equivalent if we can map one onto
the other, and if their compositions result in the identity.

On one hand, any spaces which are homeomorphic are homotopy equivalent.
But take our problematic case of $\\{ x \\}$ and
$B_\epsilon(x)$ a disk with radius $\epsilon$ around $x$. The inclusion
$i : \\{ x \\} \mapsto B_{\epsilon}(x)$ and the constant map

$$p : B_\\epsilon(x) \\to  \\{ x \\}$$

induces a homotopy equivalence. Evidently,

$$( p \\circ i )(x) = p(i(x)) = p(x) = x$$

Now, we can prove $i \circ p \simeq \mathbb{I}_{ B_\epsilon(x) }$ by
defining the radial contraction

$$h( (r, \\theta), t ) = (tr, \\theta)$$

using polar coordinates. This contraction is equal to the disk when
$t = 0$, "shrinks" it around its center as $t$ increases, and is equal
to the point when $t = 1$. This proves that $i \circ p$ is homotopic to
the identity.
