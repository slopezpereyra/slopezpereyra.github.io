---
title: Another Jane Street problem
categories: [ Science ]
---

### The problem 

> The Robot Weightlifting World Championship was such a huge success that the
organizers have hired you to help design its sequel: a Robot Tug-of-War
Competition! <br><br> 
In each one-on-one matchup, two robots are tied together with a rope. The center
of the rope has a marker that begins above position 0 on the ground. The robots
then alternate pulling on the rope. The first robot pulls in the positive
direction towards 1; the second robot pulls in the negative direction towards
-1. Each pull moves the marker a uniformly random draw from [0,1] towards the
pulling robot. If the marker first leaves the interval [‑½,½] past ½, the first
robot wins. If instead it first leaves the interval past -½, the second robot
wins. <br><br>
However, the organizers quickly noticed that the robot going second is at a
disadvantage. They want to handicap the first robot by changing the initial
position of the marker on the rope to be at some negative real number. Your job
is to compute the position of the marker that makes each matchup a 50-50
competition between the robots. Find this position to seven significant
digits—the integrity of the Robot Tug-of-War Competition hangs in the balance!

### The solution 

Let $f(x)$ a function that maps to an initial flag position $x$ the probability
that the first robot ($R_1$) wins. We know such function obeys $f(\frac{1}{2}) =
1$.

We can model the probability that $R_2$ does not win on his first pull as

$$
\begin{align*} 
    P(R_2 \text{ does not win on first pull}) &= \int_{x}^\frac{1}{2} P(R_2 \text{ does not win } | y = t)P(y = t) dt \newline
    &=\int_{x}^\frac{1}{2}(\frac{1}{2} + t) dt
\end{align*}
$$

where $y$ is the flag position after the first pull by $R_1$.

Assume, for the moment, that $R_1$ did not win on his first pull. Then $y$
exists in the interval $[x, \frac{1}{2}]$. The key to this problem is to observe
that the probability of $R_2$ eventually winning with the marker at $y$ on his
first pull is the same probability that $R_1$ wins with the marker's initial
position set to $-y$. In other words, 

$$
    P(R_2 \text{ wins with first pull at } y ) = f(-y)
$$

It follows from the two observations above that 

$$
\begin{align}
    f(x) &= (\frac{1}{2} + x) + \int_x^\frac{1}{2} (1 - f(-y)) dy \newline
        &= 1 - \int_{x}^{\frac{1}{2}} f(-y)dy
\end{align}
$$

If we take the derivative of this, using the fundamental theorem of calculus we
obtain 

$$
\begin{align}
    f'(x) = f(-x)
\end{align}
$$

This is the first major accomplishment in the problem. But the thing does not
end here. One must now observe (which requires some intuition) that, using the
chain rule, we have

$$
\begin{align}
    f''(x) = f'(-x) = -f(x)
\end{align}
$$

So we observe that $f$ has very peculiar properties. The differential equation
above has solutions 

$$
f(x) = A\sin(x) + B\cos(x)
$$

But remember that we know $f(\frac{1}{2}) = 1, f'(0) = 0$. From the first fact,
it follows that $A \sin(0.5) + B\cos(0.5) = 1$, and from the latter we have $A =
B$. So combining both results we obtain

$$
A = \frac{1}{\sin(0.5)+\cos(0.5)}
$$

Then

$$
f(x) = \frac{\cos x + \sin x}{\sin(0.5) + \cos(0.5)}
$$

Now we can use a calculator to observe that $f(x) = 0.5 \iff x = -0.2850\ldots$,
and we have found the $x$ that equalizes the winning chances for both robots.

### Simulating the game in Julia 

To evaluate our solution, we can simulate the game with two simple Julia
functions. 

```julia 
function sim_round(p₀, iters::Int=10_000)
    results = []
    for i in range(1, iters)
        p = p₀
        modifier = 1
        while abs(p) <= 0.5
            p += modifier * rand()
            modifier *= (-1)
        end
        result = p > 0.5 ? 1 : -1
        push!(results, result)
    end
    return results
end

function sim(iters_per_sim=10_000)
    avgs = [] 
    x = LinRange(-1, 1, 1000)
    for i in x 
        simulations = sim_round(i, iters_per_sim)
        mean_score = sum(simulations)/length(simulations)
        push!(avgs, mean_score)
    end 
    return (x, avgs)
end

x, y = sim(100_000)

scatter(x, y, markersize=1.5, label="Mean simulation score")
scatter!([-0.2850], [0], markersize=3, color=:red, label="Analyic balance")
hline!([0], linestyle=:dash, label="Experimental balance")
```
<p align="center">
  <img src="https://i.ibb.co/CMyM6q8/Screenshot-from-2023-04-12-20-06-41.png" alt="Alt text">
</p>


The code simulates $100.000$ tug-of-war games per each initial position $x$ (in
the code, $p_0$). On each game, a score of $1$ means the first robot won, and a
score of $-1$ means the second robot won. It takes the average score of these
competitions and plots them. We put a red dot in what is supposed to be the
equilibrium point, according to our analytic result, and a dashed line across
the actual experimental equilibrium. We can see that the line and the dot
coincide, and $0.2850$ is the point where both robots have equal chances (or,
equivalently, where average scores across time tend to $0$).

