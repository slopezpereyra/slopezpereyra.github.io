--- 
title: A tricky probability problem from Jane Street 
categores: [ Science, Personal ]
---

### The problem

The problem, as stated in Jane Street, goes as follows:

> Great news! The variety of robotic competition continues to grow at breakneck
pace! Most recently, head-to-head long jump contests have been all the rage.
<br><br>
These contests consist of rounds in which each robot has a single attempt to
score. In an attempt, a robot speeds down the running track (modeled as the
numberline) from 0, the starting line, to 1, the takeoff point. A robot moves
along this track by drawing a real number uniformly from [0,1] and adding it to
the robot’s current position. After each of these advances, the robot must
decide whether to jump or wait. If a robot crosses the takeoff point (at 1)
before jumping its attempt receives a score of 0. If the robot jumps before
crossing 1, it draws one final real number from [0,1] and adds it to its current
position, and this final sum is the score of the attempt.<br><br>
In a head-to-head contest, the two robots each have a single attempt without
knowing the other’s result. In the case that they tie (typically because they
both scored 0), that round is discarded and a new round begins. As soon as one
robot scores higher than the other on the same round, that robot is declared the
winner!<br><br>
Assume both robots are programmed to optimize their probability of winning and
are aware of each other’s strategies. You are just sitting down to watch a
match’s very first attempt (of the first round, which may or may not end up
being discarded). What is the probability that this attempt scores 0? Give this
probability as a decimal rounded to 9 digits past the decimal point.

---




Let $f(x, n)$ a function that maps to an arbitrary criteria $x \in [0, 1]$
the probability that $x$ is not surpassed by the sum of $n \in \mathbb{N}$ draws
from a standard uniform distribution. In other words, 

$$
\begin{align*}
    f(x, n) = P(Y_n \leq x - Z), ~ \text{with } ~ Z = \sum^{n-1}_{i=1} Y_i, ~ ~Y_i
    \sim U(0, 1)
.\end{align*}
$$

Observe that not surpassing the criteria $x$ with the sum of $n$ terms is
conditional on not surpassing it with the sum of the first $n-1$ terms. Then,
according to the law of total probability, 

$$
\begin{align*}
    P(Y_n \leq x - Z) &= \int_{\mathbb{R}} P(Y_n \leq x - Z \mid Z = t)P(Z = t)
    dt \\ 
                      &= \int_0^x (x - t) P(Z = t) dt
.\end{align*}
$$

Observe that the function above describes the probability of $\sum Y_i$ taking
any value less than or equal to $x$. Then $f(x, n)$ is the CDF of $\sum Y_i$,
*at least on the interval* $[0, 1]$ (this is, the domain of $f$ for $x$). 

It is trivially observable that $f(x, 1) = x$. The statement above along with
this result implies that the PDF of $Y_1$, at least in the interval of
interest, is $\frac{d}{dx}x = 1$ (something you probably already knew). Then 

$$
\begin{align*}
    f(x, 2) &= \int_0^x (x-t)(1)dt \\ 
            &= \frac{x^2}{2}
.\end{align*}
$$

Now, here's the importance of having pointed out that we had derived a PDF from
the result of the first cumulative probability. The same reasoning implies that
the PDF of $Z = Y_1 + Y_2$ is $x$ and then (by repeated application of this
logic)

$$
\begin{align*}
    f(x, 3) &= \int_0^x (x-t)t dt = \frac{x^3}{6} \\ 
    f(x, 4) &= \int_0^x (x-t) \frac{t^2}{2} dt = \frac{x^4}{24} \\
            &\ldots  \\
    f(x, n) &= \int_0^x (x-t)\frac{d}{dx}f(x, n-1)(x := t) dt = \frac{x^n}{n!}
.\end{align*}
$$

(The notation $(x := t)$ makes it explicit that $\frac{d}{dx}f(x, n-1)(t)$ is
*not* the product of the derivative of $f$ and $t$, but the derivative of $f$
*evaluated at* $t$.)

<p align="center">
  <img src="https://i.ibb.co/YDZXxY6/Screenshot-from-2023-04-10-21-27-28.png">
</p>

---

We have arrived at a general expression for the probability that the sum of $n$
uniform random variables do not surpass a certain $x$ assuming $x \in [0, 1]$.
In fact, what we have done is found a derivation for the Irwin-Hall distribution
in the domain of interest by means of the law of total probability.

If $Win$ denotes the event of eventually falling within the jumping zone, then
it is straightforward to reason that

$$
\begin{align*}
    P(Win) = (1-x)\sum_{i=1}^\infty \frac{x^n}{n!} = (1-x)e^x
.\end{align*}
$$

To formulate the probability of falling withing the jumping zone as a function
of $x$ is a major accomplishment, and one might say the problem is relatively
simple from here on. All that is left is to provide a sound payoff function
using this probability and an expected score for each $t$ in the jumping zone.

Now, if we assume the robot fell within the jumping zone at point $t$, the
expected score is $t +\frac{1}{2}$. So we may compute the expected score as a
function of $x$ in two ways. Firstly, by using the definition of expected value,
where 

$$
\begin{align*}
    \mathbb{E}(S) &= \int_x^1 \frac{t + \frac{1}{2}}{1-x} dt \\ 
         &= \frac{x+2}{2}
.\end{align*}
$$

or equivalently 

$$
\begin{align*}
    \mathbb{E}(S) &= \int_x^2 \frac{t}{2-x}dt \\ 
         &= \frac{x+2}{2}
.\end{align*}
$$

Secondly (and more simply), a geometric observation is that the expected $t$
point within the jumping zone is $x + \frac{1-x}{2}$, and then 


$$
\begin{align*}
    E(x) &= x + \frac{1-x}{2} + 0.5 \\ 
         &= \frac{x+2}{2}
.\end{align*}
$$

Then, the payoff function of this game is given by 

$$
\begin{align*}
    g(x) = (1-x)e^x\Big(\frac{x+2}{2}\Big)
.\end{align*}
$$

<p align="center">
  <img src="https://i.ibb.co/Wk15q7G/Screenshot-from-2023-04-10-21-51-33.png" alt="Alt text">
</p>

The following steps are relatively simple, and are matter of computation more
than reasoning. One computes the derivative of this function and finds its
maximum, which is at $x = \frac{\sqrt{13} - 3}{2}$. Since such $x$ is the best
policy, then one uses the fact that $1 - P(Win) = 1 - (1-x)e^x = P(Loosing)$ to
find the probability of losing given this optimization. I skip this calculations
because they are unessential to the problem.


