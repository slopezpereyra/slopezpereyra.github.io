---
title: Notes on computational neuroscience
categories: [ Science ]
---

## Neuron simulation

### Non-NMDA Synapses

The following model was found to suit the experimental data appropriately.

$$
\begin{align}
\Delta V_m^{\text{non-NMDA}} = w ~ t\exp(\frac{-t}{t^{\text{peak}}})
\end{align}
$$

Here, $w$ modulates the efficiency of the synapses and $t^{\text{peak}}$ the
time of the peak in the signal. Inhibitory postsynaptic potentials simply
contain a negative efficiency parameter $w$. 

A quick Julia implementation. 

```julia
function ΔVₘ(w::Number, t::Number, peak::Number)
    """Non-NMDA neuron EPSP and IPSP basic model. 
    
    Observe that ΔVₘ measures change and hence its output is 
    a relative PSP. (Relative to the membrane potential of the 
    postsynaptic neuron at the moment the excitatory signal is 
    received.)

    The time required for such signal to be received (neurotransmitter
    liberation, difussion of neurotransmitters, opening of the ion gates)
    is not included in the model.
    """
    w * t * exp(-t/peak)
end
```

Using this function in Julia we can generate synthetic signals. For example,
simulating an EPSP with $w = 1, t^{\text{peak}} = 3$, and an IPSP with $w = -2,
t^{\text{peak}} = 1$, we obtain:

<p align="center">
  <img src="https://i.ibb.co/HTkJ0PG/Screenshot-from-2023-03-26-00-58-04.png"/>
</p>

### NMDA Synapses

NMDA synapses are excitatory synapses. Their rise time is $\approx 10$ times
slower than non-NMDA synapses. They are voltage dependent as well. A function
used to model the time and voltage dependence of EPSP for NMDA synapses is 

$$
\begin{align*}
    ΔV_m^{\text{NMDA}} = c(V_m)\exp(-\frac{t}{\tau_1}) - \exp(-\frac{t}{\tau_2})
.\end{align*}
$$

Here, $\tau_1, \tau_2$ are time scale parameters, and $c(V_m)$ is an amplitude
dependent on the membrane potential at the time of the stimulation.

It is important to remember that the NMDA ion channels are opened only after
postsynaptic neurons have been excited; this is, after the membrane potential
was increased by other ion channels. The reason is that NMDA channels in resting
state are blocked by magnesium ions ($\text{MG}^{2\text{+}}$), which are to be
removed before sodium ($\text{Na}^{\text{+}}$) and calcium
($\text{Ca}^{2\text{+}}$) can enter the neuron through them. This will be
important in future considerations.

## The Hodgkin-Huxley model 

### Outline of the model

The Hodgkin-Huxley model is a set of equations that provide a mathematical
description of action potentials at the single-neuron level. The picture they
depict is rather complete, in the sense that they describe the ion flow through
the membrane, the conductance of the ion channels, the membrane potential, and
the relationships among the three. It is through the establishment of these
mathematical relations that the model provides a satisfying abstraction of how
action potentials are initiated and propagated at the single-neuron level.

### A quicky review of the minimal mechanisms 

At least two types of voltage-dependent ion channels are required to evoke an
action potential in a neuron. Sodium channels open up in response to an
increase of the membrane potential —for example, due to the opening of
neurotransmitter-gated ion channels and subsequent depolarization—. The influx
of $\text{Na}^{\text{+}}$, due to the lower concentration of this ion in the
interior of the cell, brings the membrane closer to the sodium resting
potential of $\approx +65 \text{mV}$.  This is the mechanism behind the rising
phase of the action potential. This rise in membrane potential provokes two
separate but simultaneous phenomena, both occurring about $1 \text{ms}$
after the opening of the sodium channels: 

- $i.$ A protein blocks the sodium
channels, stopping the influx of this ion; 
- $ii.$ voltage-dependent potassium channels open, and a subsequent efflux of
  $K^{+}$ drives the membrane potential towards its related potassium resting
  potential, $\approx -80 \text{mV}$.

The resulting hyperpolarization causes both voltage-dependent channels to close,
which restores the neuron to its resting state.

—-

**Note**. I omitted the important role of ion pumps, leakage.

### Hodgkin-Huxley equations 

Let $E_{\text{ion}}$ be the equilibrium potential of a certain ion,
$I_{\text{ion}}$ the net flow of a certain ion across the membrane, and
$g_{\text{ion}}$ the conductance of a certain ion. Then 

$$
\begin{align*}
    I_{\text{ion}} = g_{\text{ion}}(V - E_{\text{ion}})
.\end{align*}
$$

This equation is fairly easy to comprehend. Now, with $n$ the activation of the
potassium channel, $m$ the activation of the sodium channel, and $h$ the
inactivation of the sodium channel, the conductance of the channels is
described by

$$
g_k = g^{\max}_{K} n^4
$$

$$
g_{\text{Na}} = g^{\max}_{\text{Na}} m^3 h
$$

where $g^{\max}_{\text{ion}}$ is the maximum conductance. Here, $n, m, h$ are
modulation factors around maximum conductances. Which I suppose implies they are
in the real interval $[0, 1]$?

