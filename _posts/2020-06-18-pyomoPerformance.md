---
layout: post
title: Performance of Pyomo on a Mac 
tags: [Python, Pyomo, Performance]
---
Fun Fact: Pyomo runs much faster on computers with SSD hard drive (most Apple Mac computers). I discovered it accidently.  
It is because Python code of Pyomo has to access a solver file and to do that, it has to do some I/O operations, which is faster on SSD hard drive systems. Example for IPOPT:

> Pyomo default behavior is to write an `*.nl` file, then to call IPOPT to process that file and produce a `*.sol` file. Pyomo then parses back in the `*.sol` file.

The performance here is not minor and I ran the same piece of code on both Windows PC (32 GB RAM, Windows 10) and Macbook Pro (4GB RAM, Catalina) and found the code to be roughly 5 times faster on Mac.
