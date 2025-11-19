Let $X(t), Y(t)$ denote two EEG signals viewed as random variables.
Their cross-correlation is defined as

$$(X \star Y)(\tau) = \int_{-\infty}^\infty X(t)Y(t + \tau) ~ dt$$

> As a simple note, we observe that for $\tau = 0$ their cross
> correlation becomes
> $\int_{-\infty}^\infty X(t) Y(t) ~ dt = \mathbb{E}\left[ X \cdot Y
>     \right]$. If $X, Y$ are zero-meaned then this entails
> $(X \star Y)(0) \propto \text{Cov}(X, Y)$. In short, the zero-lag
> cross-correlation of two zero-mean signals is proportional to their
> covariance.

For discrete signals, like digital EEGs, the definition is analogous,
though this time we normalize:

$$\begin{aligned}
    C(t) = \frac{1}{(N-m)\sigma_X \sigma_Y} \sum_{j=0}^{N-(m+1)} \hat{X}_j
    \hat{Y}_{j+m}, \qquad t = m\tau
\end{aligned}$$

where

-   $\hat{X}_i$ is the fluctuation of $X_i$ around its mean
    ($X_i - \bar{X}$);

-   $\tau$ is the constant sampling time, i.e. the inverse of the
    sampling rate.

-   $m$ is the discrete lag, computed as a function of the continuous
    lag $t$.

> Consider for example a sampling rate of 500Hz, which gives a sampling
> time of $0.002$ seconds per sample. If we wish to compute the discrete
> cross-correlation with a time phase of two seconds, then
> $2\text{sec} = m
>     \cdot 0.002 \text{sec/sample}$ giving $m = 1000\text{ samples}$.
> In short, a two second shift would correspond to a discrete shift of
> 1000 samples.

To further understand the concept which I wish to present, let us pose a
few questions beforehand.

\(1\) First, let us ask how the existence of certain *common* frequency
in both signals affects their cross-correlation function. Say, for the
sake of the example, that both signals are strongly composed of a 10Hz
frequency oscilation, meaning that their power spectrums show «high»
energy at said frequency.

When evaluating their cross-correlation, we effectively «slide» signal
$Y$ across $X$ checking for similarity; and since by assumption both
contain a periodic 10Hz oscilation, they will align and misalign
cyclically at the exact same rate. Importantly, even if both signals
contain noise, random noise in $X$ will not generally correlate with
random noise in $Y$, so the 10Hz oscilation will be exposed in the
correlation function.

> *Insight from question (1):* If $X$ and $Y$ share a frequency $f$, the
> cross-correlation function also oscilates at frequency $f$.

\(2\) Now we deepen the question. We may assume that both signals share
a frequency $f$, but their oscilations in that frequency may or may not
be aligned. How does this affect the cross-correlation function?

It should be clear that if the oscilations in this frequency are
perfectly aligned (i.e. shifted by an angle of $\phi = 0$), the maximum
correlation occurs at lag $\tau = 0$. If the oscilations are out of
phase, the maximum correlation will occur at the lag $\tau$ which
compensates for the delay.

> *Insight from question (2):* Aligned, shared oscilations peak at
> $\tau = 0$.

With these observations in hand, understanding our topic of interest
will be simpler. Let us proceed: we'll get back to these insights
shortly.

We now define $S_{XY}$ as the power spectrum of the cross-correlation
function of two signals $X$ and $Y$. This is known as the cross-spectral
density or simply cross-spectrum:

$$S_{XY}(\nu) = \int_{-\infty}^{\infty} C(t) e^{-i 2\pi \nu t} ~ dt$$

To further disect the meaning of the power spectrum let us decompose it
a bit. Applying Euler's formula
($e^{-i\theta} = \cos\theta - i\sin\theta$), we obtain:

$$\begin{aligned}
    S_{XY}(\nu) &= \int_{-\infty}^{\infty} C(t) \left[ \cos(2\pi \nu t) - i \sin(2\pi \nu t) \right] ~ dt \\
    &= \underbrace{\int_{-\infty}^{\infty} C(t) \cos(2\pi \nu t) ~ dt}_{\text{Real Part: Co-spectrum}} 
    - i \underbrace{\int_{-\infty}^{\infty} C(t) \sin(2\pi \nu t) ~ dt}_{\text{Imaginary Part: Quad-spectrum}}
\end{aligned}$$

It is time to tie our previous insights with this expression. We can
view the formula above as asking, at each frequency component, how the
cross-correlation behaves relative to cosine and sine waves.
Importantly, the distinction is not simply between "synchrony" and
"asynchrony," but between *alignment* and *orthogonality*. To make this
clearer, note that for each frequency component we essentially have
three cases:

-   **In-Phase ($\phi = 0$):** The signals are perfectly synchronous.
    The cross-correlation peaks at zero and resembles a **positive
    cosine**. Its Fourier transform is purely real (only co-spectrum)
    and positive.

-   **Anti-Phase ($\phi = \pi$):** The signals are perfectly
    oppositional (one peaks when the other troughs). The
    cross-correlation is a **negative cosine**. Here, again, the
    activity appears only in the co-spectrum (real part), but this time
    with a negative sign.

-   **Quadrature ($\phi = \pi/2$):** The signals are shifted by a
    quarter cycle and thus are perfectly asynchronous. The
    cross-correlation resembles a **sine wave** (it is zero at lag 0).
    Its Fourier transform is purely imaginary.

What am I trying to say? That the co-spectrum measures the linear
relationship (whether parallel or anti-parallel) of both signals across
the range of frequencies. The quad-spectrum measures the orthogonal
relationship.

In EEG analysis, we are often interested specifically in *zero-lag*
synchrony. This is captured entirely by the real part. Therefore, the
«cross-spectrum» formula in these contexts often simplifies to the
co-spectrum:

$$\text{Co}_{XY}(\nu) \approx \text{Re}\left[ \sum_{j} C(t_j) e^{-i 2\pi \nu t_j} \right] = \sum_{j} C(t_j) \cos(2\pi \nu t_j)$$

We discard the imaginary part not because it is error, but because it
represents time-delayed (orthogonal) interactions rather than zero-lag
synchronization.

Some methodologies define a specific synchronization metric,
$\mu_0^{XY}(\nu)$, which not only isolates the co-spectrum but squares
it. Squaring transforms the amplitude into power and ensures that both
in-phase (positive) and anti-phase (negative) synchrony contribute
positively to the strength of the connection:

$$\mu_0^{XY}(\nu) = \left| \tau \sum_{j} c(t_j) \cos(2\pi \nu t_j) \right|^2$$
