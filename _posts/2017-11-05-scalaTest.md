---
layout: post
title: Scala 01 - Basics and Syntax
tags: [Scala begineer]
---

<style>
body {
text-align: justify}
</style>

Scala is an object-oriented ***functional programming*** language where the two concepts are closely interwined. In scala, a function value is an object. Function types are classes that can be in herited by subclasses.  


```scala
  In [1]:
  val a = 2
  val b = 3
  println(a + b)
```
5

```
  Out[1]:
  a: Int = 2
  b: Int = 3
```

## Variables in Scala
Scala has two kinds of variables: *vals* and *vars*. A val is similar to a final variable in Java. Once initialized,  a val can never be reassigned. A var, by contrast, is similar to a non-final variable in Java. A var can be reassgined throughout its lifetime. Here is a val definition: 

```scala
  In [1]:
  val msg = "Hello, world!"
```

```
  Out [1]:
  msg: String = "Hello, world!"
```
Note that while creating the variable msg, we did not specify the type of it. This illustrates an important concept in Scala: *type inference*. Scala's ability to figure out types you leave off. Just by the initialization, Scala figured out the type of msg to be String. However, there are some special cases where you have to explicitly mention the types. This is dure to Scala's *local type inference* and we will talk about this in the future posts.

What you can't do with ``msg`` given that it is a val, is reassign it. 

```scala
  In [2]:
  msg = "Bye, world!"
```
```
  cmd2.sc:1: reassignment to val
  val res2 = msg = "Goodbye world!"
  Compilation Failed
```
Vars in the other hand allow reassignment.

```scala
  In [3]:
  var greeting = "Hello, world!"
```

```
  Out [3]:	
  greeting: String = "Hello, world!"
```
<br>

```scala
  In [4]:
  var greeting = "Bye, world!"
```

```
  Out [4]:
  greeting: String = "Bye, world!"
```

## A function definition
```scala
  In [5]:
  def max(x: Int, y: Int): Int = {
    if(x > y) x
    else y
  }
```
Function definition starts with `def`. The function name max follows next, following which is a comma-seperated list of parameters in parenthesis. A type annotation must follow every function parameter. This is due to Scala's local type inference. The ': Int' after the parameter list type-annotates the function return value.

The equal sign in the function definition above points to that in a functional world view, **a function defines an expression** that returns a value. 