---
title: Fundamentos de neurociencia computacional
categories: [Science]
---

# Introducción

Estas notas están basadas en el libro *Theoretical Neuroscience* de Dayan y
Abbott. Esta obra, que se ha convertido en algo así como la biblia de la
neurociencia computacional, no está traducida al castellano. Este es un humilde
intento de democratizar al menos algunos elementos fundamentales de la
neurociencia computacional.

La neurociencia computacional, más que una disciplina, es una perspectiva.
Realizar experimentos es, en el mejor de los casos, costoso, y en el peor
imposible. Es difícil controlar los parámetros involcurados en, digamos, un
potencial de acción, a menos que el experimento tenga una dimensión minúscula.
La perspectiva computacional pretende resolver este problema ofreciendo la
posibilidad de simular las dinámicas neurales. Esto ofrece un control absoluto
de los parámetros, lo cual resulta en una posibilidad de explorar dinámicas que,
en la práctica, son imposibles de estudiar. El costo que se paga es el de la
simplificación: todo modelo es, en última instancia, una mentira más o menos
piadosa.

La neurociencia computacional no es simple: requiere un conocimiento decente de
matemáticas, en particular de cálculo, ecuaciones diferenciales, y probabilidad;
un conocimiento básico de ciertos aspectos de la física, como la fuerza
eléctrica y la teoría de circuitos; una comprensión aceptable de biología
celular y, en el caso ideal, de anatomía. Lo cierto es que es difícil pedir a un
único científico (o estudiante) que posea un dominio absoluto sobre todas estas
áreas, y la mayor parte de los trabajos en neurociencia computacional, como casi
todos los trabajos científicos, tienen múltiples autores con distintas
competencias. Sin embargo, un dominio *aceptable* de todas estas áreas sí es
adquirible, asumiendo que se tiene la disciplina adecuada. En este sentido, es
la disciplina ideal para el raro, pero a mi criterio bello tipo de personalidad
que gusta de ser exigida y que aspira, como los renacentistas, a una vida
intelectual amplia y poco limitada.

# Modelos fenomenológicos

La animación de abajo muestra una neurona de macaco (o, mejor dicho, una
simulación precisa de una) disparando repetidas veces. A simple vista, parecen
picos aleatorios que saltan aquí y allá en el tiempo. Sin embargo, es
sorprendente la cantidad de información que se puede extraer de un fenómeno tan
simple, así como la riqueza de los modelos matemáticos que lo simulan.

<p align="center">
  <img src="../Images/firing.gif">
</p>

La simulación de arriba es una simulación fenomenológica, en el sentido de que
no intenta reproducir las dinámicas que subyacen a un fenómeno—el cambio en los
voltajes de la membrana celular, el flujo de iones, la morfología de la neurona,
etc—sino simplemente alguna de sus manifestaciones inmediatamente observables,
como la cantidad de disparos. Sólo más adelante vamos a adentrarnos en qué hace
que una neurona dispare: por el momento, nos basta vivir en un mundo simple
donde las neuronas disparan antes ciertos estímulos, y la probabilidad de
disparo depende de propiedades simples del estímulo como su duración o su
intensidad.

Al observar los tiempos en los que una neurona dispara, que es lo que muestra la
animación de arriba, nos enfrentamos primero al problema de proporcionar un buen
modelo matemático para una serie de pulsos en el tiempo. La función $\delta$ de
Dirac es la candidata más obvia. En particular, sea $\{t_{1}, \ldots, t_{n}\}$
la secuencia de tiempos en los que ocurrió un pulso. Definimos la función de
respuesta neuronal (FRN) como

$$
\rho (t) = \sum\limits_{i=1}^{n}\delta(t -t_{i})
$$

La función definida arriba mapea un tiempo $t$ a $\infty$ si ese tiempo es un
tiempo de disparo y a cero en caso contrario. Es análoga a $\delta$, que la
compone, excepto que en lugar de ser positiva en cero, es positiva en cualquier
tiempo de disparo—basta recordar que $f(x - c)$ es un desplazamiento horizontal
a derecha de $f(x)$—.

Una propiedad que se sigue directamente de la definición de la $\delta$ de Dirac
es que, para cualquier función $h(t)$ con un comportamiento adecuado, tenemos:

