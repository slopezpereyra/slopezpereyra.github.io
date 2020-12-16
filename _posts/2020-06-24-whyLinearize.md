---
layout: post
title: Why Linearize in Optimization?
tags: [Operations-Research]
---

<div style="justify-align: right">
In Operations Research, there exist some very good algorithms for solving certain classes of well-structured convex optimization problems. One such class is of linear programs i.e. linear programming models. The algorithms for these optimization problems can very efficiently do the job of solving.

Operations Research also provides good algorithms for optimization problems in which some or all of the variables are integer, but would otherwise be well-structured and convex. This includes mixed-integer programs, which are linear programs that include integer variables. These problems are more difficult to solve.

So given that we are very good at solving linear programs and mixed-integer programs, it makes sense to attempt to linearize non-linear problems to make them fit in this framework. This allows us to solve these problems with the existing machinery.

If the non-linear problem is not convex, it is probably not possible to find an equivalent linear program. However, we might be able to obtain an equivalent mixed-integer problem. On this site, there are plenty of questions about linearization in which the answers introduce binary variables to model the non-linearity.

If someone is interested in finding an equivalent representation of the non-linear program, linearization then allows to get the same global optimum, but faster. If you approximate non-linear functions by (piece-wise) linear ones, global optimality is no longer guaranteed.
</div>
 

