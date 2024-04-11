---
title: Power spectral density estimation in Julia
categories: [ Science ]
---

In [another entry](https://slopezpereyra.github.io/2024-04-07-PSDInR/), I gave
a quick review of the fundamental concepts of power spectral analysis and
provided an R implementation. This was motivated by the fact that R is a
commonly used language, as well as by the fact that R packages used to estimate
power spectral densities (PSD) tend to be rather obscure. A clear example 
of this obscurity is `gsignal`'s lack of documentation on the fact that 
their `pwelch` function, which uses Welch's method to estimate the PSD of a
vector, normalizes the result to units of power over Hertz ---i.e. multiples
the power spectrum by $1 / f_s$. 

There is one fact that ought to be taken into account, however, a fact 
so simple and plain that it surprises me that it is not an axiom among 
computer scientists---this is, that R is a tasteless language, offensive
to the aesthetic sense with which nature has blessed humankind. Thus,
eager to dwell in prettier meadows, I rapidly turned to implement in Julia
what was degraded in R. I present the implementation without further ado.

```jl
using FFTW
using DSP 

mutable struct PSD
    freq::Vector
    spectrum::Vector

    function PSD(x::Vector, sampling_rate::Int)
        N = length(x)
        hann = hanning(N) # Hanning window
        x = x .* hann
        ft = abs2.(fft(x))
        ft = ft[1:(div(N, 2) + 1)] # Make one sided
        freq = [i for i in 0:( length(ft) - 1)] .* sampling_rate/N
        normalization = 2/(sum(hann.^2)) 
        spectrum = ft * normalization
        new(freq, spectrum)
    end

    # Welch's method. It would be more efficient to create a helper function
    # and perform a single `map`. But this is good and easy to read enough.
    function PSD(x::Vector, fs::Int, L::Int, overlap::AbstractFloat)
        hann = hanning(L)
        segs = overlaps(x, L, overlap)
        map!(x -> x .* hann, segs, segs) # Apply Hanning window
        map!(x -> abs2.(fft(x)), segs, segs) # Compute |H(f)|²
        map!(x -> x[1:(div(L, 2) + 1)], segs, segs) # Make one sided
        map!(x -> 2 .* x ./ ( sum(hann.^2)  ), segs, segs) # (2 * |H(f)|²) / (∑ wᵢ²)
        w = sum(segs) ./ length(segs)
        freq = [i for i in 0:(length(segs[1])-1)] .* fs/L
        new(freq, w)
    end
end
```

I compared our estimation with `DSP`'s `welch_pgram` function, with almost
identical results. For the comparison, I used a full-night EEG (8 hours) with a
sampling rate of $500\text{Hz}$. In particular, I used the C3 channel. I did it
without filtering nor artifact-rejecting the data. The result looked like this.


<p align="center">
  <img src="../Images/julia_spec.png">
</p>

If I limit the plot to frequencies below $30\text{Hz}$, it looks like this.
<p align="center">
  <img src="../Images/julia_spec_30.png">
</p>

Pretty good.
