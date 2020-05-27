---
layout: post
title: Edit-Compile-Debug
tags: [Cpp]
---

Often, while debugging, it is a good practice to
correct errors in the sequence they are reported. Often a single error can
have a cascading effect and cause a compiler to report more errors than
actually are present. It is also a good idea to recompile the code after each
fix—or after making at most a small number of obvious fixes. This cycle is
known as edit-compile-debug