$$
\sum\limits_{i=1}^{n} h(t - t_{i}) = \int_{-\infty}^{\infty} \rho(t-\tau)h(\tau)~d\tau
$$

Esta fórmula puede parecer extraña al principio, pero expresa algo bastante
intuitivo. La expresión del integrando $\rho(t - \tau)$ siempre será $0$,
excepto cuando $\tau$ toma el valor de la distancia temporal entre $t$ y un
tiempo de disparo particular. Cuando ese es el caso, la expresión $\rho$ es uno
y la integral incorpora a su suma el término $h(\tau)$. Por lo tanto, la
expresión integral es la suma de todos los valores de $h(\tau)$ donde $\tau$ es
una distancia desde $t$ a un pulso temporal $t_{i}$. Que es exactamente lo que
dice la expresión de la izquierda.

Esta propiedad es de gran importancia porque a menudo nos interesa sumar las distancias que un punto de tiempo dado tiene de cada pulso. Por lo tanto, las funciones de la forma $\sum\limits h(t - t_{i})$ serán muy comunes en nuestra investigación de la dinámica neuronal.

---

## 2. Caracterización Temporal: La Tasa de Disparo

Los potenciales de acción son fenómenos estereotipados. Debido a que entre dos potenciales de acción no existe una diferencia esencial más allá del tiempo en que ocurren, se ha entendido desde hace mucho tiempo que cualquier mecanismo que subyazca a la codificación neuronal debe tener que ver con la disposición de tales activaciones en el tiempo. En este sentido, lo **sincrónico** y lo **asincrónico** son el lenguaje binario del cerebro.

Por esta razón, la caracterización temporal de los trenes de pulsos es de gran interés. Un concepto particularmente importante es el de la **tasa de disparo** (firing rate). Se podría creer que es un concepto directo, pero en realidad hay varias formas de conceptualizarlo. La más importante es la que considera la tasa de disparo no como un valor fijo, sino como una función del tiempo:

$$
r(t) = \frac{1}{\Delta t} \int_{t}^{t+\Delta t} \langle \rho(\tau)\rangle ~ d\tau
$$

donde $\langle \cdot \rangle$ denota el **promedio entre ensayos** (trial-average). Un dato importante es que $r(t)\Delta t$ proporciona la probabilidad de que ocurra un pulso en el tiempo $t$, cuando $\Delta t$ es suficientemente pequeño.

La tasa de disparo promedio puede definirse a su vez como:

$$
\langle r \rangle =\frac{1}{T} \int_{0}^{T}r(t) dt = \frac{1}{T} \int_{0}^{T}\rho(\tau) ~d\tau
$$

---

## 3. Filtros Lineales

La tasa de disparo, como un parámetro de distribución, se infiere de una población dada de pulsos. Consideremos cómo se puede llevar a cabo dicha aproximación utilizando filtros lineales.

Un filtro lineal es una función del tiempo que calcula, en cada punto temporal $\tau$, la combinación lineal de un núcleo o **kernel** lineal $w(\tau)$ con coeficientes $\rho(t - \tau)$.

$$
R(t) =\int_{-\infty}^{\infty} w(\tau)\rho(t - \tau) d\tau
$$

Dos funciones comúnmente utilizadas son el **kernel Gaussiano**:

$$
w(\tau) = \frac{1}{\sqrt{2\pi}\sigma_{w}}\exp \Big(\frac{-\tau^{2}}{2\sigma_{w}^{2}}\Big)
$$

y una función de **promedio por ventana** (bin-average):

$$
w(t) = \begin{cases} \frac{1}{\Delta{t}}& t \in \left[\frac{-\Delta{t}}{2}, \frac{\Delta{t}}{2}\right]\\ 0 & \text{en otro caso} \end{cases}
$$

<p align="center">
  <img src="../Images/windows2.gif">
</p>

---

## 4. Curvas de Sintonía (Tuning Curves)

El estudio del efecto de estímulos externos se realiza mediante lo que se denomina una **curva de sintonía**. Una curva de sintonía es una función $\langle r \rangle = f(s)$, donde $s$ es un parámetro del estímulo.

Por ejemplo, en experimentos con la corteza visual primaria de un mono, se descubrió que la tasa de disparo de una neurona se correlacionaba con el ángulo $s$ de una barra de luz. Esto se ajustó mediante la función:

