---
layout: post
title: SCIP - An open source solver for MIP, MINLP 
tags: [Python, Pyomo, SCIP, ipopt]
---

[Pyomo](https://pyomo.readthedocs.io/en/stable/) has been my #1 choice for optimization projects for quite some time. A while ago, I was attempting to solve a certain NLP problem and wanted to try out open source solvers apart from [ipopt](https://coin-or.github.io/Ipopt/), which is in 90% of the cases is a default choice - often serving as a benchmark. My primary curiosity was to improve the ipopt solutions. Simultaneously, I wanted to add another solver to my existing suite. 

I stumbled onto a solver called [SCIP](https://www.scipopt.org/index.php#about) through google search and was surprised to notice that Pyomo already came with a provided python interface for SCIP. SCIP is freely available for research purposes. The installation procedure of SCIP was slightly non-trivial but in the end it was accomplished via provide information on the website and a bit of google search. Once locked and loaded, it was not difficult to run this from Pyomo. 

```python
from pyomo.opt import SolverFactory
solver     =  'scip'               
solver_io  =  'nl'                  
opt        =   SolverFactory(solver, solver_io = solver_io)
opt.options['max_iter'] = 50

# define a model object
model     =  ConcreteModel()

opt.solve(model)
```

My first impressions were that for my particular problem, the performance in terms of solution quality were similar for both ipopt and SCIP for majority of scenarios, although SCIP would occasionally render comparably better solutions. SCIP also greatly eliminated the number of infeasible scenarios compared to ipopt.    

The solver information rendered out in SCIP is quite granular (ipopt there is still better), and that helps quite a bit. Their website states: 

> It allows for total control of the solution process and the access of detailed information down to the guts of the solver.

Compared to ipopt, one thing I noticed was that SCIP was roughly 2.0x slower. This can be a deal breaker if you have millions of scenarios to run and on top of it if the solution differences are nominal. The [slowness of SCIP](https://or.stackexchange.com/a/6796/113) and its cause is however recognized already.   

The information provided here might be very problem specific but I hope this motivates you to give SCIP a shot for your problem.

 