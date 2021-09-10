---
layout: post
title: Making Python Codes Performant
tags: [Python, Performance]
---
<div style="text-align: justify">
A while ago, I had to speed up some Python code. I learnt a few things about speeding up Python codes that I am sharing (in no particular order, but the couple major ones are underlined). Perhaps you find them useful:
</div>


- Profile First, where is time consumed most using time, `cProfile` or `line_profiler`
- Replace `Pandas` operations with `Numpy` operations wherever possible.
- While defining placeholder `Numpy`arrays, specify the `dtype`.
- Use `ndarray` instead of `recarray`, structured array etc.
- <u>Vectorize the code if possible. This is major.</u>
- Multiple `Numpy` function can do some same job. Compare which `Numpy` function gives better performance.
- Sometimes, you might have to write your own lower level `Numpy` function for better performance rather than use the ready made library method.
- If sorting is happening somewhere, you are in game for better speed gains. Try `np.searchsort()`.
- <u>Use `Numba`</u>. If you can make it work, it works like magic. Sometimes, you might have to alter your code slightly to make it `Numba` compatible as only the listed libraries on their documentation are supported. 
- Put pre-processing stuff in a separate function. Do calculation only once, which are not changing.