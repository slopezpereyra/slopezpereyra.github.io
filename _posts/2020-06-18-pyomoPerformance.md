---
layout: post
title: Performance of Pyomo on a Mac 
tags: [Python, Pyomo, Performance]
---
<div style="text-align: justify">
**Fun Fact**: Pyomo runs much faster on computers with SSD hard drive (most Apple Mac computers). 
It is because Python code of Pyomo has to access a solver file and to do that, it has to do some I/O operations, which is faster on SSD hard drive systems. 
The performance here is not minor and I observed in mycase for a particular problem, the code running approximately 8x faster on a MacBook Pro.  
</div>
