# Definition & constuctors
mutable struct Binomial{T<:Real} 
    mu::T
    N::Integer
    function Binomial{T}(mu, N) where {T<:Real} 
        if !(zero(mu) <= mu <= one(mu))
            error("Invalid parameter mu: μ ∈ [0,1] required.")
        elseif N <= 0
            error("Invalid parameter N: N > 0 required.")
        end 
        new{T}(mu, N)
    end
end

Binomial(mu::T, N::Integer) where {T<:Real} = Binomial{T}(mu, N)


# Sampling
function sample(dist::Binomial)
    x = rand()
    for i in 0:dist.N
        if x <= cdf(dist, i)
            return i
        end
    end
end


#Densities
function pdf(dist::Binomial, x::Real)
    if x isa Integer && x >= 0
        coeff = binomial(dist.N, x)
        return coeff * (dist.mu ^ x) * ((1 - dist.mu)^(dist.N - x)) 
    end
    error("The PMF of the Binomial distribution is only defined for x ∈ ℕ₀.")
end


function cdf(dist::Binomial, x::Real)
    if x < 0 return 0 end
    if x >= dist.N return 1 end
    cumul = 0
    for i in 0:floor(x)
        cumul += pdf(dist, i)
    end
    return cumul
end


# Statistics
mean(dist::Binomial) = dist.N * dist.mu
variance(dist::Binomial) = dist.N * dist.mu * (1-dist.mu)


# Fitting
function mle(::Type{T}, x::AbstractVector) where {T<:Binomial}
    N = length(x)
    ones = count((i -> i==1), x)
    zeros = count((i -> i==0), x)
    if ones + zeros != N
        error("Argument x may only contain ones and zeros; Results of a Bernoulli trial.")
    end
    p = ones / N
    return Binomial(p, N)
end