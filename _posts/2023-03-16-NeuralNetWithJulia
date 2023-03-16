---
title: A neural network with Julia 
subtitle: Notes on a group-theory based approach
---

### General structures 

Let $\mathcal{L}, \mathcal{N}$ denote the general structs for layer and network objects. 

```jl 
mutable struct 𝓛 
    neurons::Vector 
    W::Matrix
    biases::Vector
    f::Function
    function 𝓛(neurons::Vector, W::Matrix, biases::Vector)
        new(neurons, W, biases)
    end
end

mutable struct 𝓝
    net::Dict{Int, 𝓛}
    dims::Vector
    nlayers::Int
    nparams::Int

    function 𝓝(dims::Vector)
        structure = Dict()
        structure[1] = 𝓛(zeros(Float32, dims[1]), Array{Float32}(undef, 0, 0), [])
        for i in 2:length(dims)
            neurons = zeros(Float32, dims[i])
            weights = rand(Float32, dims[i], dims[i-1])
            biases = rand(Float32, dims[i])
            structure[i] = 𝓛(neurons, weights, biases)
         end
        n::Int32 = 0
        for i in 2:length(dims)
            n += dims[i - 1] * dims[i] + dims[i]
        end

        new(structure, dims, length(dims), n)
    end 
end
```

It is useful to conceive $𝑳, 𝑵$ the sets of possible layers and networks using 
group theory. The usefulness of such conception will become clear later. For the
moment let us take such formalization to practice via the following definitions.

```jl 
function ⊕(L₁::𝓛, L₂::𝓛)
    """Addition operator over the set 𝑳 of layer objects.
    Observe that (𝑳, ⊕) is a non-abbelian group. In particular,
    the operation

                    ℒ₁ ⊕ ℒ₂ = ℒ₃,          ℒᵢ∈ 𝑳

    is neuron-preserving with respect to ℒ₁. This is, 
    ℒ₃ has the same activations as ℒ₁"""

    L₃ = 𝓛(L₁.neurons, L₁.W + L₂.W, L₁.biases + L₂.biases)
    return L₃
end

function ⊗(λ::Number, L::𝓛)
    """Scalar-layer multiplication.
    ⊗ is the group action

                ⊗ : ℝ × 𝑳 → 𝑳 
    """

    W = λ * L.W
    b = λ * L.biases
    return 𝓛(L.neurons, W, b)
end

function ⊗(λ::Number, N::𝓝)
    """Scalar-network multiplication ⊗.
    Might be thought of as a group action 

                ⊗ : ℝ × 𝑵 → 𝑵

    This operation is replacing. """

    new = 𝓝(N.dims)
    keys = [1:N.nlayers;]
    layers = [⊗(λ, N.net[i]) for i in 1:N.nlayers]
    new.net = Dict(keys .=> layers)
    return new
end

function ⊕(N₁::𝓝, N₂::𝓝)
    """Addition operator over the set 𝑵 of layer objects.
    Observe that (𝑵, ⊕) is a non-abbelian group. In particular, 

                    𝐧₁ ⊕ 𝐧₂ = 𝐧₃           𝐧ᵢ∈ 𝑵

    is neuron-preserving with respect to 𝐧₁."""

    if N₁.dims != N₂.dims
        throw(DimensionMismatch)
    end
    N₃ = 𝓝(N₁.dims)
    N₃.net = mergewith(⊕, N₁.net, N₂.net)
    return N₃
end
```

One can now very easily materialize the training of a network via
the following conception. For a given network $\mathcal{N}$, one defines the
*gradient* of each weight $w_{ij}^{(l)}$ in the network as the weight $\nabla
w_{ij}^{(l)}$ of a similar network $\nabla \mathcal{N}$.

> *Note*. I say two networks are *similar* iff their dimensions are the same.

Then 

$$
\begin{align}
    \mathcal{N}(e + 1) = \mathcal{N}(e) - \eta \nabla \mathcal{N}(e)
\end{align}
$$

defines the updated network in epoch $e + 1$. The parameters of $\mathcal{N}(e
+1)$ are shifted towards the direction of steepest decent ---rovided that $(+),
(\cdot)$ are well-defined as network-network and scalar-network operators (which
is precisely what we've done above). 

This formalization of non-abbelian groups for the network and layer objects, by
virtue of which we conceptualized training, is not at all necessary. One can
indeed update a network's parameters without the need to formalize, for example,
network-network operator ---and in fact this is what is generally done. However,
I find this formal approach to have sharper outlines.

### Forward and backward propagation 

Firstly let us defined a simple helper function, 

```jl 
function compute_layer(W::Matrix, a::Vector, b::Vector)
    Y = zeros(Float32, length(b))
    mul!(Y, W, a)
    Y += b
    return Y
end
```

This function performs $\textbf{W}\textbf{a} + \textbf{b}$, the linear
combination (plus bias) that is to be evaluated in some activation function.


```jl 
function fprop(x::Vector, N::𝓝)
    N.net[1].neurons = x
    L = N.nlayers
    for i in 1:(L-1)
        z = compute_layer(N.net[i+1].W, N.net[i].neurons, N.net[i+1].biases)
        N.net[i+1].neurons = N.net[i+1].f(z)
    end
    return(N)
end

function backprop(N::𝓝, y⃗::Vector)
    ∇𝓝 = 𝓝(N.dims)
    ∂C∂aᴸ = 2 * (N.net[N.nlayers].neurons - y⃗)
    for l in reverse(2:N.nlayers)
        ∂σ∂z = dσdx(logit.(N.net[l].neurons))
        P = hadamard(∂C∂aᴸ, ∂σ∂z)
        ∇W = kron(P, transpose(N.net[l-1].neurons))
        ∇𝓝.net[l].W = ∇W
        ∇𝓝.net[l].biases = P
        # Change the dimension of the vector appropriately
        ∂C∂aᴸ = zeros(Float32, size(N.net[l].W, 2))
        mul!(∂C∂aᴸ, transpose(N.net[l].W), P)
    end
    return ∇𝓝
end
```

The logic justifying these algorithms should be clear to anyone familiar with the
basics of neural network theory. The only difference with a traditional
backpropagation algorithm is that we are updating paramaters via network-network
operations.





### Appendix of math functions 

```jl 
relu(x::Number) = max(0, x)
function relu(X::Vector)
    relu.(X)
end

function softmax(X::Vector)
    X = X .- maximum(X)
    exp.(X) ./ sum(exp.(X))
end

σ(x::Number) = 1 / (1 + exp(-x))
function σ(X::Vector)
    σ.(X)
end

function dσdx(x::Number)
    σ(x)*(1 - σ(x))
end

function logit(x)
    if x < 0 || x > 1
        error("Logit input out of bounds")
    end
    log(x / (1 - x))
end


function dσdx(X::Vector)
    broadcast(dσdx, X)
end

function dreludx(x::Number)
    ifelse(x > 0, 1, 0)
end

square(x) = x^2
function cost(final_layer, target)::Float32
    target_vector = zeros(Float32, length(final_layer))
    target_vector[target+1] = 1
    sum(broadcast(square, final_layer .- target_vector))
end

# Hadamard product
function hadamard(A, B)
    C = broadcast(*, A, B)
    return C
end
```
