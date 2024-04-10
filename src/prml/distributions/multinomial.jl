# Definition and constuctors
mutable struct Multinomial{T<:Real}
    mu::Vector{T}
    N::Integer
    function Multinomial{T}(mu, N) where {T<:Real}
        if sum(mu) != one(T)
            error("Invalid parameter: Σμ must add up to 1.")
        elseif N <= 0
            error("Invalid parameter N: N > 0 required.")
        end
        new(mu, N)
    end
end

Multinomial(mu::Vector{T}, N::Integer) where {T<:Real} = Multinomial{T}(mu, N)


# Sampling
function sample(dist::Multinomial)
    cat = Categorical(dist.mu)
    out = zeros(Int64, length(dist.mu))
    for i in 1:dist.N
        x = sample(cat)
        out .+= x
    end
    return out
end


# Densities (Bishop does not cover a cdf)
function pdf(dist::Multinomial, x::AbstractVector{T}) where {T<:Real}
    if T <: Integer && all(z -> z >= 0, x)
        if size(x) == size(dist.mu) || sum(x) != dist.N
            coeff = multinomial(sum(x), x)
            return coeff*prod(dist.mu.^x)
        end
        error("Invalid parameter: dimension of x must match dimension of dist.mu and add up to dist.N.")
    end
    error("The PMF of the Multinomial distribution is only defined for positive categorical values, xₙ ∈ ℕ₀.")
end



# Statistics
expectation(dist::Multinomial) = dist.N.*dist.mu
variance(dist::Multinomial) = @. dist.N*dist.mu*(1-dist.mu)


# Fitting
function mle(::Type{T}, x::AbstractVector) where {T<:Multinomial}
    cats = unique(x)
    N_cats = length(cats)
    N = length(x)
    mu = zeros(Rational, N_cats)
    for i in 1:N_cats
        freq = count(z -> z == cats[i], x)
        mu[i] = freq//N
    end
    return Multinomial(mu, N), cats
end