--- 
title: A probability problem from Jane Street 
categories: [ Science ]
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
    dt \newline 
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
    f(x, 2) &= \int_0^x (x-t)(1)dt \newline 
            &= \frac{x^2}{2}
.\end{align*}
$$

Now, here's the importance of having pointed out that we had derived a PDF from
the result of the first cumulative probability. The same reasoning implies that
the PDF of $Z = Y_1 + Y_2$ is $x$ and then (by repeated application of this
logic)

$$
\begin{align*}
    f(x, 3) &= \int_0^x (x-t)t dt = \frac{x^3}{6} \newline 
    f(x, 4) &= \int_0^x (x-t) \frac{t^2}{2} dt = \frac{x^4}{24} \newline
            &\ldots  \newline
    f(x, n) &= \int_0^x (x-t)\frac{d}{dx}f(x, n-1)(x := t) dt = \frac{x^n}{n!}
.\end{align*}
$$

<p align="center">
  <img src="https://i.ibb.co/YDZXxY6/Screenshot-from-2023-04-10-21-27-28.png">
</p>

---

We have arrived at a general expression for the probability that the sum of $n$
uniform random variables do not surpass a certain $x$ assuming $x \in [0, 1]$.
In fact, what we have done is found a derivation for the [Irwin-Hall
distribution](https://en.wikipedia.org/wiki/Irwin%E2%80%93Hall_distribution) in
the domain of interest by means of the law of total probability.

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
    \mathbb{E}(S) &= \int_x^1 \frac{t + \frac{1}{2}}{1-x} dt \newline 
         &= \frac{x+2}{2}
.\end{align*}
$$

or equivalently 

$$
\begin{align*}
    \mathbb{E}(S) &= \int_x^2 \frac{t}{2-x}dt \newline 
         &= \frac{x+2}{2}
.\end{align*}
$$

Secondly (and more simply), a geometric observation is that the expected $t$
point within the jumping zone is $x + \frac{1-x}{2}$, and then 


$$
\begin{align*}
    \mathbb{R}(x) &= x + \frac{1-x}{2} + 0.5 \newline 
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

To be sure, I created a Julia simulation of the game. It has a robot play the
game a great number of times over the linear range $[0, 1]$ (with infinitesimal
discrete steps). Each blue point is the average score of the robot on a given
value of $x$ across a great number of simulations. With enough simulations per
$x$, we observe the experimental mean score almost exactly coincides with our
analytic result of $x = \frac{\sqrt{13} - 3}{2} = 0.3028$.

<p align="center">
  <img src="https://i.ibb.co/xggy5Hr/Screenshot-from-2023-04-11-02-37-18.png" alt="Alt text">
</p>

For the curious, I attach the code of the simulation.

```julia 
function sim_round(λ, iters=10_000)
    """Simulates a round of the game under a specific criteria λ 
    (the equivalent of x in our math notation)"""

    results = []
    for i in range(1, iters)
        x = 0 
        while true 
            x = x + rand() # Uniform standard
            if x >= λ && x < 1
                push!(results, x += rand())
                break
            end
            if x > 1 
                push!(results, 0)
                break 
            end
        end
    end
    return results
end

function sim_across_criteria(iters_per_sim)
    """Simulates a given number of rounds across the domain [0, 1] for λ."""

    costs = [] 
    x = LinRange(0, 1, 10000)
    for i in x 
        simulations = sim_round(i, iters_per_sim)
        mean_score = sum(simulations)/length(simulations)
        push!(costs, mean_score)
    end 
    return (x, costs)
end

# Run and plot the simulation

x, y = sim_across_criteria(10_000)
max_exp = maximum(y) # Maximum mean score
x_max = x[findfirst(x -> x == max_exp, y)] # x value of maximum mean score

plot(x, y, label="Mean score")
vline!([0.3028], linestyle=:dash, label="Analytic optimum")
scatter!([x_max], [max_exp], markersize=2, color=:red, label="Experimental maximum")
plot!(legendfontsize=6)
```



