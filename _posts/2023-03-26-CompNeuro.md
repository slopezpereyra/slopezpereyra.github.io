---
title: Notes on computational neuroscience
categories: [ Science ]
---

## Neuron simulation

### Excitatory and inhibitory postsynaptic potentials 

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