In any case, the dynamics of these conductances are given by the differential
equation 

$$
\begin{align*}
    \frac{dx}{dt} = -\frac{1}{\tau_x(V)}(x - x_0(V))
.\end{align*}
$$

where $x$ can be substituted by $n, m$ or $h$. I will not explain in detail
right now the functional relation of $\tau_x$ and $x_0$ with $V$.

Now, we move towards a description of the general dynamics of the membrane
potential with respect to all previous factors. A preliminary —and rather
conceptual step— is to conceive the neuron as a capacitor —in simplified
terms, as something that can store an electric charge. We wish to describe the
change $\frac{dq}{dt}$ across time, where $q$ is the charge held. But the cause
of charge variation is the current flow through the ion channels, which produces
depolarization and hyperpolarization. Then $\frac{dq}{dt} = I$, the net (total)
ion flow. 

For any capacitor, we know $q = CV$. It follows $\frac{dq}{dt} = C
\frac{dV}{dt} = I_c$ is the *capacitive current*. But, according to Kirchoff's
law, 

$$
\begin{align*}
    I_c + I_\text{K} + I_{\text{Na}} + I_{\text{L}} = 0
.\end{align*}
$$

From this follows

$$
\begin{align*}
    C \frac{dV}{dt} = - \sum_{\text{ion}} I_{\text{ion}} ~ + I(t)
.\end{align*}
$$

where $I(t)$ describes external currents not accounted for the sodium, potassium
or leakage channels (for example, such as neurotransmitter-gated channels). This
is the *Voltage equation*, and it is a beautiful description of the natural
change in voltage across time in terms of all the factors we have discussed
before.

---------
#### Notation summary 

$$
\begin{align*}
        &V : \text{Voltage, membrane potential} \newline
        &I_{\text{ion}} : \text{Ion flow across membrane} \newline
        &g_{\text{ion}} : \text{Conductance of ion} \newline
        &E_{\text{ion}} : \text{Equilibrium potential of ion} \newline
        &C : \text{Capacitance of the neuron, understood as a capacitor} \newline
        &q : \text{Charge of the neuron, understood as a capacitor} \newline
\end{align*}
$$

One does well in remembering that for a capacitor we have $C = \frac{q}{V}$.

-------------

### Simulating action potentials with Hodgkin-Huxley's model 

We can implement the model we described above in Julia. For numeric integration
of the partial differential equations that describe the dynamics of the
conductances, we use Euler's method. One must simply observe that with

$$
\begin{align*}
    \frac{dx}{dt} = -\frac{1}{\tau_x(V)}(x - x_0(V))
.\end{align*}
$$

one arrives at the discretized form

$$ 
\begin{align*}
    x(t + \Delta t) &= x(t) + \Delta t \Big( -\frac{1}{\tau_x} (x(t) - x_0) \Big) \\ 
                    &= x(t)(1 - \frac{\Delta t}{\tau_x}) - \frac{\Delta
                    t}{\tau_x}x_0
\end{align*}
$$

```julia 
function hh()
    
    # Maximual conductances for K, Na, R.
    gmax = [36, 120, 0.3]

    # Battery voltages, equilibrium potentials
    E = [-12, 115, 10.613]
    
    # I_ext is the external current; 
    # x holds the n, m, h variables (conductances of 
    # the different ion channels). 
    I_ext = 0; V = -10; x = [0, 0, 1];
    dt = 0.01
    x_plot = []; y_plot = [];

    for t in range(-30, 250, step=dt)
        # Turn external current on or off according to time.
        if t == 10  I_ext = 10 end
        if t == 200 I_ext = 0 end

        # Alpha functions 
        α₁ = (10 - V)/(100 * (exp((10 - V)/10) - 1))
        α₂ = (25 - V) / (10 * (exp((25-V)/10) - 1)) 
        α₃ = 0.07 * exp(-V/20)
        α = [α₁, α₂, α₃]

        # Beta functions
        β₁ = 0.125 * exp(-V/80)
        β₂ = 4 * exp(-V/18)
        β₃ = 1 / (exp((30 - V)/10) + 1)
        β = [β₁, β₂, β₃]

        # τₓ and x₀
        τₓ = 1 ./ (α + β)
        x₀ = α .* τₓ

        # Leaky integration with Euler method.
        # See formula above.
        x = (1 .- dt ./ τₓ) .* x + dt ./ τₓ .* x₀

        # Compute conductances 
        g = [gmax[1] * x[1]^4, gmax[2] * x[2]^3*x[3], gmax[3]]

        # Ohm's law 
        I = g .* (V .- E)

        # Update voltage (membrane potential) 
        V += dt * (I_ext - sum(I))

        if t >= 0 
            push!(x_plot, t)
            push!(y_plot, V)
        end 
    end
    plot(x_plot, y_plot, label="Membrane potential")
    xlabel!("t")
    ylabel!("V")
end
```

<p align="center">
  <img src="https://i.ibb.co/0X1PxCB/Screenshot-from-2023-03-27-11-29-42.png"/>
</p>