$$
f(s) = r_{max} \exp \Bigg( \frac{-1}{2} \Big( \frac{s-s_{max}}{\sigma_f} \Big) \Bigg)
$$



En nuestra simulación, asumiremos que la barra gira a una tasa constante de $-40$ a $40$ grados, de modo que la función que describe el estímulo es:

$$
g(t) = \frac{4}{5}t-40
$$

---

## 5. Implementación en Julia

Estamos listos para producir nuestro tren de pulsos artificial. Comenzaremos definiendo la curva del estímulo y la estructura para la curva de sintonía.

```julia
function stimcurve(x, T)
    # Hacemos stimcurve(T + t) = stimcurve(t) para periodicidad
    4 / 5 * (x % T) - 40
end

struct TuningCurve
    f::Function
    max_rate::Float32
    argmax_rate::Float32
    σ::Float32

    function TuningCurve(max_rate, argmax_rate, σ)
        f(s) = max_rate * exp(-0.5 * ((s - argmax_rate) / σ)^2)
        new(f, max_rate, argmax_rate, σ)
    end
end
Ahora modelamos el tren de pulsos:Juliamutable struct SpikeTrain
    """Estructura que representa un tren de pulsos con una tasa de disparo
    que es una función del tiempo no constante."""

    T::Float32
    Δt::Float32
    t::Vector{Float32}
    n::Int
    spike_train::Vector{Int}
    avg_spike_train::Vector{Float32}
    spike_times::Vector{Float32}
    avg_n::Float32
    tuncurve::TuningCurve
    stimcurve::Function

    function SpikeTrain(T, Δt, tuncurve, stimcurve)
        δ(x) = x >= rand() ? 1 : 0
        t = collect(0:Δt:T)
        f = tuncurve.f
        g = stimcurve
        # Generación de pulsos basada en probabilidad
        spikes = [δ(f(g(x)) * Δt) for x in t]
        spike_times = [t[index] for (index, value) in enumerate(spikes) if value == 1]
        n = length(spike_times)

        new(T, Δt, t, n, spikes, [], spike_times, 0, tuncurve, stimcurve)
    end
end
Ejemplo de uso:Juliausing Plots

st(x) = stimcurve(x, 100)
tuncurve = TuningCurve(2, 10, 5)
A = SpikeTrain(100, 0.1, tuncurve, st)
plot(A.t, A.spike_train, size=(500, 150), legend=false)
<p align="center"><img src="../Images/spikes.png"></p>6. Propiedades InferidasExisten varias propiedades que pueden inferirse de esta simulación:Promedio Gatillado por Disparos (STA)Describe el valor promedio de un estímulo $s$ en un intervalo de tiempo $\tau$ antes de que se dispare un pulso.$$C(\tau)=\frac{1}{\langle n \rangle}\int_{0}^{T} r(t) s(t-\tau)~ dt$$Correlación Tasa de Disparo-Estímulo$$Q_{rs}(\tau) = \frac{1}{T} \int_{0}^{T} r(t)s(t+\tau) ~ dt$$Autocorrelación del Tren de PulsosEs una medida de la influencia promedio que tiene encontrar un pulso en el tiempo $t$ sobre encontrar otro en el tiempo $t + \tau$.<p align="center"><img src="../Images/autocor.gif"></p>7. Otro Modelo: Generador de Pulsos de PoissonHasta ahora hemos explorado estimaciones de la tasa de disparo dado un tren de pulsos. Ahora planteamos el problema en términos de una suma ponderada del estímulo:$$ r_{est}(t) = r_{0}+ \int_0^{\infty} \mathcal{D}(\tau)s(t - \tau) ~ d\tau $$Este método se llama correlación inversa (reverse correlation). Para mejorar la precisión, se suelen utilizar no linealidades estáticas:Rectificación lineal: $F(L) = G[L-L_0]_{+}$.12Saturación sigmoidea: 34$F(L) = \frac{r_{max}}{1+\exp\Big( g_1(L_\frac{1}{2}-L)\Big)}$.56Tangente hiperbólica: 78$F(L) = r_{max} \big[ \tanh \big( g_{2} (L - L_0) \big) \big]_{+}$.910Todo esto es suficiente para simular un generador de pulsos de Poisson. La estructura es: D11ado un estímulo 12$s(t)$, calcular el filtro lineal 13$L$, aplicar la no linealidad para o14btener $r_{est}(t)$, y generar un pulso siempre que $r_{est}(t)\Delta t > x_{aleatorio}$.

# Modelos celulares


Recordemos que, por convención, el potencial del líquido extracelular en
el exterior de una neurona es cero. Dado que las neuronas inactivas
poseen un exceso de iones negativos en el interior de sus membranas, el
potencial de reposo de una neurona es negativo. Por lo tanto, cada
neurona tiene un potencial de equilibrio determinado por las
concentraciones iónicas en su interior. El potencial de las neuronas
puede variar aproximadamente entre $-90\text{ mV}$ y $+60\text{ mV}$,
dependiendo del tipo de neurona y de su estado.

El exceso de carga negativa en el interior hace que los iones negativos
sean atraídos hacia la cara interior de la membrana; y como dichos iones
se repelen entre sí, su distribución tiende a ser uniforme. Es decir que
la neurona funciona como un capacitor con una carga uniformemente
distribuida a lo largo de su membrana. Todo capacitor obedece que
$V = \frac{Q}{C}$, o bien $VC = Q$. Si modelamos $V = V(t)$, y tomando
$C$ como constante, se tiene

$$C \frac{dV}{dt} = \frac{dQ}{dt} =: -I$$

El signo negativo en $-I$ obedece a una convención típica: la corriente
de membrana se define como positiva cuando iones positivos salen de la
neurona, y negativa cuando iones positivos entran a la neurona. El
ingreso de una unidad de carga positiva es equivalente a la salida de
una unidad de carga negativa, y por ende definir el sentido de la
corriente en términos de los iones positivos alcanza para definirlo para
todo tipo de iones, positivos y negativos.

Generalmente, nos interesa expresar la capacitancia por unidad de área,
es decir la capacitancia específica $c_m = C / A$. Lo mismo aplica para
la resistencia, definiendo la resistencia específica $r_m = R \cdot A$ y
la conductancia específica $g_m = 1 / r_m$, tanto como para la corriente
$i_m = \frac{I}{A}$. Visto de este modo, la ecuación resulta

$$c_m \frac{dV}{dt} = -i_m$$

Las áreas (de superficie) de una neurona suelen variar entre $0.01$ y
$0.1\text{mm}^2$, y la capacitancia entre $0.01$ y $0.1\text{nF}$. Una
neurona con una capacitancia de 1 nanofaradaio necesita aproximadamente
$7\times
10^{-11}$ coulombs para generar un potencial de reposo de
$-70\text{ mV}$. Esto equivale aproximadamente a $10^9$ iones con una
carga unitaria.

El producto entre la capacitancia y la resistencia es una cantidad con
unidad de tiempo llamada constante de tiempo de membrana:
$\tau_m = R_m C_m$. Es fácil observar que $\tau_m = r_m c_m$, es decir
es independiente del área. Esta constante especifica la escala temporal
de los cambios en el potencial de membrana y generalmente varía entre
$10$ y $100\text{ ms}$. Yo sé que es un lugar común, pero la analogía
del tanque de agua es útil para entender $\tau_m$. Si la neurona se
piensa como un tanque (capacitor) llenándose a través de una manguera
(resistencia), es obvio que un tanque grande ($C$ alta) con una manguera
estrecha ($R$ alta) tardará mucho en llenarse. La neurona es entonces
\"lenta\" para responder a estímulos. Si el tanque es pequeño ($C$ baja)
y la manguera ancha ($R$ baja), el proceso sucede \"rápido\". Esta es la
dinámica capaturada por $\tau_m$.

Es importante notar que el equilibrio de potencial no es un estado
estático, sino consecuencia de que la corriente generada por las fueras
eléctricas cancela el flujo por difusión. Si un ion positivo «flota» en
el medio intracelular, y la membrana tiene un potencial negativo, el
potencial de membrana se opondrá el flujo del ion fuera de la célula. En
este caso, sólo habría flujo a través de la membrana si la energía
térmica es suficiente para superar el campo eléctrico. Si el ion tiene
una carga de $zq$, con $q$ la carga de un protón y $z$ un número real
positivo, la energía térmica debe ser de al menos $-zqV$ para que el ion
atraviese la membrana. La probabilidad de que un ion en un medio con
temperatura absoluta $T$ tenga una energía térmica $\geq zqV$ es

$$p := P(E_T \geq zqV) = \exp\left( zqV / k_B T \right) = \exp\left( zV / V_T \right)$$

donde $V_T = k_B T / q$ es el voltaje térmico.

Fuera de la célula, el potencial eléctrico puede ser contrarrestado por
un gradiente. Si la concentración de iones dentro de la célula es menor
al a concentración fuera de la misma, el gradiente electroquímico
generado puede compensar una baja probabilidad $p$. El flujo hacia
dentro de la célula es proporcional a la concentración en el medio
externo. El flujo hacia fuera es proporcional a la concentración en el
medio interno multiplicada por $p$, dado que sólo los iones con
suficiente energía térmica podrán abandonar el medio celular. El flujo
neto será cero cuando ambos flujos sean iguales. Si $E$ denota la
diferencia de potencial que satisface precisamente esta condición, y
$C_i,
C_e$ es la concentración interna y externa de iones, se tiene:

$$C_e = C_i \exp\left( \frac{zE}{V_T} \right) \iff E = \frac{V_T}{z}\ln \left(
    \frac{C_e}{C_i}\right)$$

Esta es la famosa ecuación de Nernst. Los potenciales de equilibrio para
el potasio ($K^+$) típicamente caen entre $-70\text{mV}$ y
$-90\text{mV}$; para el sodio $(\text{Na}^+)$ son $\approx 50\text{mV}$
o más, y para el calcio todavía mayores, alcanzando
$\approx 150\text{mV}$.

La ecuación de Nernst asume que la conductancia generada por un canal es
específica, i.e. cada canal permite el paso de un único tipo de ion.
Algunos canales no satisfacen esta condición, en cuyo caso el potencial
de equilibrio no es determinado por la ecuación de Nernst sino que toma
un valor intermedio entre los potenciales de equilibrio de cada tipo de
ion que atraviesa el canal.

Cada conductancia tiende a llevar el potencial de membrana $V$ a su
propio potencial de equilibrio $E$. Si $V>E$, existe flujo hacia fuera;
si $V < E$, flujo hacia adentro. Esto significa que un canal va a
polarizar o despolarizar la membrana dependiendo de su potencial de
equilibrio. Los canales de sodio y el calcio tienen potenciales de
equilibrio positivos y por lo tanto tienden a despolarizar la membrana.
Los canales de potasio tienen valores negativos y tienden a
hiperpolarizarla. Algunas conductancias, como la del cloro
($\text{Cl}^-$), tienen un potencial de equilibrio tan cercano al
potencial de reposo de la membrana que apenas dejan pasar corriente.
Como nota, las sinapsis también tienen potenciales de equilibrio: si
dicho potencial es mayor al umbral de disparo, se dice que la sinapsis
es excitatoria; si es menor, que es inhibitoria.

La corriente total a través de la membrana es la suma de las corrientes
a través de todos sus canales. La dirección de la corriente que fluye a
través de la membrana se define por convención como positiva si los
iones abandonan el medio intracelular. Como distintas neuronas tienen
distintos tamaños, es útil hablar de la corriente por unidad de área,
$i_m$. La corriente total sería $i_m A$, con $A$ la superficie total de
la neurona.

Ya establecimois que la corriente neta es nula cuando $V = E_i$, con
$E_i$ el potencial de equilibrio del ion $i$. La diferencia $V - E_i$
determina entonces la distancia entre el voltaje y el punto de
equilibrio, y la corriente por unidad de área se determina como

$$g_i(V - E_i)$$

con $g_i$ la conductancia por unidad de área para los canales de tipo
$i$. Esta determinación está justificada porque la corriente aumenta o
decrece de manera aproximadamente lineal con el factor $V - E_i$. Se
sigue que

$$i_m = \sum_i g_i (V - E_i)$$

Es importante notar que este es solo un modelo o aproximación posible de
la corriente, fundamentada en la relación aproximadamente lineal entre
la corriente y el factor $V - E_i$. Otras expresiones, como la fórmula
de Goldman-Hodgkin-Katz, a veces son utilizadas.

Si combinamos esta nueva expresión para $i_m$ con la ecuación que
determina la tasa de cambio del voltaje, obtenemos

$$c_m \frac{dV}{dt} = -\sum_i g_i(V - E_i)$$

Esta es la expresión detrás de los modelos más elementales de la
neurociencia computacional, como los *single-compartment models*. Estos
modelos describen el potencial de membrana usando una única variable
$V$. Insisto en que el signo negativo es necesario dadas las
convenciones que establecimos. Notar que si el voltaje es menor a un
potencial de equilibrio determinado, habrá un flujo de corriente hacia
adentro, y el término de la suma será positivo. Esto es consistente,
porque el ingreso de iones positivos a la célula aumenta el voltaje.

En otros escritos detallé algunos *single-compartment models*. El más
simple es el que expresa el voltaje ante una corriente externa $I_e$:

$$c_m \frac{dV}{dt} = - i_m + \frac{I_e}{A}$$

El signo positivo de $I_e$ también es mera convención: se define la
corriente externa como positiva cuando ingresa a la neurona, contrario a
la corriente de membrana.

En general, no todos los canales ionicos están abiertos al mismo tiempo.
La conductancia específica de un ion $g_i$ es determinada por la
cantidad de canales abiertos. El producto entre la conductancia de un
canal por la densidad de canales en la membrana se denota
$\overline{g_i}$. De este modo, podemos expresar como la conductancia
total como $\overline{g_i} \frac{n_i}{N_i}$, con $n_i$ la cantidad de
canales de tipo $i$ abiertos y $N_i$ la cantidad de canales en total.
Ahora bien, $n_i / N_i$ es equivalente a la probabilidad de tomar una
canal aleatorio y que el mismo esté abierto, denotada por $P_i$. En
conclusión, $g_i = \overline{g_i} P_i$.

En el modelo de Hodgkin-Huxley, dos tipos de canales se utilizaban:
transitorios (*transient*) y persistentes. Las conductancias
persistentes dependían de complejos mecanismos moleculares, que el
modelo simplificaba definiendo cada canal como compuesto de $k$
sub-unidades o *gates*, cada una de las cuales debe estar abierta para
que pueda haber corriente. El estado de las *gates* (abierta/cerrada) se
modelaba con variables aleatorias independientes e igualmente
distribuidas, de manera tal que si $n$ era la probabilidad de que una
gate esté abierta, $n^k$ era la probabilidad de que un canal esté
abierto. La variable $n$, i.e. la probabilidad de que una sub-unidad
arbitraria de un canal esté abierta, se denominaba *variable de
activación*.

En la medida en que lidiemos con canales voltaje-dependientes
(*voltage-dependent channels*), las variables de activación son una
función creciente de $V$. En particular, la probabilidad de que una
sub-unidad esté abierta debe ser proporcional a la probabilidad de que
la sub-unidad esté cerrada multiplicada por una tasa de apertura
$\alpha_n(V)$. Del mismo modo, la probabilidad de que una sub-unidad se
cierre debe ser proporcional a la probabilidad de que esté abierta por
una tasa de cierra $\beta_n(V)$. En resumen, se obtenía

$$\frac{dn}{dt} = \alpha_n(V) (1 - n) - \beta_n(V) n$$

Me voy a ahorrar los detalles, porque ya estudiamos en mi entrada sobre
el modelo de Hodgkin-Huxley, pero esto podía re-escribirse como

$$\tau_n(V) \frac{dn}{dt} = n_{\infty}(V) - n$$

donde

$$t_n(V) = \frac{1}{\alpha_n(V) + \beta_n(V)}, \qquad n_\infty(V) =
    \frac{\alpha_n(V)}{\alpha_n(V) + \beta_n(V)}$$

Los elementos clave son $\alpha_n(V), \beta_n(V)$, las tasas de apertura
y cierre dependientes del voltaje. Su derivación es compleja y omitida
en esta entrada.

El modelo de Connor-Stevens, como el de Hodgkin-Huxley, involucra
canales de sodio depolarirzantes, canales de potasio rectificadores, y
conductancias de fuga (leaky). Sin embargo, posee una conductancia
transitoria extra de $K^+$, llamada corriente $A$.

$$i_m = \overline{g}_L(V - E_L) + \overline{g}_{\text{Na}} m^3h (V -
    E_{\text{Na}})$$
