---
layout: post
title: Tips on Speeding up Python Codes
tags: [Python, Performance]
---

A while ago, I had to speed up a Python code. I learnt a few things about speeding up Python codes. I am sharing them with you. Perhaps you find them useful:

0. Profile First, where is time consumed most using time, cProfile or line_profiler

1.  Replace Pandas operations with Numpy operations wherever possible.
2.  While defining placeholder Numpy arrays, specify the dtype.
3.  Use ndarray instead of recarray, structured array etc.
4.  Vectorize the code if possible. This is major.
5.  Multiple Numpy function can do some same job. Compare which Numpy function gives better performance.
6.  Sometimes, you might have to write your own lower level Numpy function for better performance rather than use the ready made library method.
7.  If sorting is happening somewhere, you are in game for better speed gains. Try np.searchsort().
8.  Use Numba. It works like magic.
9.  Put pre-processing stuff in a separate function. Do calculation only once, which are not changing.